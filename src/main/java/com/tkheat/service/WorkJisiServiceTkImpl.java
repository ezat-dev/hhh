package com.tkheat.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tkheat.dao.WorkJisiDaoTk;
import com.tkheat.domain.WorkJisi;
import com.tkheat.domain.WorkJisiTk;

@Service
public class WorkJisiServiceTkImpl implements WorkJisiServiceTk {

	@Autowired
	private WorkJisiDaoTk workJisiDaoTk;
	
	@Override
	public List<WorkJisiTk> workInstructionTkAllList(WorkJisiTk w) {
		return workJisiDaoTk.workInstructionTkAllList(w);
	}

	@Override
	public List<WorkJisiTk> workInstructionTkDanIpgoList(WorkJisiTk w) {
		return workJisiDaoTk.workInstructionTkDanIpgoList(w);
	}

	@Override
	public List<WorkJisiTk> workInstructionTkDanUserList(WorkJisiTk w) {
		return workJisiDaoTk.workInstructionTkDanUserList(w);
	}

	@Override
	public List<WorkJisiTk> workInstructionTkDanSunipChk(WorkJisiTk w_sunip_chk) {
		return workJisiDaoTk.workInstructionTkDanSunipChk(w_sunip_chk);
	}

	@Override
	public int getWorkIlboCodeSearch() {
		return workJisiDaoTk.getWorkIlboCodeSearch();
	}

	@Override
	public void workInstructionTkDanDataSave(WorkJisiTk wSave) {
		workJisiDaoTk.workInstructionTkDanDataSave(wSave);
	}

}
