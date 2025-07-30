package com.tkheat.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


import com.tkheat.domain.Ipgo;
import com.tkheat.domain.Work;
import com.tkheat.service.ProductionService;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.JasperReportsContext;
import net.sf.jasperreports.engine.SimpleJasperReportsContext;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

@Controller
public class ProductionController {

	@Autowired
	private ProductionService productionService;


	//작업스케줄 - 화면로드
	@RequestMapping(value = "/production/workSchedule", method = RequestMethod.GET)
	public String workSchedule() {
		return "/production/workSchedule.jsp";
	}	 

	
	//작업스케줄 조회
	  
//	  @RequestMapping(value = "/production/workSchedule/getWorkScheduleList",
//	  method = RequestMethod.POST)
//	  
//	  @ResponseBody public Map<String, Object> getWorkScheduleList(
//	  
//	  @RequestParam String plnp_date,
//	  
//	  @RequestParam String corp_name,
//	  
//	  @RequestParam String prod_name,
//	 
//	  @RequestParam String prod_no,
//	  
//	  @RequestParam String prod_gubn,
//	  
//	  @RequestParam String fac_name) { Map<String, Object> rtnMap = new
//	  HashMap<String, Object>();
//	  
//	  Work work = new Work(); work.setCorp_name(plnp_date);
//	  work.setProd_name(corp_name); work.setProd_no(prod_name);
//	  work.setProd_gyu(prod_no); work.setProd_jai(prod_gubn);
//	  work.setProd_pg(fac_name);
//	  
//	  
//	  List<Work> workScheduleList = productionService.getWorkScheduleList(work);
//	  
//	  List<HashMap<String, Object>> rtnList = new ArrayList<HashMap<String,
//	  Object>>(); for(int i=0; i<workScheduleList.size(); i++) { HashMap<String,
//	  Object> rowMap = new HashMap<String, Object>(); rowMap.put("plnp_no",
//	  workScheduleList.get(i).getPlnp_no()); rowMap.put("plnp_date",
//	  workScheduleList.get(i).getPlnp_date()); rowMap.put("prod_date",
//	  workScheduleList.get(i).getProd_date()); rowMap.put("fac_name",
//	  workScheduleList.get(i).getFac_name()); rowMap.put("plnp_seq",
//	  workScheduleList.get(i).getPlnp_seq()); rowMap.put("corp_name",
//	  workScheduleList.get(i).getCorp_name()); rowMap.put("prod_name",
//	  workScheduleList.get(i).getProd_name()); rowMap.put("prod_no",
//	  workScheduleList.get(i).getProd_no()); rowMap.put("prod_gyu",
//	  workScheduleList.get(i).getProd_gyu()); rowMap.put("prod_jai",
//	  workScheduleList.get(i).getProd_jai()); rowMap.put("plnp_dsu",
//	  workScheduleList.get(i).getPlnp_dsu()); rowMap.put("plnp_tmp1",
//	  workScheduleList.get(i).getPlnp_tmp1()); rowMap.put("plnp_time1",
//	  workScheduleList.get(i).getPlnp_time1()); rowMap.put("plnp_tmp2",
//	  workScheduleList.get(i).getPlnp_tmp2()); rowMap.put("plnp_time2",
//	  workScheduleList.get(i).getPlnp_time2()); rowMap.put("plnp_ttmp",
//	  workScheduleList.get(i).getPlnp_ttmp()); rowMap.put("plnp_ttime",
//	  workScheduleList.get(i).getPlnp_ttime()); rowMap.put("plnp_note",
//	  workScheduleList.get(i).getPlnp_note()); rowMap.put("prod_cd",
//	  workScheduleList.get(i).getProd_cd()); rowMap.put("prod_pg",
//	  workScheduleList.get(i).getProd_pg()); rowMap.put("prod_sg",
//	  workScheduleList.get(i).getProd_sg());
//	  
//	  rtnList.add(rowMap); }
//	 
//	  rtnMap.put("last_page",1); rtnMap.put("data",rtnList);
//	 
//	  return rtnMap; }
	

	//작업현황 - 화면로드
	@RequestMapping(value = "/production/workStatus", method = RequestMethod.GET)
	public String workStatus() {
		return "/production/workStatus.jsp";
	}	 

	//작업현황 조회
	@RequestMapping(value = "/production/workStatus/getWorkStatusList", method = RequestMethod.POST) 
	@ResponseBody 
	public Map<String, Object> getWorkStatusList(
			@RequestParam String sdate,
			@RequestParam String edate) {
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		Work work = new Work();
		work.setSdate(sdate);
		work.setEdate(edate);


		List<Work> WorkStatusList = productionService.getWorkStatusList(work);

		List<HashMap<String, Object>> rtnList = new ArrayList<HashMap<String, Object>>();
		for(int i=0; i<WorkStatusList.size(); i++) {
			HashMap<String, Object> rowMap = new HashMap<String, Object>();
			rowMap.put("idx", (i+1));
			rowMap.put("plnp_no", WorkStatusList.get(i).getPlnp_no());
			rowMap.put("plnp_date", WorkStatusList.get(i).getPlnp_date());
			rowMap.put("ord_code", WorkStatusList.get(i).getOrd_code());
			rowMap.put("ilbo_lot", WorkStatusList.get(i).getIlbo_lot());
			rowMap.put("tech_te", WorkStatusList.get(i).getTech_te());
			rowMap.put("fac_name", WorkStatusList.get(i).getFac_name());
			rowMap.put("corp_name", WorkStatusList.get(i).getCorp_name());
			rowMap.put("prod_name", WorkStatusList.get(i).getProd_name());
			rowMap.put("prod_no", WorkStatusList.get(i).getProd_no());
			rowMap.put("prod_gyu", WorkStatusList.get(i).getProd_gyu());
			rowMap.put("prod_jai", WorkStatusList.get(i).getProd_jai());
			rowMap.put("plnp_dsu", WorkStatusList.get(i).getPlnp_dsu());
			rowMap.put("ilbo_date", WorkStatusList.get(i).getIlbo_date());
			rowMap.put("ilbo_su", WorkStatusList.get(i).getIlbo_su());

			rtnList.add(rowMap);
		}

		rtnMap.put("last_page",1);
		rtnMap.put("data",rtnList);

		return rtnMap; 
	}

	//부적합보고서 - 화면로드
	@RequestMapping(value = "/production/nonReprot", method = RequestMethod.GET)
	public String nonReprot() {
		return "/production/nonReprot.jsp";
	}	 

	//부적합보고서 조회
	@RequestMapping(value = "/production/nonReport/getNonReportList", method = RequestMethod.POST) 
	@ResponseBody 
	public Map<String, Object> getNonReportList(
			@RequestParam String sdate,
			@RequestParam String edate) {
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		Work work = new Work();
		work.setSdate(sdate);
		work.setEdate(edate);


		List<Work> nonReportList = productionService.getNonReportList(work);

		List<HashMap<String, Object>> rtnList = new ArrayList<HashMap<String, Object>>();
		for(int i=0; i<nonReportList.size(); i++) {
			HashMap<String, Object> rowMap = new HashMap<String, Object>();
			rowMap.put("idx", (i+1));
			rowMap.put("werr_wdate", nonReportList.get(i).getWerr_wdate());
			rowMap.put("corp_name", nonReportList.get(i).getCorp_name());
			rowMap.put("prod_name", nonReportList.get(i).getProd_name());
			rowMap.put("prod_no", nonReportList.get(i).getProd_no());
			rowMap.put("ord_date", nonReportList.get(i).getOrd_date());
			rowMap.put("tech_te", nonReportList.get(i).getTech_te());
			rowMap.put("werr_fac", nonReportList.get(i).getWerr_fac());
			rowMap.put("werr_gubn", nonReportList.get(i).getWerr_gubn());
			rowMap.put("werr_amnt", nonReportList.get(i).getWerr_amnt());
			rowMap.put("werr_code", nonReportList.get(i).getWerr_code());
			rowMap.put("ilbo_code", nonReportList.get(i).getIlbo_code());
			rowMap.put("ilbo_no", nonReportList.get(i).getIlbo_no());
			rowMap.put("werr_lot", nonReportList.get(i).getWerr_lot());
			rowMap.put("werr_team", nonReportList.get(i).getWerr_team());
			rowMap.put("werr_user", nonReportList.get(i).getWerr_user());
			rowMap.put("werr_jgubn", nonReportList.get(i).getWerr_jgubn());
			rowMap.put("werr_gnote", nonReportList.get(i).getWerr_gnote());
			rowMap.put("werr_jnote", nonReportList.get(i).getWerr_jnote());
			rowMap.put("werr_case", nonReportList.get(i).getWerr_case());
			rowMap.put("werr_note", nonReportList.get(i).getWerr_note());
			rowMap.put("werr_date", nonReportList.get(i).getWerr_date());
			rowMap.put("werr_fname", nonReportList.get(i).getWerr_fname());
			rowMap.put("werr_in_out_gubn", nonReportList.get(i).getWerr_in_out_gubn());

			rtnList.add(rowMap);
		}

		rtnMap.put("last_page",1);
		rtnMap.put("data",rtnList);

		return rtnMap; 
	}
	
	//부적합보고서 더블클릭 조회
	@RequestMapping(value = "/production/nonReport/nonReportDetail", method = RequestMethod.POST) 
	@ResponseBody 
	public Map<String, Object> nonReportDetail(
			@RequestParam int werr_code) {
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		Work work = new Work();
		work.setWerr_code(werr_code);
		Work nonReportList = productionService.nonReportDetail(work);

		rtnMap.put("data",nonReportList);

		return rtnMap; 
	}
	
	
	//부적합보고서(검색) 입고 조회
		@RequestMapping(value = "/production/nonReport/getNonReportIpgoList", method = RequestMethod.POST) 
		@ResponseBody 
		public Map<String, Object> getNonReportIpgoList(
				) {
			Map<String, Object> rtnMap = new HashMap<String, Object>();

			Ipgo ipgo = new Ipgo();
			
			List<Ipgo> nonReportIpgoList = productionService.getNonReportIpgoList(ipgo);

			List<HashMap<String, Object>> rtnList = new ArrayList<HashMap<String, Object>>();
			for(int i=0; i<nonReportIpgoList.size(); i++) {
				HashMap<String, Object> rowMap = new HashMap<String, Object>();
				rowMap.put("idx", (i+1));
				rowMap.put("ord_prn", nonReportIpgoList.get(i).getOrd_prn());
				rowMap.put("ord_code", nonReportIpgoList.get(i).getOrd_code());
				rowMap.put("ord_date", nonReportIpgoList.get(i).getOrd_date());
				rowMap.put("ord_nap", nonReportIpgoList.get(i).getOrd_nap());
				rowMap.put("corp_name", nonReportIpgoList.get(i).getCorp_name());
				rowMap.put("prod_name", nonReportIpgoList.get(i).getProd_name());
				rowMap.put("prod_no", nonReportIpgoList.get(i).getProd_no());
				rowMap.put("prod_gyu", nonReportIpgoList.get(i).getProd_gyu());
				rowMap.put("prod_jai", nonReportIpgoList.get(i).getProd_jai());
				rowMap.put("tech_te", nonReportIpgoList.get(i).getTech_te());
				rowMap.put("ord_danw", nonReportIpgoList.get(i).getOrd_danw());
				rowMap.put("ord_boxsu", nonReportIpgoList.get(i).getOrd_boxsu());
				rowMap.put("ord_su", nonReportIpgoList.get(i).getOrd_su());
				rowMap.put("ord_amnt", nonReportIpgoList.get(i).getOrd_amnt());
				rowMap.put("ord_lot", nonReportIpgoList.get(i).getOrd_lot());
				rowMap.put("itst_wp", nonReportIpgoList.get(i).getItst_wp());
				rowMap.put("ord_name", nonReportIpgoList.get(i).getOrd_name());
				rowMap.put("ord_sunip", nonReportIpgoList.get(i).getOrd_sunip());
				rowMap.put("ord_bigo", nonReportIpgoList.get(i).getOrd_bigo());
				rowMap.put("prod_pg", nonReportIpgoList.get(i).getProd_pg());
				rowMap.put("prod_cd", nonReportIpgoList.get(i).getProd_cd());
				rowMap.put("prod_sg", nonReportIpgoList.get(i).getProd_sg());
				rowMap.put("prod_e1", nonReportIpgoList.get(i).getProd_e1());


				rtnList.add(rowMap);
			}

			rtnMap.put("last_page",1);
			rtnMap.put("data",rtnList);

			return rtnMap; 
		}
		
		
		
		
		
		//부적합보고서 등록, 수정 - insert,update
		@RequestMapping(value = "/production/nonReportInsert/nonReportSave", method = RequestMethod.POST)
		@ResponseBody
		public Map<String, Object> nonReportSave(
				@ModelAttribute Work work,
				@RequestParam("mode") String mode) { 
			Map<String, Object> result = new HashMap<>();

			try {
				if ("insert".equalsIgnoreCase(mode)) {
					productionService.nonReportInsertSave(work);
				} else if ("update".equalsIgnoreCase(mode)) {
					productionService.nonReportUpdateSave(work);  
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


		//부적합보고서 삭제 - delete
		@RequestMapping(value = "/production/nonReportInsert/nonReportDelete", method = RequestMethod.POST)
		@ResponseBody
		public Map<String, Object> nonReportDelete(@RequestParam("werr_code") int werr_code) {
			Map<String, Object> result = new HashMap<>();

			try {
				productionService.nonReportDelete(werr_code);
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
		
		
		

	//생산대기현황 - 화면로드
	@RequestMapping(value = "/production/prodWaitingStatus", method = RequestMethod.GET)
	public String prodWaitingStatus() {
		return "/production/prodWaitingStatus.jsp";
	}	 


	//생산대기현황 조회
	@RequestMapping(value = "/production/prodWaitingStatus/getProdWaitingStatusList", method = RequestMethod.POST) 
	@ResponseBody 
	public Map<String, Object> getProdWaitingStatusList(
			@RequestParam String sdate,
			@RequestParam String edate) {
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		Work work = new Work();
		work.setSdate(sdate);
		work.setEdate(edate);


		List<Work> prodWaitingStatusList = productionService.getProdWaitingStatusList(work);

		List<HashMap<String, Object>> rtnList = new ArrayList<HashMap<String, Object>>();
		for(int i=0; i<prodWaitingStatusList.size(); i++) {
			HashMap<String, Object> rowMap = new HashMap<String, Object>();
			rowMap.put("idx", (i+1));
			rowMap.put("ord_code", prodWaitingStatusList.get(i).getOrd_code());
			rowMap.put("ord_date", prodWaitingStatusList.get(i).getOrd_date());
			rowMap.put("corp_name", prodWaitingStatusList.get(i).getCorp_name());
			rowMap.put("prod_name", prodWaitingStatusList.get(i).getProd_name());
			rowMap.put("prod_no", prodWaitingStatusList.get(i).getProd_no());
			rowMap.put("prod_gyu", prodWaitingStatusList.get(i).getProd_gyu());
			rowMap.put("ord_su", prodWaitingStatusList.get(i).getOrd_su());
			rowMap.put("ilbo_su", prodWaitingStatusList.get(i).getIlbo_su());
			rowMap.put("jan", prodWaitingStatusList.get(i).getJan());

			rtnList.add(rowMap);
		}

		rtnMap.put("last_page",1);
		rtnMap.put("data",rtnList);

		return rtnMap; 
	}

	//LOT추적 관리(입고) - 화면로드
	@RequestMapping(value = "/production/lotIpgo", method = RequestMethod.GET)
	public String lotIpgo() {
		return "/production/lotIpgo.jsp";
	}	 
	
	
	//LOT추적 관리(입고) 조회
	@RequestMapping(value = "/production/lotIpgo/getLotIpgoList", method = RequestMethod.POST) 
	@ResponseBody 
	public Map<String, Object> getLotIpgoList(
			@RequestParam String sdate,
			@RequestParam String edate,
			@RequestParam String corp_name,
			@RequestParam String prod_name,
			@RequestParam String prod_no,
			@RequestParam String prod_gyu,
			@RequestParam String prod_jai) {
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		Work work = new Work();
		work.setSdate(sdate);
		work.setEdate(edate);
		work.setCorp_name(corp_name);
		work.setProd_name(prod_name);
		work.setProd_no(prod_no);
		work.setProd_gyu(prod_gyu);
		work.setProd_jai(prod_jai);


		List<Work> ipgoList = productionService.getLotIpgoList(work);

		List<HashMap<String, Object>> rtnList = new ArrayList<HashMap<String, Object>>();
		for(int i=0; i<ipgoList.size(); i++) {
			HashMap<String, Object> rowMap = new HashMap<String, Object>();
			rowMap.put("idx", (i+1));
			rowMap.put("corp_name", ipgoList.get(i).getCorp_name());
			rowMap.put("corp_business", ipgoList.get(i).getCorp_business());
			rowMap.put("ord_code", ipgoList.get(i).getOrd_code());
			rowMap.put("prod_name", ipgoList.get(i).getProd_name());
			rowMap.put("prod_no", ipgoList.get(i).getProd_no());
			rowMap.put("prod_gyu", ipgoList.get(i).getProd_gyu());
			rowMap.put("prod_jai", ipgoList.get(i).getProd_jai());
			rowMap.put("ord_date", ipgoList.get(i).getOrd_date());
			rowMap.put("ord_lot", ipgoList.get(i).getOrd_lot());
			rowMap.put("ord_danw", ipgoList.get(i).getOrd_danw());
			rowMap.put("ord_su", ipgoList.get(i).getOrd_su());
			rowMap.put("ord_dang", ipgoList.get(i).getOrd_dang());
			rowMap.put("ord_mon", ipgoList.get(i).getOrd_mon());
			rowMap.put("ord_bigo", ipgoList.get(i).getOrd_bigo());

			rtnList.add(rowMap);
		}

		rtnMap.put("last_page",1);
		rtnMap.put("data",rtnList);

		return rtnMap; 
	}
	
	
	//LOT추적 관리(입고) - 준비 조회
	@RequestMapping(value = "/production/lotIpgo/getLotIpgoReadyList", method = RequestMethod.POST) 
	@ResponseBody 
	public Map<String, Object> getLotIpgoReadyList(@RequestParam("ord_code") Integer ord_code) {
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		Work work = new Work();
		work.setOrd_code(ord_code);


		List<Work> ipgoList = productionService.getLotIpgoReadyList(ord_code);

		List<HashMap<String, Object>> rtnList = new ArrayList<HashMap<String, Object>>();
		for(int i=0; i<ipgoList.size(); i++) {
			HashMap<String, Object> rowMap = new HashMap<String, Object>();
			rowMap.put("idx", (i+1));
			rowMap.put("ilbo_code", ipgoList.get(i).getIlbo_code());
			rowMap.put("ilbo_strt", ipgoList.get(i).getIlbo_strt());
			rowMap.put("ilbo_strt", ipgoList.get(i).getIlbo_strt());
			rowMap.put("ilbo_end", ipgoList.get(i).getIlbo_end());
			rowMap.put("ilbo_su", ipgoList.get(i).getIlbo_su());
			rowMap.put("ilbo_jung", ipgoList.get(i).getIlbo_jung());
			rowMap.put("user_name", ipgoList.get(i).getUser_name());

			rtnList.add(rowMap);
		}

		rtnMap.put("last_page",1);
		rtnMap.put("data",rtnList);

		return rtnMap; 
	}
	
	
	//LOT추적 관리(입고) - 침탄 조회
	@RequestMapping(value = "/production/lotIpgo/getLotIpgoChimList", method = RequestMethod.POST) 
	@ResponseBody 
	public Map<String, Object> getLotIpgoChimList(@RequestParam("ord_code") Integer ord_code) {
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		Work work = new Work();
		work.setOrd_code(ord_code);


		List<Work> ipgoList = productionService.getLotIpgoChimList(ord_code);

		List<HashMap<String, Object>> rtnList = new ArrayList<HashMap<String, Object>>();
		for(int i=0; i<ipgoList.size(); i++) {
			HashMap<String, Object> rowMap = new HashMap<String, Object>();
			rowMap.put("ilbo_pc", ipgoList.get(i).getIlbo_pc());
			rowMap.put("ilbo_lot", ipgoList.get(i).getIlbo_lot());
			rowMap.put("ilbo_strt", ipgoList.get(i).getIlbo_strt());
			rowMap.put("ilbo_end", ipgoList.get(i).getIlbo_end());
			rowMap.put("fac_name", ipgoList.get(i).getFac_name());
			rowMap.put("user_name", ipgoList.get(i).getUser_name());
			rowMap.put("ilbo_su", ipgoList.get(i).getIlbo_su());
			rowMap.put("ilbo_jung", ipgoList.get(i).getIlbo_jung());
			rowMap.put("ilbo_g43", ipgoList.get(i).getIlbo_g43());
			rowMap.put("ilbo_g42", ipgoList.get(i).getIlbo_g42());
			rowMap.put("ilbo_g23", ipgoList.get(i).getIlbo_g23());
			rowMap.put("ilbo_g24", ipgoList.get(i).getIlbo_g24());
			rowMap.put("ilbo_g25", ipgoList.get(i).getIlbo_g25());
			rowMap.put("ilbo_pg6", ipgoList.get(i).getIlbo_pg6());
			rowMap.put("ilbo_g26", ipgoList.get(i).getIlbo_g26());
			rowMap.put("ilbo_g27", ipgoList.get(i).getIlbo_g27());
			rowMap.put("ilbo_g31", ipgoList.get(i).getIlbo_g31());
			rowMap.put("ilbo_g32", ipgoList.get(i).getIlbo_g32());
			rowMap.put("ilbo_g33", ipgoList.get(i).getIlbo_g33());
			rowMap.put("ilbo_g34", ipgoList.get(i).getIlbo_g34());

			rtnList.add(rowMap);
		}

		rtnMap.put("last_page",1);
		rtnMap.put("data",rtnList);

		return rtnMap; 
	}
	
	
	//LOT추적 관리(입고) - 템퍼링 조회
	@RequestMapping(value = "/production/lotIpgo/getLotIpgoTemList", method = RequestMethod.POST) 
	@ResponseBody 
	public Map<String, Object> getLotIpgoTemList(@RequestParam("ord_code") Integer ord_code) {
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		Work work = new Work();
		work.setOrd_code(ord_code);


		List<Work> ipgoList = productionService.getLotIpgoTemList(ord_code);

		List<HashMap<String, Object>> rtnList = new ArrayList<HashMap<String, Object>>();
		for(int i=0; i<ipgoList.size(); i++) {
			HashMap<String, Object> rowMap = new HashMap<String, Object>();
			rowMap.put("ilbo_pc", ipgoList.get(i).getIlbo_pc());
			rowMap.put("ilbo_lot", ipgoList.get(i).getIlbo_lot());
			rowMap.put("ilbo_strt", ipgoList.get(i).getIlbo_strt());
			rowMap.put("ilbo_end", ipgoList.get(i).getIlbo_end());
			rowMap.put("fac_name", ipgoList.get(i).getFac_name());
			rowMap.put("user_name", ipgoList.get(i).getUser_name());
			rowMap.put("ilbo_su", ipgoList.get(i).getIlbo_su());
			rowMap.put("ilbo_jung", ipgoList.get(i).getIlbo_jung());
			rowMap.put("ilbo_g11", ipgoList.get(i).getIlbo_g11());
			rowMap.put("ilbo_g12", ipgoList.get(i).getIlbo_g12());
			rowMap.put("ilbo_cm", ipgoList.get(i).getIlbo_cm());

			rtnList.add(rowMap);
		}

		rtnMap.put("last_page",1);
		rtnMap.put("data",rtnList);

		return rtnMap; 
	}
	
	
	//LOT추적 관리(입고) - 출고 조회
	@RequestMapping(value = "/production/lotIpgo/getLotIpgoChulList", method = RequestMethod.POST) 
	@ResponseBody 
	public Map<String, Object> getLotIpgoChulList(@RequestParam("ord_code") Integer ord_code) {
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		Work work = new Work();
		work.setOrd_code(ord_code);


		List<Work> ipgoList = productionService.getLotIpgoChulList(ord_code);

		List<HashMap<String, Object>> rtnList = new ArrayList<HashMap<String, Object>>();
		for(int i=0; i<ipgoList.size(); i++) {
			HashMap<String, Object> rowMap = new HashMap<String, Object>();
			rowMap.put("ord_code", ipgoList.get(i).getOrd_code());
			rowMap.put("corp_name", ipgoList.get(i).getCorp_name());
			rowMap.put("prod_name", ipgoList.get(i).getProd_name());
			rowMap.put("prod_no", ipgoList.get(i).getProd_no());
			rowMap.put("ord_date", ipgoList.get(i).getOrd_date());
			rowMap.put("ord_lot", ipgoList.get(i).getOrd_lot());
			rowMap.put("och_date", ipgoList.get(i).getOch_date());
			rowMap.put("och_su", ipgoList.get(i).getOch_su());
			rowMap.put("och_amnt", ipgoList.get(i).getOch_amnt());
			rowMap.put("och_bigo", ipgoList.get(i).getOch_bigo());

			rtnList.add(rowMap);
		}

		rtnMap.put("last_page",1);
		rtnMap.put("data",rtnList);

		return rtnMap; 
	}
	
	

	//LOT추적 관리(열처리LOT) - 화면로드
	@RequestMapping(value = "/production/lotHeat", method = RequestMethod.GET)
	public String lotHeat() {
		return "/production/lotHeat.jsp";
	}	 
	
	
	//LOT추적 관리(열처리LOT) 조회
	@RequestMapping(value = "/production/lotHeat/getLotHeatList", method = RequestMethod.POST) 
	@ResponseBody 
	public Map<String, Object> getLotHeatList(
			@RequestParam String sdate,
			@RequestParam String edate) {
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		Work work = new Work();
		work.setSdate(sdate);
		work.setEdate(edate);


		List<Work> ipgoList = productionService.getLotHeatList(work);

		List<HashMap<String, Object>> rtnList = new ArrayList<HashMap<String, Object>>();
		for(int i=0; i<ipgoList.size(); i++) {
			HashMap<String, Object> rowMap = new HashMap<String, Object>();
			rowMap.put("ord_code", ipgoList.get(i).getOrd_code());
			rowMap.put("ilbo_strt", ipgoList.get(i).getIlbo_strt());
			rowMap.put("juckjaecode", ipgoList.get(i).getJuckjaecode());
			rowMap.put("corp_name", ipgoList.get(i).getCorp_name());
			rowMap.put("prod_name", ipgoList.get(i).getProd_name());
			rowMap.put("prod_no", ipgoList.get(i).getProd_no());
			rowMap.put("ord_date", ipgoList.get(i).getOrd_date());
			rowMap.put("ilbo_lot", ipgoList.get(i).getIlbo_lot());
			rowMap.put("ilbo_su", ipgoList.get(i).getIlbo_su());
			rowMap.put("och_bigo", ipgoList.get(i).getOch_bigo());
			rowMap.put("ilbo_pc", ipgoList.get(i).getIlbo_pc());

			rtnList.add(rowMap);
		}

		rtnMap.put("last_page",1);
		rtnMap.put("data",rtnList);

		return rtnMap; 
	}
	
	
	//LOT추적 관리(열처리LOT) - 입고 조회
	@RequestMapping(value = "/production/lotHeat/getLotHeatIpgoList", method = RequestMethod.POST) 
	@ResponseBody 
	public Map<String, Object> getLotHeatIpgoList(@RequestParam("ord_code") Integer ord_code) {
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		Work work = new Work();
		work.setOrd_code(ord_code);


		List<Work> ipgoList = productionService.getLotHeatIpgoList(ord_code);

		List<HashMap<String, Object>> rtnList = new ArrayList<HashMap<String, Object>>();
		for(int i=0; i<ipgoList.size(); i++) {
			HashMap<String, Object> rowMap = new HashMap<String, Object>();
			rowMap.put("ord_code", ipgoList.get(i).getOrd_code());
			rowMap.put("ord_date", ipgoList.get(i).getOrd_date());
			rowMap.put("ord_lot", ipgoList.get(i).getOrd_lot());
			rowMap.put("ord_danw", ipgoList.get(i).getOrd_danw());
			rowMap.put("ord_su", ipgoList.get(i).getOrd_su());
			rowMap.put("ord_dang", ipgoList.get(i).getOrd_dang());
			rowMap.put("ord_mon", ipgoList.get(i).getOrd_mon());

			rtnList.add(rowMap);
		}

		rtnMap.put("last_page",1);
		rtnMap.put("data",rtnList);

		return rtnMap; 
	}

	
	
	//LOT추적 관리(열처리LOT) - 입고 조회
	@RequestMapping(value = "/production/lotHeat/getLotHeatJuckList", method = RequestMethod.POST) 
	@ResponseBody 
	public Map<String, Object> getLotHeatJuckList(@RequestParam("ilbo_pc") String ilbo_pc) {
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		Work work = new Work();
		work.setIlbo_pc(ilbo_pc);


		List<Work> ipgoList = productionService.getLotHeatJuckList(ilbo_pc);

		List<HashMap<String, Object>> rtnList = new ArrayList<HashMap<String, Object>>();
		for(int i=0; i<ipgoList.size(); i++) {
			HashMap<String, Object> rowMap = new HashMap<String, Object>();
			rowMap.put("juckjaecode", ipgoList.get(i).getJuckjaecode());
			rowMap.put("ilbo_strt", ipgoList.get(i).getIlbo_strt());
			rowMap.put("ilbo_end", ipgoList.get(i).getIlbo_end());
			rowMap.put("ilbo_su", ipgoList.get(i).getIlbo_su());
			rowMap.put("user_name", ipgoList.get(i).getUser_name());

			rtnList.add(rowMap);
		}

		rtnMap.put("last_page",1);
		rtnMap.put("data",rtnList);

		return rtnMap; 
	}

	
	
	//LOT추적 관리(열처리LOT) - 입고 조회
	@RequestMapping(value = "/production/lotHeat/getLotHeatChimList", method = RequestMethod.POST) 
	@ResponseBody 
	public Map<String, Object> getLotHeatChimList(@RequestParam("ilbo_pc") String ilbo_pc) {
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		Work work = new Work();
		work.setIlbo_pc(ilbo_pc);


		List<Work> ipgoList = productionService.getLotHeatChimList(ilbo_pc);

		List<HashMap<String, Object>> rtnList = new ArrayList<HashMap<String, Object>>();
		for(int i=0; i<ipgoList.size(); i++) {
			HashMap<String, Object> rowMap = new HashMap<String, Object>();
			rowMap.put("juckjaecode", ipgoList.get(i).getJuckjaecode());
			rowMap.put("ilbo_strt", ipgoList.get(i).getIlbo_strt());
			rowMap.put("ilbo_end", ipgoList.get(i).getIlbo_end());
			rowMap.put("ilbo_su", ipgoList.get(i).getIlbo_su());
			rowMap.put("user_name", ipgoList.get(i).getUser_name());
			rowMap.put("ilbo_lot", ipgoList.get(i).getIlbo_lot());
			rowMap.put("ilbo_g11", ipgoList.get(i).getIlbo_g11());
			rowMap.put("ilbo_g12", ipgoList.get(i).getIlbo_g12());
			rowMap.put("ilbo_ms", ipgoList.get(i).getIlbo_ms());
			rowMap.put("ilbo_g34", ipgoList.get(i).getIlbo_g34());
			rowMap.put("ilbo_g35", ipgoList.get(i).getIlbo_g35());
			rowMap.put("ilbo_mp", ipgoList.get(i).getIlbo_mp());
			rowMap.put("ilbo_g23", ipgoList.get(i).getIlbo_g23());
			rowMap.put("ilbo_g24", ipgoList.get(i).getIlbo_g24());
			rowMap.put("ilbo_g25", ipgoList.get(i).getIlbo_g25());
			rowMap.put("ilbo_p26", ipgoList.get(i).getIlbo_p26());
			rowMap.put("ilbo_g26", ipgoList.get(i).getIlbo_g26());
			rowMap.put("ilbo_g27", ipgoList.get(i).getIlbo_g27());
			rowMap.put("ilbo_g31", ipgoList.get(i).getIlbo_g31());
			rowMap.put("ilbo_g32", ipgoList.get(i).getIlbo_g32());
			rowMap.put("ilbo_g33", ipgoList.get(i).getIlbo_g33());
			rowMap.put("ilbo_cm", ipgoList.get(i).getIlbo_cm());
			rowMap.put("ilbo_g41", ipgoList.get(i).getIlbo_g41());
			rowMap.put("ilbo_g42", ipgoList.get(i).getIlbo_g42());
			rowMap.put("ilbo_g21", ipgoList.get(i).getIlbo_g21());
			rowMap.put("ilbo_g22", ipgoList.get(i).getIlbo_g22());
			rowMap.put("ilbo_g13", ipgoList.get(i).getIlbo_g13());
			rowMap.put("ilbo_pg1", ipgoList.get(i).getIlbo_pg1());
			rowMap.put("ilbo_pg2", ipgoList.get(i).getIlbo_pg2());
			rowMap.put("ilbo_pg3", ipgoList.get(i).getIlbo_pg3());
			rowMap.put("ilbo_pg4", ipgoList.get(i).getIlbo_pg4());
			rowMap.put("ilbo_pg5", ipgoList.get(i).getIlbo_pg5());
			
			

			rtnList.add(rowMap);
		}

		rtnMap.put("last_page",1);
		rtnMap.put("data",rtnList);

		return rtnMap; 
	}
	
	
	
	
	
	
	
	
	
	
	
	
	

}
