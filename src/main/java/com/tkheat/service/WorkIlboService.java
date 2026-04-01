package com.tkheat.service;

import java.util.List;

import com.tkheat.domain.WorkJisiTk;

public interface WorkIlboService {
	
	void workIlboDataDelete(WorkJisiTk w);

	List<WorkJisiTk> workIlboDanchAllList(WorkJisiTk w);

	List<WorkJisiTk> workIlboDanchIpgoList(WorkJisiTk w);

	List<WorkJisiTk> workIlboUserList(WorkJisiTk w);

	List<WorkJisiTk> workIlboDanchIpgoBarcodeScan(WorkJisiTk w);

	List<WorkJisiTk> workIlboDanchIpgoListDataSetting(WorkJisiTk w_sunip_chk);

	int getWorkIlboCodeSearch();

	void workIlboDanchDataSave(WorkJisiTk wSave);

	List<WorkJisiTk> workIlboHeatAllList(WorkJisiTk w);

	List<WorkJisiTk> workIlboBcfList(WorkJisiTk w);

	List<WorkJisiTk> workIlboHeatBcfDataSearch(WorkJisiTk w);
	
	String workIlboHeatIlboLotRtn(WorkJisiTk w);

	void workIlboHeatDataSave(WorkJisiTk w);

	List<WorkJisiTk> workIlboTfDataSearch(WorkJisiTk w);

	void workIlboTfDataSave(WorkJisiTk wSave);

	List<WorkJisiTk> workIlboTfAllList(WorkJisiTk w);

	List<WorkJisiTk> workIlboDanchDataUpdateList(WorkJisiTk w);
	
	List<WorkJisiTk> workIlboHeatDataUpdateList(WorkJisiTk w);
	
	List<WorkJisiTk> workIlboTfDataUpdateList(WorkJisiTk w);

	List<WorkJisiTk> workIlboBcfDanchList(WorkJisiTk w);

	List<WorkJisiTk> workIlboBcfDanchListDataSetting(WorkJisiTk w);

	List<WorkJisiTk> workIlboTfBcfList(WorkJisiTk w);

	List<WorkJisiTk> workIlboTfBcfListDataSetting(WorkJisiTk w);

	WorkJisiTk workIlboCheckSeetPrintStd(WorkJisiTk w);

	List<WorkJisiTk> workIlboCheckSeetPrintOrdcodeList(WorkJisiTk w);

	List<WorkJisiTk> workIlboProcessOrderPrintOrdcodeList(WorkJisiTk w);
}
