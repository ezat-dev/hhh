package com.tkheat.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tkheat.dao.WorkIlboDao;
import com.tkheat.domain.WorkJisiTk;

@Service
public class WorkIlboServiceImpl implements WorkIlboService{

	@Autowired
	private WorkIlboDao workIlboDao;

	@Override
	public void workIlboDataDelete(WorkJisiTk w) {
		workIlboDao.workIlboDataDelete(w);
	}
	@Override
	public List<WorkJisiTk> workIlboDanchAllList(WorkJisiTk w) {
		return workIlboDao.workIlboDanchAllList(w);
	}
	@Override
	public List<WorkJisiTk> workIlboDanchIpgoList(WorkJisiTk w) {
		return workIlboDao.workIlboDanchIpgoList(w);
	}
	@Override
	public List<WorkJisiTk> workIlboUserList(WorkJisiTk w) {
		return workIlboDao.workIlboUserList(w);
	}
	@Override
	public List<WorkJisiTk> workIlboDanchIpgoBarcodeScan(WorkJisiTk w) {
		return workIlboDao.workIlboDanchIpgoBarcodeScan(w);
	}
	@Override
	public List<WorkJisiTk> workIlboDanchIpgoListDataSetting(WorkJisiTk w) {
		return workIlboDao.workIlboDanchIpgoListDataSetting(w);
	}
	@Override
	public int getWorkIlboCodeSearch() {
		return workIlboDao.getWorkIlboCodeSearch();
	}
	@Override
	public void workIlboDanchDataSave(WorkJisiTk w) {
		workIlboDao.workIlboDanchDataSave(w);
	}
	@Override
	public List<WorkJisiTk> workIlboHeatAllList(WorkJisiTk w) {
		return workIlboDao.workIlboHeatAllList(w);
	}
	@Override
	public List<WorkJisiTk> workIlboHeatBcfDataSearch(WorkJisiTk w) {
		return workIlboDao.workIlboHeatBcfDataSearch(w);
	}
	@Override
	public List<WorkJisiTk> workIlboBcfList(WorkJisiTk w) {
		return workIlboDao.workIlboBcfList(w);
	}
	@Override
	public String workIlboHeatIlboLotRtn(WorkJisiTk w) {
		return workIlboDao.workIlboHeatIlboLotRtn(w);
	}
	@Override
	public void workIlboHeatDataSave(WorkJisiTk w) {
		workIlboDao.workIlboHeatDataSave(w);
	}
	@Override
	public List<WorkJisiTk> workIlboTfDataSearch(WorkJisiTk w) {
		return workIlboDao.workIlboTfDataSearch(w);
	}
	@Override
	public void workIlboTfDataSave(WorkJisiTk w) {
		workIlboDao.workIlboTfDataSave(w);
	}
	@Override
	public List<WorkJisiTk> workIlboTfAllList(WorkJisiTk w) {
		return workIlboDao.workIlboTfAllList(w);
	}
	@Override
	public List<WorkJisiTk> workIlboDanchDataUpdateList(WorkJisiTk w) {
		return workIlboDao.workIlboDanchDataUpdateList(w);
	}
	@Override
	public List<WorkJisiTk> workIlboHeatDataUpdateList(WorkJisiTk w) {
		return workIlboDao.workIlboHeatDataUpdateList(w);
	}
	@Override
	public List<WorkJisiTk> workIlboTfDataUpdateList(WorkJisiTk w) {
		return workIlboDao.workIlboTfDataUpdateList(w);
	}
	@Override
	public List<WorkJisiTk> workIlboBcfDanchList(WorkJisiTk w) {
		return workIlboDao.workIlboBcfDanchList(w);
	}
	@Override
	public List<WorkJisiTk> workIlboBcfDanchListDataSetting(WorkJisiTk w) {
		return workIlboDao.workIlboBcfDanchListDataSetting(w);
	}
	@Override
	public List<WorkJisiTk> workIlboTfBcfList(WorkJisiTk w) {
		return workIlboDao.workIlboTfBcfList(w);
	}
	@Override
	public List<WorkJisiTk> workIlboTfBcfListDataSetting(WorkJisiTk w) {
		return workIlboDao.workIlboTfBcfListDataSetting(w);
	}

}
