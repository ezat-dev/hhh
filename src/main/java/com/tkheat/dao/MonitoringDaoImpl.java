package com.tkheat.dao;

import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.tkheat.domain.Monitoring;
import com.tkheat.domain.WorkJisi;

@Repository
public class MonitoringDaoImpl implements MonitoringDao{

	@Resource(name="session")
	private SqlSession sqlSession;
	
	@Override
    public List<Monitoring> getMonitoringList() {
		return sqlSession.selectList("monitoring.getMonitoringList");
    }
	
	@Override
    public List<Monitoring> gettrend(Monitoring monitoring) { 
      return sqlSession.selectList("monitoring.gettrend", monitoring);
    }

	@Override
	public List<WorkJisi> getMonitoringData(WorkJisi w) {
		return sqlSession.selectList("monitoring.getMonitoringData", w);
	}

	@Override
	public WorkJisi getMonitoringDupChk(WorkJisi w) {
		return sqlSession.selectOne("monitoring.getMonitoringDupChk",w);
	}

	@Override
	public void setMonitoringDataSet(WorkJisi setWork) {
		sqlSession.update("monitoring.setMonitoringDataSet",setWork);
	}

	@Override
	public WorkJisi getMonitoringDataSpare(WorkJisi setWork) {
		return sqlSession.selectOne("monitoring.getMonitoringDataSpare",setWork);
	}

	@Override
	public List<WorkJisi> getMonitoringDataList() {
		return sqlSession.selectList("monitoring.getMonitoringDataList");
	}

	@Override
	public void setMonitoringDataReSet(WorkJisi setWork) {
		sqlSession.update("monitoring.setMonitoringDataReSet",setWork);
	}

}
