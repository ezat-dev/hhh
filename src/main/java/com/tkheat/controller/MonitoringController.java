package com.tkheat.controller;


import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tkheat.domain.Monitoring;
import com.tkheat.domain.Temp;
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
	 
	//트렌드 - 데이터 조회
	@RequestMapping(value = "/monitoring/trend/list", method = RequestMethod.POST) 
	@ResponseBody 
	public Map<String, Object> getTrendList(
			@RequestParam String startDate,
			@RequestParam String endDate) {
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		Temp temp = new Temp();

		temp.setStartDate(startDate);
		temp.setEndDate(endDate);


		List<Temp> tempList = monitoringService.getTrendList(temp);

		List<Object> tdateList = new ArrayList<Object>();
		
		List<Object> bcf1CfList = new ArrayList<Object>();
		List<Object> bcf1OilList = new ArrayList<Object>();
		List<Object> bcf1CpList = new ArrayList<Object>();
		
		List<Object> bcf2CfList = new ArrayList<Object>();
		List<Object> bcf2OilList = new ArrayList<Object>();
		List<Object> bcf2CpList = new ArrayList<Object>();
		
		List<Object> bcf3CfList = new ArrayList<Object>();
		List<Object> bcf3OilList = new ArrayList<Object>();
		List<Object> bcf3CpList = new ArrayList<Object>();
		
		List<Object> bcf4CfList = new ArrayList<Object>();
		List<Object> bcf4OilList = new ArrayList<Object>();
		List<Object> bcf4CpList = new ArrayList<Object>();
		
		List<Object> bcf5CfList = new ArrayList<Object>();
		List<Object> bcf5OilList = new ArrayList<Object>();
		List<Object> bcf5CpList = new ArrayList<Object>();
		
		List<Object> tf1Zone1List = new ArrayList<Object>();
		List<Object> tf1Zone2List = new ArrayList<Object>();
		List<Object> tf1Zone3List = new ArrayList<Object>();
		
		for(Temp row : tempList) {
			tdateList.add(row.getUnixtime());
			
			List<Object> bcf1_cf = new ArrayList<Object>();
			bcf1_cf.add(row.getUnixtime());
			bcf1_cf.add(row.getBcf1_cf_pv());
			
			List<Object> bcf1_oil = new ArrayList<Object>();
			bcf1_oil.add(row.getUnixtime());
			bcf1_oil.add(row.getBcf1_oil_pv());
			
			List<Object> bcf1_cp = new ArrayList<Object>();
			bcf1_cp.add(row.getUnixtime());
			bcf1_cp.add(row.getBcf2_cp_pv());
			
			List<Object> bcf2_cf = new ArrayList<Object>();
			bcf2_cf.add(row.getUnixtime());
			bcf2_cf.add(row.getBcf2_cf_pv());
			
			List<Object> bcf2_oil = new ArrayList<Object>();
			bcf2_oil.add(row.getUnixtime());
			bcf2_oil.add(row.getBcf2_oil_pv());
			
			List<Object> bcf2_cp = new ArrayList<Object>();
			bcf2_cp.add(row.getUnixtime());
			bcf2_cp.add(row.getBcf2_cp_pv());
			
			List<Object> bcf3_cf = new ArrayList<Object>();
			bcf3_cf.add(row.getUnixtime());
			bcf3_cf.add(row.getBcf3_cf_pv());
			
			List<Object> bcf3_oil = new ArrayList<Object>();
			bcf3_oil.add(row.getUnixtime());
			bcf3_oil.add(row.getBcf3_oil_pv());
			
			List<Object> bcf3_cp = new ArrayList<Object>();
			bcf3_cp.add(row.getUnixtime());
			bcf3_cp.add(row.getBcf3_cp_pv());
			
			List<Object> bcf4_cf = new ArrayList<Object>();
			bcf4_cf.add(row.getUnixtime());
			bcf4_cf.add(row.getBcf4_cf_pv());
			
			List<Object> bcf4_oil = new ArrayList<Object>();
			bcf4_oil.add(row.getUnixtime());
			bcf4_oil.add(row.getBcf4_oil_pv());
			
			List<Object> bcf4_cp = new ArrayList<Object>();
			bcf4_cp.add(row.getUnixtime());
			bcf4_cp.add(row.getBcf4_cp_pv());
			
			List<Object> bcf5_cf = new ArrayList<Object>();
			bcf5_cf.add(row.getUnixtime());
			bcf5_cf.add(row.getBcf5_cf_pv());
			
			List<Object> bcf5_oil = new ArrayList<Object>();
			bcf5_oil.add(row.getUnixtime());
			bcf5_oil.add(row.getBcf5_oil_pv());
			
			List<Object> bcf5_cp = new ArrayList<Object>();
			bcf5_cp.add(row.getUnixtime());
			bcf5_cp.add(row.getBcf5_cp_pv());
			
			List<Object> tf1_zone1 = new ArrayList<Object>();
			tf1_zone1.add(row.getUnixtime());
			tf1_zone1.add(row.getTf1_zone1());
			
			List<Object> tf1_zone2 = new ArrayList<Object>();
			tf1_zone2.add(row.getUnixtime());
			tf1_zone2.add(row.getTf1_zone2());
			
			List<Object> tf1_zone3 = new ArrayList<Object>();
			tf1_zone3.add(row.getUnixtime());
			tf1_zone3.add(row.getTf1_zone3());
			
			bcf1CfList.add(bcf1_cf);
			bcf1OilList.add(bcf1_oil);
			bcf1CpList.add(bcf1_cp);
			
			bcf2CfList.add(bcf2_cf);
			bcf2OilList.add(bcf2_oil);
			bcf2CpList.add(bcf2_cp);
			
			bcf3CfList.add(bcf3_cf);
			bcf3OilList.add(bcf3_oil);
			bcf3CpList.add(bcf3_cp);
			
			bcf4CfList.add(bcf4_cf);
			bcf4OilList.add(bcf4_oil);
			bcf4CpList.add(bcf4_cp);
			
			bcf5CfList.add(bcf5_cf);
			bcf5OilList.add(bcf5_oil);
			bcf5CpList.add(bcf5_cp);
			
			tf1Zone1List.add(tf1_zone1);
			tf1Zone2List.add(tf1_zone2);
			tf1Zone3List.add(tf1_zone3);
		}
		
		Map<String, Object> bcf1CfMap = new HashMap<String, Object>();
		Map<String, Object> bcf1OilMap = new HashMap<String, Object>();
		Map<String, Object> bcf1CpMap = new HashMap<String, Object>();
		
		Map<String, Object> bcf2CfMap = new HashMap<String, Object>();
		Map<String, Object> bcf2OilMap = new HashMap<String, Object>();
		Map<String, Object> bcf2CpMap = new HashMap<String, Object>();
		
		Map<String, Object> bcf3CfMap = new HashMap<String, Object>();
		Map<String, Object> bcf3OilMap = new HashMap<String, Object>();
		Map<String, Object> bcf3CpMap = new HashMap<String, Object>();
		
		Map<String, Object> bcf4CfMap = new HashMap<String, Object>();
		Map<String, Object> bcf4OilMap = new HashMap<String, Object>();
		Map<String, Object> bcf4CpMap = new HashMap<String, Object>();
		
		Map<String, Object> bcf5CfMap = new HashMap<String, Object>();
		Map<String, Object> bcf5OilMap = new HashMap<String, Object>();
		Map<String, Object> bcf5CpMap = new HashMap<String, Object>();

		Map<String, Object> tf1Zone1Map = new HashMap<String, Object>();
		Map<String, Object> tf1Zone2Map = new HashMap<String, Object>();
		Map<String, Object> tf1Zone3Map = new HashMap<String, Object>();
		
		bcf1CfMap.put("name", "BCF1_CF_PV");
		bcf1CfMap.put("color", "#FF0000");
		bcf1CfMap.put("data", bcf1CfList);
		
		bcf1OilMap.put("name", "BCF1_OIL_PV");
		bcf1OilMap.put("color", "#997000");
		bcf1OilMap.put("data", bcf1OilList);
		
		bcf1CpMap.put("name", "BCF1_CP_PV");
		bcf1CpMap.put("color", "#000000");
		bcf1CpMap.put("data", bcf1CpList);
		
		bcf2CfMap.put("name", "BCF2_CF_PV");
		bcf2CfMap.put("color", "#FF0000");
		bcf2CfMap.put("data", bcf2CfList);
		
		bcf2OilMap.put("name", "BCF2_OIL_PV");
		bcf2OilMap.put("color", "#997000");
		bcf2OilMap.put("data", bcf2OilList);
		
		bcf2CpMap.put("name", "BCF2_CP_PV");
		bcf2CpMap.put("color", "#000000");
		bcf2CpMap.put("data", bcf2CpList);
		
		bcf3CfMap.put("name", "BCF3_CF_PV");
		bcf3CfMap.put("color", "#FF0000");
		bcf3CfMap.put("data", bcf3CfList);
		
		bcf3OilMap.put("name", "BCF3_OIL_PV");
		bcf3OilMap.put("color", "#997000");
		bcf3OilMap.put("data", bcf3OilList);
		
		bcf3CpMap.put("name", "BCF3_CP_PV");
		bcf3CpMap.put("color", "#000000");
		bcf3CpMap.put("data", bcf3CpList);
		
		bcf4CfMap.put("name", "BCF4_CF_PV");
		bcf4CfMap.put("color", "#FF0000");
		bcf4CfMap.put("data", bcf4CfList);
		
		bcf4OilMap.put("name", "BCF4_OIL_PV");
		bcf4OilMap.put("color", "#997000");
		bcf4OilMap.put("data", bcf4OilList);
		
		bcf4CpMap.put("name", "BCF4_CP_PV");
		bcf4CpMap.put("color", "#000000");
		bcf4CpMap.put("data", bcf4CpList);
		
		bcf5CfMap.put("name", "BCF5_CF_PV");
		bcf5CfMap.put("color", "#FF0000");
		bcf5CfMap.put("data", bcf5CfList);
		
		bcf5OilMap.put("name", "BCF5_OIL_PV");
		bcf5OilMap.put("color", "#997000");
		bcf5OilMap.put("data", bcf5OilList);
		
		bcf5CpMap.put("name", "BCF5_CP_PV");
		bcf5CpMap.put("color", "#000000");
		bcf5CpMap.put("data", bcf5CpList);
		
		tf1Zone1Map.put("name", "TF1_ZONE1");
		tf1Zone1Map.put("color", "#000000");
		tf1Zone1Map.put("data", tf1Zone1List);
		tf1Zone2Map.put("name", "TF1_ZONE2");
		tf1Zone2Map.put("color", "#F2CB61");
		tf1Zone2Map.put("data", tf1Zone2List);
		tf1Zone3Map.put("name", "TF1_ZONE3");
		tf1Zone3Map.put("color", "#8041D9");
		tf1Zone3Map.put("data", tf1Zone3List);
		
		rtnMap.put("tdatetime", tdateList);
		rtnMap.put("bcf1_cf_pv",bcf1CfMap);
		rtnMap.put("bcf1_oil_pv",bcf1OilMap);
		rtnMap.put("bcf1_cp_pv",bcf1CpMap);
		rtnMap.put("bcf2_cf_pv",bcf2CfMap);
		rtnMap.put("bcf2_oil_pv",bcf2OilMap);
		rtnMap.put("bcf2_cp_pv",bcf2CpMap);
		rtnMap.put("bcf3_cf_pv",bcf3CfMap);
		rtnMap.put("bcf3_oil_pv",bcf3OilMap);
		rtnMap.put("bcf3_cp_pv",bcf3CpMap);
		rtnMap.put("bcf4_cf_pv",bcf4CfMap);
		rtnMap.put("bcf4_oil_pv",bcf4OilMap);
		rtnMap.put("bcf4_cp_pv",bcf4CpMap);
		rtnMap.put("bcf5_cf_pv",bcf5CfMap);
		rtnMap.put("bcf5_oil_pv",bcf5OilMap);
		rtnMap.put("bcf5_cp_pv",bcf5CpMap);
		rtnMap.put("tf1_zone1", tf1Zone1Map);
		rtnMap.put("tf1_zone2", tf1Zone2Map);
		rtnMap.put("tf1_zone3", tf1Zone3Map);
		
		return rtnMap; 
	}
	 
	 
	 //알람이력 - 화면로드
	 @RequestMapping(value = "/monitoring/alarmHistory", method = RequestMethod.GET)
	 public String alarmHistory() {
		 return "/monitoring/alarmHistory.jsp";
	 }
	 //알람랭킹 - 화면로드
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

}
