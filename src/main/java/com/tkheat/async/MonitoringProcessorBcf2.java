package com.tkheat.async;

import java.util.concurrent.ExecutionException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;

import com.tkheat.controller.MainController;
import com.tkheat.service.MonitoringServiceBcf2;


public class MonitoringProcessorBcf2 {

	@Autowired
	private MonitoringServiceBcf2 monitoringServiceBcf2;
	
	//1초주기로 OPC UA 커넥션이 null일경우 연결
	@Scheduled(fixedRate = 5000)
	public void handle() throws InterruptedException, ExecutionException {
		if(MainController.client != null) {
			monitoringServiceBcf2.getMonitoringDataCheck();
			monitoringServiceBcf2.getMonitoringProcessPreCheck();
			monitoringServiceBcf2.getMonitoringProcessChimCheck();
			monitoringServiceBcf2.getMonitoringProcessDiffCheck();
			monitoringServiceBcf2.getMonitoringProcessGangCheck();
			monitoringServiceBcf2.getMonitoringProcessColdCheck();
			monitoringServiceBcf2.getMonitoringProcessChulCheck();
		}
	}
}
