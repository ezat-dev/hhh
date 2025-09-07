package com.tkheat.async;

import java.util.concurrent.ExecutionException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;

import com.tkheat.controller.MainController;
import com.tkheat.service.MonitoringServiceBcf4;


public class MonitoringProcessorBcf4 {

	@Autowired
	private MonitoringServiceBcf4 monitoringServiceBcf4;
	
	//1초주기로 OPC UA 커넥션이 null일경우 연결
	@Scheduled(fixedRate = 5000)
	public void handle() throws InterruptedException, ExecutionException {
		if(MainController.client != null) {
			monitoringServiceBcf4.getMonitoringDataCheck();
			monitoringServiceBcf4.getMonitoringProcessPreCheck();
			monitoringServiceBcf4.getMonitoringProcessChimCheck();
			monitoringServiceBcf4.getMonitoringProcessDiffCheck();
			monitoringServiceBcf4.getMonitoringProcessGangCheck();
			monitoringServiceBcf4.getMonitoringProcessColdCheck();
			monitoringServiceBcf4.getMonitoringProcessChulCheck();
		}
	}
}
