package com.tkheat.domain;

public class Kpi {

	private Integer kpi_seq;
	private String process_name;
	private Integer item_no;
	private Integer sort_order;
	private String kpi_name;
	private String unit;
	private String agg_type;   // SUM / AVG

	private Double plan_m1, plan_m2, plan_m3, plan_m4, plan_m5, plan_m6,
			plan_m7, plan_m8, plan_m9, plan_m10, plan_m11, plan_m12;
	private Double actual_m1, actual_m2, actual_m3, actual_m4, actual_m5, actual_m6,
			actual_m7, actual_m8, actual_m9, actual_m10, actual_m11, actual_m12;

	private String manager_name;
	private String note;

	// 조회/저장 파라미터
	private Integer year;
	private String row_type;   // PLAN / ACTUAL
	private Integer month;     // 1~12
	private Double value;

	public Integer getKpi_seq() { return kpi_seq; }
	public void setKpi_seq(Integer kpi_seq) { this.kpi_seq = kpi_seq; }
	public String getProcess_name() { return process_name; }
	public void setProcess_name(String process_name) { this.process_name = process_name; }
	public Integer getItem_no() { return item_no; }
	public void setItem_no(Integer item_no) { this.item_no = item_no; }
	public Integer getSort_order() { return sort_order; }
	public void setSort_order(Integer sort_order) { this.sort_order = sort_order; }
	public String getKpi_name() { return kpi_name; }
	public void setKpi_name(String kpi_name) { this.kpi_name = kpi_name; }
	public String getUnit() { return unit; }
	public void setUnit(String unit) { this.unit = unit; }
	public String getAgg_type() { return agg_type; }
	public void setAgg_type(String agg_type) { this.agg_type = agg_type; }

	public Double getPlan_m1() { return plan_m1; } public void setPlan_m1(Double v) { this.plan_m1 = v; }
	public Double getPlan_m2() { return plan_m2; } public void setPlan_m2(Double v) { this.plan_m2 = v; }
	public Double getPlan_m3() { return plan_m3; } public void setPlan_m3(Double v) { this.plan_m3 = v; }
	public Double getPlan_m4() { return plan_m4; } public void setPlan_m4(Double v) { this.plan_m4 = v; }
	public Double getPlan_m5() { return plan_m5; } public void setPlan_m5(Double v) { this.plan_m5 = v; }
	public Double getPlan_m6() { return plan_m6; } public void setPlan_m6(Double v) { this.plan_m6 = v; }
	public Double getPlan_m7() { return plan_m7; } public void setPlan_m7(Double v) { this.plan_m7 = v; }
	public Double getPlan_m8() { return plan_m8; } public void setPlan_m8(Double v) { this.plan_m8 = v; }
	public Double getPlan_m9() { return plan_m9; } public void setPlan_m9(Double v) { this.plan_m9 = v; }
	public Double getPlan_m10() { return plan_m10; } public void setPlan_m10(Double v) { this.plan_m10 = v; }
	public Double getPlan_m11() { return plan_m11; } public void setPlan_m11(Double v) { this.plan_m11 = v; }
	public Double getPlan_m12() { return plan_m12; } public void setPlan_m12(Double v) { this.plan_m12 = v; }

	public Double getActual_m1() { return actual_m1; } public void setActual_m1(Double v) { this.actual_m1 = v; }
	public Double getActual_m2() { return actual_m2; } public void setActual_m2(Double v) { this.actual_m2 = v; }
	public Double getActual_m3() { return actual_m3; } public void setActual_m3(Double v) { this.actual_m3 = v; }
	public Double getActual_m4() { return actual_m4; } public void setActual_m4(Double v) { this.actual_m4 = v; }
	public Double getActual_m5() { return actual_m5; } public void setActual_m5(Double v) { this.actual_m5 = v; }
	public Double getActual_m6() { return actual_m6; } public void setActual_m6(Double v) { this.actual_m6 = v; }
	public Double getActual_m7() { return actual_m7; } public void setActual_m7(Double v) { this.actual_m7 = v; }
	public Double getActual_m8() { return actual_m8; } public void setActual_m8(Double v) { this.actual_m8 = v; }
	public Double getActual_m9() { return actual_m9; } public void setActual_m9(Double v) { this.actual_m9 = v; }
	public Double getActual_m10() { return actual_m10; } public void setActual_m10(Double v) { this.actual_m10 = v; }
	public Double getActual_m11() { return actual_m11; } public void setActual_m11(Double v) { this.actual_m11 = v; }
	public Double getActual_m12() { return actual_m12; } public void setActual_m12(Double v) { this.actual_m12 = v; }

	public String getManager_name() { return manager_name; }
	public void setManager_name(String manager_name) { this.manager_name = manager_name; }
	public String getNote() { return note; }
	public void setNote(String note) { this.note = note; }

	public Integer getYear() { return year; }
	public void setYear(Integer year) { this.year = year; }
	public String getRow_type() { return row_type; }
	public void setRow_type(String row_type) { this.row_type = row_type; }
	public Integer getMonth() { return month; }
	public void setMonth(Integer month) { this.month = month; }
	public Double getValue() { return value; }
	public void setValue(Double value) { this.value = value; }
}
