package com.tkheat.service;


import java.util.List;
import java.util.Map;
import java.util.concurrent.ExecutionException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tkheat.dao.MonitoringDao;
import com.tkheat.domain.Monitoring;
import com.tkheat.domain.WorkJisi;
import com.tkheat.util.OpcDataMap;

@Service
public class MonitoringServiceImpl implements MonitoringService{

	@Autowired
	private MonitoringDao monitoringDao;
	
	private final Logger logger = LoggerFactory.getLogger(MonitoringServiceImpl.class);	
	
	 @Override
	    public List<Monitoring> getMonitoringList() {
	        return monitoringDao.getMonitoringList();
	    }
	
	 @Override
		public List<Monitoring > gettrend(Monitoring monitoring) {
		    return monitoringDao.gettrend(monitoring); 	   
		}


		@Override
		public List<WorkJisi> getMonitoringDataList() {
			return monitoringDao.getMonitoringDataList();
		}

}
