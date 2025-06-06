package com.tkheat.service;

import java.util.List;

import com.tkheat.domain.Suip;
import com.tkheat.domain.Work;

public interface QualityService {
	
	List<Suip> getSuipList(Suip suip);
	
	List<Work> getNonInsertList(Work work);
	
	List<Work> getQueHardList(Work work);
	
	List<Work> getTemHardList(Work work);
	
	List<Work> getJajuStatusList(Work work);
	
	List<Work> getJajuJochiList(Work work);

}
