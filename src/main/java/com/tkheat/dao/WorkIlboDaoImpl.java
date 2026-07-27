package com.tkheat.dao;

import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.tkheat.domain.WorkJisiTk;

@Repository
public class WorkIlboDaoImpl implements WorkIlboDao{

	@Resource(name="session")
	private SqlSession sqlSession;

	@Override
	public void workIlboDataDelete(WorkJisiTk w) {
		sqlSession.insert("workilbo.workIlboDataDeleteLog",w);
		sqlSession.delete("workilbo.workIlboDataDelete",w);		
	}

	@Override
	public List<WorkJisiTk> workIlboDanchAllList(WorkJisiTk w) {
		return sqlSession.selectList("workilbo.workIlboDanchAllList",w);
	}

	@Override
	public List<WorkJisiTk> workIlboDanchIpgoList(WorkJisiTk w) {
		return sqlSession.selectList("workilbo.workIlboDanchIpgoList",w);
	}

	@Override
	public List<WorkJisiTk> workIlboUserList(WorkJisiTk w) {
		return sqlSession.selectList("workilbo.workIlboUserList",w);
	}

	@Override
	public List<WorkJisiTk> workIlboDanchIpgoBarcodeScan(WorkJisiTk w) {
		return sqlSession.selectList("workilbo.workIlboDanchIpgoBarcodeScan",w);
	}

	@Override
	public List<WorkJisiTk> workIlboDanchIpgoListDataSetting(WorkJisiTk w) {
		return sqlSession.selectList("workilbo.workIlboDanchIpgoListDataSetting",w);
	}

	@Override
	public int getWorkIlboCodeSearch() {
		return sqlSession.selectOne("workilbo.getWorkIlboCodeSearch");
	}

	@Override
	public void workIlboDanchDataSave(WorkJisiTk w) {
		sqlSession.insert("workilbo.workIlboDanchDataSave",w);
	}

	@Override
	public List<WorkJisiTk> workIlboHeatAllList(WorkJisiTk w) {
		return sqlSession.selectList("workilbo.workIlboHeatAllList",w);
	}

	@Override
	public List<WorkJisiTk> workIlboBcfList(WorkJisiTk w) {
		return sqlSession.selectList("workilbo.workIlboBcfList",w);
	}

	@Override
	public List<WorkJisiTk> workIlboHeatBcfDataSearch(WorkJisiTk w) {
		return sqlSession.selectList("workilbo.workIlboHeatBcfDataSearch",w);
	}

	@Override
	public String workIlboHeatIlboLotRtn(WorkJisiTk w) {
		return sqlSession.selectOne("workilbo.workIlboHeatIlboLotRtn",w);
	}

	@Override
	public void workIlboHeatDataSave(WorkJisiTk w) {
		sqlSession.insert("workilbo.workIlboHeatDataSave",w);
	}

	@Override
	public List<WorkJisiTk> workIlboTfDataSearch(WorkJisiTk w) {
		return sqlSession.selectList("workilbo.workIlboTfDataSearch",w);
	}

	@Override
	public void workIlboTfDataSave(WorkJisiTk w) {
		sqlSession.insert("workilbo.workIlboTfDataSave",w);		
	}

	@Override
	public List<WorkJisiTk> workIlboTfAllList(WorkJisiTk w) {
		return sqlSession.selectList("workilbo.workIlboTfAllList",w);
	}

	@Override
	public List<WorkJisiTk> workIlboDanchDataUpdateList(WorkJisiTk w) {
		return sqlSession.selectList("workilbo.workIlboDanchDataUpdateList",w);
	}

	@Override
	public List<WorkJisiTk> workIlboHeatDataUpdateList(WorkJisiTk w) {
		return sqlSession.selectList("workilbo.workIlboHeatDataUpdateList",w);
	}

	@Override
	public List<WorkJisiTk> workIlboTfDataUpdateList(WorkJisiTk w) {
		return sqlSession.selectList("workilbo.workIlboTfDataUpdateList",w);
	}

	@Override
	public List<WorkJisiTk> workIlboBcfDanchList(WorkJisiTk w) {
		return sqlSession.selectList("workilbo.workIlboBcfDanchList",w);
	}

	@Override
	public List<WorkJisiTk> workIlboBcfDanchListDataSetting(WorkJisiTk w) {
		return sqlSession.selectList("workilbo.workIlboBcfDanchListDataSetting",w);
	}

	@Override
	public List<WorkJisiTk> workIlboTfBcfList(WorkJisiTk w) {
		return sqlSession.selectList("workilbo.workIlboTfBcfList",w);
	}

	@Override
	public List<WorkJisiTk> workIlboTfBcfListDataSetting(WorkJisiTk w) {
		return sqlSession.selectList("workilbo.workIlboTfBcfListDataSetting",w);
	}

	@Override
	public WorkJisiTk workIlboCheckSeetPrintStd(WorkJisiTk w) {
		return sqlSession.selectOne("workilbo.workIlboCheckSeetPrintStd",w);
	}

	@Override
	public List<WorkJisiTk> workIlboCheckSeetPrintOrdcodeList(WorkJisiTk w) {
		return sqlSession.selectList("workilbo.workIlboCheckSeetPrintOrdcodeList",w);
	}

	@Override
	public List<WorkJisiTk> workIlboProcessOrderPrintOrdcodeList(WorkJisiTk w) {
		return sqlSession.selectList("workilbo.workIlboProcessOrderPrintOrdcodeList",w);
	}
}
