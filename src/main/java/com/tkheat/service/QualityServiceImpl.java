package com.tkheat.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tkheat.dao.QualityDao;
import com.tkheat.domain.Product;
import com.tkheat.domain.Suip;
import com.tkheat.domain.Work;


@Service
public class QualityServiceImpl implements QualityService {

	@Autowired
	private QualityDao qualityDao;

	@Override
	public List<Suip> getSuipList(Suip suip){
		return qualityDao.getSuipList(suip);
	}

	@Override
	public Suip suipDetail(Suip suip) {
		return qualityDao.suipDetail(suip);
	}

	@Override
	public void suipUdateSave(Suip suip) {
		qualityDao.suipUdateSave(suip);
	}
	
	



	@Override 
	public List<Work> getNonInsertList(Work work){ 
		return qualityDao.getNonInsertList(work); 
	}

	@Override 
	public List<Work> getNonCorpList(Work work){ 
		return qualityDao.getNonCorpList(work);
	}

	@Override
	public Work nonInsertDetail(Work work) {
		return qualityDao.nonInsertDetail(work);
	}

	@Override
	public void nonInsertSave(Work work) {
		qualityDao.nonInsertSave(work);
	}

	@Override
	public void nonUdateSave(Work work) {
		qualityDao.nonUdateSave(work);
	}

	@Override
	public void deleteNon(Integer werr_code) {
		qualityDao.deleteNon(werr_code);
	}







	@Override
	public List<Work> getQueHardList(Work work){
		return qualityDao.getQueHardList(work);
	}

	@Override
	public List<Work> getTemHardList(Work work){
		return qualityDao.getTemHardList(work);
	}

	@Override
	public List<Work> getJajuStatusList(Work work){
		return qualityDao.getJajuStatusList(work);
	}

	@Override
	public List<Work> getJajuJochiList(Work work){
		return qualityDao.getJajuJochiList(work);
	}

	@Override
	public Suip cpkStandardList(Suip quality) {
		return qualityDao.cpkStandardList(quality);
	}

	@Override
	public List<Suip> cpkValueList(Suip quality) {
		return qualityDao.cpkValueList(quality);
	}

	@Override
	public List<Product> xBarPumbunList(Product p) {
		return qualityDao.xBarPumbunList(p);
	}

}
