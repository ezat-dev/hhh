package com.tkheat.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tkheat.dao.VehicleDao;
import com.tkheat.domain.Vehicle;
import com.tkheat.domain.VehicleFuel;
import com.tkheat.domain.VehicleRepair;

@Service
public class VehicleServiceImpl implements VehicleService {

	@Autowired
	private VehicleDao vehicleDao;

	@Override
	public List<Vehicle> getVehicleList(Vehicle vehicle) {
		return vehicleDao.getVehicleList(vehicle);
	}

	@Override
	public void vehicleInsert(Vehicle vehicle) {
		vehicleDao.vehicleInsert(vehicle);
	}

	@Override
	public void vehicleUpdate(Vehicle vehicle) {
		vehicleDao.vehicleUpdate(vehicle);
	}

	@Override
	public void vehicleDelete(int v_idx) {
		vehicleDao.vehicleDelete(v_idx);
	}

	@Override
	public List<VehicleRepair> getVehicleRepairList(VehicleRepair vehicleRepair) {
		return vehicleDao.getVehicleRepairList(vehicleRepair);
	}

	@Override
	public void vehicleRepairInsert(VehicleRepair vehicleRepair) {
		vehicleDao.vehicleRepairInsert(vehicleRepair);
	}

	@Override
	public void vehicleRepairUpdate(VehicleRepair vehicleRepair) {
		vehicleDao.vehicleRepairUpdate(vehicleRepair);
	}

	@Override
	public void vehicleRepairDelete(int vr_idx) {
		vehicleDao.vehicleRepairDelete(vr_idx);
	}

	@Override
	public List<VehicleFuel> getVehicleFuelList(VehicleFuel vehicleFuel) {
		return vehicleDao.getVehicleFuelList(vehicleFuel);
	}

	@Override
	public void vehicleFuelInsert(VehicleFuel vehicleFuel) {
		vehicleDao.vehicleFuelInsert(vehicleFuel);
	}

	@Override
	public void vehicleFuelUpdate(VehicleFuel vehicleFuel) {
		vehicleDao.vehicleFuelUpdate(vehicleFuel);
	}

	@Override
	public void vehicleFuelDelete(int vf_idx) {
		vehicleDao.vehicleFuelDelete(vf_idx);
	}

}
