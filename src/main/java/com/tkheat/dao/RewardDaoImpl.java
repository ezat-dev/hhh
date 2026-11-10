package com.tkheat.dao;

import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.tkheat.domain.RewardItem;
import com.tkheat.domain.RewardLedger;

@Repository
public class RewardDaoImpl implements RewardDao {
	@Resource(name="session")
	private SqlSession sqlSession;

	@Override
	public List<RewardLedger> getRoster() {
		return sqlSession.selectList("reward.getRoster");
	}

	@Override
	public List<RewardItem> getItemList() {
		return sqlSession.selectList("reward.getItemList");
	}

	@Override
	public void itemInsert(RewardItem item) {
		sqlSession.insert("reward.itemInsert", item);
	}

	@Override
	public void itemUpdate(RewardItem item) {
		sqlSession.update("reward.itemUpdate", item);
	}

	@Override
	public void itemDelete(int ri_idx) {
		sqlSession.delete("reward.itemDelete", ri_idx);
	}

	@Override
	public List<RewardLedger> getLedgerList() {
		return sqlSession.selectList("reward.getLedgerList");
	}

	@Override
	public void ledgerInsert(RewardLedger ledger) {
		sqlSession.insert("reward.ledgerInsert", ledger);
	}

	@Override
	public void ledgerUpdate(RewardLedger ledger) {
		sqlSession.update("reward.ledgerUpdate", ledger);
	}

	@Override
	public void ledgerDelete(int rl_idx) {
		sqlSession.delete("reward.ledgerDelete", rl_idx);
	}

	@Override
	public int getLedgerCountByWorker(String worker_no) {
		return sqlSession.selectOne("reward.getLedgerCountByWorker", worker_no);
	}

}
