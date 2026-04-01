package com.tkheat.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.pdfbox.io.MemoryUsageSetting;
import org.apache.pdfbox.multipdf.PDFMergerUtility;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tkheat.domain.WorkJisiTk;
import com.tkheat.service.WorkIlboService;

import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.JasperReportsContext;
import net.sf.jasperreports.engine.SimpleJasperReportsContext;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

@Controller
public class WorkIlboController {

	@Autowired
	private WorkIlboService workIlboService;
	
	//00.공통
	private final Logger logger = LoggerFactory.getLogger(WorkIlboController.class);
	
	
	@RequestMapping(value = "/workilbo/dataDelete", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> workIlboDataDelete(
			@RequestParam(required = false) int ilbo_code,	
			@RequestParam(required = false) int ord_code,	
			@RequestParam(required = false) String ilbo_gubn,	
			@RequestParam(required = false) String ilbo_lot,
			@RequestParam(required = false) String user_name
		){
		Map<String, Object> rtnMap = new HashMap<String, Object>();
	
		WorkJisiTk w = new WorkJisiTk();
		w.setIlbo_code(ilbo_code);
		w.setOrd_code(ord_code);
		w.setIlbo_gubn(ilbo_gubn);
		w.setIlbo_lot(ilbo_lot);
		w.setUser_name(user_name);
		
		workIlboService.workIlboDataDelete(w);
		
	
		return rtnMap;
	}

	//3-2단취작업 등록시 작업자리스트
	@RequestMapping(value = "/workilbo/userList", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> workIlboUserList(){
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		
		WorkJisiTk w = new WorkJisiTk();
		
		List<WorkJisiTk> list = workIlboService.workIlboUserList(w);
		
		
		
		rtnMap.put("data",list);
		
		
		return rtnMap;	
	}

	
	//적용할 제품의 수량,중량계산 메서드
	public Map<String, Object> workInstructionTkDanIpgoListDataCalc(
			JSONObject selectViewObj,
			JSONArray listViewArray,
			WorkJisiTk danchForm,
			boolean stdCntOverChk){
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		rtnMap.put("calcAlert","");
		
		//선택한 제품 수량,중량 계산 후 데이터 리스트로 전송
		WorkJisiTk selectWorkTmp = new WorkJisiTk();
		WorkJisiTk stdWorkTmp = new WorkJisiTk();
		JSONObject listViewObj = new JSONObject();
		
		/*행적용 데이터*/
		int ord_code = Integer.parseInt(selectViewObj.get("ord_code").toString());	//바코드
		String ord_input_view = selectViewObj.get("ord_input_view").toString();		//입고일
		int ord_su = Integer.parseInt(selectViewObj.get("ord_su").toString());		//수량
		float ord_amnt = Float.parseFloat(selectViewObj.get("ord_amnt").toString());//중량
		String corp_name = selectViewObj.get("corp_name").toString();				//거래처
		String prod_name = selectViewObj.get("prod_name").toString();				//품명
		String prod_no = selectViewObj.get("prod_no").toString();					//품번
		String prod_pg = selectViewObj.get("prod_pg").toString();					//표면경도
		String prod_gd = selectViewObj.get("prod_gd").toString();					//경화깊이
		String prod_si = selectViewObj.get("prod_si").toString();					//소입경도
		float prod_danj = Float.parseFloat(selectViewObj.get("prod_danj").toString());//단중
		int prod_code = Integer.parseInt(selectViewObj.get("prod_code").toString());//제품코드
		int ilbo_su = 0;
		float ilbo_jung = 0;
		
		//단취 기준수량
		int danch_std_cnt = Integer.parseInt(selectViewObj.get("wstd_t43").toString());
		//현재 선택한 제품의 단취가능수량(잔량)
		int danch_remain_su = Integer.parseInt(selectViewObj.get("danch_remain_su").toString());
		//현재 총 작업수량
		int danch_total_cnt = danchForm.getDanch_total_cnt();
		
		//정상처리일경우 선택한 데이터로 작업수량 계산(총 작업수량/단취수량) 및 리스트 전송
		
		//1. 단취 타뷸레이터의 리스트 수 비교
		//2. 0이면 데이터 적용 0보다 크면 동일한 품번인지 비교(모달창에 총 작업수량, 단취 기준수량 전송)
		//3. 동일한 품번이면 객체의 단취수량에 맞게 계산, 다른 품번이면 단취수량 무시		
		
		//단취리스트에 첫 적용일 때
		if(listViewArray.size() == 0) {
			if(danch_std_cnt != 0) {
				//잔량이 (단취기준수량+총 작업수량)보다 작거나 같을 때
				//360 (480+0)
				if((danch_std_cnt+danch_total_cnt) >= danch_remain_su) {
					danch_total_cnt += danch_remain_su;
					
					//작업등록 수량, 중량
					ilbo_su = danch_remain_su;
					ilbo_jung = danch_remain_su * prod_danj;
				}else {
					//잔량이 단취 기준수량보다 클 때
					//560 (480+0)
					danch_total_cnt += danch_std_cnt;
					
					//작업등록 수량, 중량
					ilbo_su = danch_std_cnt;
					ilbo_jung = danch_std_cnt * prod_danj;				
				}
			}else {
				danch_total_cnt += danch_remain_su;
				
				//단취 기준수량이 0일때
				ilbo_su = danch_remain_su;
				ilbo_jung = danch_remain_su * prod_danj;
			}
		}else {
			if(danch_std_cnt != 0) {
				//단취저장 리스트의 행이 1개 이상일 때.
				//품번이 동일/상이에 따라 단취수량계산 차이발생.
				
				//이미 등록되어있는 제품코드와 선택한 제품코드비교
				boolean prodChk = false;
				for(Object lObj : listViewArray) {
					if (lObj instanceof JSONObject) {
						listViewObj = (JSONObject)lObj;
	                    int prod_code_list = Integer.parseInt(listViewObj.get("prod_code").toString());
	                    if(prod_code_list != prod_code) {
	                    	prodChk = true;
	                    	break;
	                    }
	                    
	                }					
				}
				
				
				//리스트의 제품코드와 선택한 제품코드가 하나라도 다르면
				//단취 기준수량 무시 후 총 작업수량만 합산
				if(prodChk) {
					danch_total_cnt += danch_remain_su;
					
					//작업등록 수량, 중량
					ilbo_su = danch_remain_su;
					ilbo_jung = danch_remain_su * prod_danj;
				}else {
					
					if(stdCntOverChk) {
						rtnMap.put("calcAlert","총 작업수량은 단취 기준수량을 초과할 수 없습니다!!");
					}
					
					//총 작업수량, 잔여수량, 단취 기준수량으로 계산
					//잔량이 총 (작업수량 - 기준수량) 보다 클 때
					if(danch_remain_su > (danch_std_cnt - danch_total_cnt)) {
						ilbo_su = (danch_std_cnt - danch_total_cnt);
						ilbo_jung = (danch_std_cnt - danch_total_cnt) *  prod_danj;
						
						danch_total_cnt += (danch_std_cnt - danch_total_cnt);
					}else {					
						ilbo_su = danch_remain_su;
						ilbo_jung = danch_remain_su *  prod_danj;
						
						danch_total_cnt += danch_remain_su;
					}
								
				}
			}else {
				//단취 기준수량이 0일때
				ilbo_su = danch_remain_su;
				ilbo_jung = danch_remain_su *  prod_danj;
				
				danch_total_cnt += danch_remain_su;
			}
			
		}
			
			
		//리스트에 표현될 정보 전송
		selectWorkTmp.setOrd_code(ord_code);
		selectWorkTmp.setOrd_input_view(ord_input_view);
		selectWorkTmp.setOrd_su(ord_su);
		selectWorkTmp.setOrd_amnt(ord_amnt);
		selectWorkTmp.setCorp_name(corp_name);
		selectWorkTmp.setProd_name(prod_name);
		selectWorkTmp.setProd_no(prod_no);
		selectWorkTmp.setProd_pg(prod_pg);
		selectWorkTmp.setProd_gd(prod_gd);
		selectWorkTmp.setProd_si(prod_si);
		selectWorkTmp.setProd_code(prod_code);		
		selectWorkTmp.setDanch_total_cnt(danch_total_cnt);
		selectWorkTmp.setIlbo_su(ilbo_su);
		selectWorkTmp.setIlbo_jung(ilbo_jung);
		selectWorkTmp.setProd_danj(prod_danj+"");
		
		//제품의 기준정보 전송
		stdWorkTmp.setDanch_std_cnt(danch_std_cnt);
		stdWorkTmp.setWstd_t32(ifNullStringReturn(selectViewObj.get("wstd_t32")));
		stdWorkTmp.setWstd_t33(ifNullStringReturn(selectViewObj.get("wstd_t33")));
		stdWorkTmp.setWstd_t41(ifNullStringReturn(selectViewObj.get("wstd_t41")));
		stdWorkTmp.setWstd_t87(ifNullStringReturn(selectViewObj.get("wstd_t87")));
		stdWorkTmp.setWstd_t43(ifNullStringReturn(selectViewObj.get("wstd_t43")));
		stdWorkTmp.setWstd_t44(ifNullStringReturn(selectViewObj.get("wstd_t44")));
		stdWorkTmp.setWstd_t51(ifNullStringReturn(selectViewObj.get("wstd_t51")));
		stdWorkTmp.setWstd_t52(ifNullStringReturn(selectViewObj.get("wstd_t52")));
		stdWorkTmp.setWstd_t53(ifNullStringReturn(selectViewObj.get("wstd_t53")));
		stdWorkTmp.setWstd_t54(ifNullStringReturn(selectViewObj.get("wstd_t54")));
		stdWorkTmp.setWstd_t30(ifNullStringReturn(selectViewObj.get("wstd_t30")));
		stdWorkTmp.setProduct_file_name(ifNullStringReturn(selectViewObj.get("product_file_name")));
		stdWorkTmp.setWstd_chim_file_name1(ifNullStringReturn(selectViewObj.get("wstd_chim_file_name1")));
		stdWorkTmp.setDanch_total_cnt(danch_total_cnt);
		
		rtnMap.put("selectMap",selectWorkTmp);
		rtnMap.put("stdMap",stdWorkTmp);
		
		return rtnMap;
		
	}
	
	
	public String ifNullStringReturn(Object obj) {
		
		String rtnValue = "";
		
		if(obj != null) {
			rtnValue = obj.toString();
		}
		
		return rtnValue;
	}
	
	@RequestMapping(value = "/workilbo/bcfList", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> workIlboBcfList(
			@RequestParam(required=false) String tech_no
			){
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		
		WorkJisiTk w = new WorkJisiTk();
		w.setTech_no(tech_no);
		
		List<WorkJisiTk> list = workIlboService.workIlboBcfList(w);
		
		rtnMap.put("data",list);
		
		return rtnMap;	
	}

	
	//01.적재
	
	//적재 화면이동
	@RequestMapping(value = "/workilbo/danch", method = RequestMethod.GET)
	public String workIlboDanch() {
		return "/workilbo/danch.jsp";
	}
	
	
	//2.작업지시 데이터 조회
	@RequestMapping(value = "/workilbo/danch/allList", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> workIlboDanchAllList(
			@RequestParam(required=false) String s_sdate,
			@RequestParam(required=false) String s_edate,
			@RequestParam(required=false) String s_corp_name,
			@RequestParam(required=false) String s_prod_name,
			@RequestParam(required=false) String s_prod_no){			
		Map<String, Object> rtnMap = new HashMap<String, Object>();
				
		WorkJisiTk w = new WorkJisiTk();
		w.setSdate(s_sdate);
		w.setEdate(s_edate);
		w.setCorp_name(s_corp_name);
		w.setProd_name(s_prod_name);
		w.setProd_no(s_prod_no);
		
		List<WorkJisiTk> list = workIlboService.workIlboDanchAllList(w);
		
		
		rtnMap.put("data",list);
		
		
//		logger.info("작업지시-단취 : {}","작업지시(단취) 데이터 조회 : "+w.getSdate()+"// "+w.getEdate());
		return rtnMap;	
	}
	
	
	
	//3-1.작업지시(단취) 데이터조회(입고이력 조회선택시)
	@RequestMapping(value = "/workilbo/danch/ipgoList", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> workIlboDanchIpgoList(
			@RequestParam(required = false) String searchObjParam,
			@RequestParam(required = false) String danchSettingDataList	
		){
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		
		JSONParser listParser = new JSONParser();
		JSONParser searchParser = new JSONParser();		
		
		Object listObj = new Object();
		Object searchObj = new Object();
		
		JSONArray listJsonArray = new JSONArray();
		JSONObject searchViewObj = new JSONObject();
		JSONObject listJsonObject = new JSONObject();
		
		//리스트의 수주번호를 배열로
		List<Integer> danchSunipOrdList = null;		
		
		
		try {			
			//리스트 데이터
			listObj = listParser.parse(danchSettingDataList);
						
			if(listObj instanceof JSONArray) {
				listJsonArray = (JSONArray)listObj;
				danchSunipOrdList = new ArrayList<Integer>();
				
				for(Object lObj : listJsonArray) {
					if (lObj instanceof JSONObject) {
						listJsonObject = (JSONObject)lObj;
						danchSunipOrdList.add(Integer.parseInt(listJsonObject.get("ord_code").toString()));
	                    
	                }					
				}
			}
			
			//조회조건
			searchObj = searchParser.parse(searchObjParam);
			searchViewObj = (JSONObject)searchObj;
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		WorkJisiTk w = new WorkJisiTk();
		w.setCorp_name(ifNullStringReturn(searchViewObj.get("dan_ipgo_cname")));
		w.setProd_name(ifNullStringReturn(searchViewObj.get("dan_ipgo_pname")));
		w.setProd_no(ifNullStringReturn(searchViewObj.get("dan_ipgo_pno")));
		w.setSdate(ifNullStringReturn(searchViewObj.get("dan_ipgo_sdate")));
		w.setEdate(ifNullStringReturn(searchViewObj.get("dan_ipgo_edate")));
		w.setSunipOrdList(danchSunipOrdList);
		
		List<WorkJisiTk> list = workIlboService.workIlboDanchIpgoList(w);		
		
		rtnMap.put("data",list);
		
		
		return rtnMap;	
	}

	
	@RequestMapping(value = "/workilbo/danch/ipgoBarcodeScan", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> workIlboDanchIpgoBarcodeScan(
			@RequestParam(required = false) int ord_code){
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		
		WorkJisiTk w = new WorkJisiTk();
		w.setOrd_code(ord_code);
		
		List<WorkJisiTk> list = workIlboService.workIlboDanchIpgoBarcodeScan(w);		
		
		rtnMap.put("data",list);

		
		return rtnMap;
	}

	
	//3-3.입고리스트 선택시 단취리스트 데이터 이동
	@RequestMapping(value = "/workilbo/danch/ipgoList/dataSetting", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> workIlboDanchIpgoListDataSetting(
			@RequestParam(required = false) String workDanIpgoSelectDataParam,
			@RequestParam(required = false) String stdObjParam,
			@RequestParam(required = false) String danchSettingDataList,
			HttpServletRequest request
			){
		Map<String, Object> rtnMap = new HashMap<String, Object>();
	
//		System.out.println(workDanIpgoSelectDataParam);
//		System.out.println(danchSettingDataList);

		
		
		JSONParser selectParser = new JSONParser();
		JSONParser listParser = new JSONParser();
		JSONParser stdParser = new JSONParser();
		
		Object selectObj = new Object();
		Object listObj = new Object();
		Object stdObj = new Object();
		
		JSONObject selectViewObj = new JSONObject();
		JSONArray listJsonArray = new JSONArray();
		JSONObject stdViewObj = new JSONObject();
		JSONObject listJsonObject = new JSONObject();
		
		//리스트의 수주번호를 배열로
		List<Integer> danchSunipOrdList = null;
		
		try {
			//선택 데이터
			selectObj = selectParser.parse(workDanIpgoSelectDataParam);
			selectViewObj = (JSONObject)selectObj;
			
			//리스트 데이터
			listObj = listParser.parse(danchSettingDataList);
			
			
			if(listObj instanceof JSONArray) {
				listJsonArray = (JSONArray)listObj;
				danchSunipOrdList = new ArrayList<Integer>();
				
				for(Object lObj : listJsonArray) {
					if (lObj instanceof JSONObject) {
						listJsonObject = (JSONObject)lObj;
						danchSunipOrdList.add(Integer.parseInt(listJsonObject.get("ord_code").toString()));
	                    
	                }					
				}
			}
			
			//기준 데이터
			stdObj = stdParser.parse(stdObjParam);
			stdViewObj = (JSONObject)stdObj;
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		WorkJisiTk danchForm = new WorkJisiTk();
		danchForm.setDanch_total_cnt(Integer.parseInt(stdViewObj.get("danch_total_cnt").toString()));
		danchForm.setDanch_std_cnt(Integer.parseInt(stdViewObj.get("danch_std_cnt").toString()));
		danchForm.setDanch_sunip_chk(Integer.parseInt(stdViewObj.get("danch_sunip_chk").toString()));
		danchForm.setDanch_sunip_chk_pw(stdViewObj.get("danch_sunip_chk_pw").toString());
		
		boolean stdCntOverChk = false;
		
		if(danchForm.getDanch_total_cnt() > 0 &&
				danchForm.getDanch_total_cnt() >= danchForm.getDanch_std_cnt()) {			
			stdCntOverChk = true; 
		}
		
		//선택한 제품이 작업표준이 있는지 체크
		
		//선입선출제외 유효성 체크
		int danch_sunip_chk = danchForm.getDanch_sunip_chk();
		String danch_sunip_chk_pw = danchForm.getDanch_sunip_chk_pw();
		Map<String, Object> calcMap = new HashMap<String, Object>();
		
		calcMap = workInstructionTkDanIpgoListDataCalc(selectViewObj, listJsonArray, danchForm, stdCntOverChk);
		
		
		if(danch_sunip_chk == 1) {
			//선입선출제외 체크됨
			if("0000".equals(danch_sunip_chk_pw)) {
				//선입선출 무시
				
				rtnMap.put("alert","정상");
			}else {
				rtnMap.put("alert","선입선출 비밀번호 확인필요");
			}
		}else {
			//선입선출제외 체크안됨
			//선택한 제품의 제품코드로 선입제품이 있는지 확인
			WorkJisiTk w_sunip_chk = new WorkJisiTk();
			w_sunip_chk.setProd_code(Integer.parseInt(selectViewObj.get("prod_code").toString()));
			w_sunip_chk.setOrd_code(Integer.parseInt(selectViewObj.get("ord_code").toString()));
			w_sunip_chk.setSunipOrdList(danchSunipOrdList);
			
			List<WorkJisiTk> sunipChkList = workIlboService.workIlboDanchIpgoListDataSetting(w_sunip_chk);
			
//			calcMap = workInstructionTkDanIpgoListDataCalc(selectViewObj, listJsonArray, danchForm, stdCntOverChk);
			
			if(sunipChkList.size() > 0) {
				rtnMap.put("alert","선입된제품이 있습니다. 확인해주십시오!");
				rtnMap.put("sunipList",sunipChkList);
			}else if(sunipChkList.size() == 0) {
				//정상처리
				
				rtnMap.put("alert","정상");
			}else {
				//조회갯수 0개
				rtnMap.put("alert","조회된 제품이 없습니다. 관리자에게 문의해주시기 바랍니다!");
			}
			
//			rtnMap.put("alert","선입선출 조건 확인");
		}
		
		//품번은 동일한데 총 작업수량이 단취 기준수량 초과할경우
		if(!"".equals(ifNullStringReturn(calcMap.get("calcAlert")))) {
			rtnMap.put("alert",calcMap.get("calcAlert").toString());
		}
		
		rtnMap.put("selectOrdCode",Integer.parseInt(selectViewObj.get("ord_code").toString()));
		rtnMap.put("selectMap",calcMap.get("selectMap"));
		rtnMap.put("stdMap",calcMap.get("stdMap"));
		
		return rtnMap;	
	}
	
	
	//작업데이터 조회 후 모달표시
	@RequestMapping(value = "/workilbo/danch/dataUpdateList", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> workIlboDanchDataUpdateList(
			@RequestParam(required = false) int ilbo_code,	
			@RequestParam(required = false) String ilbo_gubn,	
			@RequestParam(required = false) String ilbo_lot,
			@RequestParam(required = false) int ilbo_pc
		){
		Map<String, Object> rtnMap = new HashMap<String, Object>();
	
		WorkJisiTk w = new WorkJisiTk();
		w.setIlbo_code(ilbo_code);
		w.setIlbo_gubn(ilbo_gubn);
		w.setIlbo_lot(ilbo_lot);
		w.setIlbo_pc(ilbo_pc);
		
		List<WorkJisiTk> wList = workIlboService.workIlboDanchDataUpdateList(w);
		
		rtnMap.put("data",wList);
	
		return rtnMap;
	}

	
	//단취데이터 저장
	@RequestMapping(value = "/workilbo/danch/dataSave", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> workIlboDanchDataSave(	
			@RequestParam(required = false) String danchSettingDataList,
			@RequestParam(required = false) String formObjParam){
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		
		JSONParser listParser = new JSONParser();
		JSONParser formParser = new JSONParser();
		
		Object listObj = new Object();
		Object formObj = new Object();
		
		JSONArray listJsonArray = new JSONArray();
		JSONObject formViewObj = new JSONObject();
		JSONObject listJsonObject = new JSONObject();
		
		try {
			//리스트 데이터
			listObj = listParser.parse(danchSettingDataList);
			
			
			if(listObj instanceof JSONArray) {
				listJsonArray = (JSONArray)listObj;
				
				//작업자, 시작, 종료 데이터
				formObj = formParser.parse(formObjParam);
				formViewObj = (JSONObject)formObj;			
					
				//일보코드 조회
				int ilbo_code = 0;
				int ilbo_code_search = workIlboService.getWorkIlboCodeSearch();
				int user_code = Integer.parseInt(ifNullStringReturn(formViewObj.get("user_code")));
				String ilbo_strt = ifNullStringReturn(formViewObj.get("ilbo_strt"));
				String ilbo_end = ifNullStringReturn(formViewObj.get("ilbo_end"));
				int ilbo_no = 0;
				for(Object lObj : listJsonArray) {
					if (lObj instanceof JSONObject) {
						listJsonObject = (JSONObject)lObj;
						//listJsonObject.get("ord_code").toString()
	                    WorkJisiTk wSave = new WorkJisiTk();
	                    
	                    if(Integer.parseInt(listJsonObject.get("ilbo_code").toString()) == 0) {
	                    	ilbo_code = ilbo_code_search;
	                    }else {
	                    	ilbo_code = Integer.parseInt(listJsonObject.get("ilbo_code").toString());
	                    }
	                    
	                    wSave.setIlbo_code(ilbo_code);
	                    wSave.setUser_code(user_code);
	                    wSave.setIlbo_strt(ilbo_strt);
	                    wSave.setIlbo_end(ilbo_end);
	                    wSave.setOrd_code(Integer.parseInt(listJsonObject.get("ord_code").toString()));
	                    wSave.setIlbo_no(ilbo_no);
	                    wSave.setIlbo_gubn("J");
	                    wSave.setIlbo_su(Integer.parseInt(listJsonObject.get("ilbo_su").toString()));
	                    wSave.setIlbo_jung(Float.parseFloat(listJsonObject.get("ilbo_jung").toString()));
	                    wSave.setIlbo_g11("0");
	                    wSave.setIlbo_g12("");
	                    
	                    workIlboService.workIlboDanchDataSave(wSave);
	                    ilbo_no++;
	                }					
				}
			}
			
			rtnMap.put("data", "저장완료");
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return rtnMap;
	}


	
	//02.전세척
	
	//03.열처리
	//열처리 화면이동
	@RequestMapping(value = "/workilbo/heat", method = RequestMethod.GET)
	public String workIlboHeat() {
		return "/workilbo/heat.jsp";
	}	

	
	//2.작업지시 데이터 조회
	@RequestMapping(value = "/workilbo/heat/allList", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> workIlboHeatAllList(
			@RequestParam(required=false) String s_sdate,
			@RequestParam(required=false) String s_edate,
			@RequestParam(required=false) String s_corp_name,
			@RequestParam(required=false) String s_prod_name,
			@RequestParam(required=false) String s_prod_no,
			@RequestParam(required=false) int s_fac_code){			
		Map<String, Object> rtnMap = new HashMap<String, Object>();
				
		WorkJisiTk w = new WorkJisiTk();
		w.setSdate(s_sdate);
		w.setEdate(s_edate);
		w.setCorp_name(s_corp_name);
		w.setProd_name(s_prod_name);
		w.setProd_no(s_prod_no);
		w.setFac_code(s_fac_code);
		
		List<WorkJisiTk> list = workIlboService.workIlboHeatAllList(w);
		
		
		rtnMap.put("data",list);
		
		
//		logger.info("작업지시-단취 : {}","작업지시(단취) 데이터 조회 : "+w.getSdate()+"// "+w.getEdate());
		return rtnMap;	
	}

	@RequestMapping(value = "/workilbo/heat/bcfDataSearch", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> workIlboHeatBcfDataSearch(	
			@RequestParam(required = false) String selectedDataParam){
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		
		JSONParser selectedParser = new JSONParser();
		Object selectedObj = new Object();
		JSONObject selectedViewObj = new JSONObject();
		
		try {
			//작업자, 시작, 종료 데이터
			selectedObj = selectedParser.parse(selectedDataParam);
			selectedViewObj = (JSONObject)selectedObj;
			
			String danch_barcode = selectedViewObj.get("danch_barcode").toString();
			
			WorkJisiTk w = new WorkJisiTk();
			w.setDanch_barcode(danch_barcode);
			
			List<WorkJisiTk> wList = workIlboService.workIlboHeatBcfDataSearch(w);
			
			rtnMap.put("data",wList);
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return rtnMap;
	}

	
	@RequestMapping(value="/workilbo/heat/ilboLotRtn", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> workIlboHeatIlboLotRtn(
			@RequestParam(required=false) String ilbo_lot_date,
			@RequestParam(required=false) int fac_code,
			@RequestParam(required=false) int ilbo_code
			){
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		
		WorkJisiTk w = new WorkJisiTk();
		w.setIlbo_lot_date(ilbo_lot_date);
		w.setFac_code(fac_code);
		w.setIlbo_code(ilbo_code);
		
		String ilbo_lot = workIlboService.workIlboHeatIlboLotRtn(w);
		
		rtnMap.put("data",ilbo_lot);
		
		return rtnMap;
	}
	
	//작업데이터 조회 후 모달표시
	@RequestMapping(value = "/workilbo/heat/dataUpdateList", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> workIlboHeatDataUpdateList(
			@RequestParam(required = false) int ilbo_code,	
			@RequestParam(required = false) String ilbo_gubn,	
			@RequestParam(required = false) String ilbo_lot,
			@RequestParam(required = false) int ilbo_pc
		){
		Map<String, Object> rtnMap = new HashMap<String, Object>();
	
		WorkJisiTk w = new WorkJisiTk();
		w.setIlbo_code(ilbo_code);
		w.setIlbo_gubn(ilbo_gubn);
		w.setIlbo_lot(ilbo_lot);
		w.setIlbo_pc(ilbo_pc);
		
		List<WorkJisiTk> wList = workIlboService.workIlboHeatDataUpdateList(w);
		
		rtnMap.put("data",wList);
	
		return rtnMap;
	}

	//3-1.작업지시(열처리) 데이터조회(단취이력 조회선택시)
	@RequestMapping(value = "/workilbo/bcf/danchList", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> workIlboBcfDanchList(
			@RequestParam(required = false) String searchObjParam,
			@RequestParam(required = false) String bcfSettingDataList	
		){
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		
		JSONParser listParser = new JSONParser();
		JSONParser searchParser = new JSONParser();
		
		Object listObj = new Object();
		Object searchObj = new Object();
		
		JSONArray listJsonArray = new JSONArray();
		JSONObject searchViewObj = new JSONObject();
		JSONObject listJsonObject = new JSONObject();
		
		//리스트의 수주번호를 배열로
		List<Integer> ilboCodeList = null;		
		
		
		try {			
			//리스트 데이터
			listObj = listParser.parse(bcfSettingDataList);
						
			if(listObj instanceof JSONArray) {
				listJsonArray = (JSONArray)listObj;
				ilboCodeList = new ArrayList<Integer>();
				
				for(Object lObj : listJsonArray) {
					if (lObj instanceof JSONObject) {
						listJsonObject = (JSONObject)lObj;
						ilboCodeList.add(Integer.parseInt(listJsonObject.get("ilbo_code").toString()));
	                    
	                }					
				}
			}
			
			//조회조건
			searchObj = searchParser.parse(searchObjParam);
			searchViewObj = (JSONObject)searchObj;
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		WorkJisiTk w = new WorkJisiTk();
		w.setCorp_name(ifNullStringReturn(searchViewObj.get("bcf_danch_cname")));
		w.setProd_name(ifNullStringReturn(searchViewObj.get("bcf_danch_pname")));
		w.setProd_no(ifNullStringReturn(searchViewObj.get("bcf_danch_pno")));
		w.setSdate(ifNullStringReturn(searchViewObj.get("bcf_danch_sdate")));
		w.setEdate(ifNullStringReturn(searchViewObj.get("bcf_danch_edate")));
		w.setSunipOrdList(ilboCodeList);
		
		List<WorkJisiTk> list = workIlboService.workIlboBcfDanchList(w);		
		
		rtnMap.put("data",list);
		
		
		return rtnMap;	
	}

	//3-3.입고리스트 선택시 단취리스트 데이터 이동
	@RequestMapping(value = "/workilbo/bcf/danchList/dataSetting", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> workIlboBcfDanchListDataSetting(
			@RequestParam(required = false) String workBcfDanchSelectDataParam,
			HttpServletRequest request
			){
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		
		
		JSONParser selectParser = new JSONParser();
		
		Object selectObj = new Object();
		
		JSONObject selectViewObj = new JSONObject();
				
		try {
			//선택 데이터
			selectObj = selectParser.parse(workBcfDanchSelectDataParam);
			selectViewObj = (JSONObject)selectObj;
						
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		int ilbo_code = Integer.parseInt(selectViewObj.get("ilbo_code").toString());
		
		WorkJisiTk w = new WorkJisiTk();
		w.setIlbo_code(ilbo_code);
		
		List<WorkJisiTk> wList = workIlboService.workIlboBcfDanchListDataSetting(w);
		
		rtnMap.put("data",wList);
		
		return rtnMap;	
	}

	
	//열처리데이터 저장
	@RequestMapping(value = "/workilbo/heat/dataSave", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> workIlboHeatDataSave(	
			@RequestParam(required = false) String bcfSettingDataList,
			@RequestParam(required = false) String formObjParam){
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		
		JSONParser listParser = new JSONParser();
		JSONParser formParser = new JSONParser();
		
		Object listObj = new Object();
		Object formObj = new Object();
		
		JSONArray listJsonArray = new JSONArray();
		JSONObject formViewObj = new JSONObject();
		JSONObject listJsonObject = new JSONObject();
		
		try {
			//리스트 데이터
			listObj = listParser.parse(bcfSettingDataList);
			
			
			if(listObj instanceof JSONArray) {
				listJsonArray = (JSONArray)listObj;
				
				//작업자, 시작, 종료 데이터
				formObj = formParser.parse(formObjParam);
				formViewObj = (JSONObject)formObj;			
					
				//일보코드 조회
				int ilbo_code = 0;
				int ilbo_code_search = workIlboService.getWorkIlboCodeSearch();
				
				int fac_code = Integer.parseInt(ifNullStringReturn(formViewObj.get("fac_code")));
				int user_code = Integer.parseInt(ifNullStringReturn(formViewObj.get("user_code")));
				String wstd_gj11 = ifNullStringReturn(formViewObj.get("wstd_gj11"));
				String wstd_gj12 = ifNullStringReturn(formViewObj.get("wstd_gj12"));
				String wstd_gj13 = ifNullStringReturn(formViewObj.get("wstd_gj13"));
				String wstd_gj14 = ifNullStringReturn(formViewObj.get("wstd_gj14"));
				String wstd_gj16 = ifNullStringReturn(formViewObj.get("wstd_gj16"));
				String wstd_gj17 = ifNullStringReturn(formViewObj.get("wstd_gj17"));
				
				String wstd_gj21 = ifNullStringReturn(formViewObj.get("wstd_gj21"));
				String wstd_gj22 = ifNullStringReturn(formViewObj.get("wstd_gj22"));
				String wstd_gj23 = ifNullStringReturn(formViewObj.get("wstd_gj23"));
				String wstd_gj24 = ifNullStringReturn(formViewObj.get("wstd_gj24"));
				
				String wstd_gj32 = ifNullStringReturn(formViewObj.get("wstd_gj32"));
				String wstd_gj33 = ifNullStringReturn(formViewObj.get("wstd_gj33"));
				String wstd_gj34 = ifNullStringReturn(formViewObj.get("wstd_gj34"));
				String wstd_gj42 = ifNullStringReturn(formViewObj.get("wstd_gj42"));
				
				String ilbo_lot = ifNullStringReturn(formViewObj.get("ilbo_lot"));
				
				String ilbo_strt = ifNullStringReturn(formViewObj.get("ilbo_strt"));
				String ilbo_end = ifNullStringReturn(formViewObj.get("ilbo_end"));
				
				String ilbo_bigo = ifNullStringReturn(formViewObj.get("ilbo_bigo"));
				String ilbo_pg1 = ifNullStringReturn(formViewObj.get("ilbo_pg1"));
				String ilbo_pg2 = ifNullStringReturn(formViewObj.get("ilbo_pg2"));
				String ilbo_pg3 = ifNullStringReturn(formViewObj.get("ilbo_pg3"));
				String ilbo_pg4 = ifNullStringReturn(formViewObj.get("ilbo_pg4"));
				String ilbo_pg5 = ifNullStringReturn(formViewObj.get("ilbo_pg5"));
				String ilbo_okng = ifNullStringReturn(formViewObj.get("ilbo_okng"));
				
				
				String ilbo_ck01 = ifNullStringReturn(formViewObj.get("ilbo_ck01"));
				String ilbo_ck02 = ifNullStringReturn(formViewObj.get("ilbo_ck02"));
				String ilbo_ck03 = ifNullStringReturn(formViewObj.get("ilbo_ck03"));
				String ilbo_ck04 = ifNullStringReturn(formViewObj.get("ilbo_ck04"));
				String ilbo_ck05 = ifNullStringReturn(formViewObj.get("ilbo_ck05"));
				
				int ilbo_no = 0;
				
				for(Object lObj : listJsonArray) {
					if (lObj instanceof JSONObject) {
						listJsonObject = (JSONObject)lObj;
						//listJsonObject.get("ord_code").toString()
	                    WorkJisiTk wSave = new WorkJisiTk();
	                    
	                    //ilbo_pc의 값이 있는지 없는지로 구분
	                    int ilbo_pc = Integer.parseInt(listJsonObject.get("ilbo_pc").toString());
	                    
	                    if(ilbo_pc == 0) {
	                    	ilbo_pc = Integer.parseInt(listJsonObject.get("ilbo_code").toString());
	                    	ilbo_code = ilbo_code_search;
	                    }else {
	                    	ilbo_pc = Integer.parseInt(listJsonObject.get("ilbo_pc").toString());
	                    	ilbo_code = Integer.parseInt(listJsonObject.get("ilbo_code").toString());	
	                    }
	                    
                    	
	                    
	                    wSave.setIlbo_code(ilbo_code);	   
	                    wSave.setIlbo_pc(ilbo_pc);
	                    wSave.setIlbo_pn(ilbo_no);
	                    
	                    wSave.setIlbo_lot(ilbo_lot);
	                    wSave.setWstd_gj11(wstd_gj11);
	                    wSave.setWstd_gj12(wstd_gj12);
	                    wSave.setWstd_gj13(wstd_gj13);
	                    wSave.setWstd_gj14(wstd_gj14);
	                    wSave.setWstd_gj16(wstd_gj16);
	                    wSave.setWstd_gj17(wstd_gj17);
	                    
	                    wSave.setWstd_gj21(wstd_gj21);
	                    wSave.setWstd_gj22(wstd_gj22);
	                    wSave.setWstd_gj23(wstd_gj23);
	                    wSave.setWstd_gj24(wstd_gj24);
	                    
	                    wSave.setWstd_gj32(wstd_gj32);
	                    wSave.setWstd_gj33(wstd_gj33);
	                    wSave.setWstd_gj34(wstd_gj34);
	                    
	                    wSave.setWstd_gj42(wstd_gj42);
	                    
	                    wSave.setUser_code(user_code);
	                    wSave.setFac_code(fac_code);
	                    wSave.setIlbo_strt(ilbo_strt);
	                    wSave.setIlbo_end(ilbo_end);
	                    wSave.setOrd_code(Integer.parseInt(listJsonObject.get("ord_code").toString()));
	                    wSave.setIlbo_no(ilbo_no);
	                    wSave.setIlbo_gubn("A");
	                    wSave.setIlbo_su(Integer.parseInt(listJsonObject.get("ilbo_su").toString()));
	                    wSave.setIlbo_jung(Float.parseFloat(listJsonObject.get("ilbo_jung").toString()));
	                    wSave.setIlbo_g11("0");
	                    wSave.setIlbo_g12("");
	                    wSave.setIlbo_bigo(ilbo_bigo);
	                    wSave.setIlbo_ck01(ilbo_ck01);
	                    wSave.setIlbo_ck02(ilbo_ck02);
	                    wSave.setIlbo_ck03(ilbo_ck03);
	                    wSave.setIlbo_ck04(ilbo_ck04);
	                    wSave.setIlbo_ck05(ilbo_ck05);
	                    wSave.setIlbo_pg1(ilbo_pg1);
	                    wSave.setIlbo_pg2(ilbo_pg2);
	                    wSave.setIlbo_pg3(ilbo_pg3);
	                    wSave.setIlbo_pg4(ilbo_pg4);
	                    wSave.setIlbo_pg5(ilbo_pg5);
	                    wSave.setIlbo_okng(ilbo_okng);
	                    
	                    workIlboService.workIlboHeatDataSave(wSave);
	                    ilbo_no++;
	                }					
				}
			}
			
			rtnMap.put("data", "저장완료");
		}catch(Exception e) {
			e.printStackTrace();
		}
		return rtnMap;
	}


	
	//04.후세정
	
	//05.쇼트
	
	//06.템퍼링
	//템퍼링 화면이동
	@RequestMapping(value = "/workilbo/tempering", method = RequestMethod.GET)
	public String workIlboTempering() {
		return "/workilbo/tempering.jsp";
	}	

	/*템퍼링 작업*/
	@RequestMapping(value = "/workilbo/tf/tfDataSearch", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> workIlboTfDataSearch(	
			@RequestParam(required = false) String selectedDataParam){
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		
		JSONParser selectedParser = new JSONParser();
		Object selectedObj = new Object();
		JSONObject selectedViewObj = new JSONObject();
		
		try {
			//작업자, 시작, 종료 데이터
			selectedObj = selectedParser.parse(selectedDataParam);
			selectedViewObj = (JSONObject)selectedObj;
			
			String danch_barcode = selectedViewObj.get("danch_barcode").toString();
			
			WorkJisiTk w = new WorkJisiTk();
			w.setDanch_barcode(danch_barcode);
			
			List<WorkJisiTk> wList = workIlboService.workIlboTfDataSearch(w);
			
			rtnMap.put("data",wList);
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return rtnMap;
	}
	
	@RequestMapping(value = "/workilbo/tf/allList", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> workIlboTfAllList(
			@RequestParam(required=false) String s_sdate,
			@RequestParam(required=false) String s_edate,
			@RequestParam(required=false) String s_corp_name,
			@RequestParam(required=false) String s_prod_name,
			@RequestParam(required=false) String s_prod_no){			
		Map<String, Object> rtnMap = new HashMap<String, Object>();
				
		WorkJisiTk w = new WorkJisiTk();
		w.setSdate(s_sdate);
		w.setEdate(s_edate);
		w.setCorp_name(s_corp_name);
		w.setProd_name(s_prod_name);
		w.setProd_no(s_prod_no);
		
		List<WorkJisiTk> list = workIlboService.workIlboTfAllList(w);
		
		
		rtnMap.put("data",list);
		
		
//		logger.info("작업지시-단취 : {}","작업지시(단취) 데이터 조회 : "+w.getSdate()+"// "+w.getEdate());
		return rtnMap;	
	}

	//작업데이터 조회 후 모달표시
	@RequestMapping(value = "/workilbo/tf/dataUpdateList", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> workIlboTfDataUpdateList(
			@RequestParam(required = false) int ilbo_code,	
			@RequestParam(required = false) String ilbo_gubn,	
			@RequestParam(required = false) String ilbo_lot,
			@RequestParam(required = false) int ilbo_pc
		){
		Map<String, Object> rtnMap = new HashMap<String, Object>();
	
		WorkJisiTk w = new WorkJisiTk();
		w.setIlbo_code(ilbo_code);
		w.setIlbo_gubn(ilbo_gubn);
		w.setIlbo_lot(ilbo_lot);
		w.setIlbo_pc(ilbo_pc);
		
		List<WorkJisiTk> wList = workIlboService.workIlboTfDataUpdateList(w);
		
		rtnMap.put("data",wList);
	
		return rtnMap;
	}

	@RequestMapping(value = "/workilbo/tf/bcfList", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> workIlboTfBcfList(
			@RequestParam(required = false) String searchObjParam,
			@RequestParam(required = false) String tfSettingDataList	
		){
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		
		JSONParser listParser = new JSONParser();
		JSONParser searchParser = new JSONParser();		
		
		Object listObj = new Object();
		Object searchObj = new Object();
		
		JSONArray listJsonArray = new JSONArray();
		JSONObject searchViewObj = new JSONObject();
		JSONObject listJsonObject = new JSONObject();
		
		//리스트의 수주번호를 배열로
		List<Integer> ilboCodeList = null;		
		
		
		try {			
			//리스트 데이터
			listObj = listParser.parse(tfSettingDataList);
						
			if(listObj instanceof JSONArray) {
				listJsonArray = (JSONArray)listObj;
				ilboCodeList = new ArrayList<Integer>();
				
				for(Object lObj : listJsonArray) {
					if (lObj instanceof JSONObject) {
						listJsonObject = (JSONObject)lObj;
						ilboCodeList.add(Integer.parseInt(listJsonObject.get("ilbo_code").toString()));
	                    
	                }					
				}
			}
			
			//조회조건
			searchObj = searchParser.parse(searchObjParam);
			searchViewObj = (JSONObject)searchObj;
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		WorkJisiTk w = new WorkJisiTk();
		w.setCorp_name(ifNullStringReturn(searchViewObj.get("tf_bcf_cname")));
		w.setProd_name(ifNullStringReturn(searchViewObj.get("tf_bcf_pname")));
		w.setProd_no(ifNullStringReturn(searchViewObj.get("tf_bcf_pno")));
		w.setSdate(ifNullStringReturn(searchViewObj.get("tf_bcf_sdate")));
		w.setEdate(ifNullStringReturn(searchViewObj.get("tf_bcf_edate")));
		w.setSunipOrdList(ilboCodeList);
		
		List<WorkJisiTk> list = workIlboService.workIlboTfBcfList(w);		
		
		rtnMap.put("data",list);
		
		
		return rtnMap;	
	}

	@RequestMapping(value = "/workilbo/tf/bcfList/dataSetting", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> workIlboTfBcfListDataSetting(
			@RequestParam(required = false) String workTfBcfSelectDataParam,
			HttpServletRequest request
			){
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		
		
		JSONParser selectParser = new JSONParser();
		
		Object selectObj = new Object();
		
		JSONObject selectViewObj = new JSONObject();
				
		try {
			//선택 데이터
			selectObj = selectParser.parse(workTfBcfSelectDataParam);
			selectViewObj = (JSONObject)selectObj;
						
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		int ilbo_pc = Integer.parseInt(selectViewObj.get("ilbo_pc").toString());
		
		WorkJisiTk w = new WorkJisiTk();
		w.setIlbo_pc(ilbo_pc);
		
		List<WorkJisiTk> wList = workIlboService.workIlboTfBcfListDataSetting(w);
		
		rtnMap.put("data",wList);
		
		return rtnMap;	
	}

	
	//템퍼링데이터 저장
	@RequestMapping(value = "/workilbo/tf/dataSave", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> workIlboTfDataSave(	
			@RequestParam(required = false) String tfSettingDataList,
			@RequestParam(required = false) String formObjParam){
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		
		JSONParser listParser = new JSONParser();
		JSONParser formParser = new JSONParser();
		
		Object listObj = new Object();
		Object formObj = new Object();
		
		JSONArray listJsonArray = new JSONArray();
		JSONObject formViewObj = new JSONObject();
		JSONObject listJsonObject = new JSONObject();
		
		try {
			//리스트 데이터
			listObj = listParser.parse(tfSettingDataList);
			
			
			if(listObj instanceof JSONArray) {
				listJsonArray = (JSONArray)listObj;
				
				//작업자, 시작, 종료 데이터
				formObj = formParser.parse(formObjParam);
				formViewObj = (JSONObject)formObj;			
					
				//일보코드 조회
				int ilbo_code = 0;
				int ilbo_code_search = workIlboService.getWorkIlboCodeSearch();				
				
				int fac_code = Integer.parseInt(ifNullStringReturn(formViewObj.get("fac_code")));
				int user_code = Integer.parseInt(ifNullStringReturn(formViewObj.get("user_code")));
				
				String ilbo_strt = ifNullStringReturn(formViewObj.get("ilbo_strt"));
				String ilbo_end = ifNullStringReturn(formViewObj.get("ilbo_end"));				
				String ilbo_g11 = ifNullStringReturn(formViewObj.get("ilbo_g11"));
				String ilbo_g12 = ifNullStringReturn(formViewObj.get("ilbo_g12"));
				String ilbo_pg1_si = ifNullStringReturn(formViewObj.get("ilbo_pg1_si"));
				String ilbo_pg2_si = ifNullStringReturn(formViewObj.get("ilbo_pg2_si"));
				String ilbo_pg3_si = ifNullStringReturn(formViewObj.get("ilbo_pg3_si"));
				String ilbo_pg4_si = ifNullStringReturn(formViewObj.get("ilbo_pg4_si"));
				String ilbo_pg5_si = ifNullStringReturn(formViewObj.get("ilbo_pg5_si"));
				String ilbo_okng_si = ifNullStringReturn(formViewObj.get("ilbo_okng_si"));
				String ilbo_pg1_sr = ifNullStringReturn(formViewObj.get("ilbo_pg1_sr"));
				String ilbo_pg2_sr = ifNullStringReturn(formViewObj.get("ilbo_pg2_sr"));
				String ilbo_pg3_sr = ifNullStringReturn(formViewObj.get("ilbo_pg3_sr"));
				String ilbo_pg4_sr = ifNullStringReturn(formViewObj.get("ilbo_pg4_sr"));
				String ilbo_pg5_sr = ifNullStringReturn(formViewObj.get("ilbo_pg5_sr"));
				String ilbo_okng_sr = ifNullStringReturn(formViewObj.get("ilbo_okng_sr"));

				
				
				
				int ilbo_no = 0;
				
				for(Object lObj : listJsonArray) {
					if (lObj instanceof JSONObject) {
						listJsonObject = (JSONObject)lObj;
						//listJsonObject.get("ord_code").toString()
	                    WorkJisiTk wSave = new WorkJisiTk();
	                    String ilbo_lot = ifNullStringReturn(listJsonObject.get("ilbo_lot"));                 
	                    String ilbo_cm = ifNullStringReturn(listJsonObject.get("ilbo_cm"));                 
	                    //ilbo_lot_yn_chk의 값이 1인지 0인지로 구분
	                    int ilbo_lot_yn_chk = Integer.parseInt(listJsonObject.get("ilbo_lot_yn_chk").toString());


	                    if("".equals(ilbo_cm)) {
	                    	ilbo_code = ilbo_code_search;
	                    }else {
	                    	ilbo_code = Integer.parseInt(listJsonObject.get("ilbo_code").toString());
	                    }
	                    
	                    int ilbo_pc = Integer.parseInt(listJsonObject.get("ilbo_pc").toString());
	                    
	                    wSave.setIlbo_code(ilbo_code);	   
	                    wSave.setIlbo_pc(ilbo_pc);
	                    wSave.setIlbo_pn(ilbo_no);
	                    
	                    wSave.setIlbo_lot(ilbo_lot);
	                    wSave.setIlbo_g11(ilbo_g11);
	                    wSave.setIlbo_g12(ilbo_g12);
	                    wSave.setIlbo_pg1_si(ilbo_pg1_si);
	                    wSave.setIlbo_pg2_si(ilbo_pg2_si);
	                    wSave.setIlbo_pg3_si(ilbo_pg3_si);
	                    wSave.setIlbo_pg4_si(ilbo_pg4_si);
	                    wSave.setIlbo_pg5_si(ilbo_pg5_si);
	                    wSave.setIlbo_okng_si(ilbo_okng_si);
	                    wSave.setIlbo_pg1_sr(ilbo_pg1_sr);
	                    wSave.setIlbo_pg2_sr(ilbo_pg2_sr);
	                    wSave.setIlbo_pg3_sr(ilbo_pg3_sr);
	                    wSave.setIlbo_pg4_sr(ilbo_pg4_sr);
	                    wSave.setIlbo_pg5_sr(ilbo_pg5_sr);
	                    wSave.setIlbo_okng_sr(ilbo_okng_sr);
	                    
	                    wSave.setUser_code(user_code);
	                    wSave.setFac_code(fac_code);
	                    wSave.setIlbo_strt(ilbo_strt);
	                    wSave.setIlbo_end(ilbo_end);
	                    wSave.setOrd_code(Integer.parseInt(listJsonObject.get("ord_code").toString()));
	                    wSave.setIlbo_no(ilbo_no);
	                    wSave.setIlbo_cm(ilbo_cm);
	                    wSave.setIlbo_gubn("R");
	                    wSave.setIlbo_su(Integer.parseInt(listJsonObject.get("ilbo_su").toString()));
	                    wSave.setIlbo_jung(Float.parseFloat(listJsonObject.get("ilbo_jung").toString()));
	                    
	                    workIlboService.workIlboTfDataSave(wSave);
	                    ilbo_no++;
	                }					
				}
			}
			
			rtnMap.put("data", "저장완료");
		}catch(Exception e) {
			e.printStackTrace();
		}
		return rtnMap;
	}



	//단취 공정이동식별표(수주번호별로 생성 후 병합하기)
	@RequestMapping(value = "workilbo/processOrderPrint", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> workIlboProcessOrderPrint(
			@RequestBody String selectedDataJson,
			HttpServletRequest request
			){
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		
		JSONParser selectParser = new JSONParser();
		
		JSONObject selectViewObj = new JSONObject();
		JSONArray selectViewArray = new JSONArray();
		WorkJisiTk w = new WorkJisiTk();
				
		try {
			//선택 데이터
			selectViewObj = (JSONObject)selectParser.parse(selectedDataJson);
			selectViewArray = (JSONArray)selectViewObj.get("processOrderData");
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		List<Integer> ilboCodeList = new ArrayList<Integer>();
		
		//선택한 행의 수만큼 반복
		for(int i=0; i<selectViewArray.size(); i++) {
			JSONObject rowObj = (JSONObject)selectViewArray.get(i);
			ilboCodeList.add(Integer.parseInt(rowObj.get("ilbo_code").toString()));
		}
		
		w.setIlboCodeList(ilboCodeList);
		
		//일보코드별 수주번호 리스트
		List<WorkJisiTk> wData = workIlboService.workIlboProcessOrderPrintOrdcodeList(w);
		
		String abPath = request.getServletContext().getRealPath("/WEB-INF/resources/reports/processorder.jrxml");
		
		if(!wData.isEmpty()) {
			String fileName = "";
			String mergeFileName = "";
			//PDF파일병합 추가
			PDFMergerUtility merge = new PDFMergerUtility();
			
			for(WorkJisiTk wRow : wData) {
				fileName = wRow.getIlbo_code()+"_"+wRow.getOrd_code();
				mergeFileName = wRow.getIlbo_code()+"";
				try {
					JRBeanCollectionDataSource dataSource = new JRBeanCollectionDataSource(wData);
					
					JasperReportsContext jasperReportsContext = new SimpleJasperReportsContext();
					JasperCompileManager compileManager = JasperCompileManager.getInstance(jasperReportsContext);
					JasperReport report = JasperCompileManager.compileReport(abPath);
					
					Map<String, Object> reportMap = new HashMap<String, Object>();
					reportMap.put("workJisiTk", wRow);
					
					
					JasperFillManager fillManager = JasperFillManager.getInstance(jasperReportsContext);
					
					JasperPrint jasperPrint = JasperFillManager.fillReport(report, reportMap, dataSource);
					
					JasperExportManager exportManager = JasperExportManager.getInstance(jasperReportsContext); 
					JasperExportManager.exportReportToPdfFile(jasperPrint,"D:/태경출력파일/공정이동표/"+fileName+".pdf");			
				
					merge.addSource("D:/태경출력파일/공정이동표/"+fileName+".pdf");
					
				}catch(Exception e) {
					e.printStackTrace();
				}

				merge.setDestinationFileName("D:/태경출력파일/공정이동표/"+mergeFileName+".pdf");
				try {
					merge.mergeDocuments(MemoryUsageSetting.setupTempFileOnly());
					
				} catch (IOException e) {
					e.printStackTrace();
				}
				
			}
			rtnMap.put("fileName",mergeFileName+".pdf");
		}
		
		return rtnMap;	
	}

	
	//열처리,템퍼링 체크시트
	@RequestMapping(value = "workilbo/checkSheetPrint", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> workIlboCheckSeetPrint(
			@RequestBody String selectedDataJson,
			HttpServletRequest request
			){
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		
		JSONParser selectParser = new JSONParser();
		
		JSONObject selectViewObj = new JSONObject();
		JSONArray selectViewArray = new JSONArray();
		WorkJisiTk w = new WorkJisiTk();
				
		try {
			//선택 데이터
			selectViewObj = (JSONObject)selectParser.parse(selectedDataJson);
			selectViewArray = (JSONArray)selectViewObj.get("checkSheetData");
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		String ilbo_lot = "";
		
		//선택한 행의 수만큼 반복
		for(int i=0; i<selectViewArray.size(); i++) {
			JSONObject rowObj = (JSONObject)selectViewArray.get(i);
			ilbo_lot = rowObj.get("ilbo_lot").toString();
		}
		
		
		w.setIlbo_lot(ilbo_lot);
		
		//기준정보
		WorkJisiTk wStd = workIlboService.workIlboCheckSeetPrintStd(w);
		//작업로트별 수주번호 리스트
		List<WorkJisiTk> wData = workIlboService.workIlboCheckSeetPrintOrdcodeList(w);
		
		String abPath = request.getServletContext().getRealPath("/WEB-INF/resources/reports/workheat.jrxml");
		String fileName = ilbo_lot;
		
		try {
			JRBeanCollectionDataSource dataSource = new JRBeanCollectionDataSource(wData);
			
			JasperReportsContext jasperReportsContext = new SimpleJasperReportsContext();
			JasperCompileManager compileManager = JasperCompileManager.getInstance(jasperReportsContext);
			JasperReport report = JasperCompileManager.compileReport(abPath);
			
			Map<String, Object> reportMap = new HashMap<String, Object>();
			reportMap.put("workJisiTk", wStd);
			reportMap.put("workJisiTkList", wData);
			
			
			JasperFillManager fillManager = JasperFillManager.getInstance(jasperReportsContext);
			
			JasperPrint jasperPrint = JasperFillManager.fillReport(report, reportMap, dataSource);
			
			JasperExportManager exportManager = JasperExportManager.getInstance(jasperReportsContext); 
			JasperExportManager.exportReportToPdfFile(jasperPrint,"D:/태경출력파일/체크시트/"+fileName+".pdf");			
		
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		rtnMap.put("fileName",fileName+".pdf");
		
		return rtnMap;	
	}
	
	//07.최종검사
	
	//08.방청
	
	//09.포장
}
