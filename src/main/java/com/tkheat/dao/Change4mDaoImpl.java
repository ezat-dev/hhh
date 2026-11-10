package com.tkheat.dao;

import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.tkheat.domain.Change4m;

@Repository
public class Change4mDaoImpl implements Change4mDao {
	@Resource(name="session")
	private SqlSession sqlSession;

	@Override
	public List<Change4m> getChange4mList() {
		return sqlSession.selectList("change4m.getChange4mList");
	}

	@Override
	public void change4mInsert(Change4m change4m) {
		sqlSession.insert("change4m.change4mInsert", change4m);
	}

	@Override
	public void change4mUpdate(Change4m change4m) {
		sqlSession.update("change4m.change4mUpdate", change4m);
	}

	@Override
	public void change4mDelete(int c4m_idx) {
		sqlSession.delete("change4m.change4mDelete", c4m_idx);
	}

	@Override
	public List<Change4m> getProductOptionList(String value) {
		return sqlSession.selectList("change4m.getProductOptionList", value);
	}

}
