package com.tkheat.dao;

import java.util.List;

import com.tkheat.domain.Monitoring;
import com.tkheat.domain.Temp;

public interface MonitoringDao {

	List<Monitoring> getMonitoringList();

	List<Temp> getTrendList(Temp temp);

}
