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

	@Override
	public void workInstructionTkDataDelete(WorkJisiTk w) {
		workJisiDaoTk.workInstructionTkDataDelete(w);
	}

	@Override
	public List<WorkJisiTk> workInstructionTkDataUpdateList(WorkJisiTk w) {
		return workJisiDaoTk.workInstructionTkDataUpdateList(w);
	}

	@Override
	public List<WorkJisiTk> workInstructionTkDanIpgoBarcodeScan(WorkJisiTk w) {
		return workJisiDaoTk.workInstructionTkDanIpgoBarcodeScan(w);
	}

	@Override
	public List<WorkJisiTk> workInstructionTkBcfDataSearch(WorkJisiTk w) {
		return workJisiDaoTk.workInstructionTkBcfDataSearch(w);
	}

	@Override
	public List<WorkJisiTk> workInstructionTkBcfList(WorkJisiTk w) {
		return workJisiDaoTk.workInstructionTkBcfList(w);
	}

	@Override
	public String workInstructionBcfIlboLotRtn(WorkJisiTk w) {
		return workJisiDaoTk.workInstructionBcfIlboLotRtn(w);
	}

	@Override
	public void workInstructionTkBcfDataSave(WorkJisiTk wSave) {
		workJisiDaoTk.workInstructionTkBcfDataSave(wSave);
	}

	@Override
	public List<WorkJisiTk> workInstructionTkTfDataSearch(WorkJisiTk w) {
		return workJisiDaoTk.workInstructionTkTfDataSearch(w);
	}

	@Override
	public void workInstructionTkTfDataSave(WorkJisiTk wSave) {
		workJisiDaoTk.workInstructionTkTfDataSave(wSave);
	}

}
