package com.tkheat.service;

import java.util.concurrent.ExecutionException;

public interface MonitoringServiceBcf2 {
	
	//통합모니터링 데이터
	void getMonitoringDataCheck() throws InterruptedException, ExecutionException ;
	
	//구간별 체크(예열)
	void getMonitoringProcessPreCheck() throws InterruptedException, ExecutionException;
	
	//구간별 체크(침탄)
	void getMonitoringProcessChimCheck() throws InterruptedException, ExecutionException;
	
	//구간별 체크(확산)
	void getMonitoringProcessDiffCheck() throws InterruptedException, ExecutionException;
	
	//구간별 체크(강온)
	void getMonitoringProcessGangCheck() throws InterruptedException, ExecutionException;
	
	//구간별 체크(냉각)
	void getMonitoringProcessColdCheck() throws InterruptedException, ExecutionException;
	
	//구간별 체크(출구)
	void getMonitoringProcessChulCheck() throws InterruptedException, ExecutionException;

}
