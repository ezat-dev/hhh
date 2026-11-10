package com.tkheat.dao;

import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.tkheat.domain.Vehicle;
import com.tkheat.domain.VehicleFuel;
import com.tkheat.domain.VehicleRepair;

@Repository
public class VehicleDaoImpl implements VehicleDao {
	@Resource(name="session")
	private SqlSession sqlSession;

	@Override
	public List<Vehicle> getVehicleList(Vehicle vehicle) {
		return sqlSession.selectList("vehicle.getVehicleList", vehicle);
	}

	@Override
	public void vehicleInsert(Vehicle vehicle) {
		sqlSession.insert("vehicle.vehicleInsert", vehicle);
	}

	@Override
	public void vehicleUpdate(Vehicle vehicle) {
		sqlSession.update("vehicle.vehicleUpdate", vehicle);
	}

	@Override
	public void vehicleDelete(int v_idx) {
		sqlSession.delete("vehicle.vehicleDelete", v_idx);
	}

	@Override
	public List<VehicleRepair> getVehicleRepairList(VehicleRepair vehicleRepair) {
		return sqlSession.selectList("vehicle.getVehicleRepairList", vehicleRepair);
	}

	@Override
	public void vehicleRepairInsert(VehicleRepair vehicleRepair) {
		sqlSession.insert("vehicle.vehicleRepairInsert", vehicleRepair);
	}

	@Override
	public void vehicleRepairUpdate(VehicleRepair vehicleRepair) {
		sqlSession.update("vehicle.vehicleRepairUpdate", vehicleRepair);
	}

	@Override
	public void vehicleRepairDelete(int vr_idx) {
		sqlSession.delete("vehicle.vehicleRepairDelete", vr_idx);
	}

	@Override
	public List<VehicleFuel> getVehicleFuelList(VehicleFuel vehicleFuel) {
		return sqlSession.selectList("vehicle.getVehicleFuelList", vehicleFuel);
	}

	@Override
	public void vehicleFuelInsert(VehicleFuel vehicleFuel) {
		sqlSession.insert("vehicle.vehicleFuelInsert", vehicleFuel);
	}

	@Override
	public void vehicleFuelUpdate(VehicleFuel vehicleFuel) {
		sqlSession.update("vehicle.vehicleFuelUpdate", vehicleFuel);
	}

	@Override
	public void vehicleFuelDelete(int vf_idx) {
		sqlSession.delete("vehicle.vehicleFuelDelete", vf_idx);
	}

}
