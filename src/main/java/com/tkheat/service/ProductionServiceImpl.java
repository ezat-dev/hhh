package com.tkheat.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tkheat.dao.ProductionDao;
import com.tkheat.domain.Ipgo;
import com.tkheat.domain.Work;

@Service
public class ProductionServiceImpl implements ProductionService{

	@Autowired
	private ProductionDao productionDao;
	
	@Override
	public List<Work> getWorkInstructionList(Work work) {
		return productionDao.getWorkInstructionList(work);
	}
	
	@Override
	public List<Work> getWorkStatusList(Work work) {
		return productionDao.getWorkStatusList(work);
	}
	
	
	
	
	@Override
	public List<Work> getNonReportList(Work work) {
		return productionDao.getNonReportList(work);
	}
	
	@Override
	public Work nonReportDetail(Work work) {
		return productionDao.nonReportDetail(work);
	}
	
	@Override
	public List<Ipgo> getNonReportIpgoList(Ipgo ipgo){
		return productionDao.getNonReportIpgoList(ipgo);
	}
	
	@Override
	public void nonReportInsertSave(Work work) {
		productionDao.nonReportInsertSave(work);
	}
	
	@Override
	public void nonReportUpdateSave(Work work) {
		productionDao.nonReportUpdateSave(work);
	}
	
	@Override
	public void nonReportDelete(int werr_code) {
		productionDao.nonReportDelete(werr_code);
	}
	
	
	
	
	
	@Override
	public List<Work> getProdWaitingStatusList(Work work) {
		return productionDao.getProdWaitingStatusList(work);
	}

	@Override
	public List<Work> getWorkWaitList(Work work) {
		return productionDao.getWorkWaitList(work);
	}

	@Override
	public void setWorkSetSave(Work work) {
		productionDao.setWorkSetSave(work);
	}

	@Override
	public Work getPlnpNo(Work works) {
		return productionDao.getPlnpNo(works);
	}

	@Override
	public Work getWorkPlnpSeq(Work work) {
		return productionDao.getWorkPlnpSeq(work);
	}

	@Override
	public List<Work> workInstructionReport(Work work) {
		return productionDao.workInstructionReport(work);
	}

	@Override
	public Work getWorkJBarcode(Work work) {
		return productionDao.getWorkJBarcode(work);
	}

	@Override
	public void setWorkJSave(Work work) {
		productionDao.setWorkJSave(work);
	}
	
	
	
	
	
	
	
	@Override
	public List<Work> getLotIpgoList(Work work) {
		return productionDao.getLotIpgoList(work);
	}
	
	@Override
	public List<Work> getLotIpgoReadyList(Integer ord_code){
		return productionDao.getLotIpgoReadyList(ord_code);
	}
	
	@Override
	public List<Work> getLotIpgoChimList(Integer ord_code){
		return productionDao.getLotIpgoChimList(ord_code);
	}
	
	@Override
	public List<Work> getLotIpgoTemList(Integer ord_code){
		return productionDao.getLotIpgoTemList(ord_code);
	}
	
	@Override
	public List<Work> getLotIpgoChulList(Integer ord_code){
		return productionDao.getLotIpgoChulList(ord_code);
	}
	
	
	
	
	
	
	
	@Override
	public List<Work> getLotHeatList(Work work) {
		return productionDao.getLotHeatList(work);
	}
	
	@Override
	public List<Work> getLotHeatIpgoList(Integer ord_code){
		return productionDao.getLotHeatIpgoList(ord_code);
	}
	
	@Override
	public List<Work> getLotHeatJuckList(String ilbo_pc){
		return productionDao.getLotHeatJuckList(ilbo_pc);
	}
	
	@Override
	public List<Work> getLotHeatChimList(String ilbo_pc){
		return productionDao.getLotHeatChimList(ilbo_pc);
	}
	
	
	
	
	
	
	
	
	
}
