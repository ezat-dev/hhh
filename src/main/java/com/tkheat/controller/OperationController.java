package com.tkheat.controller;

import java.io.IOException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tkheat.domain.Chulgo;
import com.tkheat.domain.Ipgo;
import com.tkheat.domain.Siljuk;
import com.tkheat.domain.Users;
import com.tkheat.domain.Work;
import com.tkheat.service.OperationService;
import com.tkheat.util.UtilClass;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

@Controller
public class OperationController {

	@Autowired
	private OperationService operationService;

	//제품별입고현황 - 화면로드
	@RequestMapping(value = "/operation/pIpgoStatus", method = RequestMethod.GET)
	public String pIpgoStatus() {
		return "/operation/pIpgoStatus.jsp";
	}

	//제품별입고현황 조회
	@RequestMapping(value = "/operation/pIpgoStatus/getPIpgoStatusList", method = RequestMethod.POST) 
	@ResponseBody 
	public Map<String, Object> getPIpgoStatusList(
			@RequestParam String sdate,
			@RequestParam String edate) {
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		Ipgo ipgo = new Ipgo();

		ipgo.setSdate(sdate);
		ipgo.setEdate(edate);


		List<Ipgo> pIpgoStatusList = operationService.getPIpgoStatusList(ipgo);

		List<HashMap<String, Object>> rtnList = new ArrayList<HashMap<String, Object>>();
		for(int i=0; i<pIpgoStatusList.size(); i++) {
			HashMap<String, Object> rowMap = new HashMap<String, Object>();
			rowMap.put("idx", (i+1));
			rowMap.put("ord_date", pIpgoStatusList.get(i).getOrd_date());
			rowMap.put("corp_name", pIpgoStatusList.get(i).getCorp_name());
			rowMap.put("prod_name", pIpgoStatusList.get(i).getProd_name());
			rowMap.put("prod_no", pIpgoStatusList.get(i).getProd_no());
			rowMap.put("ord_su", pIpgoStatusList.get(i).getOrd_su());
			rowMap.put("prod_dang", pIpgoStatusList.get(i).getProd_dang());
			rowMap.put("ord_mon", pIpgoStatusList.get(i).getOrd_mon());

			rtnList.add(rowMap);
		}

		rtnMap.put("last_page",1);
		rtnMap.put("data",rtnList);

		return rtnMap; 
	}


	//제품별출고현황 - 화면로드
	@RequestMapping(value = "/operation/pChulgoStatus", method = RequestMethod.GET)
	public String pChulgoStatus() {
		return "/operation/pChulgoStatus.jsp";
	}


	//제품별출고현황 조회
	@RequestMapping(value = "/operation/pChulgoStatus/getPChulgoStatusList", method = RequestMethod.POST) 
	@ResponseBody 
	public Map<String, Object> getPChulgoStatusList(
			@RequestParam String sdate,
			@RequestParam String edate) {
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		Chulgo chulgo = new Chulgo();

		chulgo.setSdate(sdate);
		chulgo.setEdate(edate);


		List<Chulgo> pChulgoStatusList = operationService.getPChulgoStatusList(chulgo);

		List<HashMap<String, Object>> rtnList = new ArrayList<HashMap<String, Object>>();
		for(int i=0; i<pChulgoStatusList.size(); i++) {
			HashMap<String, Object> rowMap = new HashMap<String, Object>();
			rowMap.put("idx", (i+1));
			rowMap.put("och_date", pChulgoStatusList.get(i).getOch_date());
			rowMap.put("corp_name", pChulgoStatusList.get(i).getCorp_name());
			rowMap.put("prod_name", pChulgoStatusList.get(i).getProd_name());
			rowMap.put("prod_no", pChulgoStatusList.get(i).getProd_no());
			rowMap.put("och_su", pChulgoStatusList.get(i).getOch_su());
			rowMap.put("och_amnt", pChulgoStatusList.get(i).getOch_amnt());
			rowMap.put("och_mon", pChulgoStatusList.get(i).getOch_mon());

			rtnList.add(rowMap);
		}

		rtnMap.put("last_page",1);
		rtnMap.put("data",rtnList);

		return rtnMap; 
	}

	//거래처별입고현황 - 화면로드
	@RequestMapping(value = "/operation/cuIpgoStatus", method = RequestMethod.GET)
	public String cuIpgoStatus() {
		return "/operation/cuIpgoStatus.jsp";
	}

	//거래처별입고현황 조회
	@RequestMapping(value = "/operation/cuIpgoStatus/getCuIpgoStatusList", method = RequestMethod.POST) 
	@ResponseBody 
	public Map<String, Object> getCuIpgoStatusList(
			@RequestParam String sdate,
			@RequestParam String edate) {
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		Ipgo ipgo = new Ipgo();

		ipgo.setSdate(sdate);
		ipgo.setEdate(edate);


		List<Ipgo> cuIpgoStatusList = operationService.getCuIpgoStatusList(ipgo);

		List<HashMap<String, Object>> rtnList = new ArrayList<HashMap<String, Object>>();
		for(int i=0; i<cuIpgoStatusList.size(); i++) {
			HashMap<String, Object> rowMap = new HashMap<String, Object>();
			rowMap.put("idx", (i+1));
			rowMap.put("ord_date", cuIpgoStatusList.get(i).getOrd_date());
			rowMap.put("corp_name", cuIpgoStatusList.get(i).getCorp_name());
			rowMap.put("ord_mon", cuIpgoStatusList.get(i).getOrd_mon());

			rtnList.add(rowMap);
		}

		rtnMap.put("last_page",1);
		rtnMap.put("data",rtnList);

		return rtnMap; 
	}

	//거래처별출고현황 - 화면로드
	@RequestMapping(value = "/operation/cuChulgoStatus", method = RequestMethod.GET)
	public String cuChulgoStatus() {
		return "/operation/cuChulgoStatus.jsp";
	}

	//거래처별출고현황 조회
	@RequestMapping(value = "/operation/cuChulgoStatus/getCuChulgoStatusList", method = RequestMethod.POST) 
	@ResponseBody 
	public Map<String, Object> getCuChulgoStatusList(
			@RequestParam String sdate,
			@RequestParam String edate) {
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		Chulgo chulgo = new Chulgo();

		chulgo.setSdate(sdate);
		chulgo.setEdate(edate);


		List<Chulgo> cuChulgoStatusList = operationService.getCuChulgoStatusList(chulgo);

		List<HashMap<String, Object>> rtnList = new ArrayList<HashMap<String, Object>>();
		for(int i=0; i<cuChulgoStatusList.size(); i++) {
			HashMap<String, Object> rowMap = new HashMap<String, Object>();
			rowMap.put("idx", (i+1));
			rowMap.put("och_date", cuChulgoStatusList.get(i).getOch_date());
			rowMap.put("corp_name", cuChulgoStatusList.get(i).getCorp_name());
			rowMap.put("och_mon", cuChulgoStatusList.get(i).getOch_mon());

			rtnList.add(rowMap);
		}

		rtnMap.put("last_page",1);
		rtnMap.put("data",rtnList);

		return rtnMap; 
	}

	//년간매출현황 - 화면로드
	@RequestMapping(value = "/operation/yearSale", method = RequestMethod.GET)
	public String yearSale() {
		return "/operation/yearSale.jsp";
	}	 
	
	//년간매출현황 조회
	@RequestMapping(value = "/operation/yearSale/getYearSaleList", method = RequestMethod.POST) 
	@ResponseBody 
	public Map<String, Object> getYearSaleList(
			@RequestParam String sdate
			) {
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		Chulgo chulgo = new Chulgo();

		chulgo.setSdate(sdate);


		List<Chulgo> yearSaleList = operationService.getYearSaleList(chulgo);

		List<HashMap<String, Object>> rtnList = new ArrayList<HashMap<String, Object>>();
		for(int i=0; i<yearSaleList.size(); i++) {
			HashMap<String, Object> rowMap = new HashMap<String, Object>();
			rowMap.put("idx", (i+1));
			rowMap.put("corp_name", yearSaleList.get(i).getCorp_name());
			rowMap.put("mm1", yearSaleList.get(i).getMm1());
			rowMap.put("mm2", yearSaleList.get(i).getMm2());
			rowMap.put("mm3", yearSaleList.get(i).getMm3());
			rowMap.put("mm4", yearSaleList.get(i).getMm4());
			rowMap.put("mm5", yearSaleList.get(i).getMm5());
			rowMap.put("mm6", yearSaleList.get(i).getMm6());
			rowMap.put("mm7", yearSaleList.get(i).getMm7());
			rowMap.put("mm8", yearSaleList.get(i).getMm8());
			rowMap.put("mm9", yearSaleList.get(i).getMm9());
			rowMap.put("mm10", yearSaleList.get(i).getMm10());
			rowMap.put("mm11", yearSaleList.get(i).getMm11());
			rowMap.put("mm12", yearSaleList.get(i).getMm12());
			rowMap.put("mm_total", yearSaleList.get(i).getMm_total());

			rtnList.add(rowMap);
		}

		rtnMap.put("last_page",1);
		rtnMap.put("data",rtnList);

		return rtnMap; 
	}
	
	
	@RequestMapping(value = "/operation/yearSale/getYearData", method = RequestMethod.POST) 
	@ResponseBody 
	public List<Chulgo> getYearData(@RequestParam String sdate, @RequestParam String corp_name) {
		Chulgo chulgo = new Chulgo();
		chulgo.setSdate(sdate);
		chulgo.setCorp_name(corp_name);

	    return operationService.getYearData(chulgo);
	}
	

	

	//월별불량현황 - 화면로드
	@RequestMapping(value = "/operation/monthBul", method = RequestMethod.GET)
	public String monthBul() {
		return "/operation/monthBul.jsp";
	}
	
	
	
	
	
	//월별불량현황 메인 조회
	@RequestMapping(value = "/operation/monthBul/getMonthBulList", method = RequestMethod.POST) 
	@ResponseBody 
	public Map<String, Object> getMonthBulList(
			@RequestParam String sdate
			) {
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		
		Work work = new Work();
		work.setSdate(sdate);
		List<Work> monthBulList = operationService.getMonthBulList(work);

		List<HashMap<String, Object>> rtnList = new ArrayList<HashMap<String, Object>>();
		for(int i=0; i<monthBulList.size(); i++) {
			HashMap<String, Object> rowMap = new HashMap<String, Object>();
			rowMap.put("idx", (i+1));
			rowMap.put("werr_gubn", monthBulList.get(i).getWerr_gubn());
			rowMap.put("m1", monthBulList.get(i).getM1());
			rowMap.put("m2", monthBulList.get(i).getM2());
			rowMap.put("m3", monthBulList.get(i).getM3());
			rowMap.put("m4", monthBulList.get(i).getM4());
			rowMap.put("m5", monthBulList.get(i).getM5());
			rowMap.put("m6", monthBulList.get(i).getM6());
			rowMap.put("m7", monthBulList.get(i).getM7());
			rowMap.put("m8", monthBulList.get(i).getM8());
			rowMap.put("m9", monthBulList.get(i).getM9());
			rowMap.put("m10", monthBulList.get(i).getM10());
			rowMap.put("m11", monthBulList.get(i).getM11());
			rowMap.put("m12", monthBulList.get(i).getM12());
			rowMap.put("average_SUM", monthBulList.get(i).getAverage_SUM());
			rowMap.put("werr_amnt_bymonth", monthBulList.get(i).getWerr_amnt_bymonth());
			rowMap.put("month", monthBulList.get(i).getMonth());

			rtnList.add(rowMap);
		}

		rtnMap.put("last_page",1);
		rtnMap.put("data",rtnList);

		return rtnMap; 
	}
	
	//월별불량현황 차트 조회
	@RequestMapping(value = "/operation/monthBul/getMonthBulChartData", method = RequestMethod.POST)
	@ResponseBody
	public List<Work> getMonthBulChartData(@RequestParam String sdate) {

	    Work work = new Work();
	    work.setSdate(sdate);

	    List<Work> chartDataList = operationService.getMonthBulChartData(work);

	    return chartDataList;
	}
	
	
	
	//월별불량현황 서브 조회
	@RequestMapping(value = "/operation/monthBul/getMonthBulSubList", method = RequestMethod.POST) 
	@ResponseBody 
	public Map<String, Object> getMonthBulSubList(
			@RequestParam String sdate
			) {
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		Work work = new Work();
		work.setSdate(sdate);
		List<Work> monthBulList = operationService.getMonthBulSubList(work);

		List<HashMap<String, Object>> rtnList = new ArrayList<HashMap<String, Object>>();
		for(int i=0; i<monthBulList.size(); i++) {
			HashMap<String, Object> rowMap = new HashMap<String, Object>();
			rowMap.put("werr_gubn", monthBulList.get(i).getWerr_gubn());
			rowMap.put("m1", monthBulList.get(i).getM1());
			rowMap.put("m2", monthBulList.get(i).getM2());
			rowMap.put("m3", monthBulList.get(i).getM3());
			rowMap.put("m4", monthBulList.get(i).getM4());
			rowMap.put("m5", monthBulList.get(i).getM5());
			rowMap.put("m6", monthBulList.get(i).getM6());
			rowMap.put("m7", monthBulList.get(i).getM7());
			rowMap.put("m8", monthBulList.get(i).getM8());
			rowMap.put("m9", monthBulList.get(i).getM9());
			rowMap.put("m10", monthBulList.get(i).getM10());
			rowMap.put("m11", monthBulList.get(i).getM11());
			rowMap.put("m12", monthBulList.get(i).getM12());
			rowMap.put("average_SUM", monthBulList.get(i).getAverage_SUM());
			rowMap.put("werr_amnt_bymonth", monthBulList.get(i).getWerr_amnt_bymonth());
			rowMap.put("month", monthBulList.get(i).getMonth());
			rowMap.put("quantityItem", monthBulList.get(i).getQuantityItem());
			rtnList.add(rowMap);
		}

		rtnMap.put("last_page",1);
		rtnMap.put("data",rtnList);

		return rtnMap; 
	}
		
		

	
	
	
	//월별거래처별불량현황 - 화면로드
	@RequestMapping(value = "/operation/cuMonthBul", method = RequestMethod.GET)
	public String cuMonthBul() {
		return "/operation/cuMonthBul.jsp";
	}	 
	
	
	//월별거래처별불량현황 메인 조회
	@RequestMapping(value = "/operation/cuMonthBul/getCuMonthBulList", method = RequestMethod.POST) 
	@ResponseBody 
	public Map<String, Object> getCuMonthBulList(
			@RequestParam String sdate, @RequestParam String werr_in_out_gubn
			) {
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		Work work = new Work();
		work.setSdate(sdate);
		work.setWerr_in_out_gubn(werr_in_out_gubn);
		
		List<Work> monthBulList = operationService.getCuMonthBulList(work);

		List<HashMap<String, Object>> rtnList = new ArrayList<HashMap<String, Object>>();
		for(int i=0; i<monthBulList.size(); i++) {
			HashMap<String, Object> rowMap = new HashMap<String, Object>();
			rowMap.put("idx", (i+1));
			rowMap.put("corp_name", monthBulList.get(i).getCorp_name());
			rowMap.put("och_su", monthBulList.get(i).getOch_su());
			rowMap.put("werr_su", monthBulList.get(i).getWerr_su());
			rowMap.put("werr_gubn1", monthBulList.get(i).getWerr_gubn1());
			rowMap.put("werr_gubn2", monthBulList.get(i).getWerr_gubn2());
			rowMap.put("werr_gubn3", monthBulList.get(i).getWerr_gubn3());
			rowMap.put("werr_gubn4", monthBulList.get(i).getWerr_gubn4());
			rowMap.put("werr_gubn5", monthBulList.get(i).getWerr_gubn5());
			rowMap.put("werr_gubn6", monthBulList.get(i).getWerr_gubn6());
			rowMap.put("werr_gubn7", monthBulList.get(i).getWerr_gubn7());
			rowMap.put("werr_gubn8", monthBulList.get(i).getWerr_gubn8());
			rowMap.put("werr_gubn9", monthBulList.get(i).getWerr_gubn9());
			rowMap.put("werr_gubn10", monthBulList.get(i).getWerr_gubn10());
			rowMap.put("ppm", monthBulList.get(i).getPpm());
			rowMap.put("och_mon", monthBulList.get(i).getOch_mon());
			rowMap.put("werr_mon", monthBulList.get(i).getWerr_mon());
			rowMap.put("ppm_mon", monthBulList.get(i).getPpm_mon());
			rowMap.put("werr_in_out_gubn", monthBulList.get(i).getWerr_in_out_gubn());

			rtnList.add(rowMap);
		}

		rtnMap.put("last_page",1);
		rtnMap.put("data",rtnList);

		return rtnMap; 
	}
	
	
	
	//월별불량현황 서브 조회
	@RequestMapping(value = "/operation/cuMonthBul/getCuBulSubList", method = RequestMethod.POST) 
	@ResponseBody 
	public Map<String, Object> getCuBulSubList(
			@RequestParam String sdate, @RequestParam String werr_in_out_gubn
			) {
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		Work work = new Work();
		work.setSdate(sdate);
		work.setWerr_in_out_gubn(werr_in_out_gubn);
		List<Work> monthBulList = operationService.getCuBulSubList(work);

		List<HashMap<String, Object>> rtnList = new ArrayList<HashMap<String, Object>>();
		for(int i=0; i<monthBulList.size(); i++) {
			HashMap<String, Object> rowMap = new HashMap<String, Object>();
			rowMap.put("werr_gubn", monthBulList.get(i).getWerr_gubn());
			rowMap.put("m1", monthBulList.get(i).getM1());
			rowMap.put("m2", monthBulList.get(i).getM2());
			rowMap.put("m3", monthBulList.get(i).getM3());
			rowMap.put("m4", monthBulList.get(i).getM4());
			rowMap.put("m5", monthBulList.get(i).getM5());
			rowMap.put("m6", monthBulList.get(i).getM6());
			rowMap.put("m7", monthBulList.get(i).getM7());
			rowMap.put("m8", monthBulList.get(i).getM8());
			rowMap.put("m9", monthBulList.get(i).getM9());
			rowMap.put("m10", monthBulList.get(i).getM10());
			rowMap.put("m11", monthBulList.get(i).getM11());
			rowMap.put("m12", monthBulList.get(i).getM12());
			rowMap.put("average_SUM", monthBulList.get(i).getAverage_SUM());
			rowMap.put("werr_amnt_bymonth", monthBulList.get(i).getWerr_amnt_bymonth());
			rowMap.put("werr_mon_bymonth", monthBulList.get(i).getWerr_mon_bymonth());
			rowMap.put("month", monthBulList.get(i).getMonth());
			rowMap.put("quantityItem", monthBulList.get(i).getQuantityItem());
			rowMap.put("ochulgo_amount_bymonth", monthBulList.get(i).getOchulgo_amount_bymonth());
			rowMap.put("ochulgo_mon_bymonth", monthBulList.get(i).getOchulgo_mon_bymonth());
			rowMap.put("workSu", monthBulList.get(i).getWorkSu());
			rowMap.put("ncmSu", monthBulList.get(i).getNcmSu());
			rtnList.add(rowMap);
		}

		rtnMap.put("last_page",1);
		rtnMap.put("data",rtnList);

		return rtnMap; 
	}

	
	
	
	
	
	
	
	
	
	
	

	//제품별작업실적 - 화면로드
	@RequestMapping(value = "/operation/prodSiljuk", method = RequestMethod.GET)
	public String prodSiljuk() {
		return "/operation/prodSiljuk.jsp";
	}

	//제품별작업실적 조회
	@RequestMapping(value = "/operation/prodSiljuk/getProdSiljukList", method = RequestMethod.POST) 
	@ResponseBody 
	public Map<String, Object> getProdSiljukList(
			@RequestParam String sdate,
			@RequestParam String edate) {
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		Siljuk siljuk = new Siljuk();

		siljuk.setSdate(sdate);
		siljuk.setEdate(edate);


		List<Siljuk> prodSiljukList = operationService.getProdSiljukList(siljuk);

		List<HashMap<String, Object>> rtnList = new ArrayList<HashMap<String, Object>>();
		for(int i=0; i<prodSiljukList.size(); i++) {
			HashMap<String, Object> rowMap = new HashMap<String, Object>();
			rowMap.put("idx", (i+1));
			rowMap.put("corp_name", prodSiljukList.get(i).getCorp_name());
			rowMap.put("prod_name", prodSiljukList.get(i).getProd_name());
			rowMap.put("prod_no", prodSiljukList.get(i).getProd_no());
			rowMap.put("ilbo_su", prodSiljukList.get(i).getIlbo_su());
			rowMap.put("ilbo_jung", prodSiljukList.get(i).getIlbo_jung());
			rowMap.put("ord_dang", prodSiljukList.get(i).getOrd_dang());
			rowMap.put("ilbo_mon", prodSiljukList.get(i).getIlbo_mon());

			rtnList.add(rowMap);
		}

		rtnMap.put("last_page",1);
		rtnMap.put("data",rtnList);

		return rtnMap; 
	}

	//설비별작업실적 - 화면로드
	@RequestMapping(value = "/operation/facSiljuk", method = RequestMethod.GET)
	public String facSiljuk() {
		return "/operation/facSiljuk.jsp";
	}


	//설비별작업실적 조회
	@RequestMapping(value = "/operation/facSiljuk/getFacSiljukList", method = RequestMethod.POST) 
	@ResponseBody 
	public Map<String, Object> getFacSiljukList(
			@RequestParam String sdate,
			@RequestParam String edate) {
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		Siljuk siljuk = new Siljuk();

		siljuk.setSdate(sdate);
		siljuk.setEdate(edate);


		List<Siljuk> facSiljukList = operationService.getFacSiljukList(siljuk);

		List<HashMap<String, Object>> rtnList = new ArrayList<HashMap<String, Object>>();
		for(int i=0; i<facSiljukList.size(); i++) {
			HashMap<String, Object> rowMap = new HashMap<String, Object>();
			rowMap.put("idx", (i+1));
			rowMap.put("ilbo_strt", facSiljukList.get(i).getIlbo_strt());
			rowMap.put("fac_name", facSiljukList.get(i).getFac_name());
			rowMap.put("tech_te", facSiljukList.get(i).getTech_te());
			rowMap.put("ilbo_su", facSiljukList.get(i).getIlbo_su());

			rtnList.add(rowMap);
		}

		rtnMap.put("last_page",1);
		rtnMap.put("data",rtnList);

		return rtnMap; 
	}



	//공지사항 - 화면로드
	@RequestMapping(value = "/operation/notice", method = RequestMethod.GET)
	public String notice() {
		return "/operation/notice.jsp";
	}
	
	
	//공지사항 조회
	@RequestMapping(value = "/operation/notice/getNoticeList", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getNoticeList() {
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		List<Users> noticeList = operationService.getNoticeList();

		List<HashMap<String, Object>> rtnList = new ArrayList<HashMap<String, Object>>();
		for(int i=0; i<noticeList.size(); i++) {
			HashMap<String, Object> rowMap = new HashMap<String, Object>();
			rowMap.put("idx", (i+1));
			rowMap.put("notice_code", noticeList.get(i).getNotice_code());
			rowMap.put("notice_name", noticeList.get(i).getNotice_name());
			rowMap.put("notice_memo", noticeList.get(i).getNotice_memo());
			rowMap.put("notice_user", noticeList.get(i).getNotice_user());
			rowMap.put("notice_date", noticeList.get(i).getNotice_date());
			rowMap.put("notice_views", noticeList.get(i).getNotice_views());
			rowMap.put("notice_dates", noticeList.get(i).getNotice_dates());
			rowMap.put("notice_datee", noticeList.get(i).getNotice_datee());

			rtnList.add(rowMap);
		}

		rtnMap.put("last_page",1);
		rtnMap.put("data",rtnList);

		return rtnMap;
	}

	//공지사항 등록/수정
	@RequestMapping(value = "/operation/notice/noticeSave", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> noticeSave(
			@RequestParam String mode,
			Users users,
			HttpServletRequest request
			) {
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		try {
			if("update".equals(mode)) {
				operationService.noticeUpdateSave(users);
			} else {
				UtilClass util = new UtilClass();
				Users loginUser = util.getSessionUser(request);
				if(loginUser != null) {
					users.setUser_code(loginUser.getUser_code());
					users.setNotice_user(loginUser.getUser_name());
				}
				operationService.noticeSave(users);
			}
			rtnMap.put("status", "success");
		} catch (Exception e) {
			rtnMap.put("status", "error");
			rtnMap.put("message", e.getMessage());
		}

		return rtnMap;
	}

	//공지사항 더블클릭 상세조회
	@RequestMapping(value = "/operation/notice/noticeDetail", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> noticeDetail(
			@RequestParam int notice_code
			) {
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		Users users = new Users();
		users.setNotice_code(notice_code);

		Users detail = operationService.noticeDetail(users);

		rtnMap.put("data", detail);

		return rtnMap;
	}

	//공지사항 삭제
	@RequestMapping(value = "/operation/notice/noticeDelete", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> noticeDelete(
			@RequestParam int notice_code
			) {
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		try {
			operationService.noticeDelete(notice_code);
			rtnMap.put("status", "success");
		} catch (Exception e) {
			rtnMap.put("status", "error");
			rtnMap.put("message", e.getMessage());
		}

		return rtnMap;
	}

	//월매출현황(마감) - 화면로드
	@RequestMapping(value = "/operation/monthSale", method = RequestMethod.GET)
	public String monthSale() {
		return "/operation/monthSale.jsp";
	}
	
	//월매출현황 조회
	@RequestMapping(value = "/operation/monthSale/getMonthSaleList", method = RequestMethod.POST) 
	@ResponseBody 
	public Map<String, Object> getMonthSaleList(
			@RequestParam String sdate,
			@RequestParam String corp_name
			) {
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		Chulgo chulgo = new Chulgo();

		chulgo.setSdate(sdate);
		chulgo.setCorp_name(corp_name);

		List<Chulgo> monthSaleList = operationService.getMonthSaleList(chulgo);

		List<HashMap<String, Object>> rtnList = new ArrayList<HashMap<String, Object>>();
		for(int i=0; i<monthSaleList.size(); i++) {
			HashMap<String, Object> rowMap = new HashMap<String, Object>();
			rowMap.put("idx", (i+1));
			rowMap.put("och_ma", monthSaleList.get(i).getOch_ma());
			rowMap.put("och_date", monthSaleList.get(i).getOch_date());
			rowMap.put("corp_name", monthSaleList.get(i).getCorp_name());
			rowMap.put("prod_name", monthSaleList.get(i).getProd_name());
			rowMap.put("prod_no", monthSaleList.get(i).getProd_no());
			rowMap.put("och_lot", monthSaleList.get(i).getOch_lot());
			rowMap.put("och_su", monthSaleList.get(i).getOch_su());
			rowMap.put("och_dang", monthSaleList.get(i).getOch_dang());
			rowMap.put("och_mon", monthSaleList.get(i).getOch_mon());
			rowMap.put("och_mon_tax", monthSaleList.get(i).getOch_mon_tax());
			rowMap.put("och_mon_total", monthSaleList.get(i).getOch_mon_total());

			rtnList.add(rowMap);
		}

		rtnMap.put("last_page",1);
		rtnMap.put("data",rtnList);

		return rtnMap;
	}

	//월매출현황(마감) - 엑셀 다운로드(거래처별 소계 행 노란색 강조는 SheetJS 무료버전이 셀 스타일
	//쓰기를 지원하지 않아 클라이언트에서는 불가능 - 서버에서 Apache POI로 직접 생성)
	@RequestMapping(value = "/operation/monthSale/excelDownload", method = RequestMethod.GET)
	public void monthSaleExcelDownload(
			@RequestParam String sdate,
			@RequestParam(required = false) String corp_name,
			HttpServletResponse response
			) throws IOException {

		Chulgo chulgo = new Chulgo();
		chulgo.setSdate(sdate);
		chulgo.setCorp_name(corp_name);

		List<Chulgo> list = operationService.getMonthSaleList(chulgo);

		String[] headers = {"NO","마감월","출고일","거래처","품명","품번","LOT NO","수량","단가","공급가액","부가세","합계금액"};
		int[] colWidths = {2000,3200,3200,5500,5500,4500,3500,3000,3500,4000,3500,4000};

		try (XSSFWorkbook wb = new XSSFWorkbook()) {
			Sheet sheet = wb.createSheet("월매출현황");

			CellStyle headerStyle = wb.createCellStyle();
			Font headerFont = wb.createFont();
			headerFont.setBold(true);
			headerStyle.setFont(headerFont);
			headerStyle.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
			headerStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
			headerStyle.setBorderBottom(BorderStyle.THIN);
			headerStyle.setAlignment(org.apache.poi.ss.usermodel.HorizontalAlignment.CENTER);

			CellStyle bodyStyle = wb.createCellStyle();
			bodyStyle.setBorderBottom(BorderStyle.THIN);

			CellStyle numStyle = wb.createCellStyle();
			numStyle.cloneStyleFrom(bodyStyle);
			numStyle.setDataFormat(wb.createDataFormat().getFormat("#,##0"));

			CellStyle subtotalStyle = wb.createCellStyle();
			Font subtotalFont = wb.createFont();
			subtotalFont.setBold(true);
			subtotalStyle.setFont(subtotalFont);
			subtotalStyle.setFillForegroundColor(IndexedColors.YELLOW.getIndex());
			subtotalStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
			subtotalStyle.setBorderBottom(BorderStyle.THIN);

			CellStyle subtotalNumStyle = wb.createCellStyle();
			subtotalNumStyle.cloneStyleFrom(subtotalStyle);
			subtotalNumStyle.setDataFormat(wb.createDataFormat().getFormat("#,##0"));

			int rowIdx = 0;
			Row headerRow = sheet.createRow(rowIdx++);
			for (int c = 0; c < headers.length; c++) {
				Cell cell = headerRow.createCell(c);
				cell.setCellValue(headers[c]);
				cell.setCellStyle(headerStyle);
				sheet.setColumnWidth(c, colWidths[c]);
			}

			String curCorp = null;
			float sumSu = 0; double sumMon = 0; double sumTax = 0; double sumTotal = 0;

			for (int i = 0; i <= list.size(); i++) {
				Chulgo c = (i < list.size()) ? list.get(i) : null;
				String corpName = (c != null) ? c.getCorp_name() : null;

				if (curCorp != null && !curCorp.equals(corpName)) {
					Row subRow = sheet.createRow(rowIdx++);
					for (int col = 0; col < headers.length; col++) {
						subRow.createCell(col).setCellStyle(
								(col == 7 || col == 9 || col == 10 || col == 11) ? subtotalNumStyle : subtotalStyle);
					}
					subRow.getCell(3).setCellValue("[ " + curCorp + " ] 소계");
					subRow.getCell(7).setCellValue(sumSu);
					subRow.getCell(9).setCellValue(sumMon);
					subRow.getCell(10).setCellValue(sumTax);
					subRow.getCell(11).setCellValue(sumTotal);

					sumSu = 0; sumMon = 0; sumTax = 0; sumTotal = 0;
				}

				if (c == null) break;

				double mon = parseNum(c.getOch_mon());

				Row row = sheet.createRow(rowIdx++);
				row.createCell(0).setCellValue(i + 1);
				row.getCell(0).setCellStyle(numStyle);
				row.createCell(1).setCellValue(c.getOch_ma()); row.getCell(1).setCellStyle(bodyStyle);
				row.createCell(2).setCellValue(c.getOch_date()); row.getCell(2).setCellStyle(bodyStyle);
				row.createCell(3).setCellValue(c.getCorp_name()); row.getCell(3).setCellStyle(bodyStyle);
				row.createCell(4).setCellValue(c.getProd_name()); row.getCell(4).setCellStyle(bodyStyle);
				row.createCell(5).setCellValue(c.getProd_no()); row.getCell(5).setCellStyle(bodyStyle);
				row.createCell(6).setCellValue(c.getOch_lot()); row.getCell(6).setCellStyle(bodyStyle);

				Cell suCell = row.createCell(7); suCell.setCellValue(c.getOch_su()); suCell.setCellStyle(numStyle);
				Cell dangCell = row.createCell(8); dangCell.setCellValue(parseNum(c.getOch_dang())); dangCell.setCellStyle(numStyle);
				Cell monCell = row.createCell(9); monCell.setCellValue(mon); monCell.setCellStyle(numStyle);
				Cell taxCell = row.createCell(10); taxCell.setCellValue(c.getOch_mon_tax()); taxCell.setCellStyle(numStyle);
				Cell totalCell = row.createCell(11); totalCell.setCellValue(c.getOch_mon_total()); totalCell.setCellStyle(numStyle);

				sumSu += c.getOch_su();
				sumMon += mon;
				sumTax += c.getOch_mon_tax();
				sumTotal += c.getOch_mon_total();

				curCorp = corpName;
			}

			sheet.createFreezePane(0, 1);

			String fileName = "월매출현황_" + new SimpleDateFormat("yyyyMMdd").format(new Date()) + ".xlsx";
			String encodedFileName = URLEncoder.encode(fileName, "UTF-8").replace("+", "%20");

			response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
			response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"; filename*=UTF-8''" + encodedFileName);

			wb.write(response.getOutputStream());
			response.getOutputStream().flush();
		}
	}

	//월매출현황(마감) - 보고서(PDF) 출력, 화면에 현재 조회된 조건 그대로 재사용
	@RequestMapping(value = "/operation/monthSale/report", method = RequestMethod.GET)
	public void monthSaleReport(
			@RequestParam String sdate,
			@RequestParam(required = false) String corp_name,
			HttpServletRequest request,
			HttpServletResponse response
			) throws IOException, JRException {

		Chulgo chulgo = new Chulgo();
		chulgo.setSdate(sdate);
		chulgo.setCorp_name(corp_name);

		List<Chulgo> list = operationService.getMonthSaleList(chulgo);

		String reportPath = request.getServletContext().getRealPath("/WEB-INF/resources/reports/MonthSaleReport.jrxml");
		JasperReport report = JasperCompileManager.compileReport(reportPath);

		//거래처 검색은 부분일치(like)라 입력한 검색어(예: "남경")와 실제 거래처명(예: "(주)남경정밀")이
		//다를 수 있음 - 제목에는 검색어가 아니라 실제로 조회된 거래처명을 그대로 보여줌
		String titleCorp;
		if (corp_name == null || corp_name.trim().isEmpty()) {
			titleCorp = "전체";
		} else {
			LinkedHashSet<String> distinctCorps = new LinkedHashSet<String>();
			for (Chulgo c : list) {
				distinctCorps.add(c.getCorp_name());
			}
			titleCorp = distinctCorps.isEmpty() ? corp_name : String.join(", ", distinctCorps);
		}

		Map<String, Object> reportMap = new HashMap<String, Object>();
		reportMap.put("title_sdate", sdate);
		reportMap.put("title_corp", titleCorp);

		JRBeanCollectionDataSource dataSource = new JRBeanCollectionDataSource(list);
		JasperPrint jasperPrint = JasperFillManager.fillReport(report, reportMap, dataSource);
		byte[] pdfBytes = JasperExportManager.exportReportToPdf(jasperPrint);

		String fileName = "월매출현황_" + sdate + ".pdf";
		String encodedFileName = URLEncoder.encode(fileName, "UTF-8").replace("+", "%20");

		response.setContentType("application/pdf");
		response.setHeader("Content-Disposition", "inline; filename=\"" + fileName + "\"; filename*=UTF-8''" + encodedFileName);
		response.setContentLength(pdfBytes.length);
		response.getOutputStream().write(pdfBytes);
		response.getOutputStream().flush();
	}

	//문자열로 저장된 금액 컬럼(och_dang/och_mon)을 안전하게 숫자로 변환 - 공백/빈값이면 0
	private double parseNum(String s) {
		if (s == null || s.trim().isEmpty()) return 0;
		try {
			return Double.parseDouble(s.replace(",", "").trim());
		} catch (NumberFormatException e) {
			return 0;
		}
	}

	//일일매출현황 조회
	@RequestMapping(value = "/operation/daySale/getDaySaleList", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getDaySaleList(
	        @RequestParam String sdate,
	        @RequestParam String edate,        // 추가
	        @RequestParam String corp_name
	) {
	    Map<String, Object> rtnMap = new HashMap<>();
	    Chulgo chulgo = new Chulgo();
	    chulgo.setSdate(sdate);
	    chulgo.setEdate(edate);            // 추가
	    chulgo.setCorp_name(corp_name);

	    List<Chulgo> daySaleList = operationService.getDaySaleList(chulgo);

	    List<HashMap<String, Object>> rtnList = new ArrayList<>();
	    for(int i=0; i<daySaleList.size(); i++) {
	        HashMap<String, Object> rowMap = new HashMap<>();
	        rowMap.put("idx", i+1);
	        rowMap.put("och_ma", daySaleList.get(i).getOch_ma());
	        rowMap.put("och_date", daySaleList.get(i).getOch_date());
	        rowMap.put("corp_name", daySaleList.get(i).getCorp_name());
	        rowMap.put("prod_name", daySaleList.get(i).getProd_name());
	        rowMap.put("prod_no", daySaleList.get(i).getProd_no());
	        rowMap.put("och_lot", daySaleList.get(i).getOch_lot());
	        rowMap.put("och_su", daySaleList.get(i).getOch_su());
	        rowMap.put("och_dang", daySaleList.get(i).getOch_dang());
	        rowMap.put("och_mon", daySaleList.get(i).getOch_mon());
	        rowMap.put("och_mon_tax", daySaleList.get(i).getOch_mon_tax());
	        rowMap.put("och_mon_total", daySaleList.get(i).getOch_mon_total());

	        rtnList.add(rowMap);
	    }

	    rtnMap.put("last_page",1);
	    rtnMap.put("data",rtnList);

	    return rtnMap;
	}

	
	//KPI - 화면로드
		@RequestMapping(value = "/operation/kpi", method = RequestMethod.GET)
		public String kpi() {
			return "/operation/kpi.jsp";
		}
		
		
		//일일매출현황 - 화면로드
		@RequestMapping(value = "/operation/daySale", method = RequestMethod.GET)
		public String daySale() {
			return "/operation/daySale.jsp";
		}	
		
		//일일매출현황 - 화면로드
		@RequestMapping(value = "/operation/ipgoChulgo", method = RequestMethod.GET)
		public String ipgoChulgo() {
			return "/operation/ipgoChulgo.jsp";
		}	
}
