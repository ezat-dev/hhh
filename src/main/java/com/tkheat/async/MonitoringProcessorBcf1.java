package com.tkheat.async;

import java.util.concurrent.ExecutionException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;

import com.tkheat.controller.MainController;
import com.tkheat.service.MonitoringServiceBcf1;


public class MonitoringProcessorBcf1 {

	@Autowired
	private MonitoringServiceBcf1 monitoringServiceBcf1;
	
	//1초주기로 OPC UA 커넥션이 null일경우 연결
	@Scheduled(fixedRate = 5000)
	public void handle() throws InterruptedException, ExecutionException {
		if(MainController.client != null) {
			monitoringServiceBcf1.getMonitoringDataCheck();
			monitoringServiceBcf1.getMonitoringProcessPreCheck();
			monitoringServiceBcf1.getMonitoringProcessChimCheck();
			monitoringServiceBcf1.getMonitoringProcessDiffCheck();
			monitoringServiceBcf1.getMonitoringProcessGangCheck();
			monitoringServiceBcf1.getMonitoringProcessColdCheck();
			monitoringServiceBcf1.getMonitoringProcessChulCheck();
		}
	}
}
