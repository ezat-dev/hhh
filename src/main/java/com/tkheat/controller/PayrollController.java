package com.tkheat.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tkheat.domain.PayrollEmp;
import com.tkheat.domain.PayrollMonth;
import com.tkheat.domain.PayrollSent;
import com.tkheat.domain.PayrollSet;
import com.tkheat.domain.PayrollSlip;
import com.tkheat.service.PayrollService;

@Controller
public class PayrollController {

	@Autowired
	private PayrollService payrollService;

	@RequestMapping(value = "/payroll", method = RequestMethod.GET)
	public String payroll() {
		return "/management/payroll.jsp";
	}

	@RequestMapping(value = "/payroll/getEmpList", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getEmpList() {
		Map<String, Object> result = new HashMap<>();
		result.put("status", "success");
		result.put("data", payrollService.getEmpList());
		return result;
	}

	@RequestMapping(value = "/payroll/empSave", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> empSave(@ModelAttribute PayrollEmp emp) {
		Map<String, Object> result = new HashMap<>();
		try {
			payrollService.empSave(emp);
			result.put("status", "success");
		} catch (Exception e) {
			result.put("status", "error"); result.put("message", e.getMessage());
		}
		return result;
	}

	@RequestMapping(value = "/payroll/getMonthList", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getMonthList(@RequestParam("ym") String ym) {
		Map<String, Object> result = new HashMap<>();
		result.put("status", "success");
		result.put("data", payrollService.getMonthList(ym));
		return result;
	}

	@RequestMapping(value = "/payroll/monthSave", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> monthSave(@ModelAttribute PayrollMonth month) {
		Map<String, Object> result = new HashMap<>();
		try {
			payrollService.monthSave(month);
			result.put("status", "success");
		} catch (Exception e) {
			result.put("status", "error"); result.put("message", e.getMessage());
		}
		return result;
	}

	@RequestMapping(value = "/payroll/monthDelete", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> monthDelete(@RequestParam("ym") String ym, @RequestParam("worker_no") String worker_no) {
		Map<String, Object> result = new HashMap<>();
		try {
			payrollService.monthDelete(ym, worker_no);
			result.put("status", "success");
		} catch (Exception e) {
			result.put("status", "error"); result.put("message", e.getMessage());
		}
		return result;
	}

	@RequestMapping(value = "/payroll/getSentList", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getSentList(@RequestParam("ym") String ym) {
		Map<String, Object> result = new HashMap<>();
		result.put("status", "success");
		result.put("data", payrollService.getSentList(ym));
		return result;
	}

	@RequestMapping(value = "/payroll/sentSave", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> sentSave(@ModelAttribute PayrollSent sent) {
		Map<String, Object> result = new HashMap<>();
		try {
			payrollService.sentSave(sent);
			result.put("status", "success");
		} catch (Exception e) {
			result.put("status", "error"); result.put("message", e.getMessage());
		}
		return result;
	}

	@RequestMapping(value = "/payroll/getSet", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getSet() {
		Map<String, Object> result = new HashMap<>();
		result.put("status", "success");
		result.put("data", payrollService.getSet());
		return result;
	}

	@RequestMapping(value = "/payroll/setSave", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> setSave(@ModelAttribute PayrollSet set) {
		Map<String, Object> result = new HashMap<>();
		try {
			payrollService.setSave(set);
			result.put("status", "success");
		} catch (Exception e) {
			result.put("status", "error"); result.put("message", e.getMessage());
		}
		return result;
	}

	@RequestMapping(value = "/payroll/sendMail", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> sendMail(
			@RequestParam("to") String to,
			@RequestParam("subject") String subject,
			@ModelAttribute PayrollSlip slip) {
		Map<String, Object> result = new HashMap<>();
		try {
			payrollService.sendMail(to, subject, slip);
			PayrollSent sent = new PayrollSent();
			sent.setYm(slip.getYm());
			sent.setWorker_no(slip.getWorkerNo());
			sent.setSentDate(new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()));
			payrollService.sentSave(sent);
			result.put("status", "success");
		} catch (Exception e) {
			result.put("status", "error"); result.put("message", fullExceptionChain(e));
		}
		return result;
	}

	private String fullExceptionChain(Throwable e) {
		StringBuilder sb = new StringBuilder();
		Throwable cur = e;
		int depth = 0;
		while (cur != null && depth < 10) {
			if (sb.length() > 0) sb.append(" <- ");
			sb.append(cur.getClass().getSimpleName()).append(": ").append(cur.getMessage());
			if (cur instanceof javax.mail.MessagingException) {
				Exception next = ((javax.mail.MessagingException) cur).getNextException();
				cur = (next != null) ? next : cur.getCause();
			} else {
				cur = cur.getCause();
			}
			depth++;
		}
		return sb.toString();
	}

}
