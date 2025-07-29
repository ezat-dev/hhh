package com.tkheat.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tkheat.dao.OperationDao;
import com.tkheat.domain.Chulgo;
import com.tkheat.domain.Ipgo;
import com.tkheat.domain.Siljuk;
import com.tkheat.domain.Users;
import com.tkheat.domain.Work;


@Service
public class OperationServiceImpl implements OperationService {
	
	@Autowired
	private OperationDao operationDao;
	
	@Override
	public List<Ipgo> getPIpgoStatusList(Ipgo ipgo){
		return operationDao.getPIpgoStatusList(ipgo);
	}
	
	@Override
	public List<Ipgo> getCuIpgoStatusList(Ipgo ipgo){
		return operationDao.getCuIpgoStatusList(ipgo);
	}
	
	@Override
	public List<Chulgo> getPChulgoStatusList(Chulgo chulgo){
		return operationDao.getPChulgoStatusList(chulgo);
	}
	
	@Override
	public List<Chulgo> getCuChulgoStatusList(Chulgo chulgo){
		return operationDao.getCuChulgoStatusList(chulgo);
	}
	
	@Override
	public List<Siljuk> getProdSiljukList(Siljuk siljuk){
		return operationDao.getProdSiljukList(siljuk);
	}
	
	@Override
	public List<Siljuk> getFacSiljukList(Siljuk siljuk){
		return operationDao.getFacSiljukList(siljuk);
	}
	
	@Override
	public List<Users> getNoticeList(){
		return operationDao.getNoticeList();
	}
	
	
	
	
	@Override
	public List<Chulgo> getYearSaleList(Chulgo chulgo){
		return operationDao.getYearSaleList(chulgo);
	}
	
	@Override
	public List<Chulgo> getYearData(Chulgo chulgo){
		return operationDao.getYearData(chulgo);
	}
	
	
	
	
	@Override
	public List<Chulgo> getMonthSaleList(Chulgo chulgo){
		return operationDao.getMonthSaleList(chulgo);
	}
	
	
	
	
	
	
	
	@Override
	public List<Work> getMonthBulList(Work work){
		return operationDao.getMonthBulList(work);
	}
	
	@Override
	public List<Work> getMonthBulSubList(Work work){
		return operationDao.getMonthBulSubList(work);
	}
	
	@Override
	public List<Work> getMonthBulChartData(Work work){
		return operationDao.getMonthBulChartData(work);
	}
	
	
	
	
	
	
	
	@Override
	public List<Work> getCuMonthBulList(Work work){
		return operationDao.getCuMonthBulList(work);
	}
	
	@Override
	public List<Work> getCuBulSubList(Work work){
		return operationDao.getCuBulSubList(work);
	}
	
	
	
	
	
	
	
	
	
	
	
	
}
