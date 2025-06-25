package com.tkheat.service;

import java.util.List;

import com.tkheat.domain.Monitoring;
import com.tkheat.domain.Temp;

public interface MonitoringService {

	
	List<Monitoring> getMonitoringList();

	List<Temp> getTrendList(Temp temp);
	
}
