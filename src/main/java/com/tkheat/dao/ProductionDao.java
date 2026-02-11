package com.tkheat.dao;

import java.util.List;

import com.tkheat.domain.Ipgo;
import com.tkheat.domain.Work;
import com.tkheat.domain.WorkJisiTk;

public interface ProductionDao {

	List<Work> getWorkInstructionList(Work work);
	
	List<Work> getWorkStatusList(Work work);
	
	
	
	
	List<Work> getNonReportList(Work work);
	
	Work nonReportDetail(Work work);
	
	List<Ipgo> getNonReportIpgoList(Ipgo ipgo);
	
	void nonReportInsertSave(Work work);
	
	void nonReportUpdateSave(Work work);
	
	void nonReportDelete(int werr_code);
	
	
	
	
	List<Work> getProdWaitingStatusList(Work work);

	List<Work> getWorkWaitList(Work work);

	void setWorkSetSave(Work work);

	Work getPlnpNo(Work works);

	Work getWorkPlnpSeq(Work work);

	List<Work> workInstructionReport(Work work);

	Work getWorkJBarcode(Work work);

	void setWorkJSave(Work work);
	
	
	
	
	List<Work> getLotIpgoList(Work work);
	
	List<Work> getLotIpgoReadyList(Integer ord_code);
	
	List<Work> getLotIpgoChimList(Integer ord_code);
	
	List<Work> getLotIpgoTemList(Integer ord_code);
	
	List<Work> getLotIpgoChulList(Integer ord_code);
	
	
	
	
	
	
	List<Work> getLotHeatList(Work work);
	
	List<Work> getLotHeatIpgoList(Integer ord_code);
	
	List<Work> getLotHeatJuckList(String ilbo_pc);
	
	List<Work> getLotHeatChimList(String ilbo_pc);
	
	
	
	List<WorkJisiTk> getLotList(WorkJisiTk workJisiTk);
	
	List<WorkJisiTk> getLotListReport(WorkJisiTk workJisiTk);
	
	
}
