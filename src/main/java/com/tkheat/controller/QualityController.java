package com.tkheat.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.tkheat.domain.Product;
import com.tkheat.domain.Suip;
import com.tkheat.domain.Work;
import com.tkheat.service.QualityService;
import com.tkheat.util.CpkCalc;

@Controller
public class QualityController {

	@Autowired
	private QualityService qualityService;

	//수입검사 - 화면로드
	@RequestMapping(value = "/quality/suip", method = RequestMethod.GET)
	public String suip() {
		return "/quality/suip.jsp";
	}
	
	//수입검사 - 화면로드
		@RequestMapping(value = "/quality/report", method = RequestMethod.GET)
		public String reprot() {
			return "/quality/report.jsp";
		}
		
	//수입검사 조회
	@RequestMapping(value = "/quality/suip/getSuipList", method = RequestMethod.POST) 
	@ResponseBody 
	public Map<String, Object> getSuipList(
			@RequestParam String sdate,
			@RequestParam String edate) {
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		Suip suip = new Suip();

		suip.setSdate(sdate);
		suip.setEdate(edate);


		List<Suip> suipList = qualityService.getSuipList(suip);

		List<HashMap<String, Object>> rtnList = new ArrayList<HashMap<String, Object>>();
		for(int i=0; i<suipList.size(); i++) {
			HashMap<String, Object> rowMap = new HashMap<String, Object>();
			rowMap.put("idx", (i+1));
			rowMap.put("itst_date", suipList.get(i).getItst_date());
			rowMap.put("ord_date", suipList.get(i).getOrd_date());
			rowMap.put("corp_name", suipList.get(i).getCorp_name());
			rowMap.put("prod_name", suipList.get(i).getProd_name());
			rowMap.put("prod_no", suipList.get(i).getProd_no());
			rowMap.put("prod_gyu", suipList.get(i).getProd_gyu());
			rowMap.put("prod_jai", suipList.get(i).getProd_jai());
			rowMap.put("itst_poor", suipList.get(i).getItst_poor());
			rowMap.put("itst_wp", suipList.get(i).getItst_wp());
			rowMap.put("itst_code", suipList.get(i).getItst_code());
			rowMap.put("corp_code", suipList.get(i).getCorp_code());

			rtnList.add(rowMap);
		}

		rtnMap.put("last_page",1);
		rtnMap.put("data",rtnList);

		return rtnMap; 
	}
	
	
	//수입검사 - insert,update
	@RequestMapping(value = "/quality/suip/suipSave", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> suipSave(
			@ModelAttribute Suip suip,
			@RequestParam("mode") String mode) { 

		System.out.println("mode = " + mode);
		System.out.println("werr_code = " + suip.getItst_code());
		Map<String, Object> result = new HashMap<>();

		try {
			if ("update".equalsIgnoreCase(mode)) {
				qualityService.suipUdateSave(suip);  
			} else {
				throw new IllegalArgumentException("Invalid mode: " + mode);
			}

			result.put("status", "success");
			result.put("message", "OK");

		} catch (Exception e) {
			result.put("status", "error");
			result.put("message", e.getMessage());
		}

		System.out.println(result.get("status"));
		System.out.println(result.get("message"));


		return result;
	} 


	//수입검사 더블클릭조회
	@RequestMapping(value = "/quality/suip/suipDetail", method = RequestMethod.POST) 
	@ResponseBody 
	public Map<String, Object> suipDetail(
			@RequestParam Integer itst_code) {
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		Suip suip = new Suip();
		suip.setItst_code(itst_code);
		Suip suipList = qualityService.suipDetail(suip);

		rtnMap.put("data",suipList);

		return rtnMap; 
	}  
	
	
	
	

	//부적합등록 - 화면로드
	@RequestMapping(value = "/quality/nonInsert", method = RequestMethod.GET)
	public String nonInsert() {
		return "/quality/nonInsert.jsp";
	}

	
	 //부적합등록 조회
	  
	  @RequestMapping(value = "/quality/nonInsert/getNonInsertList", method =
	  RequestMethod.POST)
	  @ResponseBody public Map<String, Object> getNonInsertList(
	  @RequestParam String sdate,
	  @RequestParam String edate) { Map<String, Object> rtnMap = new
	  HashMap<String, Object>();
	  
	  Work work = new Work();
	  
	  work.setSdate(sdate); 
	  work.setEdate(edate);
	  
	  List<Work> nonInsertList = qualityService.getNonInsertList(work);
	  
	  List<HashMap<String, Object>> rtnList = new ArrayList<HashMap<String,
	  Object>>(); for(int i=0; i<nonInsertList.size(); i++) { HashMap<String,
	  Object> rowMap = new HashMap<String, Object>(); 
	  rowMap.put("werr_date", nonInsertList.get(i).getWerr_date()); 
	  rowMap.put("corp_name",
	  nonInsertList.get(i).getCorp_name()); rowMap.put("prod_name",
	  nonInsertList.get(i).getProd_name()); rowMap.put("prod_no",
	  nonInsertList.get(i).getProd_no()); rowMap.put("ilbo_lot",
	  nonInsertList.get(i).getIlbo_lot()); rowMap.put("werr_gubn",
	  nonInsertList.get(i).getWerr_gubn()); rowMap.put("werr_amnt",
	  nonInsertList.get(i).getWerr_amnt()); rowMap.put("werr_mon",
	  nonInsertList.get(i).getWerr_mon());
	  rowMap.put("werr_code", nonInsertList.get(i).getWerr_code());
	  
	  rtnList.add(rowMap); }
	  
	  rtnMap.put("last_page",1); rtnMap.put("data",rtnList);
	  
	  return rtnMap; 
	  }
	  
	//부적합 설비목록 조회
	  @RequestMapping(value = "/quality/nonInsert/getNonCorpList", method = RequestMethod.POST) 
	  @ResponseBody 
	  public Map<String, Object> getNonCorpList(
			  @RequestParam Integer fac_code,
			  @RequestParam Integer ord_code,
			  @RequestParam Integer prod_code,
			  @RequestParam Integer ilbo_code,
			  @RequestParam Integer ilbo_no,
			  @RequestParam Integer corp_code,
			  @RequestParam String ilbo_lot,
			  @RequestParam String sdate,
			  @RequestParam String edate
			  ) {
		  Map<String, Object> rtnMap = new HashMap<String, Object>();
System.out.println("subilbo_lot : "+ilbo_lot);
		  Work work = new Work();
		  work.setFac_code(fac_code);
		  work.setOrd_code(ord_code);
		  work.setProd_code(prod_code);
		  work.setIlbo_code(ilbo_code);
		  work.setIlbo_no(ilbo_no);
		  work.setCorp_code(corp_code);
		  work.setIlbo_lot(ilbo_lot);
		  work.setSdate(sdate);
		  work.setEdate(edate);

		  List<Work> workList = qualityService.getNonCorpList(work);

		  List<HashMap<String, Object>> rtnList = new ArrayList<HashMap<String, Object>>();
		  for(int i=0; i<workList.size(); i++) {
			  HashMap<String, Object> rowMap = new HashMap<String, Object>();
			  rowMap.put("idx", (i+1));
			  rowMap.put("fac_name", workList.get(i).getFac_name());
			  rowMap.put("ord_date", workList.get(i).getOrd_date());
			  rowMap.put("ilbo_date", workList.get(i).getIlbo_date());
			  rowMap.put("corp_name", workList.get(i).getCorp_name());
			  rowMap.put("prod_name", workList.get(i).getProd_name());
			  rowMap.put("prod_no", workList.get(i).getProd_no());
			  rowMap.put("tech_te", workList.get(i).getTech_te());
			  rowMap.put("ilbo_su", workList.get(i).getIlbo_su());
			  rowMap.put("ord_lot", workList.get(i).getOrd_lot());
			  rowMap.put("ord_code", workList.get(i).getOrd_code());
			  rowMap.put("ilbo_lot", workList.get(i).getIlbo_lot());
			  rowMap.put("fac_code", workList.get(i).getFac_code());
			  rowMap.put("prod_code", workList.get(i).getProd_code());
			  rowMap.put("ilbo_code", workList.get(i).getIlbo_code());
			  rowMap.put("corp_code", workList.get(i).getCorp_code());
			  rowMap.put("ilbo_no", workList.get(i).getIlbo_no());
			  rowMap.put("werr_wdate", workList.get(i).getWerr_wdate());
			  rowMap.put("werr_gubn", workList.get(i).getWerr_gubn());
			  rowMap.put("werr_lot", workList.get(i).getWerr_lot());
			  rowMap.put("werr_amnt", workList.get(i).getWerr_amnt());
			  rowMap.put("werr_mon", workList.get(i).getWerr_mon());


			  rtnList.add(rowMap);
		  }

		  rtnMap.put("last_page",1);
		  rtnMap.put("data",rtnList);

		  return rtnMap; 
	  }  


	//부적합등록 - insert,update
	  @RequestMapping(value = "/quality/nonInsert/nonInsertSave", method = RequestMethod.POST)
	  @ResponseBody
	  public Map<String, Object> nonInsertSave(
	          @ModelAttribute Work work,
	          HttpServletRequest req,
				@RequestParam(value = "imageFile1", required = false) MultipartFile[] files1,
				@RequestParam(value = "imageFile2", required = false) MultipartFile[] files2,
				@RequestParam(value = "werr_fname", required = false) MultipartFile[] files3) {
	      String mode = req.getParameter("mode");
	      System.out.println("🔥 Controller 들어옴!");
	      System.out.println("mode = " + mode);
	      System.out.println("werr_code = " + work.getWerr_code());
	      System.out.println("werr_alert = " + work.getWerr_alert());

	      Map<String, Object> result = new HashMap<>();
	      try {
	          if ("insert".equalsIgnoreCase(mode)) {
	              qualityService.nonInsertSave(work);
	          } else if ("update".equalsIgnoreCase(mode)) {
	              qualityService.nonUdateSave(work);
	          } else {
	              throw new IllegalArgumentException("Invalid mode: " + mode);
	          }

	          result.put("status", "success");
	          result.put("message", "OK");
	      } catch (Exception e) {
	          e.printStackTrace();
	          result.put("status", "error");
	          result.put("message", e.getMessage());
	      }
	      return result;
	  }

	  
	  
	//부적합등록 더블클릭조회
	  @RequestMapping(value = "/quality/nonInsert/nonInsertDetail", method = RequestMethod.POST) 
	  @ResponseBody 
	  public Map<String, Object> nonInsertDetail(
			  @RequestParam int werr_code) {
		  Map<String, Object> rtnMap = new HashMap<String, Object>();

		  Work work = new Work();
		  work.setWerr_code(werr_code);
		  Work workList = qualityService.nonInsertDetail(work);

		  rtnMap.put("data",workList);

		  return rtnMap; 
	  }  
	  
	//부적합등록 삭제 - delete
	  @RequestMapping(value = "/quality/nonInsert/deleteNon", method = RequestMethod.POST)
	  @ResponseBody
	  public Map<String, Object> deleteNon(@RequestParam("werr_code") Integer werr_code) {
		  Map<String, Object> result = new HashMap<>();

		  try {
			  qualityService.deleteNon(werr_code);
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
	 

	//자주검사불량현황 - 화면로드
	@RequestMapping(value = "/quality/jajuStatus", method = RequestMethod.GET)
	public String jajuStatus() {
		return "/quality/jajuStatus.jsp";
	}
	
	//자주검사불량현황 조회
	@RequestMapping(value = "/quality/jajuStatus/getJajuStatusList", method = RequestMethod.POST) 
	@ResponseBody 
	public Map<String, Object> getJajuStatusList(
			@RequestParam String sdate,
			@RequestParam String edate) {
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		Work work = new Work();

		work.setSdate(sdate);
		work.setEdate(edate);


		List<Work> jajuStatusList = qualityService.getJajuStatusList(work);

		List<HashMap<String, Object>> rtnList = new ArrayList<HashMap<String, Object>>();
		for(int i=0; i<jajuStatusList.size(); i++) {
			HashMap<String, Object> rowMap = new HashMap<String, Object>();	
			rowMap.put("ilbo_gubn", jajuStatusList.get(i).getIlbo_gubn());
			rowMap.put("juckjaecode", jajuStatusList.get(i).getJuckjaecode());
			rowMap.put("ilbo_strt", jajuStatusList.get(i).getIlbo_strt());
			rowMap.put("ilbo_end", jajuStatusList.get(i).getIlbo_end());
			rowMap.put("ilbo_lot", jajuStatusList.get(i).getIlbo_lot());
			rowMap.put("prod_name", jajuStatusList.get(i).getProd_name());
			rowMap.put("prod_no", jajuStatusList.get(i).getProd_no());
			rowMap.put("prod_gyu", jajuStatusList.get(i).getProd_gyu());
			rowMap.put("prod_jai", jajuStatusList.get(i).getProd_jai());
			rowMap.put("prod_pg", jajuStatusList.get(i).getProd_pg());
			rowMap.put("ilbo_okng", jajuStatusList.get(i).getIlbo_okng());
			rowMap.put("ilbo_pg1", jajuStatusList.get(i).getIlbo_pg1());
			rowMap.put("ilbo_pg2", jajuStatusList.get(i).getIlbo_pg2());
			rowMap.put("ilbo_pg3", jajuStatusList.get(i).getIlbo_pg3());
			rowMap.put("ilbo_pg4", jajuStatusList.get(i).getIlbo_pg4());
			rowMap.put("ilbo_pg5", jajuStatusList.get(i).getIlbo_pg5());
			rowMap.put("user_name", jajuStatusList.get(i).getUser_name());
			

			rtnList.add(rowMap);
		}

		rtnMap.put("last_page",1);
		rtnMap.put("data",rtnList);

		return rtnMap; 
	}

	//자주검사불량조치관리 - 화면로드
	@RequestMapping(value = "/quality/jajuJochi", method = RequestMethod.GET)
	public String jajuJochi() {
		return "/quality/jajuJochi.jsp";
	}
	
	
	//자주검사불량조치관리 조회
	@RequestMapping(value = "/quality/jajwjochi/getJajuJochiList", method = RequestMethod.POST) 
	@ResponseBody 
	public Map<String, Object> getJajuJochiList(
			@RequestParam String sdate,
			@RequestParam String edate) {
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		Work work = new Work();

		work.setSdate(sdate);
		work.setEdate(edate);


		List<Work> jajuJochiList = qualityService.getJajuJochiList(work);

		List<HashMap<String, Object>> rtnList = new ArrayList<HashMap<String, Object>>();
		for(int i=0; i<jajuJochiList.size(); i++) {
			HashMap<String, Object> rowMap = new HashMap<String, Object>();	
			rowMap.put("ord_code", jajuJochiList.get(i).getOrd_code());
			rowMap.put("corp_name", jajuJochiList.get(i).getCorp_name());
			rowMap.put("prod_name", jajuJochiList.get(i).getProd_name());
			rowMap.put("prod_no", jajuJochiList.get(i).getProd_no());
			rowMap.put("prod_gyu", jajuJochiList.get(i).getProd_gyu());
			rowMap.put("jerr_rdate", jajuJochiList.get(i).getJerr_rdate());
			rowMap.put("jerr_gubn", jajuJochiList.get(i).getJerr_gubn());
			rowMap.put("jerr_jgubn", jajuJochiList.get(i).getJerr_jgubn());

			rtnList.add(rowMap);
		}

		rtnMap.put("last_page",1);
		rtnMap.put("data",rtnList);

		return rtnMap; 
	}

	//Xbar-R관리도 - 화면로드
	@RequestMapping(value = "/quality/xBar", method = RequestMethod.GET)
	public String xBar() {
		return "/quality/xBar.jsp";
	}


	//Xbar-R 관리도 품번조회
	@RequestMapping(value = "/quality/xBar/pumbun/list", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> xBarPumbunList(
    		@RequestParam(required = false) String w_client,
    		@RequestParam(required = false) String w_pname,
    		@RequestParam(required = false) String w_spec) {
		
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		
		Product p = new Product();
		p.setCorp_name(w_client);
		p.setProd_name(w_pname);
		p.setProd_gyu(w_spec);
		
		List<Product> pList = qualityService.xBarPumbunList(p);
		
		rtnMap.put("data",pList);
		
		return rtnMap;
	}	
	
	
	//Xbar-R 관리도 - 데이터조회
	@RequestMapping(value = "/quality/xBar/list", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> xBarList(
    		@RequestParam String h_pnum,
    		@RequestParam String h_sdate,
    		@RequestParam String h_edate) {
    	Map<String, Object> rtnMap = new HashMap<String, Object>();
	 
    	//선택한 품번의 기준정보
    	Suip quality = new Suip();
    	quality.setH_pnum(h_pnum);
    	quality.setH_sdate(h_sdate);
    	quality.setH_edate(h_edate);
    	
    	Suip standardQuality = qualityService.cpkStandardList(quality);
    	List<Suip> rtnList = new ArrayList<Suip>();

		HashMap<String, Object> rowMap = new HashMap<String, Object>();
		rowMap.put("h_pnum", standardQuality.getH_pnum());
		rowMap.put("h_pname", standardQuality.getH_pname());
		rowMap.put("h_gang", standardQuality.getH_gang());
		rowMap.put("h_t_gb", standardQuality.getH_t_gb());
		rowMap.put("h_hard_up", standardQuality.getH_hard_up());
		rowMap.put("h_hard_dw", standardQuality.getH_hard_dw());
    		
		rtnList.add(standardQuality);
    	rtnMap.put("standardData",rtnList);
    	
    	CpkCalc cpkCalc = new CpkCalc();
    	int n = 3;
    	double d2 = 0;
    	double a2 = 0;
    	double d4 = 0;
    	
    	
    	
    	String xm_average = "";
    	String xm_avgList = "";
    	String xm_range = "";
    	String rm_rangeList = "";
    	
    	double x_ucl = 0;
    	double x_cl = 0;
    	double x_lcl = 0;
    	
    	double r_ucl = 0;
    	double r_cl = 0;
    	
    	//선택한 품번의 기간내에 입력한 경도값
    	List<Suip> cpkList = qualityService.cpkValueList(quality);
    	rtnMap.put("cpkValueData",cpkList);
    	
    	d2 = cpkCalc.d2(n);
    	a2 = cpkCalc.a2(n);
    	d4 = cpkCalc.d4(n);
		double max_val = 0.0;
		double min_val = 0.0;
		
		max_val = Double.parseDouble(standardQuality.getH_hard_up());
		min_val = Double.parseDouble(standardQuality.getH_hard_dw());
		
		List<Suip> trendList = new ArrayList<Suip>();
    	for(int i=0; i<cpkList.size(); i++) {
    		Suip rowQuality = new Suip();
    		int xm_av_idx = 0;
    		int x_max = 0;
    		int x_min = 0;
    		

    		
    		
    		float h_x1 = cpkList.get(i).getH_x1();
    		float h_x2 = cpkList.get(i).getH_x2();
    		float h_x3 = cpkList.get(i).getH_x3();
    		
    		if(h_x1 != 0) {xm_av_idx++;}
    		if(h_x2 != 0) {xm_av_idx++;}
    		if(h_x3 != 0) {xm_av_idx++;}
    		
    		xm_average = cpkCalc.xm_average((h_x1 + h_x2 + h_x3), xm_av_idx);
    		xm_avgList = cpkCalc.xm_average2((h_x1 + h_x2 + h_x3), xm_av_idx);
    		
    		rm_rangeList = cpkCalc.xm_range(h_x1,h_x2,h_x3);
    		xm_range = cpkCalc.xm_range2(h_x1,h_x2,h_x3);
    		
    		x_ucl = Double.parseDouble(cpkCalc.x_Bar_UCL(n));
    		x_cl = Double.parseDouble(cpkCalc.x_Bar_CL());
    		x_lcl = Double.parseDouble(cpkCalc.x_Bar_LCL(n));
    		
    		r_ucl = Double.parseDouble(cpkCalc.r_UCL(n));
    		r_cl = Double.parseDouble(cpkCalc.r_CL());
    		
    		
    		rowQuality.setG_ucl_x(x_ucl);
    		rowQuality.setG_cl_x(x_cl);
    		rowQuality.setG_lcl_x(x_lcl);
    		
    		rowQuality.setG_ucl_r(r_ucl);
    		rowQuality.setG_cl_r(r_cl);
    		rowQuality.setG_max(max_val);
    		rowQuality.setG_min(min_val);
    		rowQuality.setG_avg(cpkList.get(i).getH_avg());
    		rowQuality.setG_range(cpkList.get(i).getH_range());
//    		rowQuality.setG_tdatetime(cpkList.get(i).getH_day()+" "+);
    		trendList.add(rowQuality);
    	}
    	
    	Suip quaCpk = new Suip();
    	
    	String xbar_average = cpkCalc.xbar_average();
    	String range_average = cpkCalc.range_average();
    	String xbar_ucl = (Math.round(Double.parseDouble(cpkCalc.x_Bar_UCL(n)) * 100)/100.0)+"";
    	String xbar_cl = (Math.round(Double.parseDouble(cpkCalc.x_Bar_CL()) * 100)/100.0)+"";
    	String xbar_lcl = (Math.round(Double.parseDouble(cpkCalc.x_Bar_LCL(n)) * 100)/100.0)+"";
    	
    	String rbar_ucl = (Math.round(Double.parseDouble(cpkCalc.r_UCL(n)) * 100)/100.0)+"";
    	String rbar_cl = (Math.round(Double.parseDouble(cpkCalc.r_CL()) * 100)/100.0)+"";
    	String r_bar_d2 = cpkCalc.r_Bar_d2(n);
    	String cp = cpkCalc.cp(max_val, min_val, n);
    	String k = cpkCalc.k(max_val, min_val);
    	String cpk = cpkCalc.cpk(max_val, min_val, n);
    	
    	quaCpk.setN(n);
    	quaCpk.setD2(d2);
    	quaCpk.setA2(a2);
    	quaCpk.setD4(d4);
    	
    	quaCpk.setUcl_x(xbar_ucl);
    	quaCpk.setCl_x(xbar_cl);
    	quaCpk.setLcl_x(xbar_lcl);
    	
    	quaCpk.setUcl_r(rbar_ucl);
    	quaCpk.setCl_r(rbar_cl);
    	quaCpk.setLcl_r("-");
    	
    	quaCpk.setR_d2(r_bar_d2);
    	quaCpk.setCp(cp);
    	quaCpk.setK(k);
    	quaCpk.setCpk(cpk);
    	
    	
    	rtnMap.put("cpkValueCalcData",quaCpk);
    	rtnMap.put("trendData",trendList);
    	
    	return rtnMap;
}
	

	//소입경도 - 화면로드
	@RequestMapping(value = "/quality/queHard", method = RequestMethod.GET)
	public String queHard() {
		return "/quality/queHard.jsp";
	}

	//소입경도 조회
	@RequestMapping(value = "/quality/queHard/getQueHardList", method = RequestMethod.POST) 
	@ResponseBody 
	public Map<String, Object> getQueHardList(
			@RequestParam String sdate,
			@RequestParam String edate) {
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		Work work = new Work();

		work.setSdate(sdate);
		work.setEdate(edate);

		
		List<Work> queHardList = qualityService.getQueHardList(work);

		List<HashMap<String, Object>> rtnList = new ArrayList<HashMap<String, Object>>();
		for(int i=0; i<queHardList.size(); i++) {
			HashMap<String, Object> rowMap = new HashMap<String, Object>();			
			rowMap.put("juckjaecode", queHardList.get(i).getJuckjaecode());
			rowMap.put("ilbo_strt", queHardList.get(i).getIlbo_strt());
			rowMap.put("ilbo_end", queHardList.get(i).getIlbo_end());
			rowMap.put("ilbo_lot", queHardList.get(i).getIlbo_lot());
			rowMap.put("prod_name", queHardList.get(i).getProd_name());
			rowMap.put("prod_no", queHardList.get(i).getProd_no());
			rowMap.put("prod_gyu", queHardList.get(i).getProd_gyu());
			rowMap.put("prod_jai", queHardList.get(i).getProd_jai());
			rowMap.put("prod_pg", queHardList.get(i).getProd_pg());
			rowMap.put("ilbo_okng", queHardList.get(i).getIlbo_okng());
			rowMap.put("ilbo_pg1", queHardList.get(i).getIlbo_pg1());
			rowMap.put("ilbo_pg2", queHardList.get(i).getIlbo_pg2());
			rowMap.put("ilbo_pg3", queHardList.get(i).getIlbo_pg3());
			rowMap.put("ilbo_pg4", queHardList.get(i).getIlbo_pg4());
			rowMap.put("ilbo_pg5", queHardList.get(i).getIlbo_pg5());
			rowMap.put("user_name", queHardList.get(i).getUser_name());

			rtnList.add(rowMap);
		}

		rtnMap.put("last_page",1);
		rtnMap.put("data",rtnList);

		return rtnMap; 
	}


	//템퍼링경도 - 화면로드
	@RequestMapping(value = "/quality/temHard", method = RequestMethod.GET)
	public String temHard() {
		return "/quality/temHard.jsp";
	}
	
	//템퍼링경도 조회
	@RequestMapping(value = "/quality/temHard/getTemHardList", method = RequestMethod.POST) 
	@ResponseBody 
	public Map<String, Object> getTemHardList(
			@RequestParam String sdate,
			@RequestParam String edate) {
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		Work work = new Work();

		work.setSdate(sdate);
		work.setEdate(edate);


		List<Work> temHardList = qualityService.getTemHardList(work);

		List<HashMap<String, Object>> rtnList = new ArrayList<HashMap<String, Object>>();
		for(int i=0; i<temHardList.size(); i++) {
			HashMap<String, Object> rowMap = new HashMap<String, Object>();			
			rowMap.put("juckjaecode", temHardList.get(i).getJuckjaecode());
			rowMap.put("ilbo_strt", temHardList.get(i).getIlbo_strt());
			rowMap.put("ilbo_end", temHardList.get(i).getIlbo_end());
			rowMap.put("ilbo_lot", temHardList.get(i).getIlbo_lot());
			rowMap.put("prod_name", temHardList.get(i).getProd_name());
			rowMap.put("prod_no", temHardList.get(i).getProd_no());
			rowMap.put("prod_gyu", temHardList.get(i).getProd_gyu());
			rowMap.put("prod_jai", temHardList.get(i).getProd_jai());
			rowMap.put("prod_pg", temHardList.get(i).getProd_pg());
			rowMap.put("ilbo_okng", temHardList.get(i).getIlbo_okng());
			rowMap.put("ilbo_pg1", temHardList.get(i).getIlbo_pg1());
			rowMap.put("ilbo_pg2", temHardList.get(i).getIlbo_pg2());
			rowMap.put("ilbo_pg3", temHardList.get(i).getIlbo_pg3());
			rowMap.put("ilbo_pg4", temHardList.get(i).getIlbo_pg4());
			rowMap.put("ilbo_pg5", temHardList.get(i).getIlbo_pg5());

			rtnList.add(rowMap);
		}

		rtnMap.put("last_page",1);
		rtnMap.put("data",rtnList);

		return rtnMap; 
	}
	
	
	

}
