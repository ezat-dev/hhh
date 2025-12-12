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
	
}
