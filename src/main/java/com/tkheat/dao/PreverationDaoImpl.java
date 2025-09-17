package com.tkheat.dao;

import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.tkheat.domain.Bega;
import com.tkheat.domain.Jeomgeom;
import com.tkheat.domain.Measure;
import com.tkheat.domain.SparePart;
import com.tkheat.domain.Suri;
@Repository
public class PreverationDaoImpl implements PreservationDao {
	@Resource(name="session")
	 private SqlSession sqlSession;

	@Override
	 public List<SparePart> getSparePartList() {
		 return sqlSession.selectList("sparePart.getSparePartList");
	 }
	
	@Override
	 public List<SparePart> getSpareSubList(SparePart sparePart) {
		 return sqlSession.selectList("sparePart.getSpareSubList",sparePart);
	 }
	
	@Override
	public SparePart sparePartDetail(SparePart sparePart) {
		return sqlSession.selectOne("sparePart.sparePartDetail",sparePart);
	}
	
	@Override
	 public void sparePartInsertSave(SparePart sparePart) {
		 sqlSession.insert("sparePart.sparePartInsertSave", sparePart);
	 }
	
	@Override
	 public void sparePartUpdateSave(SparePart sparePart) {
		 sqlSession.update("sparePart.sparePartUpdateSave", sparePart);
	 }
	
	@Override
	 public void sparePartDelete(Integer spp_idx) {
		 sqlSession.delete("sparePart.sparePartDelete", spp_idx);
	 }
	
	@Override
	 public void insertSpareSub(SparePart sparePart) {
		 sqlSession.insert("sparePart.insertSpareSub", sparePart);
	 }
	
	@Override
	 public void updateSpareSub(SparePart sparePart) {
		 sqlSession.update("sparePart.updateSpareSub", sparePart);
	 }
	
	
	
	
	
	
	@Override
	 public List<Bega> getBegaInsertList(Bega bega) {
		 return sqlSession.selectList("bega.getBegaInsertList", bega);
	 }
	
	//비가동등록 더블클릭 조회
	@Override
	public Bega begaInsertDetail(Bega bega) {
		return sqlSession.selectOne("bega.begaInsertDetail",bega);
	}
	
	@Override
	 public void begaInsertSave(Bega bega) {
		 sqlSession.insert("bega.begaInsertSave", bega);
	 }
	
	@Override
	 public void begaUpdateSave(Bega bega) {
		 sqlSession.update("bega.begaUpdateSave", bega);
	 }
	
	@Override
	 public void begaDelete(int fstp_code) {
		 sqlSession.delete("bega.begaDelete", fstp_code);
	 }
	
	
	
	
	
	@Override
	 public List<Bega> getBegaAnalyList(Bega bega) {
		 return sqlSession.selectList("bega.getBegaAnalyList", bega);
	 }
	
	
	
	
	@Override
	 public List<Suri> getSuriHistoryList(Suri suri) {
		 return sqlSession.selectList("suri.getSuriHistoryList", suri);
	 }
	
	@Override
	public Suri suriHistoryDetail(Suri suri) {
		return sqlSession.selectOne("suri.suriHistoryDetail",suri);
	}
	
	@Override
	 public void suriHistoryInsertSave(Suri suri) {
		 sqlSession.insert("suri.suriHistoryInsertSave", suri);
	 }
	
	@Override
	 public void suriHistoryUpdateSave(Suri suri) {
		 sqlSession.update("suri.suriHistoryUpdateSave", suri);
	 }
	
	@Override
	 public void suriHistoryDelete(int ffx_no) {
		 sqlSession.delete("suri.suriHistoryDelete", ffx_no);
	 }
	
	
	
	
	
	
	
	@Override
	 public List<Jeomgeom> getJeomgeomInsertList() {
		 return sqlSession.selectList("jeomgeom.getJeomgeomInsertList");
	 }
	
	@Override
	public Jeomgeom jeomgeomInsertDetail(Jeomgeom jeomgeom) {
		return sqlSession.selectOne("jeomgeom.jeomgeomInsertDetail",jeomgeom);
	}
	
	@Override
	 public void jeomgeomInsertSave(Jeomgeom jeomgeom) {
		 sqlSession.insert("jeomgeom.jeomgeomInsertSave", jeomgeom);
	 }
	
	@Override
	 public void jeomgeomUpdateSave(Jeomgeom jeomgeom) {
		 sqlSession.update("jeomgeom.jeomgeomUpdateSave", jeomgeom);
	 }
	
	@Override
	 public void jeomgeomDelete(int chs_code) {
		 sqlSession.delete("jeomgeom.jeomgeomDelete", chs_code);
	 }
	
	
	
	
	
	@Override
    public List<Jeomgeom> getDayJeomgeomList(Jeomgeom jeomgeom) {
        return sqlSession.selectList("jeomgeom.getDayJeomgeomList", jeomgeom);
    }
	
	@Override
    public List<Jeomgeom> dayJeomgeomSubList(Jeomgeom jeomgeom) {
        return sqlSession.selectList("jeomgeom.dayJeomgeomSubList", jeomgeom);
    }
	
	
	@Override
    public List<Jeomgeom> getMonthJeomgeomList(Jeomgeom jeomgeom) {
        return sqlSession.selectList("jeomgeom.getMonthJeomgeomList", jeomgeom);
    }
	
	
	
	
	@Override
	 public List<Measure> getGigiGojangList(Measure measure) {
		 return sqlSession.selectList("measure.getGigiGojangList", measure);
	 }
	
	@Override
	public Measure gigiGojangtDetail(Measure measure) {
		return sqlSession.selectOne("bega.gigiGojangtDetail",measure);
	}
	
	@Override
	 public void gigiGojangInsert(Measure measure) {
		 sqlSession.insert("measure.gigiGojangInsert", measure);
	 }
	
	@Override
	 public void gigiGojangUdate(Measure measure) {
		 sqlSession.update("measure.gigiGojangUdate", measure);
	 }
	
	@Override
	 public void gigiGojangDelete(int terr_code) {
		 sqlSession.delete("measure.gigiGojangDelete", terr_code);
	 }
	
	
	
	
	
	@Override
	 public List<Measure> getGigiJeomgeomList(Measure measure) {
		 return sqlSession.selectList("measure.getGigiJeomgeomList", measure);
	 }
	
	@Override
	 public void gigiJeomgeomInsertSave(Measure measure) {
		 sqlSession.insert("measure.gigiJeomgeomInsertSave", measure);
	 }
	
	@Override
	 public void gigiJeomgeomUpdateSave(Measure measure) {
		 sqlSession.update("measure.gigiJeomgeomUpdateSave", measure);
	 }
	
	@Override
	 public void gigiJeomgeomDelete(int ter_code) {
		 sqlSession.delete("measure.gigiJeomgeomDelete", ter_code);
	 }
	
	
}

