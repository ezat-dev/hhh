package com.tkheat.dao;

import java.util.List;

import com.tkheat.domain.Change4m;

public interface Change4mDao {

	List<Change4m> getChange4mList();

	void change4mInsert(Change4m change4m);

	void change4mUpdate(Change4m change4m);

	void change4mDelete(int c4m_idx);

	List<Change4m> getProductOptionList(String value);

}
