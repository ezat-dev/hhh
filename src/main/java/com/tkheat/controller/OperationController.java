package com.tkheat.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
			rowMap.put("notice_name", noticeList.get(i).getNotice_name());
			rowMap.put("notice_memo", noticeList.get(i).getNotice_memo());
			rowMap.put("notice_user", noticeList.get(i).getNotice_user());

			rtnList.add(rowMap);
		}

		rtnMap.put("last_page",1);
		rtnMap.put("data",rtnList);

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

}
