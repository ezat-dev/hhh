package com.tkheat.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tkheat.domain.WorkJisiTk;
import com.tkheat.service.WorkJisiServiceTk;

@Controller
public class WorkJisiTkController {

	@Autowired
	private WorkJisiServiceTk workJisiServiceTk;
	
	//1.작업지시NEW 화면이동
	@RequestMapping(value = "/production/workInstructionTk", method = RequestMethod.GET)
	public String workInstructionTkLoad() {
		return "/production/workInstructionTk.jsp";
	}	
	
	//2.작업지시 데이터 조회
	@RequestMapping(value = "/production/workInstructionTk/allList", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> workInstructionTkAllList(
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
		
		List<WorkJisiTk> list = workJisiServiceTk.workInstructionTkAllList(w);
		
		
		
		rtnMap.put("data",list);
		
		
		return rtnMap;	
	}
	
	//3-1.작업지시(단취) 데이터조회(입고이력 조회선택시)
	@RequestMapping(value = "/production/workInstructionTk/dan/ipgoList", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> workInstructionTkDanAllList(
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
		w.setSunipOrdList(danchSunipOrdList);
		
		List<WorkJisiTk> list = workJisiServiceTk.workInstructionTkDanIpgoList(w);		
		
		rtnMap.put("data",list);
		
		
		return rtnMap;	
	}

	//3-2단취작업 등록시 작업자리스트
	@RequestMapping(value = "/production/workInstructionTk/dan/ipgoList/userList", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> workInstructionTkDanUserList(){
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		
		WorkJisiTk w = new WorkJisiTk();
		
		List<WorkJisiTk> list = workJisiServiceTk.workInstructionTkDanUserList(w);
		
		
		
		rtnMap.put("data",list);
		
		
		return rtnMap;	
	}
	
	//3-3.입고리스트 선택시 단취리스트 데이터 이동
	@RequestMapping(value = "/production/workInstructionTk/dan/ipgoList/dataSetting", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> workInstructionTkDanIpgoListDataMove(
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
			if("3183".equals(danch_sunip_chk_pw)) {
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
			
			List<WorkJisiTk> sunipChkList = workJisiServiceTk.workInstructionTkDanSunipChk(w_sunip_chk);
			
//			calcMap = workInstructionTkDanIpgoListDataCalc(selectViewObj, listJsonArray, danchForm, stdCntOverChk);
			
			if(sunipChkList.size() > 0) {
				rtnMap.put("alert","선입된제품이 있습니다. 확인해주십시오!");	
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
		String prod_pg = selectViewObj.get("prod_pg").toString();					//소입경도
		String prod_gd = selectViewObj.get("prod_gd").toString();					//경화깊이
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
		selectWorkTmp.setProd_code(prod_code);		
		selectWorkTmp.setDanch_total_cnt(danch_total_cnt);
		selectWorkTmp.setIlbo_su(ilbo_su);
		selectWorkTmp.setIlbo_jung(ilbo_jung);
		
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
	
	//단취데이터 저장
	@RequestMapping(value = "/production/workInstructionTk/dan/dataSave", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> workInstructionTkDanDataSave(	
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
				int ilbo_code = workJisiServiceTk.getWorkIlboCodeSearch();
				int user_code = Integer.parseInt(ifNullStringReturn(formViewObj.get("user_code")));
				String ilbo_strt = ifNullStringReturn(formViewObj.get("ilbo_strt"));
				String ilbo_end = ifNullStringReturn(formViewObj.get("ilbo_end"));
				int ilbo_no = 0;
				for(Object lObj : listJsonArray) {
					if (lObj instanceof JSONObject) {
						listJsonObject = (JSONObject)lObj;
						//listJsonObject.get("ord_code").toString()
	                    WorkJisiTk wSave = new WorkJisiTk();
	                    
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
	                    
	                    workJisiServiceTk.workInstructionTkDanDataSave(wSave);
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
}
