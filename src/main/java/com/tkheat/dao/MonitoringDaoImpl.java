package com.tkheat.dao;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.tkheat.domain.AlarmHistory;
import com.tkheat.domain.AlarmRanking;
import com.tkheat.domain.Monitoring;
import com.tkheat.domain.WorkJisi;
import com.tkheat.domain.WorkJisiTk;

@Repository
public class MonitoringDaoImpl implements MonitoringDao {

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
        return sqlSession.selectOne("monitoring.getMonitoringDupChk", w);
    }

    @Override
    public void setMonitoringDataSet(WorkJisi setWork) {
        sqlSession.update("monitoring.setMonitoringDataSet", setWork);
    }

    @Override
    public WorkJisi getMonitoringDataSpare(WorkJisi setWork) {
        return sqlSession.selectOne("monitoring.getMonitoringDataSpare", setWork);
    }

    @Override
    public void setMonitoringDataReSet(WorkJisi setWork) {
        sqlSession.update("monitoring.setMonitoringDataReSet", setWork);
    }

    @Override
    public List<AlarmHistory> alarmHistory1(AlarmHistory alarmHistory) {
        return sqlSession.selectList("monitoring.alarmHistoryList", alarmHistory);
    }

    @Override
    public List<AlarmRanking> alarmRanking1(AlarmRanking alarmRanking) {
        return sqlSession.selectList("monitoring.alarmRankingList", alarmRanking);
    }

    @Override
    public List<Monitoring> getCurrentAlarmList() {
        return sqlSession.selectList("monitoring.getCurrentAlarmList");
    }
    
    @Override
    public List<WorkJisiTk> getMonitoringDataList() {
    	return sqlSession.selectList("monitoring.getMonitoringDataList");
    }
    
	@Override
	public List<WorkJisiTk> getMonitoringDataListStd(WorkJisiTk workJisiTk) {
		return sqlSession.selectList("monitoring.getMonitoringDataListStd",workJisiTk);
	}    
	
	@Override
	public Map<String, Object> getOverviewData() {
		return sqlSession.selectOne("monitoring.getOverviewData");
	}
	
	@Override
	public Map<String, Object> getCurrentAlarms() {
		return sqlSession.selectOne("monitoring.getCurrentAlarms");
	}
    
}
