package com.tkheat.dao;

import java.util.List;

import com.tkheat.domain.Vehicle;
import com.tkheat.domain.VehicleFuel;
import com.tkheat.domain.VehicleRepair;

public interface VehicleDao {

	List<Vehicle> getVehicleList(Vehicle vehicle);

	void vehicleInsert(Vehicle vehicle);

	void vehicleUpdate(Vehicle vehicle);

	void vehicleDelete(int v_idx);

	List<VehicleRepair> getVehicleRepairList(VehicleRepair vehicleRepair);

	void vehicleRepairInsert(VehicleRepair vehicleRepair);

	void vehicleRepairUpdate(VehicleRepair vehicleRepair);

	void vehicleRepairDelete(int vr_idx);

	List<VehicleFuel> getVehicleFuelList(VehicleFuel vehicleFuel);

	void vehicleFuelInsert(VehicleFuel vehicleFuel);

	void vehicleFuelUpdate(VehicleFuel vehicleFuel);

	void vehicleFuelDelete(int vf_idx);

}
