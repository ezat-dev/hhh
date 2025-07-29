package com.tkheat.service;

import java.util.List;

import com.tkheat.domain.Siljuk;

public interface ProcessService {
	
	List<Siljuk> getChimSiljukList(Siljuk siljuk);
	
	List<Siljuk> getCleanSiljukList(Siljuk siljuk);
	
	List<Siljuk> getCleanRwSiljukList(Siljuk siljuk);
	
	List<Siljuk> getTemSiljukList(Siljuk siljuk);
	
	List<Siljuk> getShortSiljukList(Siljuk siljuk);
	
	List<Siljuk> getReadySiljukList(Siljuk siljuk);
	
	void deleteSiljuk(Siljuk siljuk);
	
	List<Siljuk> getFacSiljukList(Siljuk siljuk);

}
