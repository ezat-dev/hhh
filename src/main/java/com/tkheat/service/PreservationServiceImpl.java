package com.tkheat.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tkheat.dao.PreservationDao;
import com.tkheat.domain.Bega;
import com.tkheat.domain.Corp;
import com.tkheat.domain.Fac;
import com.tkheat.domain.Jeomgeom;
import com.tkheat.domain.Measure;
import com.tkheat.domain.SparePart;
import com.tkheat.domain.SparePart2;
import com.tkheat.domain.Suri;


@Service
public class PreservationServiceImpl implements PreservationService{
	
	@Autowired
	private PreservationDao preservationDao;
	
	@Override
	public List<SparePart> getSparePartList(){
		return preservationDao.getSparePartList();
	}
	
	@Override
	public List<SparePart> getSpareSubList(SparePart sparePart){
		return preservationDao.getSpareSubList(sparePart);
	}
	
	@Override
	public SparePart sparePartDetail(SparePart sparePart) {
		return preservationDao.sparePartDetail(sparePart);
	}
	
	@Override
	public void sparePartInsertSave(SparePart sparePart) {
		preservationDao.sparePartInsertSave(sparePart);
	}
	
	@Override
	public void sparePartUpdateSave(SparePart sparePart) {
		preservationDao.sparePartUpdateSave(sparePart);
	}
	
	@Override
	public void sparePartDelete(Integer spp_idx) {
		preservationDao.sparePartDelete(spp_idx);
	}
	
	@Override
	public void insertSpareSub(SparePart sparePart) {
		preservationDao.insertSpareSub(sparePart);
	}
	
	@Override
	public void updateSpareSub(SparePart sparePart) {
		preservationDao.updateSpareSub(sparePart);
	}
	
	@Override
	public void spareSubDelete(Integer sph_idx) {
		preservationDao.spareSubDelete(sph_idx);
	}
	
	
	
	
	
	
	@Override
	public List<Bega> getBegaInsertList(Bega bega){
		return preservationDao.getBegaInsertList(bega);
	}
	
	@Override
	public Bega begaInsertDetail(Bega bega) {
		return preservationDao.begaInsertDetail(bega);
	}
	
	@Override
	public void begaInsertSave(Bega bega) {
		preservationDao.begaInsertSave(bega);
	}
	
	@Override
	public void begaUpdateSave(Bega bega) {
		preservationDao.begaUpdateSave(bega);
	}
	
	@Override
	public void begaDelete(int fstp_code) {
		preservationDao.begaDelete(fstp_code);
	}
	
	
	
	
	
	
	
	@Override
	public List<Bega> getBegaAnalyList(Bega bega){
		return preservationDao.getBegaAnalyList(bega);
	}

	
	
	
	
	
	
	@Override
	public List<Suri> getSuriHistoryList(Suri suri){
		return preservationDao.getSuriHistoryList(suri);
	}
	
	@Override
	public Suri suriHistoryDetail(Suri suri) {
		return preservationDao.suriHistoryDetail(suri);
	}
	
	@Override
	public void suriHistoryInsertSave(Suri suri) {
		preservationDao.suriHistoryInsertSave(suri);
	}
	
	@Override
	public void suriHistoryUpdateSave(Suri suri) {
		preservationDao.suriHistoryUpdateSave(suri);
	}
	
	@Override
	public void suriHistoryDelete(int ffx_no) {
		preservationDao.suriHistoryDelete(ffx_no);
	}
	
	
	
	
	@Override
	public List<Jeomgeom> getJeomgeomInsertList(){
		return preservationDao.getJeomgeomInsertList();
	}
	
	@Override
	public Jeomgeom jeomgeomInsertDetail(Jeomgeom jeomgeom) {
		return preservationDao.jeomgeomInsertDetail(jeomgeom);
	}
	
	@Override
	public void jeomgeomInsertSave(Jeomgeom jeomgeom) {
		preservationDao.jeomgeomInsertSave(jeomgeom);
	}
	
	@Override
	public void jeomgeomUpdateSave(Jeomgeom jeomgeom) {
		preservationDao.jeomgeomUpdateSave(jeomgeom);
	}
	
	@Override
	public void jeomgeomDelete(int chs_code) {
		preservationDao.jeomgeomDelete(chs_code);
	}
	
	
	
	
	
	
	
	
	@Override
	public List<Jeomgeom> getDayJeomgeomList(Jeomgeom jeomgeom){
		return preservationDao.getDayJeomgeomList(jeomgeom);
	}
	
	@Override
	public List<Jeomgeom> dayJeomgeomSubList(Jeomgeom jeomgeom){
		return preservationDao.dayJeomgeomSubList(jeomgeom);
	}
	
	
	
	
	@Override
	public List<Jeomgeom> getMonthJeomgeomList(Jeomgeom jeomgeom){
		return preservationDao.getMonthJeomgeomList(jeomgeom);
	}
	
	
	
	
	
	
	@Override
	public List<Measure> getGigiGojangList(Measure measure){
		return preservationDao.getGigiGojangList(measure);
	}
	
	@Override
	public Measure gigiGojangtDetail(Measure measure) {
		return preservationDao.gigiGojangtDetail(measure);
	}
	
	@Override
	public void gigiGojangInsert(Measure measure) {
		preservationDao.gigiGojangInsert(measure);
	}
	
	@Override
	public void gigiGojangUdate(Measure measure) {
		preservationDao.gigiGojangUdate(measure);
	}
	
	@Override
	public void gigiGojangDelete(int terr_code) {
		preservationDao.gigiGojangDelete(terr_code);
	}
	
	
	
	
	
	
	
	
	@Override
	public List<Measure> getGigiJeomgeomList(Measure measure){
		return preservationDao.getGigiJeomgeomList(measure);
	}
	
	@Override
	public void gigiJeomgeomInsertSave(Measure measure) {
		preservationDao.gigiJeomgeomInsertSave(measure);
	}
	
	@Override
	public void gigiJeomgeomUpdateSave(Measure measure) {
		preservationDao.gigiJeomgeomUpdateSave(measure);
	}
	
	@Override
	public void gigiJeomgeomDelete(int ter_code) {
		preservationDao.gigiJeomgeomDelete(ter_code);
	}


	@Override
	public List<SparePart2> getSparePart2List(SparePart2 sparePart2) {
		return preservationDao.getSparePart2List(sparePart2);
	}

	@Override
	public void sparePart2InsertSave(SparePart2 sparePart2) {
		preservationDao.sparePart2InsertSave(sparePart2);
	}

	@Override
	public void sparePart2UpdateSave(SparePart2 sparePart2) {
		preservationDao.sparePart2UpdateSave(sparePart2);
	}

	@Override
	public void sparePart2Delete(String spp2_no) {
		preservationDao.sparePart2Delete(spp2_no);
	}

	@Override
	public List<SparePart2> getSparePart2HisList(SparePart2 sparePart2) {
		return preservationDao.getSparePart2HisList(sparePart2);
	}

	@Override
	public void sparePart2HisSave(SparePart2 sparePart2) {
		preservationDao.sparePart2HisSave(sparePart2);
	}

	@Override
	public void sparePart2HisDelete(int sph2_idx) {
		preservationDao.sparePart2HisDelete(sph2_idx);
	}

	//부품재고관리(신규, e10)
	@Override
	public List<Corp> getVendorOptionList() {
		return preservationDao.getVendorOptionList();
	}

	@Override
	public List<Fac> getFacilityOptionList() {
		return preservationDao.getFacilityOptionList();
	}

	@Override
	public List<SparePart2> getPartInvenList(SparePart2 sparePart2) {
		return preservationDao.getPartInvenList(sparePart2);
	}

	@Override
	public List<Integer> getPartFacilityCodes(String spp2_no) {
		return preservationDao.getPartFacilityCodes(spp2_no);
	}

	@Override
	public int getVendorUsageCount(int vendor_code) {
		return preservationDao.getVendorUsageCount(vendor_code);
	}

	@Override
	public int getEquipUsageCount(int fac_code) {
		return preservationDao.getEquipUsageCount(fac_code);
	}

	@Override
	public void partInvenInsertSave(SparePart2 sparePart2) {
		preservationDao.partInvenInsertSave(sparePart2);
		saveFacilityLinks(sparePart2);
	}

	@Override
	public void partInvenUpdateSave(SparePart2 sparePart2) {
		preservationDao.partInvenUpdateSave(sparePart2);
		saveFacilityLinks(sparePart2);
	}

	//적용설비 다중선택 저장 - 전체 삭제 후 선택된 것만 다시 넣는 방식(파일관리 폴더트리 저장과 동일 패턴)
	private void saveFacilityLinks(SparePart2 sparePart2) {
		preservationDao.partInvenFacilityDeleteAll(sparePart2.getSpp2_no());
		if (sparePart2.getFac_codes() != null && !sparePart2.getFac_codes().isEmpty()) {
			preservationDao.partInvenFacilityInsert(sparePart2);
		}
	}

	@Override
	public void partInvenDelete(String spp2_no) {
		preservationDao.partInvenDelete(spp2_no);
	}

	@Override
	public SparePart2 getPartStockSnapshot(String spp2_no) {
		return preservationDao.getPartStockSnapshot(spp2_no);
	}

	@Override
	public void updatePartAvgPrice(SparePart2 sparePart2) {
		preservationDao.updatePartAvgPrice(sparePart2);
	}

	@Override
	public List<SparePart2> getPartInvenHisList(SparePart2 sparePart2) {
		return preservationDao.getPartInvenHisList(sparePart2);
	}

	//입고(IN) 등록 시 가중평균 구입단가를 계산해서 부품 마스터에 반영한 뒤 이력을 저장한다.
	//평균단가 = (현재고×기존평균단가 + 입고수량×입고단가) / (현재고+입고수량)
	@Override
	public void partInvenHisSave(SparePart2 sparePart2) {
		if ("IN".equals(sparePart2.getSph2_type())) {
			SparePart2 snap = preservationDao.getPartStockSnapshot(sparePart2.getSpp2_no());
			double curStock = (snap != null && snap.getCurrent_stock() != null) ? snap.getCurrent_stock() : 0;
			double curAvg = (snap != null && snap.getSpp2_avg_price() != null) ? snap.getSpp2_avg_price() : 0;
			double inQty = sparePart2.getSph2_qty() != null ? sparePart2.getSph2_qty() : 0;
			double inPrice = sparePart2.getSph2_unitprice() != null ? sparePart2.getSph2_unitprice() : 0;
			double newStock = curStock + inQty;
			double newAvg = newStock > 0 ? ((curStock * curAvg) + (inQty * inPrice)) / newStock : inPrice;

			SparePart2 avgParam = new SparePart2();
			avgParam.setSpp2_no(sparePart2.getSpp2_no());
			avgParam.setSpp2_avg_price(newAvg);
			preservationDao.updatePartAvgPrice(avgParam);
		}
		preservationDao.partInvenHisSave(sparePart2);
	}

	@Override
	public void partInvenHisDelete(int sph2_idx) {
		preservationDao.partInvenHisDelete(sph2_idx);
	}

}
