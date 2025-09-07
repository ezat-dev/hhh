package com.tkheat.service;

import java.util.List;

import com.tkheat.domain.Chulgo;
import com.tkheat.domain.Ipgo;
import com.tkheat.domain.Siljuk;
import com.tkheat.domain.Users;
import com.tkheat.domain.Work;

public interface OperationService {
	
	List<Ipgo> getPIpgoStatusList(Ipgo ipgo);
	
	
	List<Ipgo> getCuIpgoStatusList(Ipgo ipgo);
	
	
	List<Chulgo> getPChulgoStatusList(Chulgo chulgo);
	
	
	List<Chulgo> getCuChulgoStatusList(Chulgo chulgo);
	
	
	List<Siljuk> getProdSiljukList(Siljuk siljuk);
	
	
	List<Siljuk> getFacSiljukList(Siljuk siljuk);
	
	
	List<Users> getNoticeList();
	
	
	
	
	List<Chulgo> getYearSaleList(Chulgo chulgo);
	
	List<Chulgo> getYearData(Chulgo chulgo);
	
	
	
	List<Chulgo> getMonthSaleList(Chulgo chulgo);
	
	List<Chulgo> getDaySaleList(Chulgo chulgo);
	
	
	
	
	List<Work> getMonthBulList(Work work);
	
	List<Work> getMonthBulSubList(Work work);
	
	List<Work> getMonthBulChartData(Work work);
	
	
	
	
	
	
	List<Work> getCuMonthBulList(Work work);
	
	List<Work> getCuBulSubList(Work work);
	
	
	
	

}
