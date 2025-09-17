package com.tkheat.dao;

import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.tkheat.domain.Siljuk;


@Repository
public class ProcessDaoImpl implements ProcessDao {
	
	@Resource(name="session")
	 private SqlSession sqlSession;
	 
	 @Override
	 public List<Siljuk> getChimSiljukList(Siljuk siljuk) {
		 return sqlSession.selectList("siljuk.getChimSiljukList", siljuk);
	 }
	 
	 @Override
	 public List<Siljuk> getCleanSiljukList(Siljuk siljuk) {
		 return sqlSession.selectList("siljuk.getCleanSiljukList", siljuk);
	 }
	 
	 @Override
	 public List<Siljuk> getCleanRwSiljukList(Siljuk siljuk) {
		 return sqlSession.selectList("siljuk.getCleanRwSiljukList", siljuk);
	 }
	 
	 @Override
	 public List<Siljuk> getTemSiljukList(Siljuk siljuk) {
		 return sqlSession.selectList("siljuk.getTemSiljukList", siljuk);
	 }
	 
	 @Override
	 public List<Siljuk> getShortSiljukList(Siljuk siljuk) {
		 return sqlSession.selectList("siljuk.getShortSiljukList", siljuk);
	 }
	 
	 @Override
	 public List<Siljuk> getReadySiljukList(Siljuk siljuk) {
		 return sqlSession.selectList("siljuk.getReadySiljukList", siljuk);
	 }
	 
	 @Override
	 public void deleteSiljuk(Siljuk siljuk) {
		 sqlSession.delete("siljuk.deleteSiljuk", siljuk);
	 }
	 
	 @Override
	 public List<Siljuk> getFacSiljukList(Siljuk siljuk) {
		 return sqlSession.selectList("siljuk.getFacSiljukList", siljuk);
	 }

}
