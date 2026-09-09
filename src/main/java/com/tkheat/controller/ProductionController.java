package com.tkheat.controller;
import java.io.File;
import java.io.FileInputStream;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.InputStreamResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
import net.sf.jasperreports.engine.export.JRPdfExporter;
import net.sf.jasperreports.export.SimpleExporterInput;
import net.sf.jasperreports.export.SimpleOutputStreamExporterOutput;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;


import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;


import com.tkheat.domain.Ipgo;
import com.tkheat.domain.Monitoring;
import com.tkheat.domain.Work;
import com.tkheat.domain.WorkJisiTk;
import com.tkheat.service.MonitoringService;
import com.tkheat.service.ProductionService;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperReportsContext;
import net.sf.jasperreports.engine.SimpleJasperReportsContext;

import org.jfree.chart.ChartFactory;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.axis.NumberAxis;
import org.jfree.chart.axis.NumberTickUnit;
import org.jfree.chart.plot.XYPlot;
import org.jfree.data.time.Second;
import org.jfree.data.time.TimeSeries;
import org.jfree.data.time.TimeSeriesCollection;

import java.awt.Font;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.lang.reflect.Method;
import javax.imageio.ImageIO;

@Controller
public class ProductionController {

	@Autowired
	private ProductionService productionService;

	@Autowired
	private MonitoringService monitoringService;


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
	
	
	
	//lot보고서 - 화면로드
	@RequestMapping(value = "/production/lotReport", method = RequestMethod.GET)
	public String lotReport() {
		return "/production/lotReport.jsp";
	}	
	
	
	
	// LOT 보고서 리스트 조회
	@RequestMapping(value = "/production/lotReport/getLotList", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getLotList(@RequestParam(value = "lotno_date", required = false) String lotno_date,
	        @RequestParam(value = "report_type", required = false, defaultValue = "ALL") String reportType) {
	    Map<String, Object> rtnMap = new HashMap<String, Object>();

	    try {
	        WorkJisiTk workJisiTk = new WorkJisiTk();
	        workJisiTk.setReport_type(reportType);

	        if (lotno_date != null && !lotno_date.isEmpty()) {
	            String date = lotno_date.replace("-", ""); // 2025-01 -> 202501
	            workJisiTk.setLotno_date(date);
	        }

	        List<WorkJisiTk> lotList = productionService.getLotList(workJisiTk);
	        List<HashMap<String, Object>> rtnList = new ArrayList<HashMap<String, Object>>();

	        for (int i = 0; i < lotList.size(); i++) {
	            HashMap<String, Object> rowMap = new HashMap<String, Object>();

	            rowMap.put("ilbo_lot", lotList.get(i).getIlbo_lot());
	            rowMap.put("ilbo_strt", lotList.get(i).getIlbo_strt());
	            rowMap.put("ilbo_end", lotList.get(i).getIlbo_end());
	            rowMap.put("ilbo_gubn", lotList.get(i).getIlbo_gubn());
	            rowMap.put("corp_name", lotList.get(i).getCorp_name());
	            rowMap.put("prod_name", lotList.get(i).getProd_name());
	            rowMap.put("prod_no", lotList.get(i).getProd_no());
	            rowMap.put("fac_code", lotList.get(i).getFac_code());
	            rowMap.put("fac_name", lotList.get(i).getFac_name());
	            rowMap.put("heat_fac_name", lotList.get(i).getHeat_fac_name());
	            rowMap.put("tf_fac_name", lotList.get(i).getTf_fac_name());

	            rtnList.add(rowMap);
	        }
	        
	        rtnMap.put("last_page", 1);
	        rtnMap.put("data", rtnList);
	        
	    } catch (Exception e) {
	        System.err.println("❌ LOT 보고서 조회 실패:");
	        e.printStackTrace();
	        
	        rtnMap.put("last_page", 1);
	        rtnMap.put("data", new ArrayList<>());
	    }
	    
	    return rtnMap;
	}
	
	
	//lotReort 생성(자스퍼리포트)
	@RequestMapping(value = "/production/lotReport/lotPrint", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<Resource> lotPrint(@RequestBody WorkJisiTk workJisiTk,
	        HttpServletRequest request) {
	    
	    System.out.println("===== lotPrint 진입 =====");
	    
	    if (workJisiTk.getIlbo_lot() == null) {
	        System.out.println("▶ 로트번호 == null");
	        return ResponseEntity.badRequest().body(null);
	    }
	    
	    System.out.println("▶ 요청 LOT = " + workJisiTk.getIlbo_lot());
	    
	    String lotno = workJisiTk.getIlbo_lot();
	    String pdfFileName = lotno + ".pdf";
	    String pdfPath = "D:/태경출력파일/lot보고서/" + pdfFileName;
	    
	    try {
	        // 1) 데이터 조회
	        List<WorkJisiTk> lotInfoList = productionService.getLotListReport(workJisiTk);
	        
	        System.out.println("▶ lotInfoList size = " + (lotInfoList == null ? "null" : lotInfoList.size()));
	        
	        if (lotInfoList == null || lotInfoList.isEmpty()) {
	            System.out.println("▶ lotInfoList 비어있음");
	            return ResponseEntity.badRequest().body(null);
	        }
	        
	        for (WorkJisiTk v : lotInfoList) {
	            System.out.println("v.getIlbo_strt() = " + v.getIlbo_strt());
	        }

        // 2) 한 LOT이 열처리->템퍼링 두 단계(각각 다른 설비/작업기간)를 거칠 수 있으므로,
        //    여러 행(단계별로 1개씩)을 한 행으로 병합해서 리포트에는 항상 1건만 넘김.
        //    단, 침탄로/템퍼링 개별 보고서 요청이면 해당 단계 행만 남기고 병합(다른 단계 정보가 섞여 나오지 않게)
        String reportType = workJisiTk.getReport_type();
        List<WorkJisiTk> mergeSourceList = lotInfoList;
        if ("HEAT".equals(reportType)) {
            mergeSourceList = new ArrayList<>();
            for (WorkJisiTk v : lotInfoList) {
                if ("A".equals(v.getIlbo_gubn())) {
                    mergeSourceList.add(v);
                }
            }
        } else if ("TF".equals(reportType)) {
            mergeSourceList = new ArrayList<>();
            for (WorkJisiTk v : lotInfoList) {
                if ("R".equals(v.getIlbo_gubn())) {
                    mergeSourceList.add(v);
                }
            }
        }
        if (mergeSourceList.isEmpty()) {
            mergeSourceList = lotInfoList;
        }

        WorkJisiTk merged = mergeLotReportRows(mergeSourceList);
        List<WorkJisiTk> reportDataList = new ArrayList<>();
        reportDataList.add(merged);

        Map<String, Object> reportMap = new HashMap<>();
        reportMap.put("lotno", lotno);

        // 3) 단계별 작업기간중 알람이력 (해당 단계가 존재할 때만)
        StringBuilder alarmText = new StringBuilder();
        appendStageAlarmText(alarmText, "열처리(" + nullToDash(merged.getHeat_fac_name()) + ")",
                merged.getHeat_fac_code(), merged.getHeat_strt(), merged.getHeat_end());
        appendStageAlarmText(alarmText, "템퍼링(" + nullToDash(merged.getTf_fac_name()) + ")",
                merged.getTf_fac_code(), merged.getTf_strt(), merged.getTf_end());
        reportMap.put("alarmListText", alarmText.length() > 0 ? alarmText.toString() : "해당 작업기간 중 발생한 알람이 없습니다.");

        // 4) 단계별 온도트렌드 차트 (해당 단계가 존재할 때만 각각 별도 이미지로)
        reportMap.put("heatTrendChartImage", buildStageTrendChartImage("열처리 - " + nullToDash(merged.getHeat_fac_name()),
                merged.getHeat_fac_code(), merged.getHeat_strt(), merged.getHeat_end()));
        reportMap.put("tfTrendChartImage", buildStageTrendChartImage("템퍼링 - " + nullToDash(merged.getTf_fac_name()),
                merged.getTf_fac_code(), merged.getTf_strt(), merged.getTf_end()));

	        // Report - lot보고서
	        String reportPath = request.getServletContext()
	                .getRealPath("/WEB-INF/resources/reports/lotReport.jrxml");
	        
	        System.out.println("▶ reportPath = " + reportPath);
	        
	        JasperReport report = JasperCompileManager.compileReport(reportPath);
	        JasperPrint jasperPrint = JasperFillManager.fillReport(
	                report,
	                reportMap,
	                new JRBeanCollectionDataSource(reportDataList)
	        );
	        
	        System.out.println("▶ jasperPrint 생성 완료");
	        
	        // PDF 생성
	        JRPdfExporter exporter = new JRPdfExporter();
	        
	        // ✅ 수정: List로 감싸기
	        List<JasperPrint> jasperPrintList = new ArrayList<>();
	        jasperPrintList.add(jasperPrint);
	        exporter.setExporterInput(SimpleExporterInput.getInstance(jasperPrintList));
	        
	        exporter.setExporterOutput(new SimpleOutputStreamExporterOutput(pdfPath));
	        
	        exporter.exportReport();
	        
	        File file = new File(pdfPath);
	        System.out.println("▶ PDF 생성 완료 : " + file.exists());
	        
	        if (!file.exists()) {
	            System.out.println("▶ PDF 파일 생성 실패");
	            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
	        }
	        
	        InputStreamResource resource = new InputStreamResource(new FileInputStream(file));
	        
	        return ResponseEntity.ok()
	                .header(HttpHeaders.CONTENT_DISPOSITION,
	                        "attachment; filename=\"" + URLEncoder.encode(pdfFileName, "UTF-8").replaceAll("\\+", "%20") + "\"")
	                .contentLength(file.length())
	                .contentType(MediaType.parseMediaType("application/pdf"))
	                .body(resource);
	        
	    } catch (Exception e) {
	        System.out.println("▶ 예외 발생");
	        e.printStackTrace();
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
	    }
	}
	
	
	
	
	
	


	//LOT 보고서 - 설비코드 -> tb_alarmlist.a_hogi 태그 매핑 (침탄로 BCF1~5, 템퍼링은 1/2호기 구분없이 TF 하나로 수집됨)
	private String mapFacCodeToAlarmHogi(int facCode) {
		switch (facCode) {
			case 1: return "BCF1";
			case 2: return "BCF2";
			case 3: return "BCF3";
			case 4: return "BCF4";
			case 18: return "BCF5";
			case 16:
			case 17: return "TF";
			default: return null;
		}
	}

	//LOT 보고서 - 알람이력 목록을 리포트에 한 번에 넣을 텍스트 블록으로 가공
	private String buildAlarmListText(List<WorkJisiTk> alarmList) {
		if (alarmList == null || alarmList.isEmpty()) {
			return "해당 작업기간 중 발생한 알람이 없습니다.";
		}

		StringBuilder sb = new StringBuilder();
		for (WorkJisiTk a : alarmList) {
			String time = a.getRegtime();
			if (time != null && time.length() >= 16) {
				time = time.substring(5, 16); // "yyyy-MM-dd HH:mm:ss" -> "MM-dd HH:mm"
			}
			String state = "1".equals(a.getA_value()) ? "발생" : "해제";
			sb.append(time).append("  ").append(a.getA_comment()).append(" (").append(state).append(")\n");
		}
		return sb.toString();
	}

	//LOT 보고서 - 온도트렌드 차트 이미지 생성 (TrendSnapshotScheduler.savePng()와 동일한 방식, 파일 대신 byte[] 반환)
	//LOT 보고서 - 여러 WORKILBO 행(단계별)을 한 행으로 병합. 작업시작/종료는 전체 단계 중 최소/최대로 재계산
	private WorkJisiTk mergeLotReportRows(List<WorkJisiTk> rows) {
		WorkJisiTk merged = new WorkJisiTk();
		String earliestStrt = null;
		String latestEnd = null;

		for (WorkJisiTk row : rows) {
			mergeStringFields(merged, row);

			if ("A".equals(row.getIlbo_gubn())) {
				merged.setHeat_fac_name(row.getFac_name());
				merged.setHeat_fac_code(row.getFac_code());
				merged.setHeat_strt(row.getIlbo_strt());
				merged.setHeat_end(row.getIlbo_end());
			} else if ("R".equals(row.getIlbo_gubn())) {
				merged.setTf_fac_name(row.getFac_name());
				merged.setTf_fac_code(row.getFac_code());
				merged.setTf_strt(row.getIlbo_strt());
				merged.setTf_end(row.getIlbo_end());
			}

			if (isValidDateTime(row.getIlbo_strt()) && (earliestStrt == null || row.getIlbo_strt().compareTo(earliestStrt) < 0)) {
				earliestStrt = row.getIlbo_strt();
			}
			if (isValidDateTime(row.getIlbo_end()) && (latestEnd == null || row.getIlbo_end().compareTo(latestEnd) > 0)) {
				latestEnd = row.getIlbo_end();
			}
		}

		merged.setIlbo_strt(earliestStrt);
		merged.setIlbo_end(latestEnd);
		return merged;
	}

	//target에 값이 비어있는 String 필드만 source의 값으로 채움 (여러 단계 행에 나뉘어 있는 정보를 한 행으로 합치기 위함)
	private void mergeStringFields(WorkJisiTk target, WorkJisiTk source) {
		for (Method getter : WorkJisiTk.class.getMethods()) {
			if (!getter.getName().startsWith("get") || getter.getParameterCount() != 0 || getter.getReturnType() != String.class) {
				continue;
			}
			try {
				String currentVal = (String) getter.invoke(target);
				if (currentVal != null && !currentVal.isEmpty()) {
					continue;
				}
				String newVal = (String) getter.invoke(source);
				if (newVal == null || newVal.isEmpty()) {
					continue;
				}
				Method setter = WorkJisiTk.class.getMethod("set" + getter.getName().substring(3), String.class);
				setter.invoke(target, newVal);
			} catch (Exception e) {
				//필드 하나 실패해도 나머지는 계속 진행
			}
		}
	}

	private boolean isValidDateTime(String s) {
		return s != null && !s.isEmpty() && !s.startsWith("1900");
	}

	private String nullToDash(String s) {
		return (s == null || s.isEmpty()) ? "-" : s;
	}

	//LOT 보고서 - 단계 하나(열처리 또는 템퍼링)의 알람이력을 텍스트로 뽑아 sb에 이어붙임. 단계가 없으면 아무것도 추가하지 않음
	private void appendStageAlarmText(StringBuilder sb, String stageLabel, int facCode, String strt, String end) {
		String hogi = mapFacCodeToAlarmHogi(facCode);
		if (hogi == null || !isValidDateTime(strt) || !isValidDateTime(end)) {
			return;
		}

		WorkJisiTk alarmParam = new WorkJisiTk();
		alarmParam.setSdate(strt);
		alarmParam.setEdate(end);
		alarmParam.setA_hogi(hogi);
		List<WorkJisiTk> alarmList = productionService.getLotAlarmList(alarmParam);
		if (alarmList == null || alarmList.isEmpty()) {
			return;
		}

		sb.append("[").append(stageLabel).append("]\n");
		sb.append(buildAlarmListText(alarmList));
		sb.append("\n");
	}

	//jrxml에서 쓰는 굴림 폰트(한글 깨짐 방지용, 차트는 PDF 폰트임베딩이 아니라 이미지라 별도 로딩 필요)
	private Font loadKoreanFont(float size, int style) {
		try (InputStream is = getClass().getClassLoader().getResourceAsStream("fonts/gulim.ttf")) {
			if (is == null) {
				return new Font("SansSerif", style, (int) size);
			}
			Font base = Font.createFont(Font.TRUETYPE_FONT, is);
			return base.deriveFont(style, size);
		} catch (Exception e) {
			return new Font("SansSerif", style, (int) size);
		}
	}

	//LOT 보고서 - 단계 하나(열처리 또는 템퍼링)의 온도트렌드 차트 이미지 생성. 단계가 없으면(설비코드 0 등) null 반환
	private byte[] buildStageTrendChartImage(String stageTitle, int facCode, String sdate, String edate) {
		if (facCode == 0 || !isValidDateTime(sdate) || !isValidDateTime(edate)) {
			return null;
		}

		try {
			Monitoring param = new Monitoring();
			param.setStartDate(sdate);
			param.setEndDate(edate);

			List<Monitoring> list = monitoringService.gettrend(param);

			if (list == null || list.isEmpty()) {
				return null;
			}

			boolean isTempering = (facCode == 16 || facCode == 17);

			TimeSeries series1 = new TimeSeries(isTempering ? "존1 온도" : "CF(PV)");
			TimeSeries series2 = new TimeSeries(isTempering ? "존2 온도" : "OIL(PV)");

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

				if (isTempering) {
					if (m.getTf1_zone1() != null) {
						series1.addOrUpdate(second, m.getTf1_zone1());
					}
					if (m.getTf1_zone2() != null) {
						series2.addOrUpdate(second, m.getTf1_zone2());
					}
				} else {
					Integer cf = getBcfCfByFacCode(m, facCode);
					Integer oil = getBcfOilByFacCode(m, facCode);
					if (cf != null) {
						series1.addOrUpdate(second, cf);
					}
					if (oil != null) {
						series2.addOrUpdate(second, oil);
					}
				}
			}

			if (series1.isEmpty() && series2.isEmpty()) {
				return null;
			}

			TimeSeriesCollection dataset = new TimeSeriesCollection();
			dataset.addSeries(series1);
			dataset.addSeries(series2);

			JFreeChart chart = ChartFactory.createTimeSeriesChart(
					stageTitle,
					"시간",
					"온도(℃)",
					dataset,
					true,
					true,
					false
			);

			//한글 폰트를 명시적으로 지정하지 않으면 서버 환경에 따라 제목/범례/축 한글이 네모(tofu)로 깨져 나옴
			Font titleFont = loadKoreanFont(14f, Font.BOLD);
			Font labelFont = loadKoreanFont(11f, Font.PLAIN);
			Font tickFont = loadKoreanFont(9f, Font.PLAIN);

			chart.getTitle().setFont(titleFont);
			if (chart.getLegend() != null) {
				chart.getLegend().setItemFont(labelFont);
			}

			XYPlot plot = chart.getXYPlot();
			plot.getDomainAxis().setLabelFont(labelFont);
			plot.getDomainAxis().setTickLabelFont(tickFont);

			NumberAxis rangeAxis = (NumberAxis) plot.getRangeAxis();
			rangeAxis.setLabelFont(labelFont);
			rangeAxis.setTickLabelFont(tickFont);
			//웹 트렌드 화면(monitoring/trend.jsp)과 같은 스케일로 고정 - 안 그러면 LOT마다 데이터 범위가 달라 그래프 축척이 제각각으로 보임
			rangeAxis.setRange(0, 1200);
			rangeAxis.setTickUnit(new NumberTickUnit(100));

			BufferedImage bufferedImage = chart.createBufferedImage(900, 400);
			ByteArrayOutputStream baos = new ByteArrayOutputStream();
			ImageIO.write(bufferedImage, "png", baos);
			return baos.toByteArray();

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	private Integer getBcfCfByFacCode(Monitoring m, int facCode) {
		switch (facCode) {
			case 1: return m.getBcf1_cf_pv();
			case 2: return m.getBcf2_cf_pv();
			case 3: return m.getBcf3_cf_pv();
			case 4: return m.getBcf4_cf_pv();
			case 18: return m.getBcf5_cf_pv();
			default: return null;
		}
	}

	private Integer getBcfOilByFacCode(Monitoring m, int facCode) {
		switch (facCode) {
			case 1: return m.getBcf1_oil_pv();
			case 2: return m.getBcf2_oil_pv();
			case 3: return m.getBcf3_oil_pv();
			case 4: return m.getBcf4_oil_pv();
			case 18: return m.getBcf5_oil_pv();
			default: return null;
		}
	}

}
