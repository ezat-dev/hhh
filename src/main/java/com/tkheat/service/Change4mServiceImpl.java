package com.tkheat.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tkheat.dao.Change4mDao;
import com.tkheat.domain.Change4m;

@Service
public class Change4mServiceImpl implements Change4mService {

	@Autowired
	private Change4mDao change4mDao;

	@Override
	public List<Change4m> getChange4mList() {
		return change4mDao.getChange4mList();
	}

	@Override
	public void change4mInsert(Change4m change4m) {
		change4mDao.change4mInsert(change4m);
	}

	@Override
	public void change4mUpdate(Change4m change4m) {
		change4mDao.change4mUpdate(change4m);
	}

	@Override
	public void change4mDelete(int c4m_idx) {
		change4mDao.change4mDelete(c4m_idx);
	}

	@Override
	public List<Change4m> getProductOptionList(String value) {
		return change4mDao.getProductOptionList(value);
	}

}
