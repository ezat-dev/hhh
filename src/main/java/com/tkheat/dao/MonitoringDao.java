package com.tkheat.dao;

import java.util.List;

import com.tkheat.domain.Monitoring;
import com.tkheat.domain.WorkJisi;

public interface MonitoringDao {

	List<Monitoring> getMonitoringList();
	
	List<Monitoring> gettrend(Monitoring monitoring);

	List<WorkJisi> getMonitoringData(WorkJisi w);

	WorkJisi getMonitoringDupChk(WorkJisi w);

	void setMonitoringDataSet(WorkJisi setWork);

	WorkJisi getMonitoringDataSpare(WorkJisi setWork);

	List<WorkJisi> getMonitoringDataList();

	void setMonitoringDataReSet(WorkJisi setWork);
}
