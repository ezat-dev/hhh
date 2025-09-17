package com.tkheat.dao;
import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.tkheat.domain.Product;
import com.tkheat.domain.Suip;
import com.tkheat.domain.Work;

@Repository
public class QualityDaoImpl implements QualityDao{

	@Resource(name="session")
	private SqlSession sqlSession;
	
	@Override
	public List<Suip> getSuipList(Suip suip) {
		return sqlSession.selectList("suip.getSuipList",suip);
	}
	
	@Override
	public Suip suipDetail(Suip suip) {
		return sqlSession.selectOne("suip.suipDetail",suip);
	}
	
	@Override
	 public void suipUdateSave(Suip suip) {
		 sqlSession.update("suip.suipUdateSave", suip);
	 }
	
	
	
	
	
	
	
	@Override public List<Work> getNonInsertList(Work work) { 
		return sqlSession.selectList("work.getNonInsertList",work); 
	}
	
	@Override public List<Work> getNonCorpList(Work work) { 
		return sqlSession.selectList("work.getNonCorpList",work); 
	}
	
	@Override
	public Work nonInsertDetail(Work work) {
		return sqlSession.selectOne("work.nonInsertDetail",work);
	}
	
	@Override
	 public void nonInsertSave(Work work) {
		 sqlSession.insert("work.nonInsertSave", work);
	 }
	
	@Override
	 public void nonUdateSave(Work work) {
		 sqlSession.update("work.nonUdateSave", work);
	 }
	
	@Override
	 public void deleteNon(Integer werr_code) {
		 sqlSession.delete("work.deleteNon", werr_code);
	 }
	
	
	
	
	
	
	 
	
	@Override
	public List<Work> getQueHardList(Work work) {
		return sqlSession.selectList("work.getQueHardList",work);
	}
	
	@Override
	public List<Work> getTemHardList(Work work) {
		return sqlSession.selectList("work.getTemHardList",work);
	}
	
	@Override
	public List<Work> getJajuStatusList(Work work) {
		return sqlSession.selectList("work.getJajuStatusList",work);
	}
	
	@Override
	public List<Work> getJajuJochiList(Work work) {
		return sqlSession.selectList("work.getJajuJochiList",work);
	}

	@Override
	public Suip cpkStandardList(Suip quality) {
		return sqlSession.selectOne("work.cpkStandardList",quality);
	}

	@Override
	public List<Suip> cpkValueList(Suip quality) {
		return sqlSession.selectList("work.cpkValueList",quality);
	}

	@Override
	public List<Product> xBarPumbunList(Product p) {
		return sqlSession.selectList("work.xBarPumbunList",p);
	}

}
