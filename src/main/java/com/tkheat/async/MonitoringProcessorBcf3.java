package com.tkheat.async;

import java.util.concurrent.ExecutionException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;

import com.tkheat.controller.MainController;
import com.tkheat.service.MonitoringServiceBcf3;


public class MonitoringProcessorBcf3 {

	@Autowired
	private MonitoringServiceBcf3 monitoringServiceBcf3;
	
	//1초주기로 OPC UA 커넥션이 null일경우 연결
	@Scheduled(fixedRate = 5000)
	public void handle() throws InterruptedException, ExecutionException {
		if(MainController.client != null) {
			monitoringServiceBcf3.getMonitoringDataCheck();
			monitoringServiceBcf3.getMonitoringProcessPreCheck();
			monitoringServiceBcf3.getMonitoringProcessChimCheck();
			monitoringServiceBcf3.getMonitoringProcessDiffCheck();
			monitoringServiceBcf3.getMonitoringProcessGangCheck();
			monitoringServiceBcf3.getMonitoringProcessColdCheck();
			monitoringServiceBcf3.getMonitoringProcessChulCheck();
		}
	}
}
