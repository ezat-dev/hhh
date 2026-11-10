package com.tkheat.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tkheat.dao.RewardDao;
import com.tkheat.domain.RewardItem;
import com.tkheat.domain.RewardLedger;

@Service
public class RewardServiceImpl implements RewardService {

	@Autowired
	private RewardDao rewardDao;

	@Override
	public List<RewardLedger> getRoster() {
		return rewardDao.getRoster();
	}

	@Override
	public List<RewardItem> getItemList() {
		return rewardDao.getItemList();
	}

	@Override
	public void itemSave(RewardItem item, boolean isNew) {
		if (isNew) rewardDao.itemInsert(item);
		else rewardDao.itemUpdate(item);
	}

	@Override
	public void itemDelete(int ri_idx) {
		rewardDao.itemDelete(ri_idx);
	}

	@Override
	public List<RewardLedger> getLedgerList() {
		return rewardDao.getLedgerList();
	}

	@Override
	public void ledgerSave(RewardLedger ledger, boolean isNew) {
		if (isNew) rewardDao.ledgerInsert(ledger);
		else rewardDao.ledgerUpdate(ledger);
	}

	@Override
	public void ledgerDelete(int rl_idx) {
		rewardDao.ledgerDelete(rl_idx);
	}

	@Override
	public int getLedgerCountByWorker(String worker_no) {
		return rewardDao.getLedgerCountByWorker(worker_no);
	}

}
