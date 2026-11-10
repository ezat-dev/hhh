package com.tkheat.dao;

import java.util.List;

import com.tkheat.domain.RewardItem;
import com.tkheat.domain.RewardLedger;

public interface RewardDao {

	List<RewardLedger> getRoster();

	List<RewardItem> getItemList();

	void itemInsert(RewardItem item);

	void itemUpdate(RewardItem item);

	void itemDelete(int ri_idx);

	List<RewardLedger> getLedgerList();

	void ledgerInsert(RewardLedger ledger);

	void ledgerUpdate(RewardLedger ledger);

	void ledgerDelete(int rl_idx);

	int getLedgerCountByWorker(String worker_no);

}
