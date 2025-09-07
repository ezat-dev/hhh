package com.tkheat.async;

import java.util.concurrent.ExecutionException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;

import com.tkheat.controller.MainController;
import com.tkheat.service.MonitoringServiceBcf5;


public class MonitoringProcessorBcf5 {

	@Autowired
	private MonitoringServiceBcf5 monitoringServiceBcf5;
	
	//1초주기로 OPC UA 커넥션이 null일경우 연결
	@Scheduled(fixedRate = 5000)
	public void handle() throws InterruptedException, ExecutionException {
		if(MainController.client != null) {
			monitoringServiceBcf5.getMonitoringDataCheck();
			monitoringServiceBcf5.getMonitoringProcessPreCheck();
			monitoringServiceBcf5.getMonitoringProcessChimCheck();
			monitoringServiceBcf5.getMonitoringProcessDiffCheck();
			monitoringServiceBcf5.getMonitoringProcessGangCheck();
			monitoringServiceBcf5.getMonitoringProcessColdCheck();
			monitoringServiceBcf5.getMonitoringProcessChulCheck();
		}
	}
}
