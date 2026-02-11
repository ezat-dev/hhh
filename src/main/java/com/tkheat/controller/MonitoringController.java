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
import com.tkheat.domain.WorkJisiTk;
import com.tkheat.service.MonitoringService;
import com.tkheat.util.OpcDataMap;



@Controller
public class MonitoringController {
	
	@Autowired
	private MonitoringService monitoringService;
	

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
			 
			 r.setBcf_pre_view("");
			 r.setBcf_chim_view("");
			 r.setBcf_diff_view("");
			 r.setBcf_gang_view("");
			 r.setBcf_cold_view("");
			 r.setTemp_view("");
			 
			 switch (result.get(i).getCol_name_view()) {
				 case "pre": r.setBcf_pre_view(result.get(i).getBcf_pre_view()); 
				 			 r.setTemp_view(result.get(i).getTemp_view());
				 break;
				 case "chim": r.setBcf_chim_view(result.get(i).getBcf_chim_view());
				 			  r.setTemp_view(result.get(i).getTemp_view());
				 break;
				 case "diff": r.setBcf_diff_view(result.get(i).getBcf_diff_view());
				 			  r.setTemp_view(result.get(i).getTemp_view());
				 break;
				 case "gang": r.setBcf_gang_view(result.get(i).getBcf_gang_view());
				 			  r.setTemp_view(result.get(i).getTemp_view());
				 break;
				 case "cold": r.setBcf_cold_view(result.get(i).getBcf_cold_view());
				 			  r.setTemp_view(result.get(i).getTemp_view());
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
	 
	 
	 
	 
	 
	 @RequestMapping(value = "/monitoring/getOverviewData", method = RequestMethod.POST)
	    @ResponseBody
	    public Map<String, Object> getOverviewData() {
	        return monitoringService.getOverviewData();
	    }
	 
	 
	 
	 
	 
	 
	 
	 
	 

}
