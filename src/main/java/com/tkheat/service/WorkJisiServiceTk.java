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

}
