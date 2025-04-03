package com.tkheat.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tkheat.domain.Chulgo;
import com.tkheat.domain.Gongjung;
import com.tkheat.domain.Ipgo;
import com.tkheat.domain.Jaego;
import com.tkheat.service.ProductService;

@Controller
public class ProductController {

	@Autowired
	private ProductService productService;

	//입고관리 - 화면로드
	@RequestMapping(value = "/product/ipgo", method = RequestMethod.GET)
	public String ipgo() {
		return "/product/ipgo.jsp";
	}	 

	//입고관리 조회
	@RequestMapping(value = "/product/ipgo/getIpgoList", method = RequestMethod.POST) 
	@ResponseBody 
	public Map<String, Object> getIpgoList() {
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		Ipgo ipgo = new Ipgo();
		ipgo.setSdate("2024-02-01 00:00:00");
		ipgo.setEdate("2024-02-20 23:59:59");
		
		List<Ipgo> ipgoList = productService.getIpgoList(ipgo);

		List<HashMap<String, Object>> rtnList = new ArrayList<HashMap<String, Object>>();
		for(int i=0; i<ipgoList.size(); i++) {
			HashMap<String, Object> rowMap = new HashMap<String, Object>();
			rowMap.put("idx", (i+1));
			rowMap.put("ord_prn", ipgoList.get(i).getOrd_prn());
			rowMap.put("ord_code", ipgoList.get(i).getOrd_code());
			rowMap.put("ord_date", ipgoList.get(i).getOrd_date());
			rowMap.put("ord_nap", ipgoList.get(i).getOrd_nap());
			rowMap.put("corp_name", ipgoList.get(i).getCorp_name());
			rowMap.put("prod_name", ipgoList.get(i).getProd_name());
			rowMap.put("prod_no", ipgoList.get(i).getProd_no());
			rowMap.put("prod_gyu", ipgoList.get(i).getProd_gyu());
			rowMap.put("prod_jai", ipgoList.get(i).getProd_jai());
			rowMap.put("tech_te", ipgoList.get(i).getTech_te());
			rowMap.put("ord_danw", ipgoList.get(i).getOrd_danw());
			rowMap.put("ord_boxsu", ipgoList.get(i).getOrd_boxsu());
			rowMap.put("ord_su", ipgoList.get(i).getOrd_su());
			rowMap.put("ord_amnt", ipgoList.get(i).getOrd_amnt());
			rowMap.put("ord_lot", ipgoList.get(i).getOrd_lot());
			rowMap.put("itst_wp", ipgoList.get(i).getItst_wp());
			rowMap.put("ord_name", ipgoList.get(i).getOrd_name());
			rowMap.put("ord_sunip", ipgoList.get(i).getOrd_sunip());
			rowMap.put("ord_bigo", ipgoList.get(i).getOrd_bigo());
			rowMap.put("prod_pg", ipgoList.get(i).getProd_pg());
			rowMap.put("prod_cd", ipgoList.get(i).getProd_cd());
			rowMap.put("prod_sg", ipgoList.get(i).getProd_sg());
			rowMap.put("prod_e1", ipgoList.get(i).getProd_e1());


			rtnList.add(rowMap);
		}

		rtnMap.put("last_page",1);
		rtnMap.put("data",rtnList);

		return rtnMap; 
	}



	//출고관리 - 화면로드
	@RequestMapping(value = "/product/chulgo", method = RequestMethod.GET)
	public String chulgo() {
		return "/product/chulgo.jsp";
	}	 

	//출고관리 조회
	@RequestMapping(value = "/product/chulgo/getChulgoList", method = RequestMethod.POST) 
	@ResponseBody 
	public Map<String, Object> getChulgoList() {
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		List<Chulgo> chulgoList = productService.getChulgoList();

		List<HashMap<String, Object>> rtnList = new ArrayList<HashMap<String, Object>>();
		for(int i=0; i<chulgoList.size(); i++) {
			HashMap<String, Object> rowMap = new HashMap<String, Object>();
			rowMap.put("idx", (i+1));
			rowMap.put("och_prn", chulgoList.get(i).getOch_prn());
			rowMap.put("ord_date", chulgoList.get(i).getOrd_date());
			rowMap.put("och_date", chulgoList.get(i).getOch_date());
			rowMap.put("och_code", chulgoList.get(i).getOch_code());
			rowMap.put("corp_name", chulgoList.get(i).getCorp_name());
			rowMap.put("prod_name", chulgoList.get(i).getProd_name());
			rowMap.put("prod_no", chulgoList.get(i).getProd_no());
			rowMap.put("prod_jai", chulgoList.get(i).getProd_jai());
			rowMap.put("prod_gyu", chulgoList.get(i).getProd_gyu());
			rowMap.put("tech_te", chulgoList.get(i).getTech_te());
			rowMap.put("och_lot", chulgoList.get(i).getOch_lot());
			rowMap.put("prod_danw", chulgoList.get(i).getProd_danw());
			rowMap.put("och_su", chulgoList.get(i).getOch_su());
			rowMap.put("och_amnt", chulgoList.get(i).getOch_amnt());
			rowMap.put("och_mon", chulgoList.get(i).getOch_mon());
			rowMap.put("och_dang", chulgoList.get(i).getOch_dang());
			rowMap.put("prod_danj", chulgoList.get(i).getProd_danj());
			rowMap.put("och_ma", chulgoList.get(i).getOch_ma());
			rowMap.put("och_bigo", chulgoList.get(i).getOch_bigo());


			rtnList.add(rowMap);
		}

		rtnMap.put("last_page",1);
		rtnMap.put("data",rtnList);

		return rtnMap; 
	}


	//재고현황(상세정보) - 화면로드
	@RequestMapping(value = "/product/jaegoStatus", method = RequestMethod.GET)
	public String jaegoStatus() {
		return "/product/jaegoStatus.jsp";
	}	 

	//재고현황(상세정보) 조회
	@RequestMapping(value = "/product/jaegoStatus/getJaegoStatusList", method = RequestMethod.POST) 
	@ResponseBody 
	public Map<String, Object> getJaegoStatusList() {
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		List<Jaego> jaegoList = productService.getJaegoStatusList();

		List<HashMap<String, Object>> rtnList = new ArrayList<HashMap<String, Object>>();
		for(int i=0; i<jaegoList.size(); i++) {
			HashMap<String, Object> rowMap = new HashMap<String, Object>();
			rowMap.put("idx", (i+1));
			rowMap.put("ord_code", jaegoList.get(i).getOrd_code());
			rowMap.put("ord_date", jaegoList.get(i).getOrd_date());
			rowMap.put("corp_name", jaegoList.get(i).getCorp_name());
			rowMap.put("prod_name", jaegoList.get(i).getProd_name());
			rowMap.put("prod_no", jaegoList.get(i).getProd_no());
			rowMap.put("prod_jai", jaegoList.get(i).getProd_jai());
			rowMap.put("prod_gyu", jaegoList.get(i).getProd_gyu());
			rowMap.put("tech_te", jaegoList.get(i).getTech_te());
			rowMap.put("ord_lot", jaegoList.get(i).getOrd_lot());
			rowMap.put("ord_dang", jaegoList.get(i).getOrd_dang());
			rowMap.put("ord_danj", jaegoList.get(i).getOrd_danj());
			rowMap.put("ord_su", jaegoList.get(i).getOrd_su());
			rowMap.put("ord_amnt", jaegoList.get(i).getOrd_amnt());
			rowMap.put("jaigo_su", jaegoList.get(i).getJaigo_su());
			rowMap.put("jaigo_amnt", jaegoList.get(i).getJaigo_amnt());
			rowMap.put("ord_bigo", jaegoList.get(i).getOrd_bigo());
			rowMap.put("ord_name", jaegoList.get(i).getOrd_name());
			rowMap.put("ord_danw", jaegoList.get(i).getOrd_danw());
			rowMap.put("och_mon", jaegoList.get(i).getOch_mon());
			rowMap.put("och_bigo", jaegoList.get(i).getOch_bigo());


			rtnList.add(rowMap);
		}

		rtnMap.put("last_page",1);
		rtnMap.put("data",rtnList);

		return rtnMap; 
	}

	//제품별재고현황 - 화면로드
	@RequestMapping(value = "/product/pJaegoStatus", method = RequestMethod.GET)
	public String pJaegoStatus() {
		return "/product/pJaegoStatus.jsp";
	}
	
	//재고현황(상세정보) 조회
		@RequestMapping(value = "/product/pjaegoStatus/getPJaegoStatusList", method = RequestMethod.POST) 
		@ResponseBody 
		public Map<String, Object> getPJaegoStatusList() {
			Map<String, Object> rtnMap = new HashMap<String, Object>();

			List<Jaego> pJaegoList = productService.getPJaegoStatusList();

			List<HashMap<String, Object>> rtnList = new ArrayList<HashMap<String, Object>>();
			for(int i=0; i<pJaegoList.size(); i++) {
				HashMap<String, Object> rowMap = new HashMap<String, Object>();
				rowMap.put("idx", (i+1));
				rowMap.put("corp_name", pJaegoList.get(i).getCorp_name());
				rowMap.put("prod_name", pJaegoList.get(i).getProd_name());
				rowMap.put("prod_gyu", pJaegoList.get(i).getProd_gyu());
				rowMap.put("prod_no", pJaegoList.get(i).getProd_no());
				rowMap.put("prod_jai", pJaegoList.get(i).getProd_jai());
				rowMap.put("tech_te", pJaegoList.get(i).getTech_te());
				rowMap.put("prod_danw", pJaegoList.get(i).getProd_danw());
				rowMap.put("prod_dang", pJaegoList.get(i).getOrd_dang());
				rowMap.put("prod_danj", pJaegoList.get(i).getOrd_danj());
				rowMap.put("pjai_pre", pJaegoList.get(i).getPjai_pre());
				rowMap.put("pjai_ip", pJaegoList.get(i).getPjai_ip());
				rowMap.put("pjai_ch", pJaegoList.get(i).getPjai_ch());
				rowMap.put("pjai_jai", pJaegoList.get(i).getPjai_jai());
				rowMap.put("pjai_jai_j", pJaegoList.get(i).getPjai_jai_j());
				rowMap.put("pjai_jai_mon", pJaegoList.get(i).getPjai_jai_mon());
				rowMap.put("pjai_jo", pJaegoList.get(i).getPjai_jo());
				rowMap.put("pjai_jo_j", pJaegoList.get(i).getPjai_jo_j());
				rowMap.put("pjai_real", pJaegoList.get(i).getPjai_real());
				rowMap.put("pjai_real_j", pJaegoList.get(i).getPjai_real_j());
				rowMap.put("pjai_real_mon", pJaegoList.get(i).getPjai_real_mon());
				rowMap.put("och_bigo", pJaegoList.get(i).getOch_bigo());
				rowMap.put("corp_business", pJaegoList.get(i).getCorp_business());


				rtnList.add(rowMap);
			}

			rtnMap.put("last_page",1);
			rtnMap.put("data",rtnList);

			return rtnMap; 
		}

	//출고대기현황 - 화면로드
	@RequestMapping(value = "/product/chulgoWaiting", method = RequestMethod.GET)
	public String chulgoWaiting() {
		return "/product/chulgoWaiting.jsp";
	}

	//출고대기현황 조회
	@RequestMapping(value = "/product/chulgoWaiting/getChulgoWaitingList", method = RequestMethod.POST) 
	@ResponseBody 
	public Map<String, Object> getChulgoWaitingList() {
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		List<Chulgo> chulgoWaitingList = productService.getChulgoWaitingList();

		List<HashMap<String, Object>> rtnList = new ArrayList<HashMap<String, Object>>();
		for(int i=0; i<chulgoWaitingList.size(); i++) {
			HashMap<String, Object> rowMap = new HashMap<String, Object>();
			rowMap.put("idx", (i+1));
			rowMap.put("ord_code", chulgoWaitingList.get(i).getOrd_code());
			rowMap.put("ord_date", chulgoWaitingList.get(i).getOrd_date());
			rowMap.put("corp_name", chulgoWaitingList.get(i).getCorp_name());
			rowMap.put("prod_name", chulgoWaitingList.get(i).getProd_name());
			rowMap.put("prod_no", chulgoWaitingList.get(i).getProd_no());
			rowMap.put("prod_gyu", chulgoWaitingList.get(i).getProd_gyu());
			rowMap.put("ord_danw", chulgoWaitingList.get(i).getOrd_danw());
			rowMap.put("ord_su", chulgoWaitingList.get(i).getOrd_su());
			rowMap.put("och_su", chulgoWaitingList.get(i).getOch_su());
			rowMap.put("jaego_su", chulgoWaitingList.get(i).getJaego_su());


			rtnList.add(rowMap);
		}

		rtnMap.put("last_page",1);
		rtnMap.put("data",rtnList);

		return rtnMap; 
	}

	//공정작업현황 - 화면로드
	@RequestMapping(value = "/product/workStatus", method = RequestMethod.GET)
	public String workStatus() {
		return "/product/workStatus.jsp";
	}	 

	//공정작업현황 조회
	@RequestMapping(value = "/product/workStatus/getWorkStatusList", method = RequestMethod.POST) 
	@ResponseBody 
	public Map<String, Object> getWorkStatusList() {
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		List<Gongjung> workStatusList = productService.getWorkStatusList();

		List<HashMap<String, Object>> rtnList = new ArrayList<HashMap<String, Object>>();
		for(int i=0; i<workStatusList.size(); i++) {
			HashMap<String, Object> rowMap = new HashMap<String, Object>();
			rowMap.put("idx", (i+1));
			rowMap.put("ord_name", workStatusList.get(i).getOrd_name());
			rowMap.put("ord_code", workStatusList.get(i).getOrd_code());
			rowMap.put("corp_name", workStatusList.get(i).getCorp_name());
			rowMap.put("prod_name", workStatusList.get(i).getProd_name());
			rowMap.put("prod_no", workStatusList.get(i).getProd_no());
			rowMap.put("prod_gyu", workStatusList.get(i).getProd_gyu());
			rowMap.put("prod_jai", workStatusList.get(i).getProd_jai());
			rowMap.put("ord_su", workStatusList.get(i).getOrd_su());
			rowMap.put("prod_j", workStatusList.get(i).getProd_j());
			rowMap.put("prod_p", workStatusList.get(i).getProd_j());
			rowMap.put("prod_a", workStatusList.get(i).getProd_j());
			rowMap.put("prod_h", workStatusList.get(i).getProd_j());
			rowMap.put("prod_f", workStatusList.get(i).getProd_j());
			rowMap.put("prod_r", workStatusList.get(i).getProd_j());
			rowMap.put("prod_s", workStatusList.get(i).getProd_j());
			rowMap.put("och_su", workStatusList.get(i).getOch_su());


			rtnList.add(rowMap);
		}

		rtnMap.put("last_page",1);
		rtnMap.put("data",rtnList);

		return rtnMap; 
	}

	//입출고삭제현황 - 화면로드
	@RequestMapping(value = "/product/ipChulDelete", method = RequestMethod.GET)
	public String ipChulDelete() {
		return "/product/ipChulDelete.jsp";
	}	 

	//입출고삭제현황 조회
	@RequestMapping(value = "/product/ipChulDelete/getIpChulDeleteList", method = RequestMethod.POST) 
	@ResponseBody 
	public Map<String, Object> getIpChulDeleteList() {
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		List<Gongjung> ipChulDeleteList = productService.getIpChulDeleteList();

		List<HashMap<String, Object>> rtnList = new ArrayList<HashMap<String, Object>>();
		for(int i=0; i<ipChulDeleteList.size(); i++) {
			HashMap<String, Object> rowMap = new HashMap<String, Object>();
			rowMap.put("idx", (i+1));
			rowMap.put("del_date", ipChulDeleteList.get(i).getDel_date());
			rowMap.put("ord_date", ipChulDeleteList.get(i).getOrd_date());
			rowMap.put("och_date", ipChulDeleteList.get(i).getOch_date());
			rowMap.put("del_kind", ipChulDeleteList.get(i).getDel_kind());
			rowMap.put("corp_name", ipChulDeleteList.get(i).getCorp_name());
			rowMap.put("prod_name", ipChulDeleteList.get(i).getProd_name());
			rowMap.put("prod_no", ipChulDeleteList.get(i).getProd_no());
			rowMap.put("prod_gyu", ipChulDeleteList.get(i).getProd_gyu());
			rowMap.put("ord_lot", ipChulDeleteList.get(i).getOrd_lot());
			rowMap.put("del_su", ipChulDeleteList.get(i).getDel_su());
			rowMap.put("del_amnt", ipChulDeleteList.get(i).getDel_amnt());
			rowMap.put("session_name", ipChulDeleteList.get(i).getSession_name());


			rtnList.add(rowMap);
		}

		rtnMap.put("last_page",1);
		rtnMap.put("data",rtnList);

		return rtnMap; 
	}


}
