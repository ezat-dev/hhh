package com.tkheat.dao;

import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.tkheat.domain.Kpi;

@Repository
public class KpiDaoImpl implements KpiDao {

	@Resource(name="session")
	private SqlSession sqlSession;

	@Override
	public List<Kpi> getKpiList(Kpi kpi) {
		return sqlSession.selectList("kpi.getKpiList", kpi);
	}

	@Override
	public List<Integer> getKpiYearList() {
		return sqlSession.selectList("kpi.getKpiYearList");
	}

	@Override
	public int getDataRowCount(Kpi kpi) {
		return sqlSession.selectOne("kpi.getDataRowCount", kpi);
	}

	@Override
	public void insertDataRow(Kpi kpi) {
		sqlSession.insert("kpi.insertDataRow", kpi);
	}

	@Override
	public void updateDataCell(Kpi kpi) {
		sqlSession.update("kpi.updateDataCell", kpi);
	}

	@Override
	public int getMetaRowCount(Kpi kpi) {
		return sqlSession.selectOne("kpi.getMetaRowCount", kpi);
	}

	@Override
	public void insertMetaRow(Kpi kpi) {
		sqlSession.insert("kpi.insertMetaRow", kpi);
	}

	@Override
	public void updateMeta(Kpi kpi) {
		sqlSession.update("kpi.updateMeta", kpi);
	}

	@Override
	public List<String> getProcessList() {
		return sqlSession.selectList("kpi.getProcessList");
	}

	@Override
	public int getProcessItemCount(Kpi kpi) {
		return sqlSession.selectOne("kpi.getProcessItemCount", kpi);
	}

	@Override
	public int getProcessMaxItemNo(Kpi kpi) {
		return sqlSession.selectOne("kpi.getProcessMaxItemNo", kpi);
	}

	@Override
	public int getProcessMaxSortOrder(Kpi kpi) {
		return sqlSession.selectOne("kpi.getProcessMaxSortOrder", kpi);
	}

	@Override
	public int getMaxSortOrder() {
		return sqlSession.selectOne("kpi.getMaxSortOrder");
	}

	@Override
	public void shiftSortOrder(Kpi kpi) {
		sqlSession.update("kpi.shiftSortOrder", kpi);
	}

	@Override
	public void insertKpiItem(Kpi kpi) {
		sqlSession.insert("kpi.insertKpiItem", kpi);
	}

	@Override
	public void updateKpiItem(Kpi kpi) {
		sqlSession.update("kpi.updateKpiItem", kpi);
	}

	@Override
	public void deleteKpiItemData(Kpi kpi) {
		sqlSession.delete("kpi.deleteKpiItemData", kpi);
	}

	@Override
	public void deleteKpiItem(Kpi kpi) {
		sqlSession.delete("kpi.deleteKpiItem", kpi);
	}
}
