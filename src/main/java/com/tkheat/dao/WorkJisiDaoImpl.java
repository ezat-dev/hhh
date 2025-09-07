package com.tkheat.dao;

import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.tkheat.domain.Ipgo;
import com.tkheat.domain.Product;
import com.tkheat.domain.WorkJisi;

@Repository
public class WorkJisiDaoImpl implements WorkJisiDao{

	@Resource(name="session")
	private SqlSession sqlSession;
	

	@Override
	 public List<WorkJisi> getIpgoList(WorkJisi ipgo) {
		 return sqlSession.selectList("workjisi.getIpgoList", ipgo);
	 }

	@Override
	public List<WorkJisi> getIpgoAddList(WorkJisi ipgo) {
		return sqlSession.selectList("workjisi.getIpgoAddList", ipgo);
	}

	@Override
	public int setIpgoAdd(WorkJisi ipgo) {
		return sqlSession.insert("workjisi.setIpgoAdd", ipgo);
	}

	@Override
	public void setIpgoTest(WorkJisi ipgo) {
		sqlSession.insert("workjisi.setIpgoTest", ipgo);
	}

	@Override
	public Product getProductData(WorkJisi ipgo) {
		return sqlSession.selectOne("workjisi.getProductData",ipgo);
	}

	@Override
	public List<Ipgo> ipgoListPrintBeforeHeat(WorkJisi ipgo) {
		return sqlSession.selectList("workjisi.ipgoListPrintBeforeHeat",ipgo);
	}

	@Override
	public List<Ipgo> ipgoListPrintAfterHeat(WorkJisi ipgo) {
		return sqlSession.selectList("workjisi.ipgoListPrintAfterHeat",ipgo);
	}

	@Override
	public List<Ipgo> ipgoListPrintManager(WorkJisi ipgo) {
		return sqlSession.selectList("workjisi.ipgoListPrintManager",ipgo);
	}


	@Override
	public List<WorkJisi> workJisiReadyIpgoList(WorkJisi w) {
		return sqlSession.selectList("workjisi.workJisiReadyIpgoList",w);
	}

	@Override
	public void setWorkJisiJSave(WorkJisi workJisi) {
		
//		WorkJisi rWork = sqlSession.selectOne("workjisi.setWorkJisiJSaveChk", workJisi);
/*		
		if(rWork == null) {
			workJisi.setQueryGb("I");	
		}else {
			workJisi.setQueryGb("U");
		}
*/		
		sqlSession.insert("workjisi.setWorkJisiJSave",workJisi);
		
	}

	@Override
	public List<WorkJisi> workJisiHeatJisiList(WorkJisi w) {
		return sqlSession.selectList("workjisi.workJisiHeatJisiList",w);
	}

	@Override
	public List<WorkJisi> workJisiAllList(WorkJisi w) {
		return sqlSession.selectList("workjisi.workJisiAllList",w);
	}

	@Override
	public void setWorkJisiHSave(WorkJisi workJisi) {
		sqlSession.insert("workjisi.setWorkJisiHSave",workJisi);
	}

	@Override
	public String getWorkJisiLot(WorkJisi ww) {
		return sqlSession.selectOne("workjisi.getWorkJisiLot",ww);
	}

	@Override
	public List<WorkJisi> workHeatListPrint(WorkJisi w) {
		return sqlSession.selectList("workjisi.workHeatListPrint",w);
	}

	@Override
	public WorkJisi getProductionAllListDetailDanch(WorkJisi w) {
		return sqlSession.selectOne("workjisi.getProductionAllListDetailDanch",w);
	}

	@Override
	public WorkJisi getProductionAllListDetailHeat(WorkJisi w) {
		return sqlSession.selectOne("workjisi.getProductionAllListDetailHeat",w);
	}

	@Override
	public List<WorkJisi> workHeatListProcessPrint(WorkJisi w) {
		return sqlSession.selectList("workjisi.workHeatListProcessPrint",w);
	}

	@Override
	public void getIpgoListUpdate(WorkJisi w) {
		sqlSession.update("workjisi.getIpgoListUpdate",w);
	}

	@Override
	public List<WorkJisi> workJisiHeatIpgoList(WorkJisi w) {
		return sqlSession.selectList("workjisi.workJisiHeatIpgoList",w);
	}

	@Override
	public List<WorkJisi> getWorkJisiHeatIpgoListRegSunip(WorkJisi w) {
		return sqlSession.selectList("workjisi.getWorkJisiHeatIpgoListRegSunip",w);
	}

	@Override
	public List<WorkJisi> getWorkJisiHeatIpgoListRegList(WorkJisi w) {
		return sqlSession.selectList("workjisi.getWorkJisiHeatIpgoListRegList",w);
	}

	@Override
	public WorkJisi setWorkipgoBarcodeScan(WorkJisi w) {
		return sqlSession.selectOne("workjisi.setWorkipgoBarcodeScan",w);
	}

	@Override
	public int getWorkJisiIlboCode(WorkJisi ww) {
		return sqlSession.selectOne("workjisi.getWorkJisiIlboCode",ww);
	}

	@Override
	public void ipgoListDelete(WorkJisi w) {
		//입고삭제 로깅
		sqlSession.delete("workjisi.ipgoListDeleteLog",w);
		//입고이력 삭제
		sqlSession.delete("workjisi.ipgoListDelete",w);
		//수입검사 삭제
		sqlSession.delete("workjisi.ipgoListDeleteIpTest",w);
	}

	@Override
	public void workJisiListDelete(WorkJisi w) {
		//작업지시삭제 로깅
		sqlSession.delete("workjisi.workJisiListDeleteLog",w);
		
		//작업지시이력 삭제(tb_workheat)
		sqlSession.delete("workjisi.workJisiListDeletWorkHeat",w);
		
		//작업지시이력 삭제(WORKILBO)
		sqlSession.delete("workjisi.workJisiListDeletWorkIlbo",w);
	}

	@Override
	public List<WorkJisi> getChulgoList(WorkJisi chulgo) {
		return sqlSession.selectList("workjisi.getChulgoList",chulgo);
	}

	@Override
	public List<WorkJisi> getChulgoAddList(WorkJisi chulgo) {
		return sqlSession.selectList("workjisi.getChulgoAddList",chulgo);
	}

	@Override
	public void setChulgoAdd(WorkJisi chulgo) {
		sqlSession.insert("workjisi.setChulgoAdd",chulgo);
	}
	
	
}
