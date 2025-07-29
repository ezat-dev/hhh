package com.tkheat.dao;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.tkheat.domain.Chulgo;
import com.tkheat.domain.Ipgo;
import com.tkheat.domain.Siljuk;
import com.tkheat.domain.Users;
import com.tkheat.domain.Work;

@Repository
public class OperationDaoImpl implements OperationDao{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<Ipgo> getPIpgoStatusList(Ipgo ipgo) {
		return sqlSession.selectList("ipgo.getPIpgoStatusList",ipgo);
	}
	
	@Override
	public List<Ipgo> getCuIpgoStatusList(Ipgo ipgo) {
		return sqlSession.selectList("ipgo.getCuIpgoStatusList",ipgo);
	}
	
	@Override
	public List<Chulgo> getPChulgoStatusList(Chulgo chulgo) {
		return sqlSession.selectList("chulgo.getPChulgoStatusList",chulgo);
	}
	
	@Override
	public List<Chulgo> getCuChulgoStatusList(Chulgo chulgo) {
		return sqlSession.selectList("chulgo.getCuChulgoStatusList",chulgo);
	}
	
	@Override
	public List<Siljuk> getProdSiljukList(Siljuk siljuk) {
		return sqlSession.selectList("siljuk.getProdSiljukList",siljuk);
	}
	
	@Override
	public List<Siljuk> getFacSiljukList(Siljuk siljuk) {
		return sqlSession.selectList("siljuk.getFacSiljukList",siljuk);
	}
	
	@Override
	public List<Users> getNoticeList() {
		return sqlSession.selectList("users.getNoticeList");
	}
	
	@Override
	public List<Chulgo> getYearSaleList(Chulgo chulgo) {
		return sqlSession.selectList("chulgo.getYearSaleList",chulgo);
	}
	
	@Override
	public List<Chulgo> getYearData(Chulgo chulgo) {
		return sqlSession.selectList("chulgo.getYearData",chulgo);
	}
	
	@Override
	public List<Chulgo> getMonthSaleList(Chulgo chulgo) {
		return sqlSession.selectList("chulgo.getMonthSaleList",chulgo);
	}
	
	
	
	
	
	
	@Override
	public List<Work> getMonthBulList(Work work) {
		return sqlSession.selectList("work.getMonthBulList",work);
	}
	
	@Override
	public List<Work> getMonthBulSubList(Work work) {
		return sqlSession.selectList("work.getMonthBulSubList",work);
	}
	
	@Override
	public List<Work> getMonthBulChartData(Work work) {
		return sqlSession.selectList("work.getMonthBulChartData",work);
	}
	
	
	
	
	
	
	
	
	@Override
	public List<Work> getCuMonthBulList(Work work) {
		return sqlSession.selectList("work.getCuMonthBulList",work);
	}
	
	@Override
	public List<Work> getCuBulSubList(Work work) {
		return sqlSession.selectList("work.getCuBulSubList",work);
	}
	
	
	
	
	
	
	
	
	
	
	

}
