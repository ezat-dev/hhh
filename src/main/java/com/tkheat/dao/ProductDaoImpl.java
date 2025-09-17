package com.tkheat.dao;

import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.tkheat.domain.Chulgo;
import com.tkheat.domain.Gongjung;
import com.tkheat.domain.Ipgo;
import com.tkheat.domain.Jaego;
import com.tkheat.domain.Product;
@Repository
public class ProductDaoImpl implements ProductDao {
	@Resource(name="session")
	 private SqlSession sqlSession;

	@Override
	 public List<Ipgo> getIpgoList(Ipgo ipgo) {
		 return sqlSession.selectList("ipgo.getIpgoList", ipgo);
	 }
	
	@Override
	 public List<Chulgo> getChulgoList(Chulgo chulgo) {
		 return sqlSession.selectList("chulgo.getChulgoList", chulgo);
	 }
	
	@Override
	 public List<Chulgo> getChulgoWaitingList(Chulgo chulgo) {
		 return sqlSession.selectList("chulgo.getChulgoWaitingList", chulgo);
	 }
	
	@Override
	 public List<Jaego> getJaegoStatusList(Jaego jaego) {
		 return sqlSession.selectList("jaego.getJaegoStatusList", jaego);
	 }
	
	@Override
	 public List<Jaego> getPJaegoStatusList(Jaego jaego) {
		 return sqlSession.selectList("jaego.getPJaegoStatusList", jaego);
	 }
	
	@Override
	 public List<Gongjung> getIpChulDeleteList(Gongjung gongjung) {
		 return sqlSession.selectList("gongjung.getIpChulDeleteList", gongjung);
	 }
	
	@Override
	 public List<Gongjung> getWorkStatusList(Gongjung gongjung) {
		 return sqlSession.selectList("gongjung.getWorkStatusList", gongjung);
	 }

	@Override
	public List<Ipgo> getIpgoAddList(Ipgo ipgo) {
		return sqlSession.selectList("ipgo.getIpgoAddList", ipgo);
	}

	@Override
	public int setIpgoAdd(Ipgo ipgo) {
		return sqlSession.insert("ipgo.setIpgoAdd", ipgo);
	}

	@Override
	public void setIpgoTest(Ipgo ipgo) {
		sqlSession.insert("ipgo.setIpgoTest", ipgo);
	}

	@Override
	public Product getProductData(Ipgo ipgo) {
		return sqlSession.selectOne("ipgo.getProductData",ipgo);
	}
	
}

