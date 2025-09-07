package com.tkheat.service;

import java.util.List;
import java.util.concurrent.ExecutionException;

import com.tkheat.domain.Monitoring;
import com.tkheat.domain.WorkJisi;

public interface MonitoringService {

	
	List<Monitoring> getMonitoringList();
	
	List<Monitoring> gettrend(Monitoring monitoring);
	
	List<WorkJisi> getMonitoringDataList();
	
}
