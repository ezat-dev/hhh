package com.tkheat.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.tkheat.domain.PayrollEmp;
import com.tkheat.domain.PayrollMonth;
import com.tkheat.domain.PayrollSent;
import com.tkheat.domain.PayrollSet;

@Repository
public class PayrollDaoImpl implements PayrollDao {
	@Resource(name="session")
	private SqlSession sqlSession;

	@Override
	public List<PayrollEmp> getEmpList() {
		return sqlSession.selectList("payroll.getEmpList");
	}

	@Override
	public int empUpdate(PayrollEmp emp) {
		return sqlSession.update("payroll.empUpdate", emp);
	}

	@Override
	public void empInsert(PayrollEmp emp) {
		sqlSession.insert("payroll.empInsert", emp);
	}

	@Override
	public List<PayrollMonth> getMonthList(String ym) {
		return sqlSession.selectList("payroll.getMonthList", ym);
	}

	@Override
	public int monthUpdate(PayrollMonth month) {
		return sqlSession.update("payroll.monthUpdate", month);
	}

	@Override
	public void monthInsert(PayrollMonth month) {
		sqlSession.insert("payroll.monthInsert", month);
	}

	@Override
	public void monthDelete(String ym, String worker_no) {
		Map<String, Object> m = new HashMap<>();
		m.put("ym", ym); m.put("worker_no", worker_no);
		sqlSession.delete("payroll.monthDelete", m);
	}

	@Override
	public List<PayrollSent> getSentList(String ym) {
		return sqlSession.selectList("payroll.getSentList", ym);
	}

	@Override
	public int sentUpdate(PayrollSent sent) {
		return sqlSession.update("payroll.sentUpdate", sent);
	}

	@Override
	public void sentInsert(PayrollSent sent) {
		sqlSession.insert("payroll.sentInsert", sent);
	}

	@Override
	public PayrollSet getSet() {
		return sqlSession.selectOne("payroll.getSet");
	}

	@Override
	public int setUpdate(PayrollSet set) {
		return sqlSession.update("payroll.setUpdate", set);
	}

	@Override
	public void setInsert(PayrollSet set) {
		sqlSession.insert("payroll.setInsert", set);
	}

}
