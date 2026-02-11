package com.tkheat.service;

import java.util.List;

import com.tkheat.domain.WorkJisi;
import com.tkheat.domain.WorkJisiTk;

public interface WorkJisiServiceTk {

	List<WorkJisiTk> workInstructionTkAllList(WorkJisiTk w);

	List<WorkJisiTk> workInstructionTkDanIpgoList(WorkJisiTk w);

	List<WorkJisiTk> workInstructionTkDanUserList(WorkJisiTk w);

	List<WorkJisiTk> workInstructionTkDanSunipChk(WorkJisiTk w_sunip_chk);

	int getWorkIlboCodeSearch();

	void workInstructionTkDanDataSave(WorkJisiTk wSave);

	void workInstructionTkDataDelete(WorkJisiTk w);

	List<WorkJisiTk> workInstructionTkDataUpdateList(WorkJisiTk w);

	List<WorkJisiTk> workInstructionTkDanIpgoBarcodeScan(WorkJisiTk w);

	List<WorkJisiTk> workInstructionTkBcfDataSearch(WorkJisiTk w);

	List<WorkJisiTk> workInstructionTkBcfList(WorkJisiTk w);

	String workInstructionBcfIlboLotRtn(WorkJisiTk w);

	void workInstructionTkBcfDataSave(WorkJisiTk wSave);

	List<WorkJisiTk> workInstructionTkTfDataSearch(WorkJisiTk w);

	void workInstructionTkTfDataSave(WorkJisiTk wSave);

}
