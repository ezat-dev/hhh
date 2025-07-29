package com.tkheat.service;

import java.util.List;


import com.tkheat.domain.Suip;
import com.tkheat.domain.Work;

public interface QualityService {
	
	List<Suip> getSuipList(Suip suip);
	
	Suip suipDetail(Suip suip);
	
	void suipUdateSave(Suip suip);
	
	
	
	
	List<Work> getNonInsertList(Work work);
	
	List<Work> getNonCorpList(Work work);
	
	Work nonInsertDetail(Work work);
	
	void nonInsertSave(Work work);
	
	void nonUdateSave(Work work);
	
	void deleteNon(Integer werr_code);
	
	
	
	
	
	List<Work> getQueHardList(Work work);
	
	List<Work> getTemHardList(Work work);
	
	List<Work> getJajuStatusList(Work work);
	
	List<Work> getJajuJochiList(Work work);

}
