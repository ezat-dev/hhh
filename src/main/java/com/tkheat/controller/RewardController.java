package com.tkheat.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tkheat.domain.RewardItem;
import com.tkheat.domain.RewardLedger;
import com.tkheat.service.RewardService;

@Controller
public class RewardController {

	@Autowired
	private RewardService rewardService;

	@RequestMapping(value = "/reward", method = RequestMethod.GET)
	public String reward() {
		return "/management/reward.jsp";
	}

	@RequestMapping(value = "/reward/getRoster", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getRoster() {
		Map<String, Object> result = new HashMap<>();
		result.put("status", "success");
		result.put("data", rewardService.getRoster());
		return result;
	}

	@RequestMapping(value = "/reward/getItemList", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getItemList() {
		Map<String, Object> result = new HashMap<>();
		result.put("status", "success");
		result.put("data", rewardService.getItemList());
		return result;
	}

	@RequestMapping(value = "/reward/itemSave", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> itemSave(@ModelAttribute RewardItem item, @RequestParam("mode") String mode) {
		Map<String, Object> result = new HashMap<>();
		try {
			rewardService.itemSave(item, "insert".equalsIgnoreCase(mode));
			result.put("status", "success");
		} catch (Exception e) {
			result.put("status", "error"); result.put("message", e.getMessage());
		}
		return result;
	}

	@RequestMapping(value = "/reward/itemDelete", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> itemDelete(@RequestParam("ri_idx") int ri_idx) {
		Map<String, Object> result = new HashMap<>();
		try {
			rewardService.itemDelete(ri_idx);
			result.put("status", "success");
		} catch (Exception e) {
			result.put("status", "error"); result.put("message", e.getMessage());
		}
		return result;
	}

	@RequestMapping(value = "/reward/getLedgerList", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getLedgerList() {
		Map<String, Object> result = new HashMap<>();
		result.put("status", "success");
		result.put("data", rewardService.getLedgerList());
		return result;
	}

	@RequestMapping(value = "/reward/ledgerSave", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> ledgerSave(@ModelAttribute RewardLedger ledger, @RequestParam("mode") String mode) {
		Map<String, Object> result = new HashMap<>();
		try {
			rewardService.ledgerSave(ledger, "insert".equalsIgnoreCase(mode));
			result.put("status", "success");
		} catch (Exception e) {
			result.put("status", "error"); result.put("message", e.getMessage());
		}
		return result;
	}

	@RequestMapping(value = "/reward/ledgerDelete", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> ledgerDelete(@RequestParam("rl_idx") int rl_idx) {
		Map<String, Object> result = new HashMap<>();
		try {
			rewardService.ledgerDelete(rl_idx);
			result.put("status", "success");
		} catch (Exception e) {
			result.put("status", "error"); result.put("message", e.getMessage());
		}
		return result;
	}

	@RequestMapping(value = "/reward/getLedgerCountByWorker", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getLedgerCountByWorker(@RequestParam("worker_no") String worker_no) {
		Map<String, Object> result = new HashMap<>();
		result.put("status", "success");
		result.put("data", rewardService.getLedgerCountByWorker(worker_no));
		return result;
	}

}
