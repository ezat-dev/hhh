package com.tkheat.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tkheat.domain.Kpi;
import com.tkheat.service.KpiService;

@Controller
public class KpiController {

	@Autowired
	private KpiService kpiService;

	//KPI관리현황 - 화면로드
	@RequestMapping(value = "/quality/kpiStatus", method = RequestMethod.GET)
	public String kpiStatus() {
		return "/quality/kpiStatus.jsp";
	}

	//연도별 KPI 목록 조회
	@RequestMapping(value = "/quality/kpiStatus/getKpiList", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getKpiList(@RequestParam("year") int year) {
		Map<String, Object> result = new HashMap<>();

		Kpi param = new Kpi();
		param.setYear(year);

		List<Kpi> list = kpiService.getKpiList(param);
		result.put("status", "success");
		result.put("data", list);
		return result;
	}

	//등록된 연도 목록 조회(연도 선택 콤보용)
	@RequestMapping(value = "/quality/kpiStatus/getYearList", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getYearList() {
		Map<String, Object> result = new HashMap<>();
		result.put("status", "success");
		result.put("data", kpiService.getKpiYearList());
		return result;
	}

	//계획/실적 셀 하나 저장 (화면에서 셀 클릭 후 수정)
	@RequestMapping(value = "/quality/kpiStatus/saveDataCell", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> saveDataCell(
			@RequestParam("kpi_seq") int kpi_seq,
			@RequestParam("year") int year,
			@RequestParam("row_type") String row_type,
			@RequestParam("month") int month,
			@RequestParam("value") Double value) {
		Map<String, Object> result = new HashMap<>();

		try {
			if (month < 1 || month > 12) {
				throw new IllegalArgumentException("month는 1~12 사이여야 합니다.");
			}
			if (!"PLAN".equals(row_type) && !"ACTUAL".equals(row_type)) {
				throw new IllegalArgumentException("row_type은 PLAN 또는 ACTUAL이어야 합니다.");
			}

			Kpi kpi = new Kpi();
			kpi.setKpi_seq(kpi_seq);
			kpi.setYear(year);
			kpi.setRow_type(row_type);
			kpi.setMonth(month);
			kpi.setValue(value);

			kpiService.saveDataCell(kpi);
			result.put("status", "success");
		} catch (Exception e) {
			result.put("status", "error");
			result.put("message", e.getMessage());
		}

		return result;
	}

	//담당자/비고 저장
	@RequestMapping(value = "/quality/kpiStatus/saveMeta", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> saveMeta(
			@RequestParam("kpi_seq") int kpi_seq,
			@RequestParam("year") int year,
			@RequestParam(value = "manager_name", required = false) String manager_name,
			@RequestParam(value = "note", required = false) String note) {
		Map<String, Object> result = new HashMap<>();

		try {
			Kpi kpi = new Kpi();
			kpi.setKpi_seq(kpi_seq);
			kpi.setYear(year);
			kpi.setManager_name(manager_name);
			kpi.setNote(note);

			kpiService.saveMeta(kpi);
			result.put("status", "success");
		} catch (Exception e) {
			result.put("status", "error");
			result.put("message", e.getMessage());
		}

		return result;
	}

	//대분류(프로세스명) 목록 조회 - 새 항목 추가 모달의 기존 프로세스 선택용
	@RequestMapping(value = "/quality/kpiStatus/getProcessList", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getProcessList() {
		Map<String, Object> result = new HashMap<>();
		result.put("status", "success");
		result.put("data", kpiService.getProcessList());
		return result;
	}

	//새 성과지표 항목 추가 (프로세스명을 새로 입력하면 대분류 자체도 새로 생김)
	@RequestMapping(value = "/quality/kpiStatus/addItem", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> addItem(
			@RequestParam("process_name") String process_name,
			@RequestParam("kpi_name") String kpi_name,
			@RequestParam(value = "unit", required = false) String unit,
			@RequestParam("agg_type") String agg_type) {
		Map<String, Object> result = new HashMap<>();

		try {
			process_name = process_name == null ? "" : process_name.trim();
			kpi_name = kpi_name == null ? "" : kpi_name.trim();
			if (process_name.isEmpty() || kpi_name.isEmpty()) {
				throw new IllegalArgumentException("프로세스명과 성과지표명은 필수입니다.");
			}
			if (!"SUM".equals(agg_type) && !"AVG".equals(agg_type)) {
				throw new IllegalArgumentException("agg_type은 SUM 또는 AVG이어야 합니다.");
			}

			Kpi kpi = new Kpi();
			kpi.setProcess_name(process_name);
			kpi.setKpi_name(kpi_name);
			kpi.setUnit(unit);
			kpi.setAgg_type(agg_type);

			kpiService.addKpiItem(kpi);
			result.put("status", "success");
		} catch (Exception e) {
			result.put("status", "error");
			result.put("message", e.getMessage());
		}

		return result;
	}

	//성과지표명/단위/집계방식 수정
	@RequestMapping(value = "/quality/kpiStatus/updateItem", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> updateItem(
			@RequestParam("kpi_seq") int kpi_seq,
			@RequestParam("kpi_name") String kpi_name,
			@RequestParam(value = "unit", required = false) String unit,
			@RequestParam("agg_type") String agg_type) {
		Map<String, Object> result = new HashMap<>();

		try {
			kpi_name = kpi_name == null ? "" : kpi_name.trim();
			if (kpi_name.isEmpty()) {
				throw new IllegalArgumentException("성과지표명은 필수입니다.");
			}
			if (!"SUM".equals(agg_type) && !"AVG".equals(agg_type)) {
				throw new IllegalArgumentException("agg_type은 SUM 또는 AVG이어야 합니다.");
			}

			Kpi kpi = new Kpi();
			kpi.setKpi_seq(kpi_seq);
			kpi.setKpi_name(kpi_name);
			kpi.setUnit(unit);
			kpi.setAgg_type(agg_type);

			kpiService.updateKpiItem(kpi);
			result.put("status", "success");
		} catch (Exception e) {
			result.put("status", "error");
			result.put("message", e.getMessage());
		}

		return result;
	}

	//항목 삭제(그 항목의 전체 연도 데이터 포함)
	@RequestMapping(value = "/quality/kpiStatus/deleteItem", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteItem(@RequestParam("kpi_seq") int kpi_seq) {
		Map<String, Object> result = new HashMap<>();

		try {
			Kpi kpi = new Kpi();
			kpi.setKpi_seq(kpi_seq);
			kpiService.deleteKpiItem(kpi);
			result.put("status", "success");
		} catch (Exception e) {
			result.put("status", "error");
			result.put("message", e.getMessage());
		}

		return result;
	}
}
