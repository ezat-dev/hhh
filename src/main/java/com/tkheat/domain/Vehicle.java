package com.tkheat.domain;

public class Vehicle {

	private Integer v_idx;
	private String v_no;			//차량번호
	private String v_type;			//구분(트럭/지게차)
	private String v_model;			//차명/모델
	private String v_year;			//연식
	private String v_vin;			//차대번호
	private String v_fueltype;		//연료
	private String v_regdate;		//등록일
	private String v_insp;			//검사 만료일
	private String v_ins;			//보험 만료일
	private String v_memo;

	//조회 표시용(계산값)
	private String last_fuel_date;
	private String last_repair_date;
	private String last_repair_item;

	private String keyword;

	public Integer getV_idx() { return v_idx; }
	public void setV_idx(Integer v_idx) { this.v_idx = v_idx; }
	public String getV_no() { return v_no; }
	public void setV_no(String v_no) { this.v_no = v_no; }
	public String getV_type() { return v_type; }
	public void setV_type(String v_type) { this.v_type = v_type; }
	public String getV_model() { return v_model; }
	public void setV_model(String v_model) { this.v_model = v_model; }
	public String getV_year() { return v_year; }
	public void setV_year(String v_year) { this.v_year = v_year; }
	public String getV_vin() { return v_vin; }
	public void setV_vin(String v_vin) { this.v_vin = v_vin; }
	public String getV_fueltype() { return v_fueltype; }
	public void setV_fueltype(String v_fueltype) { this.v_fueltype = v_fueltype; }
	public String getV_regdate() { return v_regdate; }
	public void setV_regdate(String v_regdate) { this.v_regdate = v_regdate; }
	public String getV_insp() { return v_insp; }
	public void setV_insp(String v_insp) { this.v_insp = v_insp; }
	public String getV_ins() { return v_ins; }
	public void setV_ins(String v_ins) { this.v_ins = v_ins; }
	public String getV_memo() { return v_memo; }
	public void setV_memo(String v_memo) { this.v_memo = v_memo; }
	public String getLast_fuel_date() { return last_fuel_date; }
	public void setLast_fuel_date(String last_fuel_date) { this.last_fuel_date = last_fuel_date; }
	public String getLast_repair_date() { return last_repair_date; }
	public void setLast_repair_date(String last_repair_date) { this.last_repair_date = last_repair_date; }
	public String getLast_repair_item() { return last_repair_item; }
	public void setLast_repair_item(String last_repair_item) { this.last_repair_item = last_repair_item; }
	public String getKeyword() { return keyword; }
	public void setKeyword(String keyword) { this.keyword = keyword; }
}
