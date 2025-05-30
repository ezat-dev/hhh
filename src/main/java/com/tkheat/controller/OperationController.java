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
			rowMap.put("ord_dang", pIpgoStatusList.get(i).getOrd_dang());
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

	//월별불량현황 - 화면로드
	@RequestMapping(value = "/operation/monthBul", method = RequestMethod.GET)
	public String monthBul() {
		return "/operation/monthBul.jsp";
	}	 

	//월별거래처별불량현황 - 화면로드
	@RequestMapping(value = "/operation/cuMonthBul", method = RequestMethod.GET)
	public String cuMonthBul() {
		return "/operation/cuMonthBul.jsp";
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

}
