package com.tkheat.dao;

import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.tkheat.domain.WorkJisi;
import com.tkheat.domain.WorkJisiTk;

@Repository
public class WorkJisiDaoTkImpl implements WorkJisiDaoTk {

	@Resource(name="session")
	private SqlSession sqlSession;

	@Override
	public List<WorkJisiTk> workInstructionTkAllList(WorkJisiTk w) {
		return sqlSession.selectList("workjisitk.workInstructionTkAllList",w);
	}

	@Override
	public List<WorkJisiTk> workInstructionTkDanIpgoList(WorkJisiTk w) {
		return sqlSession.selectList("workjisitk.workInstructionTkDanIpgoList",w);
	}

	@Override
	public List<WorkJisiTk> workInstructionTkDanUserList(WorkJisiTk w) {
		return sqlSession.selectList("workjisitk.workInstructionTkDanUserList",w);
	}

	@Override
	public List<WorkJisiTk> workInstructionTkDanSunipChk(WorkJisiTk w) {
		return sqlSession.selectList("workjisitk.workInstructionTkDanSunipChk",w);
	}

	@Override
	public int getWorkIlboCodeSearch() {
		return sqlSession.selectOne("workjisitk.getWorkIlboCodeSearch");
	}

	@Override
	public void workInstructionTkDanDataSave(WorkJisiTk wSave) {
		sqlSession.insert("workjisitk.workInstructionTkDanDataSave",wSave);
	}

	@Override
	public void workInstructionTkDataDelete(WorkJisiTk w) {
		sqlSession.insert("workjisitk.workInstructionTkDataDeleteLog",w);
		sqlSession.delete("workjisitk.workInstructionTkDataDelete",w);
	}

	@Override
	public List<WorkJisiTk> workInstructionTkDataUpdateList(WorkJisiTk w) {
		return sqlSession.selectList("workjisitk.workInstructionTkDataUpdateList",w);
	}

	@Override
	public List<WorkJisiTk> workInstructionTkDanIpgoBarcodeScan(WorkJisiTk w) {
		return sqlSession.selectList("workjisitk.workInstructionTkDanIpgoBarcodeScan",w);
	}

	@Override
	public List<WorkJisiTk> workInstructionTkBcfDataSearch(WorkJisiTk w) {
		return sqlSession.selectList("workjisitk.workInstructionTkBcfDataSearch",w);
	}

	@Override
	public List<WorkJisiTk> workInstructionTkBcfList(WorkJisiTk w) {
		return sqlSession.selectList("workjisitk.workInstructionTkBcfList",w);
	}

	@Override
	public String workInstructionBcfIlboLotRtn(WorkJisiTk w) {
		return sqlSession.selectOne("workjisitk.workInstructionBcfIlboLotRtn",w);
	}

	@Override
	public void workInstructionTkBcfDataSave(WorkJisiTk wSave) {
		sqlSession.insert("workjisitk.workInstructionTkBcfDataSave",wSave);		
	}
	
}
