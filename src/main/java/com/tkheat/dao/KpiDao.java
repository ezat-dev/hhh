package com.tkheat.dao;

import java.util.List;

import com.tkheat.domain.Kpi;

public interface KpiDao {

	List<Kpi> getKpiList(Kpi kpi);

	List<Integer> getKpiYearList();

	int getDataRowCount(Kpi kpi);

	void insertDataRow(Kpi kpi);

	void updateDataCell(Kpi kpi);

	int getMetaRowCount(Kpi kpi);

	void insertMetaRow(Kpi kpi);

	void updateMeta(Kpi kpi);



	List<String> getProcessList();

	int getProcessItemCount(Kpi kpi);

	int getProcessMaxItemNo(Kpi kpi);

	int getProcessMaxSortOrder(Kpi kpi);

	int getMaxSortOrder();

	void shiftSortOrder(Kpi kpi);

	void insertKpiItem(Kpi kpi);

	void updateKpiItem(Kpi kpi);

	void deleteKpiItemData(Kpi kpi);

	void deleteKpiItem(Kpi kpi);
}
