package com.tkheat.controller;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;
import java.util.concurrent.ExecutionException;

import javax.servlet.http.HttpSession;

import org.eclipse.milo.opcua.stack.core.UaException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tkheat.domain.AlarmHistory;
import com.tkheat.domain.AlarmRanking;
import com.tkheat.domain.Monitoring;
import com.tkheat.domain.Standard;
import com.tkheat.domain.WorkJisiTk;
import com.tkheat.service.ManagementService;
import com.tkheat.service.MonitoringService;
import com.tkheat.util.OpcDataMap;



@Controller
public class MonitoringController {

	@Autowired
	private MonitoringService monitoringService;

	@Autowired
	private ManagementService managementService;


	 //통합모니터링 - 화면로드
	 @RequestMapping(value = "/monitoring/pumMonitoring", method = RequestMethod.GET)
	 public String pumMonitoring() {
		 return "/monitoring/pumMonitoring.jsp";
	 }
	 
	//설비모니터링 - 화면로드
	 @RequestMapping(value = "/monitoring/overView", method = RequestMethod.GET)
	 public String overView() {
		 return "/monitoring/overView.jsp";
	 }

	//통합모니터링 - 화면로드
	@RequestMapping(value = "/monitoring/monitoring", method = RequestMethod.GET)
	public String monitoring() {
		return "/monitoring/monitoring.jsp";
	}
	 
	 //알람1 - 화면로드
	 @RequestMapping(value = "/monitoring/alarm1", method = RequestMethod.GET)
	 public String alarm1() {
		 return "/monitoring/alarm1.jsp";
	 }

	 //알람2 - 화면로드
	 @RequestMapping(value = "/monitoring/alarm2", method = RequestMethod.GET)
	 public String alarm2() {
		 return "/monitoring/alarm2.jsp";
	 }

	 //트렌드 - 화면로드
	 @RequestMapping(value = "/monitoring/trend", method = RequestMethod.GET)
	 public String trend() {
		 return "/monitoring/trend.jsp";
	 }

	 @RequestMapping(value = "/monitoring/trend2", method = RequestMethod.GET)
	 public String trend2() {
		 return "/monitoring/trend2.jsp";
	 }


	 
	 @RequestMapping(value = "/monitoring/currentAlarmList", method = RequestMethod.POST)
	 @ResponseBody
	 public Map<String, Object> getCurrentAlarmList() {

	     Map<String, Object> rtnMap = new HashMap<>();

	     List<Monitoring> alarmList = monitoringService.getCurrentAlarmList();

	     rtnMap.put("data", alarmList);
	     rtnMap.put("last_page", 1);

	     return rtnMap;
	 }	 
	
	 
	 
	 //2페이지알람
	 @RequestMapping(value = "/monitoring/alarm/alarmList2", method = RequestMethod.POST)
	 @ResponseBody
	 public Map<String, Object> alarmView2() throws UaException, InterruptedException, ExecutionException {
		 OpcDataMap opcDataMap = new OpcDataMap();
		 return opcDataMap.getOpcDataListMap("TKHEAT.MODBUS.ALARM");    
	 }
	 
	 
	 
	 
	 
	 //트렌드 - 화면로드
	 @RequestMapping(value = "/monitoring/alarmHistory", method = RequestMethod.GET)
	 public String alarmHistory() {
		 return "/monitoring/alarmHistory.jsp";
	 }
	 //트렌드 - 화면로드
	 @RequestMapping(value = "/monitoring/alarmRanking", method = RequestMethod.GET)
	 public String alarmRanking() {
		 return "/monitoring/alarmRanking.jsp";
	 }
	 

	 @RequestMapping(value = "/monitoring/getMonitoringList", method = RequestMethod.POST) 
	 @ResponseBody 
	 public Map<String, Object> getMonitoringList(HttpSession session) {
		 Map<String, Object> rtnMap = new HashMap<>();
		 List<Monitoring> list = monitoringService.getMonitoringList();
		 rtnMap.put("data", list);
		 return rtnMap;
	 }
	 
	 @RequestMapping(value = "/monitoring/trend/trendList", method = RequestMethod.POST)
	    @ResponseBody
	    public List<Monitoring> gettrend(Monitoring monitoring) {

		 String startDateStr = monitoring.getStartDate();
		 String endDateStr = monitoring.getEndDate();


		 DateTimeFormatter inputFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
		 DateTimeFormatter outputFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

		 LocalDateTime startDateTime = LocalDateTime.parse(startDateStr, inputFormatter);
		 LocalDateTime endDateTime = LocalDateTime.parse(endDateStr, inputFormatter);


		 monitoring.setStartDate(startDateTime.format(outputFormatter)); 
		 monitoring.setEndDate(endDateTime.format(outputFormatter));


		 List<Monitoring> result = monitoringService.gettrend(monitoring);

	        
	        
	        return result;
	    }
	 
	 

	 
	 //2025-08-18 추가
	 @RequestMapping(value = "/monitoring/monitoringDataList", method = RequestMethod.POST)
	 @ResponseBody
	 public Map<String, Object> getMonitoringDataList(){
		 Map<String, Object> rtnMap = new HashMap<String, Object>();
		 
		 List<WorkJisiTk> result = monitoringService.getMonitoringDataList();
		 
		 List<WorkJisiTk> rList = new ArrayList<WorkJisiTk>();
		
		 for(int i=0; i<result.size(); i++) {
			 
			 WorkJisiTk r = new WorkJisiTk();
			 
			 r.setFac_name_view(result.get(i).getFac_name_view());
			 r.setProc_gb_view(result.get(i).getProc_gb_view());
			 r.setIlbo_lot(result.get(i).getIlbo_lot());
			 //설비모니터링(overView.jsp)이 BCF1~5 설비명 박스 밑에 현재 생산중인 제품명을 표시할 때
			 //hogi_code/hogi_proc로 어느 설비의 "진행중" 행인지 매칭하는데, 이 두 값을 새 객체(r)에
			 //옮겨담지 않아서 응답에 항상 빠져있었음 - 그래서 그 매칭이 전부 실패해 제품명이 하나도
			 //안 뜨고 있었음
			 r.setHogi_code(result.get(i).getHogi_code());
			 r.setHogi_proc(result.get(i).getHogi_proc());

			 r.setBcf_up_view("");
			 r.setBcf_pre_view("");
			 r.setBcf_chim_view("");
			 r.setBcf_diff_view("");
			 r.setBcf_gang_view("");
			 r.setBcf_cold_view("");
			 //설비온도(temp_view)는 tb_temp(SCADA 실시간 센서값)에서 오는 값이라 tb_monitoring의
			 //공정단계 플래그(bcf_up/pre/...)와는 무관하게 항상 표시되어야 함 - 예전엔 switch 안에서만
			 //채워져서, 어떤 단계에도 안 걸리면(예: "승온" 단계처럼 case가 아예 없거나, PLC 태그 이슈로
			 //단계 플래그가 전부 0으로 굳어있는 경우) 실제로는 센서값이 살아있는데도 화면엔 설비온도까지
			 //덩달아 빈칸으로 나오던 원인이었음
			 r.setTemp_view(result.get(i).getTemp_view());

			 switch (result.get(i).getCol_name_view()) {
				 //"up"(승온) 단계가 switch에서 아예 빠져있었음 - v_monitoring의 col_name이 'up'으로
				 //오는 경우(현재 승온 중인 설비) bcf_up_view가 전혀 채워지지 않아 해당 설비는 승온
				 //단계인데도 "승온" 칸이 항상 빈칸으로 보였음
				 case "up": r.setBcf_up_view(result.get(i).getBcf_up_view());
				 break;
				 case "pre": r.setBcf_pre_view(result.get(i).getBcf_pre_view());
				 break;
				 case "chim": r.setBcf_chim_view(result.get(i).getBcf_chim_view());
				 break;
				 case "diff": r.setBcf_diff_view(result.get(i).getBcf_diff_view());
				 break;
				 case "gang": r.setBcf_gang_view(result.get(i).getBcf_gang_view());
				 break;
				 case "cold": r.setBcf_cold_view(result.get(i).getBcf_cold_view());
				 break;
			 }
/*			 
			 if(result.get(i).getBcf_pre() == 1) {
				 r.setBcf_pre_view(result.get(i).getBcf_pre_view());
			 }else {
				 r.setBcf_pre_view("");
			 }
*/			 
				 List<WorkJisiTk> tList = monitoringService.getMonitoringDataListStd(result.get(i));
//				 Set<String> cnameSet = new HashSet<String>();
//				 Set<String> pnameSet = new HashSet<String>();
				 Set<String> cnameSet = new TreeSet<String>();
				 Set<String> pnameSet = new TreeSet<String>();
				 
				 for(int j=0; j<tList.size(); j++) {
					 cnameSet.add(tList.get(j).getCorp_name());
					 pnameSet.add(tList.get(j).getProd_name());				 
				 }
				 
				 Iterator<String> cnameIte = cnameSet.iterator();
				 Iterator<String> pnameIte = pnameSet.iterator();
				 String cname = "";
				 String pname = "";
				 while(cnameIte.hasNext()) { cname += cnameIte.next()+";"; }
				 while(pnameIte.hasNext()) { pname += pnameIte.next()+";"; }
			 
			r.setCorp_name(cname);
			r.setProd_name(pname);
			rList.add(r);
		 }
		 
		 
		 
		 rtnMap.put("data",rList);
		 
		 return rtnMap;
	 }
	 
	 public String strLengthChkRtn(String strValue, int len) {
		 String rtnValue = strValue;
		 
		 if(strValue.length() > len) {
			 String v1 = strValue.substring(0,len);
			 String v2 = strValue.substring(len,strValue.length());
			 
			 rtnValue = v1+"</br>"+v2;
		 }
		 
		 return rtnValue;
	 }
	 
	 
	 @RequestMapping(value = "/monitoring/alarmHistory1", method = RequestMethod.POST)
	 @ResponseBody
	 public Map<String, Object> alarmHistory1(
	         @RequestParam(required = false) String sdateTime,
	         @RequestParam(required = false) String edateTime
	 ) {
	     Map<String, Object> rtnMap = new HashMap<>();

	     AlarmHistory alarmHistory = new AlarmHistory();
	     alarmHistory.setSdateTime(sdateTime);
	     alarmHistory.setEdateTime(edateTime);

	     List<AlarmHistory> rawList = monitoringService.alarmHistory1(alarmHistory);

	     
	     Map<String, AlarmHistory> alarmMap = new LinkedHashMap<>();

	     for (AlarmHistory event : rawList) {
	         String key = event.getA_comment() + "_" + event.getA_hogi();
	         AlarmHistory row;
	         Integer aValue = event.getA_value() != null ? event.getA_value() : 0;

	         if (!alarmMap.containsKey(key)) {
	             row = new AlarmHistory();
	             row.setRegtime(aValue == 1 ? event.getRegtime() : null);
	             row.setA_comment(event.getA_comment());
	             row.setA_hogi(event.getA_hogi());
	             row.setDisplayValue(aValue == 1 ? "경보발생" : "경보해제");
	             row.setReleaseTime(aValue == 0 ? event.getRegtime() : null);
	             alarmMap.put(key, row);
	         } else {
	             row = alarmMap.get(key);
	             if (aValue == 0) {
	                 row.setReleaseTime(event.getRegtime());
	                 row.setDisplayValue("경보해제");
	             }
	         }
	     }

	     List<AlarmHistory> resultList = new ArrayList<>(alarmMap.values());

	     rtnMap.put("last_page", 1);
	     rtnMap.put("data", resultList);

	     return rtnMap;
	 }

	 
	 
	 
	 @RequestMapping(value = "/monitoring/alarmRanking1", method = RequestMethod.POST)
	    @ResponseBody
	    public Map<String, Object> alarmRanking1(
	    		@RequestParam(required = false) String sdateTime,
	    		@RequestParam(required = false) String edateTime
	    		){
	    	Map<String, Object> rtnMap = new HashMap<String, Object>();
	    	
	    	AlarmRanking alarmRanking = new AlarmRanking();
	    	alarmRanking.setSdateTime(sdateTime);
	    	alarmRanking.setEdateTime(edateTime);
	    	
	    	
	    	List<AlarmRanking> alarmRankingList = monitoringService.alarmRanking1(alarmRanking);

	    	
	    	
	    	rtnMap.put("last_page",1);
	    	rtnMap.put("data", alarmRankingList);
	    	
	    	return rtnMap;
	    }
	 
	 
	 
	 
	 
	 //5호기(BCF5, FAC_CODE=18)는 스카다가 침탄/냉각/CP 설정값(SV) 3개를 못 주고 있어서(tb_overview_new에
	 //해당 컬럼 자체가 없음) - 차선책으로 5호기에서 지금 진행중인 제품의 침탄로작업표준(WORKSTD)에 등록된
	 //침탄온도/유조(냉각)온도/침탄CP 값을 대신 채워 넣음. 설정값 텍스트에 공차가 섞여 있을 수 있어(예:
	 //"900±5") 화면에 숫자로 바로 표시할 수 있도록 선행 숫자만 추출해서 내려줌
	 private static final int BCF5_FAC_CODE = 18;

	 @RequestMapping(value = "/monitoring/getOverviewData", method = RequestMethod.POST)
	    @ResponseBody
	    public Map<String, Object> getOverviewData() {
	        Map<String, Object> data = monitoringService.getOverviewData();
	        fillBcf5StdFallbackSv(data);
	        return data;
	    }

	 private void fillBcf5StdFallbackSv(Map<String, Object> data) {
		 if (data == null) {
			 return;
		 }
		 try {
			 String prodCode = monitoringService.getCurrentProdCodeByFacility(BCF5_FAC_CODE);
			 if (prodCode == null || prodCode.trim().isEmpty()) {
				 return;
			 }

			 Standard stdParam = new Standard();
			 stdParam.setProd_code(prodCode);
			 stdParam.setFac_code(BCF5_FAC_CODE);
			 Standard std = managementService.getProcessStandardForChart(stdParam);
			 if (std == null) {
				 return;
			 }

			 putLeadingNumberIfAbsent(data, "bcf_5_cf_sv", std.getWstd_gj12()); //침탄온도
			 putLeadingNumberIfAbsent(data, "bcf_5_qt_sv", std.getWstd_gj16()); //유조(냉각)온도
			 putLeadingNumberIfAbsent(data, "bcf_5_cp_sv", std.getWstd_gj32()); //침탄CP
		 } catch (Exception e) {
			 e.printStackTrace();
		 }
	 }

	 private void putLeadingNumberIfAbsent(Map<String, Object> data, String key, String rawValue) {
		 if (data.containsKey(key)) {
			 return; //스카다가 이미 값을 주고 있으면 그 값을 그대로 우선 사용
		 }
		 if (rawValue == null) {
			 return;
		 }
		 java.util.regex.Matcher m = java.util.regex.Pattern.compile("-?\\d+(\\.\\d+)?").matcher(rawValue);
		 if (m.find()) {
			 data.put(key, m.group());
		 }
	 }
	 
	 
	 @RequestMapping(value = "/monitoring/alarm/currentAlarms", method = RequestMethod.POST)
	 @ResponseBody
	 public Map<String, Object> getCurrentAlarms() {
	     return monitoringService.getCurrentAlarms();
	 }
	 
	 
	 
	 
	 
	 

}
