package com.tkheat.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tkheat.domain.Siljuk;
import com.tkheat.service.ProcessService;

@Controller
public class ProcessController {

	@Autowired
	private ProcessService processService;

	//준비작업실적 - 화면로드
	@RequestMapping(value = "/process/readySiljuk", method = RequestMethod.GET)
	public String readySiljuk() {
		return "/process/readySiljuk.jsp";
	}
	
	//준비작업실적 조회
		@RequestMapping(value = "/process/readySiljuk/getReadySiljukList", method = RequestMethod.POST) 
		@ResponseBody 
		public Map<String, Object> getReadySiljukList(
				@RequestParam String sdate,
				@RequestParam String edate) {
			Map<String, Object> rtnMap = new HashMap<String, Object>();

			Siljuk siljuk = new Siljuk();

			siljuk.setSdate(sdate);
			siljuk.setEdate(edate);


			List<Siljuk> readySiljukList = processService.getReadySiljukList(siljuk);

			List<HashMap<String, Object>> rtnList = new ArrayList<HashMap<String, Object>>();
			for(int i=0; i<readySiljukList.size(); i++) {
				HashMap<String, Object> rowMap = new HashMap<String, Object>();
				rowMap.put("idx", (i+1));
				rowMap.put("ilbo_strt", readySiljukList.get(i).getIlbo_strt());
				rowMap.put("ilbo_date", readySiljukList.get(i).getIlbo_date());
				rowMap.put("ilbo_code", readySiljukList.get(i).getIlbo_code());
				rowMap.put("ord_code", readySiljukList.get(i).getOrd_code());
				rowMap.put("ilbo_lot", readySiljukList.get(i).getIlbo_lot());
				rowMap.put("ilbo_strt", readySiljukList.get(i).getIlbo_strt());
				rowMap.put("ilbo_end", readySiljukList.get(i).getIlbo_end());
				rowMap.put("ord_lot", readySiljukList.get(i).getOrd_lot());
				rowMap.put("corp_name", readySiljukList.get(i).getCorp_name());
				rowMap.put("prod_name", readySiljukList.get(i).getProd_name());
				rowMap.put("prod_no", readySiljukList.get(i).getProd_no());
				rowMap.put("prod_gyu", readySiljukList.get(i).getProd_gyu());
				rowMap.put("prod_jai", readySiljukList.get(i).getProd_jai());
				rowMap.put("ilbo_su", readySiljukList.get(i).getIlbo_su());
				rowMap.put("user_name", readySiljukList.get(i).getUser_name());
				rowMap.put("ord_name", readySiljukList.get(i).getOrd_name());

				rtnList.add(rowMap);
			}

			rtnMap.put("last_page",1);
			rtnMap.put("data",rtnList);

			return rtnMap; 
		}
		
		
		//준비작업실적 삭제
		@RequestMapping(value = "/process/readySiljuk/delete", method = RequestMethod.POST)
		@ResponseBody
		public Map<String, Object> deleteReadySiljuk(@RequestBody Siljuk siljuk) {
		    Map<String, Object> result = new HashMap<>();

		    try {
		    	processService.deleteSiljuk(siljuk);
		        result.put("status", "success");
		        result.put("message", "삭제 완료");
		    } catch (Exception e) {
		        result.put("status", "error");
		        result.put("message", e.getMessage());
		    }

		    System.out.println(result.get("status"));
		    System.out.println(result.get("message"));

		    return result;
		}


	
		
		
		

	//전세정작업실적 - 화면로드
	@RequestMapping(value = "/process/cleanSiljuk", method = RequestMethod.GET)
	public String cleanSiljuk() {
		return "/process/cleanSiljuk.jsp";
	}

	//전세정작업실적 조회
	@RequestMapping(value = "/process/cleanSiljuk/getCleanSiljukList", method = RequestMethod.POST) 
	@ResponseBody 
	public Map<String, Object> getCleanSiljukList(
			@RequestParam String sdate,
			@RequestParam String edate) {
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		Siljuk siljuk = new Siljuk();

		siljuk.setSdate(sdate);
		siljuk.setEdate(edate);


		List<Siljuk> cleanSiljukList = processService.getCleanSiljukList(siljuk);

		List<HashMap<String, Object>> rtnList = new ArrayList<HashMap<String, Object>>();
		for(int i=0; i<cleanSiljukList.size(); i++) {
			HashMap<String, Object> rowMap = new HashMap<String, Object>();
			rowMap.put("idx", (i+1));
			rowMap.put("ilbo_strt", cleanSiljukList.get(i).getIlbo_strt());
			rowMap.put("ilbo_code", cleanSiljukList.get(i).getIlbo_code());
			rowMap.put("ord_code", cleanSiljukList.get(i).getOrd_code());
			rowMap.put("ilbo_lot", cleanSiljukList.get(i).getIlbo_lot());
			rowMap.put("ilbo_strt", cleanSiljukList.get(i).getIlbo_strt());
			rowMap.put("ilbo_end", cleanSiljukList.get(i).getIlbo_end());
			rowMap.put("ord_lot", cleanSiljukList.get(i).getOrd_lot());
			rowMap.put("corp_name", cleanSiljukList.get(i).getCorp_name());
			rowMap.put("prod_name", cleanSiljukList.get(i).getProd_name());
			rowMap.put("prod_no", cleanSiljukList.get(i).getProd_no());
			rowMap.put("prod_gyu", cleanSiljukList.get(i).getProd_gyu());
			rowMap.put("prod_jai", cleanSiljukList.get(i).getProd_jai());
			rowMap.put("ilbo_su", cleanSiljukList.get(i).getIlbo_su());
			rowMap.put("user_name", cleanSiljukList.get(i).getUser_name());
			rowMap.put("ord_name", cleanSiljukList.get(i).getOrd_name());

			rtnList.add(rowMap);
		}

		rtnMap.put("last_page",1);
		rtnMap.put("data",rtnList);

		return rtnMap; 
	}
	
	//후세정작업실적 - 화면로드
	@RequestMapping(value = "/process/cleanRwSiljuk", method = RequestMethod.GET)
	public String cleanRwSiljuk() {
		return "/process/cleanRwSiljuk.jsp";
	}
	
	//후세정작업실적 조회
		@RequestMapping(value = "/process/cleanRwSiljuk/getCleanRwSiljukList", method = RequestMethod.POST) 
		@ResponseBody 
		public Map<String, Object> getCleanRwSiljukList(
				@RequestParam String sdate,
				@RequestParam String edate) {
			Map<String, Object> rtnMap = new HashMap<String, Object>();

			Siljuk siljuk = new Siljuk();

			siljuk.setSdate(sdate);
			siljuk.setEdate(edate);

			List<Siljuk> cleanRwSiljukList = processService.getCleanRwSiljukList(siljuk);

			List<HashMap<String, Object>> rtnList = new ArrayList<HashMap<String, Object>>();
			for(int i=0; i<cleanRwSiljukList.size(); i++) {
				HashMap<String, Object> rowMap = new HashMap<String, Object>();
				rowMap.put("idx", (i+1));
				rowMap.put("ilbo_strt", cleanRwSiljukList.get(i).getIlbo_strt());
				rowMap.put("ilbo_code", cleanRwSiljukList.get(i).getIlbo_code());
				rowMap.put("ord_code", cleanRwSiljukList.get(i).getOrd_code());
				rowMap.put("ilbo_lot", cleanRwSiljukList.get(i).getIlbo_lot());
				rowMap.put("ilbo_strt", cleanRwSiljukList.get(i).getIlbo_strt());
				rowMap.put("ilbo_end", cleanRwSiljukList.get(i).getIlbo_end());
				rowMap.put("ord_lot", cleanRwSiljukList.get(i).getOrd_lot());
				rowMap.put("corp_name", cleanRwSiljukList.get(i).getCorp_name());
				rowMap.put("prod_name", cleanRwSiljukList.get(i).getProd_name());
				rowMap.put("prod_no", cleanRwSiljukList.get(i).getProd_no());
				rowMap.put("prod_gyu", cleanRwSiljukList.get(i).getProd_gyu());
				rowMap.put("prod_jai", cleanRwSiljukList.get(i).getProd_jai());
				rowMap.put("ilbo_su", cleanRwSiljukList.get(i).getIlbo_su());
				rowMap.put("user_name", cleanRwSiljukList.get(i).getUser_name());
				rowMap.put("ord_name", cleanRwSiljukList.get(i).getOrd_name());

				rtnList.add(rowMap);
			}

			rtnMap.put("last_page",1);
			rtnMap.put("data",rtnList);

			return rtnMap; 
		}

	//침탄작업실적 - 화면로드
	@RequestMapping(value = "/process/chimSiljuk", method = RequestMethod.GET)
	public String chimSiljuk() {
		return "/process/chimSiljuk.jsp";
	}

	//침탄작업실적 조회
	@RequestMapping(value = "/process/chimSiljuk/getChimSiljukList", method = RequestMethod.POST) 
	@ResponseBody 
	public Map<String, Object> getChimSiljukList(
			@RequestParam String sdate,
			@RequestParam String edate) {
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		Siljuk siljuk = new Siljuk();

		siljuk.setSdate(sdate);
		siljuk.setEdate(edate);


		List<Siljuk> chimSiljukList = processService.getChimSiljukList(siljuk);

		List<HashMap<String, Object>> rtnList = new ArrayList<HashMap<String, Object>>();
		for(int i=0; i<chimSiljukList.size(); i++) {
			HashMap<String, Object> rowMap = new HashMap<String, Object>();
			rowMap.put("idx", (i+1));
			rowMap.put("ilbo_strt", chimSiljukList.get(i).getIlbo_strt());
			rowMap.put("ilbo_code", chimSiljukList.get(i).getIlbo_code());
			rowMap.put("ord_code", chimSiljukList.get(i).getOrd_code());
			rowMap.put("fac_name", chimSiljukList.get(i).getFac_name());
			rowMap.put("ilbo_lot", chimSiljukList.get(i).getIlbo_lot());
			rowMap.put("ilbo_strt", chimSiljukList.get(i).getIlbo_strt());
			rowMap.put("ilbo_end", chimSiljukList.get(i).getIlbo_end());
			rowMap.put("ord_lot", chimSiljukList.get(i).getOrd_lot());
			rowMap.put("corp_name", chimSiljukList.get(i).getCorp_name());
			rowMap.put("prod_name", chimSiljukList.get(i).getProd_name());
			rowMap.put("prod_no", chimSiljukList.get(i).getProd_no());
			rowMap.put("prod_gyu", chimSiljukList.get(i).getProd_gyu());
			rowMap.put("prod_jai", chimSiljukList.get(i).getProd_jai());
			rowMap.put("ilbo_su", chimSiljukList.get(i).getIlbo_su());
			rowMap.put("user_name", chimSiljukList.get(i).getUser_name());
			rowMap.put("ord_name", chimSiljukList.get(i).getOrd_name());

			rtnList.add(rowMap);
		}

		rtnMap.put("last_page",1);
		rtnMap.put("data",rtnList);

		return rtnMap; 
	}


	

	//템퍼링작업실적 - 화면로드
	@RequestMapping(value = "/process/temSiljuk", method = RequestMethod.GET)
	public String temSiljuk() {
		return "/process/temSiljuk.jsp";
	}

	//템퍼링작업실적 조회
	@RequestMapping(value = "/process/temSiljuk/getTemSiljukList", method = RequestMethod.POST) 
	@ResponseBody 
	public Map<String, Object> getTemSiljukList(
			@RequestParam String sdate,
			@RequestParam String edate) {
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		Siljuk siljuk = new Siljuk();

		siljuk.setSdate(sdate);
		siljuk.setEdate(edate);


		List<Siljuk> temSiljukList = processService.getTemSiljukList(siljuk);

		List<HashMap<String, Object>> rtnList = new ArrayList<HashMap<String, Object>>();
		for(int i=0; i<temSiljukList.size(); i++) {
			HashMap<String, Object> rowMap = new HashMap<String, Object>();
			rowMap.put("idx", (i+1));
			rowMap.put("ilbo_strt", temSiljukList.get(i).getIlbo_strt());
			rowMap.put("ilbo_code", temSiljukList.get(i).getIlbo_code());
			rowMap.put("ord_code", temSiljukList.get(i).getOrd_code());
			rowMap.put("fac_name", temSiljukList.get(i).getFac_name());
			rowMap.put("ilbo_lot", temSiljukList.get(i).getIlbo_lot());
			rowMap.put("ilbo_strt", temSiljukList.get(i).getIlbo_strt());
			rowMap.put("ilbo_end", temSiljukList.get(i).getIlbo_end());
			rowMap.put("ord_lot", temSiljukList.get(i).getOrd_lot());
			rowMap.put("corp_name", temSiljukList.get(i).getCorp_name());
			rowMap.put("prod_name", temSiljukList.get(i).getProd_name());
			rowMap.put("prod_no", temSiljukList.get(i).getProd_no());
			rowMap.put("prod_gyu", temSiljukList.get(i).getProd_gyu());
			rowMap.put("prod_jai", temSiljukList.get(i).getProd_jai());
			rowMap.put("ilbo_su", temSiljukList.get(i).getIlbo_su());
			rowMap.put("user_name", temSiljukList.get(i).getUser_name());
			rowMap.put("ord_name", temSiljukList.get(i).getOrd_name());

			rtnList.add(rowMap);
		}

		rtnMap.put("last_page",1);
		rtnMap.put("data",rtnList);

		return rtnMap; 
	}

	//쇼트/샌딩작업실적 - 화면로드
	@RequestMapping(value = "/process/shortSiljuk", method = RequestMethod.GET)
	public String shortSiljuk() {
		return "/process/shortSiljuk.jsp";
	}
	
	//쇼트/샌딩작업실적 조회
		@RequestMapping(value = "/process/shortSiljuk/getShortSiljukList", method = RequestMethod.POST) 
		@ResponseBody 
		public Map<String, Object> getShortSiljukList(
				@RequestParam String sdate,
				@RequestParam String edate) {
			Map<String, Object> rtnMap = new HashMap<String, Object>();

			Siljuk siljuk = new Siljuk();

			siljuk.setSdate(sdate);
			siljuk.setEdate(edate);


			List<Siljuk> shortSiljukList = processService.getShortSiljukList(siljuk);

			List<HashMap<String, Object>> rtnList = new ArrayList<HashMap<String, Object>>();
			for(int i=0; i<shortSiljukList.size(); i++) {
				HashMap<String, Object> rowMap = new HashMap<String, Object>();
				rowMap.put("idx", (i+1));
				rowMap.put("ilbo_strt", shortSiljukList.get(i).getIlbo_strt());
				rowMap.put("ilbo_code", shortSiljukList.get(i).getIlbo_code());
				rowMap.put("ord_code", shortSiljukList.get(i).getOrd_code());
				rowMap.put("ilbo_lot", shortSiljukList.get(i).getIlbo_lot());
				rowMap.put("ilbo_strt", shortSiljukList.get(i).getIlbo_strt());
				rowMap.put("ilbo_end", shortSiljukList.get(i).getIlbo_end());
				rowMap.put("ord_lot", shortSiljukList.get(i).getOrd_lot());
				rowMap.put("corp_name", shortSiljukList.get(i).getCorp_name());
				rowMap.put("prod_name", shortSiljukList.get(i).getProd_name());
				rowMap.put("prod_no", shortSiljukList.get(i).getProd_no());
				rowMap.put("prod_gyu", shortSiljukList.get(i).getProd_gyu());
				rowMap.put("prod_jai", shortSiljukList.get(i).getProd_jai());
				rowMap.put("ilbo_su", shortSiljukList.get(i).getIlbo_su());
				rowMap.put("user_name", shortSiljukList.get(i).getUser_name());
				rowMap.put("ord_name", shortSiljukList.get(i).getOrd_name());

				rtnList.add(rowMap);
			}

			rtnMap.put("last_page",1);
			rtnMap.put("data",rtnList);

			return rtnMap; 
		}

	//설비별작업실적 - 화면로드
	@RequestMapping(value = "/process/facSiljuk", method = RequestMethod.GET)
	public String facSiljuk() {
		return "/process/facSiljuk.jsp";
	}	 

		 
	//설비별작업실적 조회
	@RequestMapping(value = "/process/facSiljuk/getFacSiljukList", method = RequestMethod.POST) 
	@ResponseBody 
	public Map<String, Object> getFacSiljukList(
			@RequestParam String sdate,
			@RequestParam String edate) {
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		Siljuk siljuk = new Siljuk();

		siljuk.setSdate(sdate);
		siljuk.setEdate(edate);


		List<Siljuk> facSiljukList = processService.getFacSiljukList(siljuk);

		List<HashMap<String, Object>> rtnList = new ArrayList<HashMap<String, Object>>();
		for(int i=0; i<facSiljukList.size(); i++) {
			HashMap<String, Object> rowMap = new HashMap<String, Object>();
			rowMap.put("idx", (i+1));
			rowMap.put("ilbo_lot", facSiljukList.get(i).getIlbo_lot());
			rowMap.put("ilbo_code", facSiljukList.get(i).getIlbo_code());
			rowMap.put("fac_name", facSiljukList.get(i).getFac_name());
			rowMap.put("corp_name", facSiljukList.get(i).getCorp_name());
			rowMap.put("prod_name", facSiljukList.get(i).getProd_name());
			rowMap.put("prod_no", facSiljukList.get(i).getProd_no());
			rowMap.put("ilbo_strt", facSiljukList.get(i).getIlbo_strt());
			rowMap.put("ilbo_end", facSiljukList.get(i).getIlbo_end());
			rowMap.put("time", facSiljukList.get(i).getTime());
			rowMap.put("ord_lot", facSiljukList.get(i).getOrd_lot());
			rowMap.put("ilbo_su", facSiljukList.get(i).getIlbo_su());
			rowMap.put("ilbo_jung", facSiljukList.get(i).getIlbo_jung());
			rowMap.put("ord_danw", facSiljukList.get(i).getOrd_danw());
			rowMap.put("ord_dang", facSiljukList.get(i).getOrd_dang());
			rowMap.put("mon", facSiljukList.get(i).getMon());

			rtnList.add(rowMap);
		}

		rtnMap.put("last_page",1);
		rtnMap.put("data",rtnList);

		return rtnMap; 
	}

	
	
	
	

	/*
	 * //소입경도현황 - 화면로드
	 * 
	 * @RequestMapping(value = "/process/queHard", method = RequestMethod.GET)
	 * public String queHard() { return "/process/queHard.jsp"; }
	 * 
	 * //템퍼링경도현황 - 화면로드
	 * 
	 * @RequestMapping(value = "/process/temHard", method = RequestMethod.GET)
	 * public String temHard() { return "/process/temHard.jsp"; }
	 * 
		 * //제품별불량현황 - 화면로드
		@RequestMapping(value = "/process/prodFaulty", method = RequestMethod.GET)
		public String prodFaulty() {
			return "/process/prodFaulty.jsp";
	}
	 */
	/*
	 * //고주파작업실적 - 화면로드
	 * 
	 * @RequestMapping(value = "/process/gojuSiljuk", method = RequestMethod.GET)
	 * public String gojuSiljuk() { return "/process/gojuSiljuk.jsp"; }
	 */ 

}
