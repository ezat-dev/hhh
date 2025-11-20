package com.tkheat.dao;

import java.util.List;

import com.tkheat.domain.Ipgo;
import com.tkheat.domain.Product;
import com.tkheat.domain.WorkJisi;

public interface WorkJisiDao {
	
	List<WorkJisi> getIpgoList(WorkJisi ipgo);

	List<WorkJisi> getIpgoAddList(WorkJisi ipgo);

	int setIpgoAdd(WorkJisi ipgo);

	void setIpgoTest(WorkJisi ipgo);

	Product getProductData(WorkJisi ipgo);

	List<Ipgo> ipgoListPrintBeforeHeat(WorkJisi ipgo);

	List<Ipgo> ipgoListPrintAfterHeat(WorkJisi ipgo);

	List<Ipgo> ipgoListPrintManager(WorkJisi ipgo);

	List<WorkJisi> workJisiReadyIpgoList(WorkJisi w);

	void setWorkJisiJSave(WorkJisi workJisi);

	List<WorkJisi> workJisiHeatJisiList(WorkJisi w);

	List<WorkJisi> workJisiAllList(WorkJisi w);

	void setWorkJisiHSave(WorkJisi workJisi);

	String getWorkJisiLot(WorkJisi ww);

	List<WorkJisi> workHeatListPrint(WorkJisi w);

	WorkJisi getProductionAllListDetailDanch(WorkJisi w);
	
	WorkJisi getProductionAllListDetailHeat(WorkJisi w);

	List<WorkJisi> workHeatListProcessPrint(WorkJisi w);

	void getIpgoListUpdate(WorkJisi w);

	List<WorkJisi> workJisiHeatIpgoList(WorkJisi w);

	List<WorkJisi> getWorkJisiHeatIpgoListRegSunip(WorkJisi w);

	List<WorkJisi> getWorkJisiHeatIpgoListRegList(WorkJisi w);

	WorkJisi setWorkipgoBarcodeScan(WorkJisi w);

	int getWorkJisiIlboCode(WorkJisi ww);

	void ipgoListDelete(WorkJisi w);

	void workJisiListDelete(WorkJisi w);

	List<WorkJisi> getChulgoList(WorkJisi chulgo);

	List<WorkJisi> getChulgoAddList(WorkJisi chulgo);

	void setChulgoAdd(WorkJisi chulgo);

	List<WorkJisi> getWorkJisiHeatProdCodeList(WorkJisi w);

	List<WorkJisi> barcodeDataCheck(WorkJisi workJisi);

	List<WorkJisi> barcodeDataDupCheck(WorkJisi workJisi);

	void barcodeDataProc(WorkJisi ww);	
}
