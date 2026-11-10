package com.tkheat.dao;

import java.util.List;

import com.tkheat.domain.PayrollEmp;
import com.tkheat.domain.PayrollMonth;
import com.tkheat.domain.PayrollSent;
import com.tkheat.domain.PayrollSet;

public interface PayrollDao {

	List<PayrollEmp> getEmpList();

	int empUpdate(PayrollEmp emp);

	void empInsert(PayrollEmp emp);

	List<PayrollMonth> getMonthList(String ym);

	int monthUpdate(PayrollMonth month);

	void monthInsert(PayrollMonth month);

	void monthDelete(String ym, String worker_no);

	List<PayrollSent> getSentList(String ym);

	int sentUpdate(PayrollSent sent);

	void sentInsert(PayrollSent sent);

	PayrollSet getSet();

	int setUpdate(PayrollSet set);

	void setInsert(PayrollSet set);

}
