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

import com.tkheat.domain.Vehicle;
import com.tkheat.domain.VehicleFuel;
import com.tkheat.domain.VehicleRepair;
import com.tkheat.service.VehicleService;

@Controller
public class VehicleController {

	@Autowired
	private VehicleService vehicleService;

	@RequestMapping(value = "/vehicleLog", method = RequestMethod.GET)
	public String vehicleLog() {
		return "/preservation/vehicleLog.jsp";
	}

	@RequestMapping(value = "/vehicleLog/getVehicleList", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getVehicleList(@ModelAttribute Vehicle vehicle) {
		Map<String, Object> result = new HashMap<>();
		result.put("status", "success");
		result.put("data", vehicleService.getVehicleList(vehicle));
		return result;
	}

	@RequestMapping(value = "/vehicleLog/vehicleSave", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> vehicleSave(@ModelAttribute Vehicle vehicle, @RequestParam("mode") String mode) {
		Map<String, Object> result = new HashMap<>();
		try {
			if ("insert".equalsIgnoreCase(mode)) vehicleService.vehicleInsert(vehicle);
			else vehicleService.vehicleUpdate(vehicle);
			result.put("status", "success");
		} catch (Exception e) {
			result.put("status", "error"); result.put("message", e.getMessage());
		}
		return result;
	}

	@RequestMapping(value = "/vehicleLog/vehicleDelete", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> vehicleDelete(@RequestParam("v_idx") int v_idx) {
		Map<String, Object> result = new HashMap<>();
		try {
			vehicleService.vehicleDelete(v_idx);
			result.put("status", "success");
		} catch (Exception e) {
			result.put("status", "error"); result.put("message", e.getMessage());
		}
		return result;
	}

	@RequestMapping(value = "/vehicleLog/getVehicleRepairList", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getVehicleRepairList(@ModelAttribute VehicleRepair vehicleRepair) {
		Map<String, Object> result = new HashMap<>();
		result.put("status", "success");
		result.put("data", vehicleService.getVehicleRepairList(vehicleRepair));
		return result;
	}

	@RequestMapping(value = "/vehicleLog/vehicleRepairSave", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> vehicleRepairSave(@ModelAttribute VehicleRepair vehicleRepair, @RequestParam("mode") String mode) {
		Map<String, Object> result = new HashMap<>();
		try {
			if ("insert".equalsIgnoreCase(mode)) vehicleService.vehicleRepairInsert(vehicleRepair);
			else vehicleService.vehicleRepairUpdate(vehicleRepair);
			result.put("status", "success");
		} catch (Exception e) {
			result.put("status", "error"); result.put("message", e.getMessage());
		}
		return result;
	}

	@RequestMapping(value = "/vehicleLog/vehicleRepairDelete", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> vehicleRepairDelete(@RequestParam("vr_idx") int vr_idx) {
		Map<String, Object> result = new HashMap<>();
		try {
			vehicleService.vehicleRepairDelete(vr_idx);
			result.put("status", "success");
		} catch (Exception e) {
			result.put("status", "error"); result.put("message", e.getMessage());
		}
		return result;
	}

	@RequestMapping(value = "/vehicleLog/getVehicleFuelList", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getVehicleFuelList(@ModelAttribute VehicleFuel vehicleFuel) {
		Map<String, Object> result = new HashMap<>();
		result.put("status", "success");
		result.put("data", vehicleService.getVehicleFuelList(vehicleFuel));
		return result;
	}

	@RequestMapping(value = "/vehicleLog/vehicleFuelSave", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> vehicleFuelSave(@ModelAttribute VehicleFuel vehicleFuel, @RequestParam("mode") String mode) {
		Map<String, Object> result = new HashMap<>();
		try {
			if ("insert".equalsIgnoreCase(mode)) vehicleService.vehicleFuelInsert(vehicleFuel);
			else vehicleService.vehicleFuelUpdate(vehicleFuel);
			result.put("status", "success");
		} catch (Exception e) {
			result.put("status", "error"); result.put("message", e.getMessage());
		}
		return result;
	}

	@RequestMapping(value = "/vehicleLog/vehicleFuelDelete", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> vehicleFuelDelete(@RequestParam("vf_idx") int vf_idx) {
		Map<String, Object> result = new HashMap<>();
		try {
			vehicleService.vehicleFuelDelete(vf_idx);
			result.put("status", "success");
		} catch (Exception e) {
			result.put("status", "error"); result.put("message", e.getMessage());
		}
		return result;
	}

}
