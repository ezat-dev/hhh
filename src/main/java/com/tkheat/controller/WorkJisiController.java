package com.tkheat.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

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
import com.tkheat.domain.Product;
import com.tkheat.domain.Users;
import com.tkheat.domain.WorkJisi;
import com.tkheat.service.WorkJisiService;
import com.tkheat.util.UtilClass;

import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.JasperReportsContext;
import net.sf.jasperreports.engine.SimpleJasperReportsContext;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

@Controller
public class WorkJisiController {

	@Autowired
	private WorkJisiService workJisiService;


	//입고관리

	//입고관리 - 화면로드
	@RequestMapping(value = "/product/ipgo", method = RequestMethod.GET)
	public String ipgo() {
		return "/product/ipgo.jsp";
	}	 

	//입고관리 조회
	@RequestMapping(value = "/product/ipgo/getIpgoList", method = RequestMethod.POST) 
	@ResponseBody 
	public Map<String, Object> getIpgoList(
			@RequestParam String sdate,
			@RequestParam String edate
			) {
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		WorkJisi ipgo = new WorkJisi();
		ipgo.setSdate(sdate);
		ipgo.setEdate(edate);
		
		List<WorkJisi> ipgoList = workJisiService.getIpgoList(ipgo);

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
			rowMap.put("ord_danj", ipgoList.get(i).getOrd_danj());
			rowMap.put("itst_wp", ipgoList.get(i).getItst_wp());
			rowMap.put("ord_name", ipgoList.get(i).getOrd_name());
			rowMap.put("ord_sunip", ipgoList.get(i).getOrd_sunip());
			rowMap.put("ord_bigo", ipgoList.get(i).getOrd_bigo());
			rowMap.put("prod_pg", ipgoList.get(i).getProd_pg());
			rowMap.put("prod_cd", ipgoList.get(i).getProd_cd());
			rowMap.put("prod_sg", ipgoList.get(i).getProd_sg());
			rowMap.put("prod_e1", ipgoList.get(i).getProd_e1());
			
			//열처리수주서 파일유무
			File file1 = new File("D:/태경출력파일/열처리수주서/"+ipgoList.get(i).getOrd_code()+".pdf");
			File file2 = new File("D:/태경출력파일/열후TAG/"+ipgoList.get(i).getOrd_code()+".pdf");
			File file3 = new File("D:/태경출력파일/입고현황표/"+ipgoList.get(i).getOrd_code()+".pdf");

			if(file1.exists()) {
				rowMap.put("ord_before_file_yn",1);
			}else {
				rowMap.put("ord_before_file_yn",0);
			}
			
			if(file2.exists()) {
				rowMap.put("ord_after_file_yn",1);
			}else {
				rowMap.put("ord_after_file_yn",0);
			}
			
			if(file3.exists()) {
				rowMap.put("ord_manage_file_yn",1);
			}else {
				rowMap.put("ord_manage_file_yn",0);
			}

			rtnList.add(rowMap);
		}

		rtnMap.put("last_page",1);
		rtnMap.put("data",rtnList);

		return rtnMap; 
	}
	
	//입고관리 - 입고등록리스트
		@RequestMapping(value = "/product/ipgo/getIpgoAddList", method = RequestMethod.POST) 
		@ResponseBody 
		public Map<String, Object> getIpgoAddList(
				@RequestParam String sdate,
				@RequestParam String edate
				) {
			Map<String, Object> rtnMap = new HashMap<String, Object>();

			WorkJisi ipgo = new WorkJisi();
			ipgo.setSdate(sdate);
			ipgo.setEdate(edate);
			
			List<WorkJisi> ipgoList = workJisiService.getIpgoAddList(ipgo);

			List<HashMap<String, Object>> rtnList = new ArrayList<HashMap<String, Object>>();
			for(int i=0; i<ipgoList.size(); i++) {
				HashMap<String, Object> rowMap = new HashMap<String, Object>();
				rowMap.put("idx", (i+1));
				rowMap.put("prod_code", ipgoList.get(i).getProd_code());
				rowMap.put("corp_name", ipgoList.get(i).getCorp_name());
				rowMap.put("prod_name", ipgoList.get(i).getProd_name());
				rowMap.put("prod_no", ipgoList.get(i).getProd_no());
				rowMap.put("prod_gyu", ipgoList.get(i).getProd_gyu());
				rowMap.put("prod_jai", ipgoList.get(i).getProd_jai());
				rowMap.put("tech_te", ipgoList.get(i).getTech_te());
				rowMap.put("prod_pg", ipgoList.get(i).getProd_pg());
				rowMap.put("prod_sg", ipgoList.get(i).getProd_sg());
				rowMap.put("prod_cd", ipgoList.get(i).getProd_cd());
				rowMap.put("prod_e1", ipgoList.get(i).getProd_e1());
				rowMap.put("prod_gubn", ipgoList.get(i).getProd_gubn());
				rowMap.put("prod_e3", ipgoList.get(i).getProd_e3());
				rowMap.put("prod_danw", ipgoList.get(i).getProd_danw());
				rowMap.put("prod_danj", ipgoList.get(i).getProd_danj());
				rowMap.put("prod_dang", ipgoList.get(i).getProd_dang());
				rowMap.put("prod_cno", ipgoList.get(i).getProd_cno());
				rowMap.put("prod_gd1", ipgoList.get(i).getProd_gd1());
				rowMap.put("prod_gd2", ipgoList.get(i).getProd_gd2());
				rowMap.put("prod_gd3", ipgoList.get(i).getProd_gd3());
				rowMap.put("ord_row", 1);
				rowMap.put("prod_boxsu", 1);
				rowMap.put("ord_su", 1);

				rtnList.add(rowMap);
			}

			rtnMap.put("last_page",1);
			rtnMap.put("data",rtnList);

			return rtnMap; 
		}

		//작업지시 - 등록
		@RequestMapping(value = "/product/ipgo/ipgoAdd", method = RequestMethod.POST) 
		@ResponseBody 
		public Map<String, Object> setIpgoAdd(@RequestBody String str){
			Map<String, Object> rtnMap = new HashMap<String, Object>();

			JSONParser jParser = new JSONParser();

			try {
				JSONObject workObj = (JSONObject)jParser.parse(str);

				String ordDate = workObj.get("ordDate").toString();
				int ordCode = Integer.parseInt(workObj.get("ordDate").toString().replace("-", ""));

				JSONArray workData = (JSONArray)workObj.get("ipgoData");

//				//System.out.println(workObj.toString());
				int result = 0;
				
				for(int i=0; i<workData.size(); i++) {

					JSONObject jObj = (JSONObject)workData.get(i);

					WorkJisi ipgo = new WorkJisi();

					
					float prodDanj = Float.parseFloat(jObj.get("prod_danj").toString());
					float prodDang = Float.parseFloat(jObj.get("prod_dang").toString());
					float su = Float.parseFloat(jObj.get("ord_su").toString());
					float amnt = prodDanj * su;
					float ord_mon = 0;
					if("KG".equals(jObj.get("prod_danw").toString())) {
						ord_mon = prodDang * amnt;
					}else if("EA".equals(jObj.get("prod_danw").toString()) ||
							"CH".equals(jObj.get("prod_danw").toString())) {
						amnt = prodDanj * su;
						if("".equals(jObj.get("prod_danj").toString())) {
							ord_mon = 0;
						}else {
							ord_mon = prodDang * su;
						}
					}
					
					ipgo.setOrd_code(ordCode);
					ipgo.setOrd_prn("0");
					ipgo.setOrd_input(ordDate);
					ipgo.setProd_code(Integer.parseInt(jObj.get("prod_code").toString()));
					ipgo.setOrd_date(ordDate);
					ipgo.setOrd_lot("");
					ipgo.setOrd_danw(jObj.get("prod_danw").toString());
					ipgo.setOrd_dang(prodDang);
					ipgo.setOrd_danj(prodDanj);
					ipgo.setOrd_su(Integer.parseInt(jObj.get("ord_su").toString()));
					ipgo.setOrd_amnt(amnt);
					ipgo.setOrd_mon(ord_mon);
					ipgo.setOrd_name("김성우");
					ipgo.setOrd_gyu("");
					ipgo.setOrd_sunip("선입1");
					ipgo.setOrd_boxsu(jObj.get("prod_boxsu").toString());
/*
					//System.out.println(ipgo.getOrd_code());
					//System.out.println(ipgo.getOrd_prn());
					//System.out.println(ipgo.getOrd_input());
					//System.out.println(ipgo.getProd_code());
					//System.out.println(ipgo.getOrd_date());
					//System.out.println(ipgo.getOrd_lot());
					//System.out.println(ipgo.getOrd_danw());
					//System.out.println(ipgo.getOrd_dang());
					//System.out.println(ipgo.getOrd_danj());
					//System.out.println(ipgo.getOrd_su());
					//System.out.println(ipgo.getOrd_amnt());
					//System.out.println(ipgo.getOrd_mon());
					//System.out.println(ipgo.getOrd_name());
					//System.out.println(ipgo.getOrd_gyu());
					//System.out.println(ipgo.getOrd_sunip());
					//System.out.println(ipgo.getOrd_boxsu());
*/
					
					Product product = workJisiService.getProductData(ipgo);
					
					ipgo.setProd_chisu1n(product.getProd_chisu1n());
					ipgo.setProd_chisu1s(product.getProd_chisu1s());
					ipgo.setProd_chisu2n(product.getProd_chisu2n());
					ipgo.setProd_chisu2s(product.getProd_chisu2s());
					ipgo.setProd_chisu3n(product.getProd_chisu3n());
					ipgo.setProd_chisu3s(product.getProd_chisu3s());
					ipgo.setProd_chisu4n(product.getProd_chisu4n());
					ipgo.setProd_chisu4s(product.getProd_chisu4s());
					ipgo.setProd_chisu5n(product.getProd_chisu5n());
					ipgo.setProd_chisu5s(product.getProd_chisu5s());
					
					result = workJisiService.setIpgoAdd(ipgo);
					
					if(result == 1) {
						workJisiService.setIpgoTest(ipgo);
					}
				}

			} catch (ParseException e) {
				e.printStackTrace();
			}

			rtnMap.put("data","succ");

			return rtnMap;
		}

	//입고관리 등록
	@RequestMapping(value = "/product/ipgo/ipgoListPrint", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> ipgoListPrint(
			@RequestParam(value="ord_code_array") int[] ordCodeArray,
			@RequestParam int ord_print_gb,
			HttpServletRequest request){
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		
		//ord_print_gb : [1] - 열처리수주서, [2] - 열후TAG, [3] - 입고현황표
		WorkJisi ipgo = new WorkJisi();
		List<Ipgo> ipgoList = null;

        String fileName = ""; //파일명
		
		String abPath = ""; //파일경로
		
		
		if(ordCodeArray.length > 0) {
			for(int ord_code : ordCodeArray) {
				ipgo.setOrd_code(ord_code);
//				System.out.println("ord_print_gb : "+ord_print_gb);
				
				if(ord_print_gb == 1) {
					ipgoList = workJisiService.ipgoListPrintBeforeHeat(ipgo);
					abPath = request.getServletContext().getRealPath("/WEB-INF/resources/reports/BeforeHeat.jrxml");
					fileName = "열처리수주서/"+ord_code;
				}else if(ord_print_gb == 2) {
					ipgoList = workJisiService.ipgoListPrintAfterHeat(ipgo);
					abPath = request.getServletContext().getRealPath("/WEB-INF/resources/reports/AfterHeat.jrxml");
					fileName = "열후TAG/"+ord_code;
				}else if(ord_print_gb == 3) {
					ipgoList = workJisiService.ipgoListPrintManager(ipgo);
					abPath = request.getServletContext().getRealPath("/WEB-INF/resources/reports/repIbgoManager.jrxml");
					fileName = "입고현황표/"+ord_code;
				}
				
				try {
					JRBeanCollectionDataSource dataSource = new JRBeanCollectionDataSource(ipgoList);
					
					JasperReportsContext jasperReportsContext = new SimpleJasperReportsContext();
					JasperCompileManager compileManager = JasperCompileManager.getInstance(jasperReportsContext);
					JasperReport report = JasperCompileManager.compileReport(abPath);
					
					Map<String, Object> reportMap = new HashMap<String, Object>();
					reportMap.put("ipgo_list", ipgoList);
					
					
					JasperFillManager fillManager = JasperFillManager.getInstance(jasperReportsContext);
					
					JasperPrint jasperPrint = JasperFillManager.fillReport(report, reportMap, dataSource);		
					
					JasperExportManager exportManager = JasperExportManager.getInstance(jasperReportsContext); 
					JasperExportManager.exportReportToPdfFile(jasperPrint,"D:/태경출력파일/"+fileName+".pdf");			
					rtnMap.put("heatData",fileName+".pdf");

				}catch(Exception e) {
					e.printStackTrace();
				}
				
				
			}
		}
		
		return rtnMap;
	}
	
	//입고리스트 데이터수정
    @RequestMapping(value= "/product/ipgo/getIpgoList/update", method=RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getIpgoListUpdate(
    		@RequestParam String cell_field,
    		@RequestParam String cell_value,
    		@RequestParam int cell_code){
    	Map<String, Object> rtnMap = new HashMap<String, Object>();
    	
    	WorkJisi w = new WorkJisi();
    	w.setCell_field(cell_field);
    	w.setCell_value(cell_value);
    	w.setCell_code(cell_code);
    	
    	workJisiService.getIpgoListUpdate(w);
    	
    	rtnMap.put("data","ok");
    		
    	return rtnMap;	
    }
	
	
	//2025-07-10 작업지시

	//작업지시 - 화면로드
	@RequestMapping(value = "/production/workInstruction", method = RequestMethod.GET)
	public String workInstruction() {
		return "/production/workInstruction.jsp";
	}	 
    
	//작업지시 전체화면 조회
	@RequestMapping(value = "/production/workjisi/allList", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> workJisiAllList(
			@RequestParam String jisi_sdate,
			@RequestParam String jisi_edate){			
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		
		WorkJisi w = new WorkJisi();
		w.setJisi_sdate(jisi_sdate);
		w.setJisi_edate(jisi_edate);
		
		List<WorkJisi> list = workJisiService.workJisiAllList(w);
		
		List<WorkJisi> rtnList = new ArrayList<WorkJisi>();
		
		for(WorkJisi wj : list) {
			File file = new File("D:/태경출력파일/작업지시서/"+wj.getJisi_lot_view()+".pdf");
			File file2 = new File("D:/태경출력파일/공정이동표/"+wj.getOrd_code()+".pdf");
			
			if(file.exists()) {
				wj.setJisi_h_file_yn(1);
			}else {
				wj.setJisi_h_file_yn(0);
			}
			
			if(file2.exists()) {
				wj.setJisi_j_file_yn(1);
			}else {
				wj.setJisi_j_file_yn(0);
			}
			
			rtnList.add(wj);
		}
		
		rtnMap.put("data",rtnList);
		
		
		return rtnMap;	
	}
	
	//단취등록시 입고데이터로 표현
	@RequestMapping(value = "/production/workjisi/ready/ipgoList", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> workJisiReadyIpgoList(
			@RequestParam String jisi_j_sdate,
			@RequestParam String jisi_j_edate){
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		
		WorkJisi w = new WorkJisi();
		w.setJisi_j_sdate(jisi_j_sdate);
		w.setJisi_j_edate(jisi_j_edate);
		
		List<WorkJisi> list = workJisiService.workJisiReadyIpgoList(w);
		
		rtnMap.put("data",list);
		
		
		return rtnMap;
	}
	
	//준비작업 등록
	@RequestMapping(value = "/production/workInstruction/workJisiJSave", method = RequestMethod.POST) 
	@ResponseBody 
	public Map<String, Object> setWorkJisiJSave(
			@ModelAttribute WorkJisi workJisi,
			HttpServletRequest request) {
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		UtilClass util = new UtilClass();
		
		workJisi.setJisi_user_code(util.getSessionUser(request).getUser_code());
		workJisiService.setWorkJisiJSave(workJisi);

		rtnMap.put("data",workJisi);
		
		
		return rtnMap; 
	}		
	
	//열처리등록시 작업지시데이터로 표현
	@RequestMapping(value = "/production/workjisi/heat/jisiList", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> workJisiHeatJisiList(
			@RequestParam(value="ord_code_array") int[] ord_code_array){
		Map<String, Object> rtnMap = new HashMap<String, Object>();
			
		WorkJisi w = new WorkJisi();
		w.setOrd_code_array(ord_code_array);
		
		List<WorkJisi> list = workJisiService.workJisiHeatJisiList(w);
		
		rtnMap.put("data",list);
		
		
		return rtnMap;
	}
	
	//열처리등록전 작업대기 리스트 조회
	@RequestMapping(value = "/production/workInstruction/heat/ipgoList", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> workJisiHeatIpgoList(
			@RequestParam String ord_sdate,
			@RequestParam String ord_edate){
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		
		WorkJisi w = new WorkJisi();
		w.setSdate(ord_sdate);
		w.setEdate(ord_edate);
		
		List<WorkJisi> list = workJisiService.workJisiHeatIpgoList(w);
		
		rtnMap.put("data",list);
		
		
		return rtnMap;
	}
	
	//열처리등록전 작업대기 리스트 조회 선택한 항목 적용
	@RequestMapping(value = "/production/workInstruction/heat/ipgoListReg", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> workJisiHeatIpgoListReg(
			@RequestParam(required = false) String workJisi,
			@RequestParam String ord_sdate,
			@RequestParam String ord_edate,
			@RequestParam int s_ord_sunip_check,
			@RequestParam String s_ord_sunip_pw,
			HttpServletRequest request){
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		
		JSONParser parser = new JSONParser();
		Object obj = null;
		try {
			obj = parser.parse(workJisi);
		} catch (ParseException e) {
			e.printStackTrace();
		}

		JSONObject jsonObj = (JSONObject)obj;
		
		
		WorkJisi w = new WorkJisi();
		w.setOrd_input(jsonObj.get("ord_input").toString());
		w.setSdate(ord_sdate);
		w.setEdate(ord_edate);
		w.setProd_code(Integer.parseInt(jsonObj.get("prod_code").toString()));
		w.setJisi_j_su(Integer.parseInt(jsonObj.get("jisi_j_su").toString()));
		w.setOrd_code(Integer.parseInt(jsonObj.get("ord_code").toString()));
		
		
		
		//선입제품이 있는지 체크
		if(s_ord_sunip_check == 0) {
			List<WorkJisi> sunipWork = workJisiService.getWorkJisiHeatIpgoListRegSunip(w);
			
			if(sunipWork.size() > 0) {
				rtnMap.put("alert","선입된 제품이 있습니다. 다시 확인하십시오!");
				return rtnMap;
			}
		}else {
			//선입제품 체크되어도 비밀번호가 3183일때만
			
			if(!"3183".equals(s_ord_sunip_pw)) {
				rtnMap.put("alert","선입선출제외 비밀번호를 확인해주십시오!");
				return rtnMap;				
			}
		}
		
		
		
		//선입제품이 없다면 총 단취수량의 합까지 모든 리스트 조회
		List<WorkJisi> ipgoList = workJisiService.getWorkJisiHeatIpgoListRegList(w);
		int jisi_diff_su = 0;
		int jisi_j_su = Integer.parseInt(jsonObj.get("jisi_j_su").toString());
		int jisi_h_calc_su = 0;
		float jisi_h_calc_jung = 0;
		
		List<WorkJisi> rtnList = new ArrayList<WorkJisi>();
		
		for(WorkJisi wj : ipgoList) {
			int temp = 0;
			
			if(jisi_j_su != jisi_diff_su) {
				if(wj.getJisi_diff_su() <= (jisi_j_su-jisi_diff_su)) {
					temp = wj.getJisi_diff_su();
					
					jisi_diff_su += wj.getJisi_diff_su();
				}else {
					temp = jisi_j_su - jisi_diff_su;
					
					jisi_diff_su += temp;
				}
				
				jisi_h_calc_su += temp;
				jisi_h_calc_jung += (temp * wj.getOrd_danj());
				
				wj.setJisi_h_su(temp);
				wj.setJisi_h_calc_su(jisi_h_calc_su);
				wj.setJisi_h_calc_jung(Math.round(jisi_h_calc_jung * 100)/100f);

				rtnList.add(wj);
			}
		}
/*		
		List<WorkJisi> list = workJisiService.workJisiHeatIpgoList(w);
		
		rtnMap.put("data",list);
*/		
		rtnMap.put("data",rtnList);
		return rtnMap;
	}
	
	//열처리작업 등록시 바코드스캔하면 스캔한 수주번호의 데이터 리턴	
	///production/workInstruction/heat/ipgoBarcodeScan
	@RequestMapping(value = "/production/workInstruction/heat/ipgoBarcodeScan", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> setWorkipgoBarcodeScan(
			@RequestParam int ord_code){
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		
		WorkJisi w = new WorkJisi();
		w.setJisi_h_ord_code(ord_code);
		
		WorkJisi wj = workJisiService.setWorkipgoBarcodeScan(w);
		
		rtnMap.put("data",wj);
		
		return rtnMap;
	}

	
	//열처리작업 등록
	@RequestMapping(value = "/production/workInstruction/workJisiHSave", method = RequestMethod.POST) 
	@ResponseBody 
	public Map<String, Object> setWorkJisiHSave(
			@RequestParam(required = false) String jsonData,
			HttpServletRequest request) {
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		UtilClass util = new UtilClass();
		
		JSONParser parser = new JSONParser();
		Object obj = null;
		try {
			obj = parser.parse(jsonData);
		} catch (ParseException e) {
			e.printStackTrace();
		}

		JSONObject jsonObj = (JSONObject)obj;
		
		JSONArray hDataArray = (JSONArray)jsonObj.get("hDataList");
		JSONObject hDataObj = (JSONObject)jsonObj.get("hDataForm");
		
		if(hDataArray.size() > 0) {
	
			//작업지시 LOT 생성
			WorkJisi ww = new WorkJisi();
			String setHogi = hDataObj.get("jisi_h_fac_code").toString();
			
			if("18".equals(setHogi)) {
				setHogi = "5";	
			}
		
			//JSONArray데이터 WorkJisi 리스트에 담기
			int ordCodeArray[] = new int[hDataArray.size()];
			
			for(int i=0; i<hDataArray.size(); i++) {
				JSONObject objs = (JSONObject)hDataArray.get(i);
				ordCodeArray[i] = Integer.parseInt(objs.get("ord_code").toString());
			}
			
			//침탄로 호기
			ww.setJisi_h_hogi(setHogi);
			//리스트의 데이터 보내서 제품코드별로 카운트 리턴
			ww.setOrd_code_array(ordCodeArray);
			
			ww.setJisi_h_count(hDataArray.size());
			
			String jisi_lot = workJisiService.getWorkJisiLot(ww);
			
			String ilbo_lot = "";
			
			if(jisi_lot.substring(8).equals("1")) {
				ilbo_lot = jisi_lot.substring(0,8)+"A";
			}else if(jisi_lot.substring(8).equals("2")) {
				ilbo_lot = jisi_lot.substring(0,8)+"B";
			}else {
				ilbo_lot = jisi_lot;
			}
			
//			System.out.println("jisi_lot : "+jisi_lot+"// ilbo_lot : "+ilbo_lot);
			
			int j_ilbo_code = workJisiService.getWorkJisiIlboCode(ww);
			Users loginUser = util.getSessionUser(request);

			//준비작업 저장(일보코드는 각각 불러올 것) 여러행이여도 같은 지시로트,일보코드
			for(int i=0; i<hDataArray.size(); i++) {
	//			System.out.println(hDataArray.get(i).toString());
				//행의 수에 따라서 LOT번호 부여방식 다름.
				
				JSONObject hDataRow = (JSONObject)hDataArray.get(i);
				WorkJisi hWork = new WorkJisi();
				
				hWork.setIlbo_code(j_ilbo_code);
				hWork.setIlbo_no(i);
				hWork.setOrd_code(Integer.parseInt(hDataRow.get("ord_code").toString()));
				
				hWork.setIlbo_gubn("J");
				
				hWork.setIlbo_lot(ilbo_lot);
				hWork.setIlbo_su(Float.parseFloat(hDataRow.get("jisi_h_su").toString()));
				hWork.setIlbo_jung(
						Float.parseFloat(hDataRow.get("jisi_h_su").toString()) * 
						Float.parseFloat(hDataRow.get("ord_danj").toString())
					);
				
//				hWork.setFac_code(Integer.parseInt(hDataObj.get("jisi_h_fac_code").toString()));
				hWork.setUser_code(loginUser.getUser_code());
				hWork.setIlbo_g11("0");
				
				workJisiService.setWorkJisiJSave(hWork);
			}

			int h_ilbo_code = workJisiService.getWorkJisiIlboCode(ww);
			
			//열처리작업 저장(일보코드는 각각 불러올 것) 여러행이여도 같은 지시로트,일보코드
			for(int i=0; i<hDataArray.size(); i++) {
	//			System.out.println(hDataArray.get(i).toString());
				//행의 수에 따라서 LOT번호 부여방식 다름.
				
				JSONObject hDataRow = (JSONObject)hDataArray.get(i);
				WorkJisi hWork = new WorkJisi();
				
				
				hWork.setIlbo_code(h_ilbo_code);
				hWork.setIlbo_no(i);
				hWork.setOrd_code(Integer.parseInt(hDataRow.get("ord_code").toString()));
				
				hWork.setIlbo_gubn("A");
				
				hWork.setIlbo_lot(ilbo_lot);
				hWork.setIlbo_su(Float.parseFloat(hDataRow.get("jisi_h_su").toString()));
				hWork.setIlbo_jung(
						Float.parseFloat(hDataRow.get("jisi_h_su").toString()) * 
						Float.parseFloat(hDataRow.get("ord_danj").toString())
					);				
				hWork.setFac_code(Integer.parseInt(hDataObj.get("jisi_h_fac_code").toString()));				
				hWork.setJisi_h_hogi(hDataObj.get("jisi_h_fac_code").toString());
				hWork.setJisi_t_hogi(hDataObj.get("jisi_t_fac_code").toString());

				hWork.setUser_code(loginUser.getUser_code());
				hWork.setJisi_user_code(util.getSessionUser(request).getUser_code());				
				
				hWork.setIlbo_pc(j_ilbo_code);
				hWork.setIlbo_pn(i);
				
				hWork.setJisi_h_pre_temp(hDataObj.get("jisi_h_pre_temp").toString());
				hWork.setJisi_h_chim_temp(hDataObj.get("jisi_h_chim_temp").toString());
				hWork.setJisi_h_diff_temp(hDataObj.get("jisi_h_diff_temp").toString());
				hWork.setJisi_h_gang_temp(hDataObj.get("jisi_h_gang_temp").toString());
				hWork.setJisi_h_crack_temp(hDataObj.get("jisi_h_crack_temp").toString());
				hWork.setJisi_h_cold_temp(hDataObj.get("jisi_h_cold_temp").toString());
				
				hWork.setJisi_h_pre_time(hDataObj.get("jisi_h_pre_time").toString());
				hWork.setJisi_h_chim_time(hDataObj.get("jisi_h_chim_time").toString());
				hWork.setJisi_h_diff_time(hDataObj.get("jisi_h_diff_time").toString());
				hWork.setJisi_h_gang_time(hDataObj.get("jisi_h_gang_time").toString());
				hWork.setJisi_h_crack_time(hDataObj.get("jisi_h_crack_time").toString());
				
				
				hWork.setJisi_h_chim_cp(hDataObj.get("jisi_h_chim_cp").toString());
				hWork.setJisi_h_diff_cp(hDataObj.get("jisi_h_diff_cp").toString());
				hWork.setJisi_h_gang_cp(hDataObj.get("jisi_h_gang_cp").toString());

				hWork.setJisi_h_pre_h2(hDataObj.get("jisi_h_pre_h2").toString());
				hWork.setJisi_h_chim_h2(hDataObj.get("jisi_h_chim_h2").toString());
				hWork.setJisi_h_diff_h2(hDataObj.get("jisi_h_diff_h2").toString());
				hWork.setJisi_h_gang_h2(hDataObj.get("jisi_h_gang_h2").toString());
				
				hWork.setJisi_h_pre_nh3(hDataObj.get("jisi_h_pre_nh3").toString());
				hWork.setJisi_h_chim_nh3(hDataObj.get("jisi_h_chim_nh3").toString());
				hWork.setJisi_h_diff_nh3(hDataObj.get("jisi_h_diff_nh3").toString());
				hWork.setJisi_h_gang_nh3(hDataObj.get("jisi_h_gang_nh3").toString());
				
				
				hWork.setJisi_t_temp(hDataObj.get("jisi_t_temp").toString());
				hWork.setJisi_t_time(hDataObj.get("jisi_t_time").toString());

				
				hWork.setJisi_h_rx(hDataObj.get("jisi_h_rx").toString());
				hWork.setJisi_h_lpg(hDataObj.get("jisi_h_lpg").toString());
				hWork.setJisi_h_agi(hDataObj.get("jisi_h_agi").toString());
				
				hWork.setJisi_h_code(Integer.parseInt(hDataRow.get("jisi_h_code").toString()));
				hWork.setJisi_j_code_ref(Integer.parseInt(hDataRow.get("jisi_j_code").toString()));
				hWork.setJisi_j_code(Integer.parseInt(hDataRow.get("jisi_j_code").toString()));
				hWork.setJisi_h_su(Integer.parseInt(hDataRow.get("jisi_h_su").toString()));
				hWork.setJisi_h_jung(Float.parseFloat(hDataRow.get("jisi_h_jung").toString()));
				hWork.setJisi_t_su(Integer.parseInt(hDataRow.get("jisi_h_su").toString()));
				hWork.setJisi_t_jung(Float.parseFloat(hDataRow.get("jisi_h_jung").toString()));
				
				hWork.setJisi_ord_code(Integer.parseInt(hDataRow.get("ord_code").toString()));
				hWork.setJisi_lot(jisi_lot);
				
				workJisiService.setWorkJisiHSave(hWork);
			}

			rtnMap.put("data1",hDataArray);
			rtnMap.put("data2",hDataObj);
		}	
		
		return rtnMap; 
	}		

	//작업지시 - 공정이동식별표 출력
	
	//작업지시 - 작업지시서 출력
	@RequestMapping(value = "/production/workjisi/heat/workHeatListPrint", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> workHeatListPrint(
			@RequestParam(value="jisi_lot_array") String[] jisiLotArray,
			HttpServletRequest request){
		Map<String, Object> rtnMap = new HashMap<String, Object>();
	
		Set<String> lotSet = new HashSet<String>();
		
		if(jisiLotArray != null) {
			for(String s : jisiLotArray) {
				lotSet.add(s);	
			}			
		}
		
		Iterator<String> setList = lotSet.iterator();
		
		while(setList.hasNext()) {
//			System.out.println(setList.next());
			WorkJisi w = new WorkJisi();
			w.setJisi_lot(setList.next());
			
			//선택한 작업번호에 대한 상세정보
			List<WorkJisi> lotList = workJisiService.workHeatListPrint(w);
			int jisi_h_su_sum = 0;
			float jisi_h_jung_sum = 0;
			
			WorkJisi reportWorkJisi = null;
			for(WorkJisi wj : lotList) {
				reportWorkJisi = wj;
				jisi_h_su_sum += wj.getJisi_h_su();
				jisi_h_jung_sum += wj.getJisi_h_jung();
			}
			
			//JasperReports 연동
	        String fileName = reportWorkJisi.getJisi_lot_view(); // 최종 파일 이름
			
			String abPath = request.getServletContext().getRealPath("/WEB-INF/resources/reports/workheat.jrxml");
			
			try {
				JRBeanCollectionDataSource dataSource = new JRBeanCollectionDataSource(lotList);
				
				JasperReportsContext jasperReportsContext = new SimpleJasperReportsContext();
				JasperCompileManager compileManager = JasperCompileManager.getInstance(jasperReportsContext);
				JasperReport report = JasperCompileManager.compileReport(abPath);
				
				
				
				
				Map<String, Object> reportMap = new HashMap<String, Object>();
				reportMap.put("jisi_list", lotList);
				reportMap.put("jisi_lot_view", reportWorkJisi.getJisi_lot_view());
				reportMap.put("jisi_lot", reportWorkJisi.getJisi_lot());
				reportMap.put("fac_name", reportWorkJisi.getFac_name());
				reportMap.put("jisi_h_pre_temp", reportWorkJisi.getJisi_h_pre_temp());
				reportMap.put("jisi_h_chim_temp", reportWorkJisi.getJisi_h_chim_temp());
				reportMap.put("jisi_h_diff_temp", reportWorkJisi.getJisi_h_diff_temp());
				reportMap.put("jisi_h_gang_temp", reportWorkJisi.getJisi_h_gang_temp());
				reportMap.put("jisi_h_pre_time", reportWorkJisi.getJisi_h_pre_time());
				reportMap.put("jisi_h_chim_time", reportWorkJisi.getJisi_h_chim_time());
				reportMap.put("jisi_h_diff_time", reportWorkJisi.getJisi_h_diff_time());
				reportMap.put("jisi_h_gang_time", reportWorkJisi.getJisi_h_gang_time());
				reportMap.put("jisi_h_chim_cp", reportWorkJisi.getJisi_h_chim_cp());
				reportMap.put("jisi_h_diff_cp", reportWorkJisi.getJisi_h_diff_cp());
				reportMap.put("jisi_h_gang_cp", reportWorkJisi.getJisi_h_gang_cp());
				reportMap.put("jisi_h_cold_temp", reportWorkJisi.getJisi_h_cold_temp());
				reportMap.put("jisi_h_cold_time", reportWorkJisi.getJisi_h_cold_time());
				reportMap.put("jisi_t_temp", reportWorkJisi.getJisi_t_temp());
				reportMap.put("jisi_t_time", reportWorkJisi.getJisi_t_time());
				reportMap.put("user_name", reportWorkJisi.getUser_name());
				reportMap.put("jisi_h_regtime", reportWorkJisi.getJisi_h_regtime());
				reportMap.put("jisi_h_su_sum", jisi_h_su_sum);
				reportMap.put("jisi_h_jung_sum", jisi_h_jung_sum);
				
				
				JasperFillManager fillManager = JasperFillManager.getInstance(jasperReportsContext);
				
				JasperPrint jasperPrint = JasperFillManager.fillReport(report, reportMap, dataSource);		
				
				JasperExportManager exportManager = JasperExportManager.getInstance(jasperReportsContext); 
				JasperExportManager.exportReportToPdfFile(jasperPrint,"D:/태경출력파일/작업지시서/"+fileName+".pdf");			
				rtnMap.put("heatData",fileName+".pdf");

			}catch(Exception e) {
				e.printStackTrace();
			}
			
			//공정이동표 출력
			List<WorkJisi> ordList = workJisiService.workHeatListProcessPrint(w);
	        
			
			String abPath2 = request.getServletContext().getRealPath("/WEB-INF/resources/reports/workprocess.jrxml");
			
			try {
				
				for(WorkJisi wjList : ordList) {
					
					String fileName2 = wjList.getOrd_code()+""; // 최종 파일 이름
					
					Map<String, Object> reportMap = new HashMap<String, Object>();
					reportMap.put("ord_code", wjList.getOrd_code());
					reportMap.put("jisi_h_code", wjList.getJisi_h_code());
					reportMap.put("corp_name", wjList.getCorp_name());
					reportMap.put("prod_no", wjList.getProd_no());
					reportMap.put("prod_name", wjList.getProd_name());
					reportMap.put("prod_gyu", wjList.getProd_gyu());
					reportMap.put("prod_jai", wjList.getProd_jai());
					reportMap.put("tech_te", wjList.getTech_te());
					reportMap.put("ord_lot", wjList.getOrd_lot());
					reportMap.put("ord_gyu", wjList.getOrd_gyu());
					reportMap.put("ord_su", wjList.getOrd_su());
					reportMap.put("prod_danj", wjList.getProd_danj());
					reportMap.put("ord_amnt", wjList.getOrd_amnt());
					reportMap.put("cost_ea", wjList.getCost_ea());
					reportMap.put("cost_kg", wjList.getCost_kg());
					reportMap.put("ord_mon", wjList.getOrd_mon());
					reportMap.put("prod_upjong", wjList.getProd_upjong());
					reportMap.put("jisi_h_su", wjList.getJisi_h_su());
					reportMap.put("jisi_h_jung", wjList.getJisi_h_jung());
					reportMap.put("jisi_h_cost", wjList.getJisi_h_cost());
					reportMap.put("prod_gd", wjList.getProd_gd());
					reportMap.put("prod_cd", wjList.getProd_cd());
					reportMap.put("prod_pg", wjList.getProd_pg());
					reportMap.put("prod_polish", wjList.getProd_polish());
					reportMap.put("prod_sg", wjList.getProd_sg());
					reportMap.put("prod_e1", wjList.getProd_e1());
					reportMap.put("prod_vnyl", wjList.getProd_vnyl());
					reportMap.put("prod_plt", wjList.getProd_plt());
					reportMap.put("prod_pad", wjList.getProd_pad());
					reportMap.put("prod_danch", wjList.getProd_danch());
					reportMap.put("prod_bangch", wjList.getProd_bangch());
					reportMap.put("ord_bigo", wjList.getOrd_bigo());
					reportMap.put("prod_note", wjList.getProd_note());
					reportMap.put("ord_name", wjList.getOrd_name());
					reportMap.put("prod_img", "http://127.0.0.1:8082/tkPrint/"+wjList.getProd_img());
					reportMap.put("jisi_h_bigo", wjList.getJisi_h_bigo());
					reportMap.put("fac1", wjList.getFac1());
					reportMap.put("fac2", wjList.getFac2());
					reportMap.put("fac3", wjList.getFac3());
					reportMap.put("fac4", wjList.getFac4());
					reportMap.put("fac5", wjList.getFac5());
					reportMap.put("fac6", wjList.getFac6());
					reportMap.put("fac7", wjList.getFac7());
					reportMap.put("user_name", wjList.getUser_name());				
					reportMap.put("jisi_lot", wjList.getJisi_lot());
					
					JRBeanCollectionDataSource dataSource = new JRBeanCollectionDataSource(ordList);
					
					JasperReportsContext jasperReportsContext = new SimpleJasperReportsContext();
					JasperCompileManager compileManager = JasperCompileManager.getInstance(jasperReportsContext);
					JasperReport report = JasperCompileManager.compileReport(abPath2);
					
					
					JasperFillManager fillManager = JasperFillManager.getInstance(jasperReportsContext);
					
					JasperPrint jasperPrint = JasperFillManager.fillReport(report, reportMap, dataSource);		
					
					JasperExportManager exportManager = JasperExportManager.getInstance(jasperReportsContext); 
					JasperExportManager.exportReportToPdfFile(jasperPrint,"D:/태경출력파일/공정이동표/"+fileName2+".pdf");			
					rtnMap.put("heatData",fileName+".pdf");
				}
			}catch(Exception e) {
				e.printStackTrace();
			}
			
		}
		return rtnMap;
	}
	
	//
	@RequestMapping(value="/production/workjisi/allList/detail", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getProductionAllListDetail(
			@RequestParam int jisi_j_code,
			@RequestParam int jisi_h_code){
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		
		WorkJisi w = new WorkJisi();
		w.setJisi_j_code(jisi_j_code);
		w.setJisi_h_code(jisi_h_code);
		
		WorkJisi danch = workJisiService.getProductionAllListDetailDanch(w);
		WorkJisi heat = workJisiService.getProductionAllListDetailHeat(w);
		
		rtnMap.put("danch",danch);
		rtnMap.put("heat",heat);
		
		return rtnMap;
	}
	
}
