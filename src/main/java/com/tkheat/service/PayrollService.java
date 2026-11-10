package com.tkheat.service;

import java.util.List;

import com.tkheat.domain.PayrollEmp;
import com.tkheat.domain.PayrollMonth;
import com.tkheat.domain.PayrollSent;
import com.tkheat.domain.PayrollSet;
import com.tkheat.domain.PayrollSlip;

public interface PayrollService {

	List<PayrollEmp> getEmpList();

	void empSave(PayrollEmp emp);

	List<PayrollMonth> getMonthList(String ym);

	void monthSave(PayrollMonth month);

	void monthDelete(String ym, String worker_no);

	List<PayrollSent> getSentList(String ym);

	void sentSave(PayrollSent sent);

	PayrollSet getSet();

	void setSave(PayrollSet set);

	void sendMail(String to, String subject, PayrollSlip slip) throws Exception;

}
