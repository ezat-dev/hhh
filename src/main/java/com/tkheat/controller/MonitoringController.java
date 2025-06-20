package com.tkheat.controller;


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
	 
	 

		 @RequestMapping(value = "/monitoring/getMonitoringList", method = RequestMethod.POST) 
		 @ResponseBody 
		 public Map<String, Object> getMonitoringList(HttpSession session) {
			 Map<String, Object> rtnMap = new HashMap<>();
			    List<Monitoring> list = monitoringService.getMonitoringList();
			    rtnMap.put("data", list);
			    return rtnMap;
		 }

}
