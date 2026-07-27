package com.tkheat.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.apache.pdfbox.io.MemoryUsageSetting;
import org.apache.pdfbox.multipdf.PDFMergerUtility;
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

	public String ifNullStringReturn(Object obj) {
		
		String rtnValue = "";
		
		if(obj != null) {
			rtnValue = obj.toString();
		}
		
		return rtnValue;
	}

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
			@ModelAttribute WorkJisi w) {
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		
		List<WorkJisi> ipgoList = workJisiService.getIpgoList(w);
		List<WorkJisi> ipgoTechList = workJisiService.getIpgoTechList(w);

		for(int i=0; i<ipgoList.size(); i++) {
			ipgoList.get(i).setIdx(i+1);
		}

		rtnMap.put("data",ipgoList);
		rtnMap.put("techin",ipgoTechList);

		return rtnMap; 
	}
	
	//입고관리 - 입고등록리스트
		@RequestMapping(value = "/product/ipgo/getIpgoAddList", method = RequestMethod.POST) 
		@ResponseBody 
		public Map<String, Object> getIpgoAddList(@ModelAttribute WorkJisi w) {
			Map<String, Object> rtnMap = new HashMap<String, Object>();

			
			List<WorkJisi> ipgoList = workJisiService.getIpgoAddList(w);

			rtnMap.put("data",ipgoList);

			return rtnMap; 
		}

		//입고관리 - 등록
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
					int ordRow = Integer.parseInt(jObj.get("ord_row").toString());
					for(int j=0; j<ordRow; j++) {
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
				}

			} catch (ParseException e) {
				e.printStackTrace();
			}

			rtnMap.put("data","succ");

			return rtnMap;
		}

	//입고관리 출력
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
	        String printFileName = "";
	        String fileNameGb = ""; //열처리수주서, 열후TAG, 입고현황표 구분
			
			String abPath = ""; //파일경로
			
			switch(ord_print_gb) {
				case 1: fileNameGb = "열처리수주서/"; break;
				case 2: fileNameGb = "열후TAG/"; break;
				case 3: fileNameGb = "입고현황표/"; break;
			}
			
			String mergePath = "D:/태경출력파일/"+fileNameGb;
			String mergePathFileName = "";
			
			//PDF파일병합 추가
			PDFMergerUtility merge = new PDFMergerUtility();
			
			
			
			if(ordCodeArray.length > 0) {
//				for(int ord_code : ordCodeArray) {
//					ipgo.setOrd_code(ord_code);
					ipgo.setOrd_code_array(ordCodeArray);
//					System.out.println("ord_print_gb : "+ord_print_gb);
					
					if(ord_print_gb == 1) {
						ipgoList = workJisiService.ipgoListPrintBeforeHeat(ipgo);
						abPath = request.getServletContext().getRealPath("/WEB-INF/resources/reports/BeforeHeat.jrxml");
						fileName = fileNameGb+ordCodeArray[0]+"_"+ordCodeArray.length;
					}else if(ord_print_gb == 2) {
						ipgoList = workJisiService.ipgoListPrintAfterHeat(ipgo);
						abPath = request.getServletContext().getRealPath("/WEB-INF/resources/reports/AfterHeat.jrxml");
						fileName = fileNameGb+ordCodeArray[0]+"_"+ordCodeArray.length;
					}else if(ord_print_gb == 3) {
						ipgoList = workJisiService.ipgoListPrintManager(ipgo);
						abPath = request.getServletContext().getRealPath("/WEB-INF/resources/reports/repIbgoManager.jrxml");
						fileName = fileNameGb+ordCodeArray[0]+"_"+ordCodeArray.length;
					}
					
					printFileName = ordCodeArray[0]+"_"+ordCodeArray.length;
//					mergePathFileName = ord_code+"_"+ordCodeArray.length;
					
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
						

//						merge.addSource("D:/태경출력파일/"+fileName+".pdf");
						
					}catch(Exception e) {
						e.printStackTrace();
					}
					rtnMap.put("heatData",printFileName+".pdf");
					
//				}
	/*				
				merge.setDestinationFileName(mergePath+mergePathFileName+".pdf");
				try {
					merge.mergeDocuments(MemoryUsageSetting.setupTempFileOnly());
					
				} catch (IOException e) {
					e.printStackTrace();
				}
	*/
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
	
	//입고관리 삭제
	@RequestMapping(value = "/product/ipgo/ipgoListDelete", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> ipgoListDelete(
			@RequestParam(value="ord_code_array") int[] ordCodeArray,
			HttpServletRequest request){
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		
		UtilClass util = new UtilClass();
		
		Users users = util.getSessionUser(request);
		
		if(ordCodeArray.length > 0) {
			for(int ord_code : ordCodeArray) {
				WorkJisi w = new WorkJisi();
				w.setOrd_code(ord_code);
				w.setUser_name(users.getUser_name());
				
				workJisiService.ipgoListDelete(w);
			}
		}
		
		rtnMap.put("data",ordCodeArray);
		
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
			File file2 = new File("D:/태경출력파일/공정이동표/"+wj.getJisi_lot_view()+".pdf");
			
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
			@RequestParam int jisi_h_calc_su_param,
			@RequestParam(value="ipgo_ord_code_array") int[] ord_code_array,
			@RequestParam(value="selectOrdCodeArray") int[] selectOrdCodeArray,
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
		w.setJisi_h_calc_su(jisi_h_calc_su_param);
		w.setOrd_code_array(ord_code_array);
		w.setSelectOrdCodeArray(selectOrdCodeArray);
		
		//선입제품이 있는지 체크
		if(s_ord_sunip_check == 0) {
			List<WorkJisi> sunipWork = workJisiService.getWorkJisiHeatIpgoListRegSunip(w);
			
			if(sunipWork.size() > 0) {
				rtnMap.put("alert","선입제품이 있습니다. 다시 확인하십시오!");
				rtnMap.put("alertData",sunipWork);
				return rtnMap;
			}
		}else {
			//선입제품 체크되어도 비밀번호가 3183일때만
			
			if(!"3183".equals(s_ord_sunip_pw)) {
				rtnMap.put("alert","선입선출제외 비밀번호를 확인해주십시오!");
				return rtnMap;				
			}
		}
		
		//배열로 가지고 있는 수주번호로 품번이 동일한지 아닌지 구분
		List<WorkJisi> prodCodeList = workJisiService.getWorkJisiHeatProdCodeList(w);
		//동일할경우 작업표준의 '총 작업수량'의 값보다 크면 안됨
		
		
		List<WorkJisi> ipgoList = workJisiService.getWorkJisiHeatIpgoListRegList(w);
		System.out.println("선택한 제품의 품번 수 : "+prodCodeList.size());
		int jisi_diff_su = 0;
		//작업표준의 총 작업수량
		int jisi_j_su = Integer.parseInt(jsonObj.get("jisi_j_su").toString());
		
		//화면에 리턴할 리스트
		List<WorkJisi> rtnList = new ArrayList<WorkJisi>();
		
		if(prodCodeList != null) {
			//작업지시 등록할 제품의 품번이 동일할 때
			if(prodCodeList.size() <= 1) {
				//선입제품이 없다면 총 단취수량의 합까지 모든 리스트 조회
				
				for(WorkJisi wj : ipgoList) {
					int temp = 0;
	
					jisi_diff_su = wj.getJisi_diff_su(); //행의 잔량
					if(jisi_j_su != jisi_h_calc_su_param) {
						if(jisi_h_calc_su_param == 0) {
								//침탄표준의 적재수량이 더 클 때
							if(jisi_j_su > jisi_diff_su) {
								temp = jisi_diff_su;					
							}else{
								//침탄표준의 적재수량이 더 작거나 같을 때
								temp = jisi_j_su;
							}
						}else {
								//400, 200 > 50
							if(jisi_j_su > (jisi_h_calc_su_param + jisi_diff_su)) {
								temp = jisi_diff_su;
							}else{
								//400, 200 < 210
								temp = jisi_j_su - jisi_h_calc_su_param;
							}
							
						}
						
						wj.setJisi_h_su(temp);
			
						rtnList.add(wj);
					}else {
						rtnMap.put("alert","총 작업수량을 초과할 수 없습니다!");
						return rtnMap;				
					}
	
				}
			}else {
				for(WorkJisi wj : ipgoList) {
					int temp = 0;

					temp += jisi_h_calc_su_param;
					
					wj.setJisi_h_su(temp);
		
					rtnList.add(wj);
					
				}
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
				ilbo_lot = "TK"+jisi_lot.substring(0,6)+"-"+jisi_lot.substring(6,8)+"A";
			}else if(jisi_lot.substring(8).equals("2")) {
				ilbo_lot = "TK"+jisi_lot.substring(0,6)+"-"+jisi_lot.substring(6,8)+"B";
			}else {
				ilbo_lot = "TK"+jisi_lot.substring(0,6)+"-"+jisi_lot.substring(6,8)+"0";;
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
	@RequestMapping(value = "/production/workjisi/heat/workHeatListProcPrint", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> workHeatListProcPrint(
			@RequestParam(value="jisi_lot_array") String[] jisiLotArray,
			HttpServletRequest request){
		Map<String, Object> rtnMap = new HashMap<String, Object>();
	
		Set<String> lotSet = new HashSet<String>();
		
		if(jisiLotArray != null) {
			for(String s : jisiLotArray) {
				lotSet.add(s);	
			}			
		}
		
		
		String mergePathProc = "D:/태경출력파일/공정이동표/";
		String fileName = "";
		
		//PDF파일병합 추가
		PDFMergerUtility mergeProc = new PDFMergerUtility();
		
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
	        fileName = reportWorkJisi.getJisi_lot_view()+"_"+jisiLotArray.length; // 최종 파일 이름
			
			//공정이동표 출력
			List<WorkJisi> ordList = workJisiService.workHeatListProcessPrint(w);
	        
			
			String abPath2 = request.getServletContext().getRealPath("/WEB-INF/resources/reports/workprocess.jrxml");
			
			try {
				
					
				
				Map<String, Object> reportMap = new HashMap<String, Object>();
	            reportMap.put("ord_list", ordList);
	               
	            reportMap.put("jisi_lot", reportWorkJisi.getJisi_lot());					
				JRBeanCollectionDataSource dataSource = new JRBeanCollectionDataSource(ordList);
				
				JasperReportsContext jasperReportsContext = new SimpleJasperReportsContext();
				JasperCompileManager compileManager = JasperCompileManager.getInstance(jasperReportsContext);
				JasperReport report = JasperCompileManager.compileReport(abPath2);
				
				
				JasperFillManager fillManager = JasperFillManager.getInstance(jasperReportsContext);
				
				JasperPrint jasperPrint = JasperFillManager.fillReport(report, reportMap, dataSource);		
				
				JasperExportManager exportManager = JasperExportManager.getInstance(jasperReportsContext); 
				JasperExportManager.exportReportToPdfFile(jasperPrint,"D:/태경출력파일/공정이동표/"+fileName+".pdf");			
				rtnMap.put("heatData",fileName+".pdf");
				
				mergeProc.addSource("D:/태경출력파일/공정이동표/"+fileName+".pdf");
			}catch(Exception e) {
				e.printStackTrace();
			}
			
		}
		
		mergeProc.setDestinationFileName(mergePathProc+fileName+".pdf");
		return rtnMap;
	}
	
	//작업지시 - 작업지시서 출력
	@RequestMapping(value = "/production/workjisi/heat/workHeatListWorkPrint", method = RequestMethod.POST)
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
		
		
		String mergePathWork = "D:/태경출력파일/작업지시서/";
		String fileName = "";
		
		//PDF파일병합 추가
		PDFMergerUtility mergeWork = new PDFMergerUtility();
		
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
	        fileName = reportWorkJisi.getJisi_lot_view()+"_"+jisiLotArray.length; // 최종 파일 이름
			
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

				mergeWork.addSource("D:/태경출력파일/작업지시서/"+fileName+".pdf");
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		mergeWork.setDestinationFileName(mergePathWork+fileName+".pdf");
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
	
	//작업지시관리 삭제
	@RequestMapping(value = "/production/workjisi/workJisiListDelete", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> workJisiListDelete(
			@RequestParam(value="jisi_lot_view_array") String[] jisiLotViewArray,
			HttpServletRequest request){
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		
		UtilClass util = new UtilClass();
		
		Users users = util.getSessionUser(request);
		
		if(jisiLotViewArray.length > 0) {
			for(String jisi_lot_view : jisiLotViewArray) {
				WorkJisi w = new WorkJisi();
				w.setJisi_lot_view(jisi_lot_view);
				w.setUser_name(users.getUser_name());
				
				workJisiService.workJisiListDelete(w);
			}
		}
		
		rtnMap.put("data",jisiLotViewArray);
		
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
	public Map<String, Object> getChulgoList(
			@RequestParam String sdate,
			@RequestParam String edate,
			@RequestParam String prod_gubn
			) {
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		
		WorkJisi chulgo = new WorkJisi();
		chulgo.setSdate(sdate);
		chulgo.setEdate(edate);
		chulgo.setProd_gubn(prod_gubn);

		List<WorkJisi> chulgoList = workJisiService.getChulgoList(chulgo);

		for(int i=0; i<chulgoList.size(); i++) {
			chulgoList.get(i).setIdx(i+1);
		}

		rtnMap.put("data",chulgoList);

		return rtnMap; 
	}
	
	//출고관리 - 등록(입고정보 조회)
	@RequestMapping(value = "/product/chulgo/getChulgoAddList", method = RequestMethod.POST) 
	@ResponseBody 
	public Map<String, Object> getChulgoAddList(
			@RequestParam String sdate,
			@RequestParam String edate
			) {
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		
		WorkJisi chulgo = new WorkJisi();
		chulgo.setSdate(sdate);
		chulgo.setEdate(edate);
		
		List<WorkJisi> chulgoRegList = workJisiService.getChulgoAddList(chulgo);
		
		rtnMap.put("data",chulgoRegList);
		
		return rtnMap; 
	}
	
	//출고 - 등록
	@RequestMapping(value = "/product/chulgo/chulgoAdd", method = RequestMethod.POST) 
	@ResponseBody 
	public Map<String, Object> setChulgoAdd(@RequestBody String str){
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		JSONParser jParser = new JSONParser();

		try {
			JSONObject workObj = (JSONObject)jParser.parse(str);

			String ochDate = workObj.get("ochDate").toString();

			JSONArray workData = (JSONArray)workObj.get("chulgoData");

			int result = 0;
			
			
			for(int i=0; i<workData.size(); i++) {

				JSONObject jObj = (JSONObject)workData.get(i);

				WorkJisi chulgo = new WorkJisi();
				
				chulgo.setTend_code(i);
				chulgo.setCorp_name(jObj.get("corp_name").toString());
				chulgo.setJaego_amnt(Float.parseFloat(jObj.get("jaego_amnt").toString()));
				chulgo.setJaego_su(Integer.parseInt(jObj.get("jaego_su").toString()));
				chulgo.setOch_su(Float.parseFloat(jObj.get("och_su").toString()));
				chulgo.setOch_amnt(Float.parseFloat(jObj.get("och_amnt").toString()));
				chulgo.setOch_bigo(jObj.get("och_bigo").toString());
				chulgo.setOch_ma(jObj.get("och_ma").toString());
				chulgo.setOrd_dang(Float.parseFloat(jObj.get("ord_dang").toString()));
				chulgo.setOrd_danj(Float.parseFloat(jObj.get("ord_danj").toString()));
				chulgo.setOrd_code(Integer.parseInt(jObj.get("ord_code").toString()));
				chulgo.setOrd_lot(jObj.get("ord_lot").toString());
				chulgo.setOch_mon(jObj.get("och_mon").toString());
				chulgo.setOch_date(ochDate);
			
				workJisiService.setChulgoAdd(chulgo);
			}

		} catch (ParseException e) {
			e.printStackTrace();
		}

		rtnMap.put("data","succ");

		return rtnMap;
	}
	
	//출고 - 수정
	@RequestMapping(value = "/product/chulgo/chulgoUpdate", method = RequestMethod.POST) 
	@ResponseBody 
	public Map<String, Object> setChulgoUpdate(@RequestBody String str){
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		
		JSONParser jParser = new JSONParser();
		
		try {
			JSONObject workObj = (JSONObject)jParser.parse(str);
						
			JSONObject workData = (JSONObject)workObj.get("chulgoData");
											
			WorkJisi chulgo = new WorkJisi();
			
			chulgo.setOch_date(workData.get("och_date").toString());
			chulgo.setOch_su(Integer.parseInt(workData.get("och_su").toString()));
			chulgo.setOch_amnt(Float.parseFloat(workData.get("och_amnt").toString()));
			chulgo.setOch_mon(workData.get("och_mon").toString());
			chulgo.setOch_bigo(workData.get("och_bigo").toString());
			chulgo.setOch_ma(workData.get("och_ma").toString());
			chulgo.setOch_dang(workData.get("och_dang").toString());
			chulgo.setOch_no(Integer.parseInt(workData.get("och_no").toString()));
			
			workJisiService.setChulgoUpdate(chulgo);
			
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		rtnMap.put("data","succ");
		
		return rtnMap;
	}

	//출고 - 삭제
	@RequestMapping(value = "/product/chulgo/chulgoDelete", method = RequestMethod.POST) 
	@ResponseBody 
	public Map<String, Object> setChulgoDelete(@RequestBody String str,
			HttpServletRequest request){
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		JSONParser jParser = new JSONParser();
		
		UtilClass util = new UtilClass();
		
		Users users = util.getSessionUser(request);

		try {
			JSONObject workObj = (JSONObject)jParser.parse(str);

			String userName = users.getUser_name();

			JSONArray workData = (JSONArray)workObj.get("chulgoData");

			int result = 0;
			
			
			for(int i=0; i<workData.size(); i++) {

				JSONObject jObj = (JSONObject)workData.get(i);

				WorkJisi chulgo = new WorkJisi();
				
				chulgo.setUser_name(userName);
				chulgo.setOch_no(Integer.parseInt(jObj.get("och_no").toString()));
			
				workJisiService.setChulgoDelete(chulgo);
			}

		} catch (ParseException e) {
			e.printStackTrace();
		}

		rtnMap.put("data","succ");

		return rtnMap;
	}

	
	//출고 - 거래명세서-일반 출력
	@RequestMapping(value = "/product/chulgo/chulgoReport", method = RequestMethod.POST) 
	@ResponseBody 
	public Map<String, Object> getChulgoReportNormal(@RequestBody String str,
			HttpServletRequest request){
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		String reportPath = "";
		String subReportPath = "";
		
		JSONParser jParser = new JSONParser();
		List<Integer> och_code_list = null;
		List<Integer> och_no_list = null;
		String fileName = "";		//파일명
		String fileNameGb = "";		//거래명세서별 구분값
		
		
		String openPath = "";			//파일경로
		String mergePath = "";
		String mergePathFileName = "";		
		//PDF파일병합 추가
		PDFMergerUtility merge = new PDFMergerUtility();
		
		try {
			JSONObject workObj = (JSONObject)jParser.parse(str);
			
			/* chulgo_print_gb
			 [1] : 거래명세서 - 일반
			 [2] : 거래명세서 - A4
			 [3] : 거래명세서 - 일반_2
			 [4] : 거래명세서 - A4_2
			 [5] : 거래명세서 - 제품별
			 */
			int chulgo_print_gb = Integer.parseInt(workObj.get("chulgo_print_gb").toString());

			switch(chulgo_print_gb) {
				case 1: 
					fileNameGb = "거래명세서-일반/";
					mergePath = "D:/태경출력파일/"+fileNameGb;
					openPath = "/tkPrint/chulgoNormalPdf/";
					reportPath = request.getServletContext().getRealPath("/WEB-INF/resources/reports/TradePortfolio.jrxml");
					subReportPath = request.getServletContext().getRealPath("/WEB-INF/resources/reports/TradePortfolioSub.jrxml");
				break;
				case 2: fileNameGb = "거래명세서-A4/"; break;
				case 3: fileNameGb = "거래명세서-일반_2/"; break;
				case 4: fileNameGb = "거래명세서-A4_2/"; break;
				case 5: 
					fileNameGb = "거래명세서-제품별/"; 
					mergePath = "D:/태경출력파일/"+fileNameGb;
					openPath = "/tkPrint/chulgoProdPdf/";
					reportPath = request.getServletContext().getRealPath("/WEB-INF/resources/reports/TradePortfolioChulgo_prod.jrxml");
					subReportPath = request.getServletContext().getRealPath("/WEB-INF/resources/reports/TradePortfolioChulgo_prod_Sub.jrxml");
				break;
			}
			
			mergePath = "D:/태경출력파일/"+fileNameGb;
			
			JSONArray workData = (JSONArray)workObj.get("chulgoData");
			
			och_code_list = new ArrayList<Integer>();
			och_no_list = new ArrayList<Integer>();
			//선택한 행의 수만큼 반복
			for(int i=0; i<workData.size(); i++) {
				JSONObject rowObj = (JSONObject)workData.get(i);
				och_code_list.add(Integer.parseInt(rowObj.get("och_code").toString()));
				och_no_list.add(Integer.parseInt(rowObj.get("och_no").toString()));
			}
			
			WorkJisi w = new WorkJisi();
			w.setOch_code_list(och_code_list);
			w.setOch_no_list(och_no_list);
			//och_code_list로 출고등록된 거래처 조회
			
			//거래명세서 발행할 거래처 리스트(출고일 기준)
			List<WorkJisi> chulgoReportList = workJisiService.getChulgoReportNormal(w);
			
			Map<String, List<Integer>> ochMap = new HashMap<String, List<Integer>>();
			List<Integer> ochList = new ArrayList<Integer>();
			

				if(chulgo_print_gb == 1) {
					/*거래명세서 - 일반*/
					
					//출고일+거래처코드별 출고코드 리스트 저장
					//출고일, 거래처코드, 출고코드
					String och_date = "";
					int corp_code = 0;
					int och_code = 0;
					
					for(int i=0; i<chulgoReportList.size(); i++) {
						
						//출고일이나 거래처코드 둘중 하나라도 다르다면
						if(!och_date.equals(chulgoReportList.get(i).getOch_date())
								|| corp_code != chulgoReportList.get(i).getCorp_code()) {
							
							ochList = new ArrayList<Integer>();
						}
						
						corp_code = chulgoReportList.get(i).getCorp_code();
						och_date = chulgoReportList.get(i).getOch_date();
						och_code = chulgoReportList.get(i).getOch_code();
						
						ochList.add(och_code);
						ochMap.put(och_date+";"+corp_code,ochList);
					}
					
					//체크한 항목들을 거래처코드+출고일 기준으로 매핑
					int printIdx = 1;
					for(Entry<String, List<Integer>> och : ochMap.entrySet()) {
		
						//출고일;거래처코드
						String[] keyArr = och.getKey().split(";");
						
						WorkJisi cw = new WorkJisi();
						cw.setOch_date(keyArr[0]);
						cw.setCorp_code(Integer.parseInt(keyArr[1]));
						cw.setOch_code_list(och.getValue());
						
						//상단 리스트
						List<WorkJisi> chulgoReportMainList = workJisiService.getChulgoReportMainNormal(cw);
						//하단 리스트				
						List<WorkJisi> chulgoReportSubList = workJisiService.getChulgoReportSubNormal(cw);
						
						fileName = fileNameGb+"_"+keyArr[0].replace("-","")+"_"+chulgoReportMainList.get(0).getCorp_name()+printIdx;
						mergePathFileName = keyArr[0].replace("-","")+"_"+chulgoReportMainList.get(0).getCorp_name();
						
						JRBeanCollectionDataSource dataSource = new JRBeanCollectionDataSource(chulgoReportMainList);
						JRBeanCollectionDataSource subDataSource = new JRBeanCollectionDataSource(chulgoReportSubList);
						JRBeanCollectionDataSource subDataSource2 = new JRBeanCollectionDataSource(chulgoReportSubList);
						
						JasperReportsContext jasperReportsContext = new SimpleJasperReportsContext();
						JasperCompileManager compileManager = JasperCompileManager.getInstance(jasperReportsContext);
						JasperReport report = JasperCompileManager.compileReport(reportPath);
						JasperReport subReport = JasperCompileManager.compileReport(subReportPath);
						
						Map<String, Object> reportMap = new HashMap<String, Object>();
						reportMap.put("report_list", chulgoReportList);
						reportMap.put("SUBREPORT_DATASOURCE", subDataSource);
						reportMap.put("SUBREPORT", subReport);
						reportMap.put("SUBREPORT_DATASOURCE2", subDataSource2);
						reportMap.put("SUBREPORT2", subReport);
						
						
						JasperFillManager fillManager = JasperFillManager.getInstance(jasperReportsContext);
						
						JasperPrint jasperPrint = JasperFillManager.fillReport(report, reportMap, dataSource);		
						
						JasperExportManager exportManager = JasperExportManager.getInstance(jasperReportsContext); 
						JasperExportManager.exportReportToPdfFile(jasperPrint,"D:/태경출력파일/"+fileName+".pdf");
						printIdx++;
						merge.addSource("D:/태경출력파일/"+fileName+".pdf");
					}
				}else if(chulgo_print_gb == 5) {
					/*거래명세서 - 제품별*/
					/*거래명세서 - 일반*/
					
					//출고일+거래처코드별 출고코드 리스트 저장
					//출고일, 거래처코드, 출고코드
					String och_date = "";
					int prod_code = 0;
					int och_code = 0;
					
					for(int i=0; i<chulgoReportList.size(); i++) {
						
						//출고일이나 거래처코드 둘중 하나라도 다르다면
						if(!och_date.equals(chulgoReportList.get(i).getOch_date())) {
							
							ochList = new ArrayList<Integer>();
						}
						
						prod_code = chulgoReportList.get(i).getProd_code();
						och_date = chulgoReportList.get(i).getOch_date();
						och_code = chulgoReportList.get(i).getOch_code();
						
						ochList.add(och_code);
						ochMap.put(och_date,ochList);
					}
					
					//체크한 항목들을 거래처코드+출고일 기준으로 매핑
					int printIdx = 1;
					for(Entry<String, List<Integer>> och : ochMap.entrySet()) {
//						System.out.println(och.getKey());
//						System.out.println(och.getValue());
						//출고일;거래처코드
						String keyArr = och.getKey();
						
						WorkJisi cw = new WorkJisi();
						cw.setOch_date(keyArr);
						cw.setOch_code_list(och.getValue());
						
						//상단 리스트
						List<WorkJisi> chulgoReportMainList = workJisiService.getChulgoReportMainProd(cw);
						//하단 리스트				
						List<WorkJisi> chulgoReportSubList = workJisiService.getChulgoReportSubProd(cw);
						
						fileName = fileNameGb+"_"+keyArr.replace("-","")+"_"+printIdx;
						mergePathFileName = keyArr.replace("-","")+"_";
						
						JRBeanCollectionDataSource dataSource = new JRBeanCollectionDataSource(chulgoReportMainList);
						JRBeanCollectionDataSource subDataSource = new JRBeanCollectionDataSource(chulgoReportSubList);
						JRBeanCollectionDataSource subDataSource2 = new JRBeanCollectionDataSource(chulgoReportSubList);
						
						JasperReportsContext jasperReportsContext = new SimpleJasperReportsContext();
						JasperCompileManager compileManager = JasperCompileManager.getInstance(jasperReportsContext);
						JasperReport report = JasperCompileManager.compileReport(reportPath);
						JasperReport subReport = JasperCompileManager.compileReport(subReportPath);
						
						Map<String, Object> reportMap = new HashMap<String, Object>();
						reportMap.put("report_list", chulgoReportList);
						reportMap.put("SUBREPORT_DATASOURCE", subDataSource);
						reportMap.put("SUBREPORT", subReport);
						reportMap.put("SUBREPORT_DATASOURCE2", subDataSource2);
						reportMap.put("SUBREPORT2", subReport);
						
						
						JasperFillManager fillManager = JasperFillManager.getInstance(jasperReportsContext);
						
						JasperPrint jasperPrint = JasperFillManager.fillReport(report, reportMap, dataSource);		
						
						JasperExportManager exportManager = JasperExportManager.getInstance(jasperReportsContext); 
						JasperExportManager.exportReportToPdfFile(jasperPrint,"D:/태경출력파일/"+fileName+".pdf");
						printIdx++;
						merge.addSource("D:/태경출력파일/"+fileName+".pdf");
				}
			}
				
	
			} catch (Exception e) {
				e.printStackTrace();
			}

		merge.setDestinationFileName(mergePath+mergePathFileName+".pdf");
		try {
			merge.mergeDocuments(MemoryUsageSetting.setupTempFileOnly());
			rtnMap.put("fileName",openPath+mergePathFileName+".pdf");
		} catch (IOException e) {
			e.printStackTrace();
		}

		return rtnMap;
	}

}
