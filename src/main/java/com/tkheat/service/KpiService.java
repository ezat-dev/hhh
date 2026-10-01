package com.tkheat.service;

import java.util.List;

import com.tkheat.domain.Kpi;

public interface KpiService {

	List<Kpi> getKpiList(Kpi kpi);

	List<Integer> getKpiYearList();

	void saveDataCell(Kpi kpi);

	void saveMeta(Kpi kpi);



	List<String> getProcessList();

	void addKpiItem(Kpi kpi);

	void updateKpiItem(Kpi kpi);

	void deleteKpiItem(Kpi kpi);
}
