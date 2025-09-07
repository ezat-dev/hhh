package com.tkheat.controller;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tkheat.domain.Monitoring;
import com.tkheat.domain.WorkJisi;
import com.tkheat.service.MonitoringService;



@Controller
public class MonitoringController {
	
	@Autowired
	private MonitoringService monitoringService;
	

	 //통합모니터링 - 화면로드
	 @RequestMapping(value = "/monitoring/pumMonitoring", method = RequestMethod.GET)
	 public String pumMonitoring() {
		 return "/monitoring/pumMonitoring.jsp";
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
		 
		 List<WorkJisi> result = monitoringService.getMonitoringDataList();
		 
		 rtnMap.put("data",result);
		 
		 return rtnMap;
	 }
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 

}
