package com.tkheat.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tkheat.dao.WorkJisiDao;
import com.tkheat.domain.Ipgo;
import com.tkheat.domain.Product;
import com.tkheat.domain.WorkJisi;

@Service
public class WorkJisiServiceImpl implements WorkJisiService{
	
	@Autowired
	private WorkJisiDao workJisiDao;
	
	@Override
	public List<WorkJisi> getIpgoList(WorkJisi ipgo){
		return workJisiDao.getIpgoList(ipgo);
	}

	@Override
	public List<WorkJisi> getIpgoAddList(WorkJisi ipgo) {
		return workJisiDao.getIpgoAddList(ipgo);
	}

	@Override
	public int setIpgoAdd(WorkJisi ipgo) {
		return workJisiDao.setIpgoAdd(ipgo);
	}

	@Override
	public void setIpgoTest(WorkJisi ipgo) {
		workJisiDao.setIpgoTest(ipgo);
	}

	@Override
	public Product getProductData(WorkJisi ipgo) {
		return workJisiDao.getProductData(ipgo);
	}

	@Override
	public List<Ipgo> ipgoListPrintBeforeHeat(WorkJisi ipgo) {
		return workJisiDao.ipgoListPrintBeforeHeat(ipgo);
	}

	@Override
	public List<Ipgo> ipgoListPrintAfterHeat(WorkJisi ipgo) {
		return workJisiDao.ipgoListPrintAfterHeat(ipgo);
	}

	@Override
	public List<Ipgo> ipgoListPrintManager(WorkJisi ipgo) {
		return workJisiDao.ipgoListPrintManager(ipgo);
	}

	@Override
	public List<WorkJisi> workJisiReadyIpgoList(WorkJisi w) {
		return workJisiDao.workJisiReadyIpgoList(w);
	}

	@Override
	public void setWorkJisiJSave(WorkJisi workJisi) {
		workJisiDao.setWorkJisiJSave(workJisi);
	}

	@Override
	public List<WorkJisi> workJisiHeatJisiList(WorkJisi w) {
		return workJisiDao.workJisiHeatJisiList(w);
	}

	@Override
	public List<WorkJisi> workJisiAllList(WorkJisi w) {
		return workJisiDao.workJisiAllList(w);
	}

	@Override
	public void setWorkJisiHSave(WorkJisi workJisi) {
		workJisiDao.setWorkJisiHSave(workJisi);
	}

	@Override
	public String getWorkJisiLot(WorkJisi ww) {
		return workJisiDao.getWorkJisiLot(ww);
	}

	@Override
	public List<WorkJisi> workHeatListPrint(WorkJisi w) {
		return workJisiDao.workHeatListPrint(w);
	}

	@Override
	public WorkJisi getProductionAllListDetailDanch(WorkJisi w) {
		return workJisiDao.getProductionAllListDetailDanch(w);
	}

	@Override
	public WorkJisi getProductionAllListDetailHeat(WorkJisi w) {
		return workJisiDao.getProductionAllListDetailHeat(w);
	}

	@Override
	public List<WorkJisi> workHeatListProcessPrint(WorkJisi w) {
		return workJisiDao.workHeatListProcessPrint(w);
	}

	@Override
	public void getIpgoListUpdate(WorkJisi w) {
		workJisiDao.getIpgoListUpdate(w);
	}

	@Override
	public List<WorkJisi> workJisiHeatIpgoList(WorkJisi w) {
		return workJisiDao.workJisiHeatIpgoList(w);
	}

	@Override
	public List<WorkJisi> getWorkJisiHeatIpgoListRegSunip(WorkJisi w) {
		return workJisiDao.getWorkJisiHeatIpgoListRegSunip(w);
	}

	@Override
	public List<WorkJisi> getWorkJisiHeatIpgoListRegList(WorkJisi w) {
		return workJisiDao.getWorkJisiHeatIpgoListRegList(w);
	}

	@Override
	public WorkJisi setWorkipgoBarcodeScan(WorkJisi w) {
		return workJisiDao.setWorkipgoBarcodeScan(w);
	}

	@Override
	public int getWorkJisiIlboCode(WorkJisi ww) {
		return workJisiDao.getWorkJisiIlboCode(ww);
	}

}
