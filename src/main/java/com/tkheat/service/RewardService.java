package com.tkheat.service;

import java.util.List;

import com.tkheat.domain.RewardItem;
import com.tkheat.domain.RewardLedger;

public interface RewardService {

	List<RewardLedger> getRoster();

	List<RewardItem> getItemList();

	void itemSave(RewardItem item, boolean isNew);

	void itemDelete(int ri_idx);

	List<RewardLedger> getLedgerList();

	void ledgerSave(RewardLedger ledger, boolean isNew);

	void ledgerDelete(int rl_idx);

	int getLedgerCountByWorker(String worker_no);

}
