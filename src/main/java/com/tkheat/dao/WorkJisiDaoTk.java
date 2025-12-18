package com.tkheat.dao;

import java.util.List;

import com.tkheat.domain.WorkJisi;
import com.tkheat.domain.WorkJisiTk;

public interface WorkJisiDaoTk {

	List<WorkJisiTk> workInstructionTkAllList(WorkJisiTk w);

	List<WorkJisiTk> workInstructionTkDanIpgoList(WorkJisiTk w);

	List<WorkJisiTk> workInstructionTkDanUserList(WorkJisiTk w);

	List<WorkJisiTk> workInstructionTkDanSunipChk(WorkJisiTk w);

	int getWorkIlboCodeSearch();

	void workInstructionTkDanDataSave(WorkJisiTk wSave);

	void workInstructionTkDataDelete(WorkJisiTk w);

	List<WorkJisiTk> workInstructionTkDataUpdateList(WorkJisiTk w);

	List<WorkJisiTk> workInstructionTkDanIpgoBarcodeScan(WorkJisiTk w);

	List<WorkJisiTk> workInstructionTkBcfDataSearch(WorkJisiTk w);

	List<WorkJisiTk> workInstructionTkBcfList(WorkJisiTk w);

	String workInstructionBcfIlboLotRtn(WorkJisiTk w);

	void workInstructionTkBcfDataSave(WorkJisiTk wSave);

}
