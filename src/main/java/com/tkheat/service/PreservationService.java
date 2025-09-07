package com.tkheat.service;

import java.util.List;

import com.tkheat.domain.Bega;
import com.tkheat.domain.Jeomgeom;
import com.tkheat.domain.Measure;
import com.tkheat.domain.SparePart;
import com.tkheat.domain.Suri;

public interface PreservationService {
	
	List<SparePart> getSparePartList();
	
	List<SparePart> getSpareSubList(SparePart sparePart);
	
	SparePart sparePartDetail(SparePart sparePart);
	
	void sparePartInsertSave(SparePart sparePart);
	
	void sparePartUpdateSave(SparePart sparePart);
	
	void sparePartDelete(Integer spp_idx);
	
	void insertSpareSub(SparePart sparePart);
	
	void updateSpareSub(SparePart sparePart);
	
	
	
	
	List<Bega> getBegaInsertList(Bega bega);
	
	Bega begaInsertDetail(Bega bega);
	
	void begaInsertSave(Bega bega);
	
	void begaUpdateSave(Bega bega);
	
	void begaDelete(int fstp_code);
	
	
	
	List<Bega> getBegaAnalyList(Bega bega);
	
	
	
	
	List<Suri> getSuriHistoryList(Suri srui);
	
	Suri suriHistoryDetail(Suri srui);
	
	void suriHistoryInsertSave(Suri srui);
	
	void suriHistoryUpdateSave(Suri srui);
	
	void suriHistoryDelete(int ffx_no);
	
	
	
	
	
	List<Jeomgeom> getJeomgeomInsertList();
	
	Jeomgeom jeomgeomInsertDetail(Jeomgeom jeomgeom);
	
	void jeomgeomInsertSave(Jeomgeom jeomgeom);
	
	void jeomgeomUpdateSave(Jeomgeom jeomgeom);
	
	void jeomgeomDelete(int chs_code);
	
	
	
	
	
	
	List<Jeomgeom> getDayJeomgeomList(Jeomgeom jeomgeom);
	
	List<Jeomgeom> dayJeomgeomSubList(Jeomgeom jeomgeom);
	
	
	
	
	List<Jeomgeom> getMonthJeomgeomList(Jeomgeom jeomgeom);
	
	
	
	List<Measure> getGigiGojangList(Measure measure);
	
	Measure gigiGojangtDetail(Measure measure);
	
	void gigiGojangInsert(Measure measure);
	
	void gigiGojangUdate(Measure measure);
	
	void gigiGojangDelete(int terr_code);
	
	
	
	
	List<Measure> getGigiJeomgeomList(Measure measure);
	
	void gigiJeomgeomInsertSave(Measure measure);
	
	void gigiJeomgeomUpdateSave(Measure measure);
	
	void gigiJeomgeomDelete(int ter_code);

}
