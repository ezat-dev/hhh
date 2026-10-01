package com.tkheat.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tkheat.dao.KpiDao;
import com.tkheat.domain.Kpi;

@Service
public class KpiServiceImpl implements KpiService {

	@Autowired
	private KpiDao kpiDao;

	@Override
	public List<Kpi> getKpiList(Kpi kpi) {
		return kpiDao.getKpiList(kpi);
	}

	@Override
	public List<Integer> getKpiYearList() {
		return kpiDao.getKpiYearList();
	}

	//월별 계획/실적 셀 저장 - 그 해당(항목,연도,구분) 행이 아직 없으면 먼저 빈 행을 만든 뒤 해당 월만 갱신
	@Override
	public void saveDataCell(Kpi kpi) {
		if (kpiDao.getDataRowCount(kpi) == 0) {
			kpiDao.insertDataRow(kpi);
		}
		kpiDao.updateDataCell(kpi);
	}

	//담당자/비고 저장 - 그 해당(항목,연도) 행이 아직 없으면 insert, 있으면 update
	@Override
	public void saveMeta(Kpi kpi) {
		if (kpiDao.getMetaRowCount(kpi) == 0) {
			kpiDao.insertMetaRow(kpi);
		} else {
			kpiDao.updateMeta(kpi);
		}
	}

	@Override
	public List<String> getProcessList() {
		return kpiDao.getProcessList();
	}

	//새 성과지표 항목 추가 - 기존 프로세스명이면 그 그룹 맨 끝에 끼워넣고(순번 자동 계산),
	//새 프로세스명이면 전체 맨 끝에 새 그룹으로 추가함
	@Override
	public void addKpiItem(Kpi kpi) {
		int existingCount = kpiDao.getProcessItemCount(kpi);

		int newItemNo;
		int newSortOrder;
		if (existingCount > 0) {
			newItemNo = kpiDao.getProcessMaxItemNo(kpi) + 1;
			newSortOrder = kpiDao.getProcessMaxSortOrder(kpi) + 1;

			//그 자리 밑으로 이미 등록된(다른 프로세스 포함) 항목들의 정렬순서를 한 칸씩 밀어서 자리를 만듦
			Kpi shiftParam = new Kpi();
			shiftParam.setSort_order(newSortOrder);
			kpiDao.shiftSortOrder(shiftParam);
		} else {
			newItemNo = 1;
			newSortOrder = kpiDao.getMaxSortOrder() + 1;
		}

		kpi.setItem_no(newItemNo);
		kpi.setSort_order(newSortOrder);
		kpiDao.insertKpiItem(kpi);
	}

	//성과지표명/단위/집계방식 수정
	@Override
	public void updateKpiItem(Kpi kpi) {
		kpiDao.updateKpiItem(kpi);
	}

	//항목 삭제 - 그 항목의 모든 연도 데이터(계획/실적/담당자/비고)까지 함께 삭제
	@Override
	public void deleteKpiItem(Kpi kpi) {
		kpiDao.deleteKpiItemData(kpi);
		kpiDao.deleteKpiItem(kpi);
	}
}
