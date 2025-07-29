package com.tkheat.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tkheat.dao.ProcessDao;
import com.tkheat.domain.Siljuk;

@Service
public class ProcessServiceImpl implements ProcessService{
	
	@Autowired
	private ProcessDao processDao;
	
	@Override
	public List<Siljuk> getChimSiljukList(Siljuk siljuk) {
		return processDao.getChimSiljukList(siljuk);
	}
	
	@Override
	public List<Siljuk> getCleanSiljukList(Siljuk siljuk) {
		return processDao.getCleanSiljukList(siljuk);
	}
	
	@Override
	public List<Siljuk> getCleanRwSiljukList(Siljuk siljuk) {
		return processDao.getCleanRwSiljukList(siljuk);
	}
	
	@Override
	public List<Siljuk> getTemSiljukList(Siljuk siljuk) {
		return processDao.getTemSiljukList(siljuk);
	}
	
	@Override
	public List<Siljuk> getShortSiljukList(Siljuk siljuk) {
		return processDao.getShortSiljukList(siljuk);
	}
	
	@Override
	public List<Siljuk> getReadySiljukList(Siljuk siljuk) {
		return processDao.getReadySiljukList(siljuk);
	}
	
	@Override
	public void deleteSiljuk(Siljuk siljuk) {
		processDao.deleteSiljuk(siljuk);
	}
	
	@Override
	public List<Siljuk> getFacSiljukList(Siljuk siljuk) {
		return processDao.getFacSiljukList(siljuk);
	}

}
