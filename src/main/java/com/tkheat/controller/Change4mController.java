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

import com.tkheat.domain.Change4m;
import com.tkheat.service.Change4mService;

@Controller
public class Change4mController {

	@Autowired
	private Change4mService change4mService;

	@RequestMapping(value = "/change4m", method = RequestMethod.GET)
	public String change4m() {
		return "/preservation/change4m.jsp";
	}

	@RequestMapping(value = "/change4m/getChange4mList", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getChange4mList() {
		Map<String, Object> result = new HashMap<>();
		List<Change4m> list = change4mService.getChange4mList();
		result.put("status", "success");
		result.put("data", list);
		return result;
	}

	@RequestMapping(value = "/change4m/save", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> save(@ModelAttribute Change4m change4m, @RequestParam("mode") String mode) {
		Map<String, Object> result = new HashMap<>();
		try {
			if ("insert".equalsIgnoreCase(mode)) {
				change4mService.change4mInsert(change4m);
			} else {
				change4mService.change4mUpdate(change4m);
			}
			result.put("status", "success");
		} catch (Exception e) {
			result.put("status", "error");
			result.put("message", e.getMessage());
		}
		return result;
	}

	@RequestMapping(value = "/change4m/delete", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> delete(@RequestParam("c4m_idx") int c4m_idx) {
		Map<String, Object> result = new HashMap<>();
		try {
			change4mService.change4mDelete(c4m_idx);
			result.put("status", "success");
		} catch (Exception e) {
			result.put("status", "error");
			result.put("message", e.getMessage());
		}
		return result;
	}

	@RequestMapping(value = "/change4m/getProductOptionList", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getProductOptionList(@RequestParam(value = "value", required = false, defaultValue = "") String value) {
		Map<String, Object> result = new HashMap<>();
		List<Change4m> list = change4mService.getProductOptionList(value);
		result.put("status", "success");
		result.put("data", list);
		return result;
	}

}
