package com.tkheat.async;

import java.io.File;
import java.io.FileOutputStream;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import java.awt.Color;

import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartUtils;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.axis.NumberAxis;
import org.jfree.chart.axis.NumberTickUnit;
import org.jfree.chart.plot.XYPlot;
import org.jfree.chart.renderer.xy.XYLineAndShapeRenderer;
import org.jfree.data.time.Second;
import org.jfree.data.time.TimeSeries;
import org.jfree.data.time.TimeSeriesCollection;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;

import com.tkheat.domain.Monitoring;
import com.tkheat.service.MonitoringService;

//BCF1 온도 트렌드 10분 주기 스냅샷 (엑셀 + PNG 저장) - 테스트용
public class TrendSnapshotScheduler {

	@Autowired
	private MonitoringService monitoringService;

	private static final String EXCEL_DIR = "C:\\Users\\admin\\Desktop\\온도\\엑셀파일";
	private static final String PNG_DIR = "C:\\Users\\admin\\Desktop\\온도\\캡쳐";

	@Scheduled(cron = "0 0/10 * * * *")
	public void saveBcf1TrendSnapshot() {
		try {
			Date end = new Date();
			Calendar cal = Calendar.getInstance();
			cal.setTime(end);
			cal.add(Calendar.MINUTE, -10);
			Date start = cal.getTime();

			SimpleDateFormat sqlFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

			Monitoring param = new Monitoring();
			param.setStartDate(sqlFormat.format(start));
			param.setEndDate(sqlFormat.format(end));

			List<Monitoring> list = monitoringService.gettrend(param);

			if (list == null || list.isEmpty()) {
				return;
			}

			new File(EXCEL_DIR).mkdirs();
			new File(PNG_DIR).mkdirs();

			SimpleDateFormat fileFormat = new SimpleDateFormat("yyyyMMdd_HHmm");
			String fileBase = fileFormat.format(end) + "_BCF1_온도";

			saveExcel(list, EXCEL_DIR + File.separator + fileBase + ".xlsx");
			savePng(list, PNG_DIR + File.separator + fileBase + ".png");

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private void saveExcel(List<Monitoring> list, String filePath) throws Exception {
		XSSFWorkbook workbook = new XSSFWorkbook();
		XSSFSheet sheet = workbook.createSheet("BCF1 온도");

		Row header = sheet.createRow(0);
		header.createCell(0).setCellValue("시간");
		header.createCell(1).setCellValue("CF(PV)");
		header.createCell(2).setCellValue("OIL(PV)");
		header.createCell(3).setCellValue("CP(PV)");

		int rowIdx = 1;
		for (Monitoring m : list) {
			Row row = sheet.createRow(rowIdx++);
			row.createCell(0).setCellValue(m.getTdatetime());
			row.createCell(1).setCellValue(m.getBcf1_cf_pv() == null ? 0 : m.getBcf1_cf_pv());
			row.createCell(2).setCellValue(m.getBcf1_oil_pv() == null ? 0 : m.getBcf1_oil_pv());
			// 웹 트렌드 화면과 동일하게 표시하기 위해 *1000 적용 (SQL에서 이미 *0.001 된 값을 화면에서 다시 *1000 함)
			row.createCell(3).setCellValue(m.getBcf1_cp_pv() == null ? 0 : m.getBcf1_cp_pv() * 1000);
		}

		for (int i = 0; i < 4; i++) {
			sheet.autoSizeColumn(i);
		}

		try (FileOutputStream fos = new FileOutputStream(filePath)) {
			workbook.write(fos);
		}
		workbook.close();
	}

	private void savePng(List<Monitoring> list, String filePath) throws Exception {
		TimeSeries cfSeries = new TimeSeries("CF(PV)");
		TimeSeries oilSeries = new TimeSeries("OIL(PV)");
		TimeSeries cpSeries = new TimeSeries("CP(PV)");

		SimpleDateFormat parseFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

		for (Monitoring m : list) {
			String raw = m.getTdatetime();
			if (raw == null) {
				continue;
			}
			if (raw.length() > 19) {
				raw = raw.substring(0, 19);
			}

			Date t;
			try {
				t = parseFormat.parse(raw);
			} catch (Exception ex) {
				continue;
			}

			Second second = new Second(t);
			if (m.getBcf1_cf_pv() != null) {
				cfSeries.addOrUpdate(second, m.getBcf1_cf_pv());
			}
			if (m.getBcf1_oil_pv() != null) {
				oilSeries.addOrUpdate(second, m.getBcf1_oil_pv());
			}
			if (m.getBcf1_cp_pv() != null) {
				// 웹 트렌드 화면과 동일하게 표시하기 위해 *1000 적용 (SQL에서 이미 *0.001 된 값을 화면에서 다시 *1000 함)
				cpSeries.addOrUpdate(second, m.getBcf1_cp_pv() * 1000);
			}
		}

		// 왼쪽(온도) 축 데이터셋 - CF, OIL / 웹 화면과 동일하게 0~1200, 100간격
		TimeSeriesCollection tempDataset = new TimeSeriesCollection();
		tempDataset.addSeries(cfSeries);
		tempDataset.addSeries(oilSeries);

		// 오른쪽(CP) 축 데이터셋 - 웹 화면과 동일하게 0~2.5, 0.2간격
		TimeSeriesCollection cpDataset = new TimeSeriesCollection();
		cpDataset.addSeries(cpSeries);

		JFreeChart chart = ChartFactory.createTimeSeriesChart(
				"BCF1 설비 트렌드",
				"시간",
				"온도(℃)",
				tempDataset,
				true,
				true,
				false
		);

		XYPlot plot = chart.getXYPlot();

		NumberAxis tempAxis = (NumberAxis) plot.getRangeAxis();
		tempAxis.setRange(0, 1200);
		tempAxis.setTickUnit(new NumberTickUnit(100));

		NumberAxis cpAxis = new NumberAxis("CP");
		cpAxis.setRange(0, 2.5);
		cpAxis.setTickUnit(new NumberTickUnit(0.2));
		plot.setRangeAxis(1, cpAxis);
		plot.setDataset(1, cpDataset);
		plot.mapDatasetToRangeAxis(1, 1);

		// 웹 트렌드 화면과 동일한 색상: CF=빨강, OIL=초록, CP=파랑
		XYLineAndShapeRenderer tempRenderer = (XYLineAndShapeRenderer) plot.getRenderer(0);
		tempRenderer.setSeriesPaint(0, Color.RED);
		tempRenderer.setSeriesPaint(1, Color.GREEN);

		XYLineAndShapeRenderer cpRenderer = new XYLineAndShapeRenderer(true, false);
		cpRenderer.setSeriesPaint(0, Color.BLUE);
		plot.setRenderer(1, cpRenderer);

		ChartUtils.saveChartAsPNG(new File(filePath), chart, 1000, 600);
	}
}
