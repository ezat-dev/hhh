package com.tkheat.service;

import java.util.List;
import java.util.Map;
import java.util.concurrent.ExecutionException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tkheat.dao.MonitoringDao;
import com.tkheat.domain.WorkJisi;
import com.tkheat.util.OpcDataMap;

@Service
public class MonitoringServiceBcf3Impl implements MonitoringServiceBcf3{

	boolean preVirt = true;		//예열
	boolean chimVirt = true;	//침탄
	boolean diffVirt = true;	//확산
	boolean gangVirt = true;	//강온
	boolean coldVirt = true;	//냉각
	boolean chulVirt = true;	//출구
	int qrHogi = 0;
	short shortResetValue = 0;
	int intResetValue = 0;
	long longResetValue = 0;
	
	@Autowired
	private MonitoringDao monitoringDao;	

	@Override
	public void getMonitoringDataCheck() throws InterruptedException, ExecutionException {
		
		OpcDataMap opcData = new OpcDataMap();
		StringBuffer desc = new StringBuffer();
//		long resetValue = 0;
		
		Map<String, Object> qrMap = opcData.getOpcData("TKHEAT.MODBUS.MONITORING.QR_BCF3");
		Map<String, Object> qrBuffMap = opcData.getOpcData("TKHEAT.MODBUS.MONITORING.QR_BUFF_BCF3");
		
		int qr = Integer.parseInt(qrMap.get("value").toString());
		int qrBuff = Integer.parseInt(qrBuffMap.get("value").toString());		

		Map<String, Object> preMap = opcData.getOpcData("TKHEAT.MODBUS.MONITORING.PRE_BCF3");		
		Map<String, Object> chimMap = opcData.getOpcData("TKHEAT.MODBUS.MONITORING.CHIM_BCF3");
		Map<String, Object> diffMap = opcData.getOpcData("TKHEAT.MODBUS.MONITORING.DIFF_BCF3");
		Map<String, Object> gangMap = opcData.getOpcData("TKHEAT.MODBUS.MONITORING.GANG_BCF3");
		Map<String, Object> coldMap = opcData.getOpcData("TKHEAT.MODBUS.MONITORING.COLD_BCF3");
		Map<String, Object> chulMap = opcData.getOpcData("TKHEAT.MODBUS.MONITORING.CHUL_BCF3");
		boolean pre = Boolean.parseBoolean(preMap.get("value").toString());
		boolean chim = Boolean.parseBoolean(chimMap.get("value").toString());
		boolean diff = Boolean.parseBoolean(diffMap.get("value").toString());
		boolean gang = Boolean.parseBoolean(gangMap.get("value").toString());
		boolean cold = Boolean.parseBoolean(coldMap.get("value").toString());
		boolean chul = Boolean.parseBoolean(chulMap.get("value").toString());

		WorkJisi w = new WorkJisi();
		
		//바코드버퍼의 값이 0이 아닐때
		if(qrBuff != 0) {
			//스캔한 바코드의 값이 적용할 호기와 일치할때만
			//불일치시 미적용
			if("1".equals((qrBuff+"").substring(6,7))){
				if(qr == 0) {
					//실 적용 바코드의 값이 0이면 버퍼의 값을 실제 적용 바코드로 값 쓰기.
					opcData.setOpcData("TKHEAT.MODBUS.MONITORING.WRITE_BUFF_BCF3", true);
				}				
			}else {
				//해당 호기가 아닐경우 값 리셋
				opcData.setOpcData("TKHEAT.MODBUS.MONITORING.RESET_BUFF_BCF3", true);
			}

		}

		Thread.sleep(300);

//		System.out.println("QR : "+qr+"// BUFF_QR : "+qrBuff+"// 출고변수 : "+chul+"// 출고 가상변수 : "+chulVirt);
		if(qr != 0) {
			//실 적용 바코드의 값이 0이 아니면 버퍼의 값은 유지
			//실 적용 바코드값으로 정보 매핑
			if(chul) {
				if(chulVirt) {
					//진행중인 제품이 출구에 위치해 있다면
					//공정정보 DB 업데이트
					WorkJisi www = new WorkJisi();
					www.setLot_qr(qr);
					List<WorkJisi> wList = monitoringDao.getMonitoringData(www);
					
//					System.out.println("출구만 신호 들어옴 : "+chul+"// : "+qr);
					
					WorkJisi setWork = new WorkJisi();
					setWork.setLot_qr(0);
					setWork.setHogi("BCF3");
					setWork.setCutum("");
					setWork.setPum("");
					setWork.setLot("");
					setWork.setPre("");
					setWork.setChim("");
					setWork.setDiff("");
					setWork.setGang("");
					setWork.setCold("");
					setWork.setChul("");
					//작업지시번호 기준 
					
					
					monitoringDao.setMonitoringDataReSet(setWork);
					
	//					chulVirt = false;
					boolean v1Chk = true;
					
					while(v1Chk) {
						if(qr != 0) {
							opcData.setOpcData("TKHEAT.MODBUS.MONITORING.RESET_BCF3",true);
							v1Chk = false;
						}
					}
					chulVirt = false;
				}
			}else {
				if(!pre && !chim 
						&& !diff && !gang && !cold) {
					//테이블에 중복되는 QR이 있는지 비교
					w.setHogi("BCF3");
					w.setLot_qr(qr);
					
					WorkJisi dupChk = monitoringDao.getMonitoringDupChk(w);
					
					//중복되는 QR이 없다면
					if(dupChk == null) {
						
						List<WorkJisi> wList = monitoringDao.getMonitoringData(w);
//						System.out.println("wListSize : "+wList.size());
						int hogi_idx = 1;
						for(WorkJisi ww : wList) {					
							WorkJisi setWork = new WorkJisi();
							setWork.setLot_qr(qr);
							setWork.setHogi("BCF3");
							setWork.setCutum(ww.getCorp_name());
							setWork.setPum(ww.getProd_name());
							setWork.setLot(ww.getJisi_lot_view());
							setWork.setHogi_idx(hogi_idx);
							setWork.setPre("");
							setWork.setChim("");
							setWork.setDiff("");
							setWork.setGang("");
							setWork.setCold("");	
							setWork.setChul("");
							//작업지시번호 기준 
							
							
							monitoringDao.setMonitoringDataSet(setWork);
							hogi_idx++;
						}

						Thread.sleep(100);
					}else{
						if(qr == qrBuff) {
							//중복되는 QR이 있는경우는 실 적용중인 QR외 버퍼에 동일한 QR이 등록된 상태로 버퍼의 QR 리셋
							opcData.setOpcData("TKHEAT.MODBUS.MONITORING.WRITE_BUFF_BCF3", true);
						}
					}
				}				
			}
		}
		
	}

	
	//구간별 이동(예열)
	public void getMonitoringProcessPreCheck() throws InterruptedException, ExecutionException {
		
		OpcDataMap opcData = new OpcDataMap();
		
		Map<String, Object> preMap = opcData.getOpcData("TKHEAT.MODBUS.MONITORING.PRE_BCF3");
		
		boolean pre = Boolean.parseBoolean(preMap.get("value").toString());
//		System.out.println("예열 : "+bcf2Pre);
		if(pre) {
//			if(preVirt) {
				chulVirt = true;	//예열구간 이동시 출구 가상변수 true
				//예열구간 표준정보 표현
				Map<String, Object> qrMap = opcData.getOpcData("TKHEAT.MODBUS.MONITORING.QR_BCF3");
				
				int qr = Integer.parseInt(qrMap.get("value").toString());
				
				if(qr != 0) {
					//공정정보 DB 업데이트
					WorkJisi w = new WorkJisi();
					w.setLot_qr(qr);
					List<WorkJisi> wList = monitoringDao.getMonitoringData(w);
					
					int hogi_idx = 1;
					for(WorkJisi ww : wList) {
						WorkJisi setWork = new WorkJisi();
						setWork.setLot_qr(qr);
						setWork.setHogi("BCF3");
						setWork.setCutum(ww.getCorp_name());
						setWork.setPum(ww.getProd_name());
						setWork.setLot(ww.getJisi_lot_view());
						setWork.setHogi_idx(hogi_idx);
						setWork.setPre(ww.getPre());
						setWork.setChim("");
						setWork.setDiff("");
						setWork.setGang("");
						setWork.setCold("");
						setWork.setChul("");
						//작업지시번호 기준 
						
						
						monitoringDao.setMonitoringDataSet(setWork);
						hogi_idx++;
					}					
					
//					preVirt = false;
//				}
			}
		}else {
			//예열구간 표준정보 표현초기화
//			preVirt = true;
		}

	}
	
	//구간별 이동(침탄)
	public void getMonitoringProcessChimCheck() throws InterruptedException, ExecutionException {
		
		OpcDataMap opcData = new OpcDataMap();
		
		Map<String, Object> chimMap = opcData.getOpcData("TKHEAT.MODBUS.MONITORING.CHIM_BCF3");
		
		boolean chim = Boolean.parseBoolean(chimMap.get("value").toString());
//		
		if(chim) {
//			if(chimVirt) {
				//침탄구간 표준정보 표현
				Map<String, Object> qrMap = opcData.getOpcData("TKHEAT.MODBUS.MONITORING.QR_BCF3");
				
				int qr = Integer.parseInt(qrMap.get("value").toString());
				
				if(qr != 0) {
					//공정정보 DB 업데이트
					WorkJisi w = new WorkJisi();
					w.setLot_qr(qr);
					List<WorkJisi> wList = monitoringDao.getMonitoringData(w);
					
					int hogi_idx = 1;
					for(WorkJisi ww : wList) {
						WorkJisi setWork = new WorkJisi();
						setWork.setLot_qr(qr);
						setWork.setHogi("BCF3");
						setWork.setCutum(ww.getCorp_name());
						setWork.setPum(ww.getProd_name());
						setWork.setLot(ww.getJisi_lot_view());
						setWork.setHogi_idx(hogi_idx);
						setWork.setPre("");
						setWork.setChim(ww.getChim());
						setWork.setDiff("");
						setWork.setGang("");
						setWork.setCold("");
						setWork.setChul("");
						//작업지시번호 기준 
						
						
						monitoringDao.setMonitoringDataSet(setWork);
						hogi_idx++;
					}					
					
//					chimVirt = false;
//				}
			}
		}else {
			//침탄구간 표준정보 표현초기화
//			chimVirt = true;
		}

	}

	//구간별 이동(확산)
	@Override
	public void getMonitoringProcessDiffCheck() throws InterruptedException, ExecutionException {
		
		OpcDataMap opcData = new OpcDataMap();
		
		Map<String, Object> diffMap = opcData.getOpcData("TKHEAT.MODBUS.MONITORING.DIFF_BCF3");
		
		boolean diff = Boolean.parseBoolean(diffMap.get("value").toString());
//		
		if(diff) {
//			if(chimVirt) {
				//침탄구간 표준정보 표현
				Map<String, Object> qrMap = opcData.getOpcData("TKHEAT.MODBUS.MONITORING.QR_BCF3");
				
				int qr = Integer.parseInt(qrMap.get("value").toString());
				
				if(qr != 0) {
					//공정정보 DB 업데이트
					WorkJisi w = new WorkJisi();
					w.setLot_qr(qr);
					List<WorkJisi> wList = monitoringDao.getMonitoringData(w);
					
					int hogi_idx = 1;
					for(WorkJisi ww : wList) {
						WorkJisi setWork = new WorkJisi();
						setWork.setLot_qr(qr);
						setWork.setHogi("BCF3");
						setWork.setCutum(ww.getCorp_name());
						setWork.setPum(ww.getProd_name());
						setWork.setLot(ww.getJisi_lot_view());
						setWork.setHogi_idx(hogi_idx);
						setWork.setPre("");
						setWork.setChim("");
						setWork.setDiff(ww.getDiff());
						setWork.setGang("");
						setWork.setCold("");
						setWork.setChul("");
						//작업지시번호 기준 
						
						
						monitoringDao.setMonitoringDataSet(setWork);
						hogi_idx++;
					}					
					
//					diffVirt = false;
//				}
			}
		}else {
			//확산구간 표준정보 표현초기화
//			diffVirt = true;
		}

	}

	//구간별 이동(강온)
	@Override
	public void getMonitoringProcessGangCheck() throws InterruptedException, ExecutionException {
		
		OpcDataMap opcData = new OpcDataMap();
		
		Map<String, Object> gangMap = opcData.getOpcData("TKHEAT.MODBUS.MONITORING.GANG_BCF3");
		
		boolean gang = Boolean.parseBoolean(gangMap.get("value").toString());
//		
		if(gang) {
//			if(gangVirt) {
				//침탄구간 표준정보 표현
				Map<String, Object> qrMap = opcData.getOpcData("TKHEAT.MODBUS.MONITORING.QR_BCF3");
				
				int qr = Integer.parseInt(qrMap.get("value").toString());
				
				if(qr != 0) {
					//공정정보 DB 업데이트
					WorkJisi w = new WorkJisi();
					w.setLot_qr(qr);
					List<WorkJisi> wList = monitoringDao.getMonitoringData(w);
					
					int hogi_idx = 1;
					for(WorkJisi ww : wList) {
						WorkJisi setWork = new WorkJisi();
						setWork.setLot_qr(qr);
						setWork.setHogi("BCF3");
						setWork.setCutum(ww.getCorp_name());
						setWork.setPum(ww.getProd_name());
						setWork.setLot(ww.getJisi_lot_view());
						setWork.setHogi_idx(hogi_idx);
						setWork.setPre("");
						setWork.setChim("");
						setWork.setDiff("");
						setWork.setGang(ww.getGang());
						setWork.setCold("");
						setWork.setChul("");
						//작업지시번호 기준 
						
						
						monitoringDao.setMonitoringDataSet(setWork);
						hogi_idx++;
					}					
					
//					gangVirt = false;
//				}
			}
		}else {
			//강온구간 표준정보 표현초기화
//			gangVirt = true;
		}

	}

	//구간별 이동(냉각)
	@Override
	public void getMonitoringProcessColdCheck() throws InterruptedException, ExecutionException {
		
		OpcDataMap opcData = new OpcDataMap();
		
		Map<String, Object> coldMap = opcData.getOpcData("TKHEAT.MODBUS.MONITORING.COLD_BCF3");
		
		boolean cold = Boolean.parseBoolean(coldMap.get("value").toString());
//		
		if(cold) {
//			if(coldVirt) {
				//침탄구간 표준정보 표현
				Map<String, Object> qrMap = opcData.getOpcData("TKHEAT.MODBUS.MONITORING.QR_BCF3");
				
				int qr = Integer.parseInt(qrMap.get("value").toString());
				
				if(qr != 0) {
					//공정정보 DB 업데이트
					WorkJisi w = new WorkJisi();
					w.setLot_qr(qr);
					List<WorkJisi> wList = monitoringDao.getMonitoringData(w);
					
					int hogi_idx = 1;
					for(WorkJisi ww : wList) {
						WorkJisi setWork = new WorkJisi();
						setWork.setLot_qr(qr);
						setWork.setHogi("BCF3");
						setWork.setCutum(ww.getCorp_name());
						setWork.setPum(ww.getProd_name());
						setWork.setLot(ww.getJisi_lot_view());
						setWork.setHogi_idx(hogi_idx);
						setWork.setPre("");
						setWork.setChim("");
						setWork.setDiff("");
						setWork.setGang("");
						setWork.setCold(ww.getCold());
						setWork.setChul("");
						//작업지시번호 기준 
						
						
						monitoringDao.setMonitoringDataSet(setWork);
						hogi_idx++;
					}					
					
//					coldVirt = false;
//				}
			}
		}else {
			//강온구간 표준정보 표현초기화
//			coldVirt = true;
		}

	}

	//구간별 이동(출구)
	@Override
	public void getMonitoringProcessChulCheck() throws InterruptedException, ExecutionException {
		
		OpcDataMap opcData = new OpcDataMap();
		
		Map<String, Object> chulMap = opcData.getOpcData("TKHEAT.MODBUS.MONITORING.CHUL_BCF3");
		
		
		boolean chul = Boolean.parseBoolean(chulMap.get("value").toString());
		System.out.println("출구 ON : "+chul);
		
		if(chul) {
//			if(chulVirt) {
				//침탄구간 표준정보 표현
				Map<String, Object> qrMap = opcData.getOpcData("TKHEAT.MODBUS.MONITORING.QR_BCF3");
				
				int qr = Integer.parseInt(qrMap.get("value").toString());
				System.out.println("출구 ON : "+qr);
				
				if(qr != 0) {
					//공정정보 DB 업데이트
					WorkJisi w = new WorkJisi();
					w.setLot_qr(qr);
					List<WorkJisi> wList = monitoringDao.getMonitoringData(w);
					
					
					int hogi_idx = 1;
					for(WorkJisi ww : wList) {
						WorkJisi setWork = new WorkJisi();
						setWork.setLot_qr(qr);
						setWork.setHogi("BCF3");
						setWork.setCutum("");
						setWork.setPum("");
						setWork.setLot("");
						setWork.setHogi_idx(hogi_idx);
						setWork.setPre("");
						setWork.setChim("");
						setWork.setDiff("");
						setWork.setGang("");
						setWork.setCold("");
						setWork.setChul("");
						//작업지시번호 기준 
						
						
						monitoringDao.setMonitoringDataSet(setWork);
						hogi_idx++;
					}					
					
//					chulVirt = false;
					boolean v1Chk = true;
					
					while(v1Chk) {
						if(qr != 0) {
							opcData.setOpcData("TKHEAT.MODBUS.MONITORING.RESET_BCF3",true);
							v1Chk = false;
						}
					}					
					
//				}
			}
		}else {
			//출구구간 표준정보 표현초기화
//			chulVirt = true;
		}

	}


	
	

	//출구이후 사용
	/*
	Map<String, Object> v1ChkMap = opcData.getOpcData("TKHEAT.MODBUS.MONITORING.QR_BCF3");
	int v1ChkVal = Integer.parseInt(v1ChkMap.get("value").toString());
	boolean v1Chk = true;
	
	while(v1Chk) {
		if(v1ChkVal != 0) {
			opcData.setOpcData("TKHEAT.MODBUS.MONITORING.RESET_BCF3",true);
			v1Chk = false;
		}
	}
	*/
}
