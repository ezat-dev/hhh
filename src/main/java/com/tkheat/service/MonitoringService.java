package com.tkheat.service;

import java.util.List;
import java.util.concurrent.ExecutionException;

import com.tkheat.domain.AlarmHistory;
import com.tkheat.domain.AlarmRanking;
import com.tkheat.domain.Monitoring;
import com.tkheat.domain.WorkJisi;

public interface MonitoringService {

	
	List<Monitoring> getMonitoringList();
	
	List<Monitoring> gettrend(Monitoring monitoring);
	
	List<WorkJisi> getMonitoringDataList();
	
	List<AlarmHistory> alarmHistory1(AlarmHistory alarmHistory);
	
	List<AlarmRanking> alarmRanking1(AlarmRanking alarmRanking);
	
}
