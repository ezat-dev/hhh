package com.tkheat.domain;

public class VehicleRepair {

	private Integer vr_idx;
	private Integer v_idx;
	private String vr_date;
	private String vr_item;
	private String vr_shop;
	private Double vr_cost;
	private Double vr_odo;
	private String vr_memo;

	//조인 표시용
	private String v_no;
	private String v_type;

	//조회 조건
	private String keyword;
	private String fromMonth;	//yyyy-MM
	private String toMonth;	//yyyy-MM

	public Integer getVr_idx() { return vr_idx; }
	public void setVr_idx(Integer vr_idx) { this.vr_idx = vr_idx; }
	public Integer getV_idx() { return v_idx; }
	public void setV_idx(Integer v_idx) { this.v_idx = v_idx; }
	public String getVr_date() { return vr_date; }
	public void setVr_date(String vr_date) { this.vr_date = vr_date; }
	public String getVr_item() { return vr_item; }
	public void setVr_item(String vr_item) { this.vr_item = vr_item; }
	public String getVr_shop() { return vr_shop; }
	public void setVr_shop(String vr_shop) { this.vr_shop = vr_shop; }
	public Double getVr_cost() { return vr_cost; }
	public void setVr_cost(Double vr_cost) { this.vr_cost = vr_cost; }
	public Double getVr_odo() { return vr_odo; }
	public void setVr_odo(Double vr_odo) { this.vr_odo = vr_odo; }
	public String getVr_memo() { return vr_memo; }
	public void setVr_memo(String vr_memo) { this.vr_memo = vr_memo; }
	public String getV_no() { return v_no; }
	public void setV_no(String v_no) { this.v_no = v_no; }
	public String getV_type() { return v_type; }
	public void setV_type(String v_type) { this.v_type = v_type; }
	public String getKeyword() { return keyword; }
	public void setKeyword(String keyword) { this.keyword = keyword; }
	public String getFromMonth() { return fromMonth; }
	public void setFromMonth(String fromMonth) { this.fromMonth = fromMonth; }
	public String getToMonth() { return toMonth; }
	public void setToMonth(String toMonth) { this.toMonth = toMonth; }
}
