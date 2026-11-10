package com.tkheat.domain;

public class VehicleFuel {

	private Integer vf_idx;
	private Integer v_idx;
	private String vf_date;
	private Double vf_liter;
	private Double vf_cost;
	private String vf_card;
	private Double vf_odo;
	private String vf_station;
	private String vf_memo;

	//조인 표시용
	private String v_no;
	private String v_type;
	private Integer gap_days;	//직전 주유일로부터 경과일(조회시 계산)

	//조회 조건
	private String keyword;
	private String card;
	private String fromMonth;
	private String toMonth;

	public Integer getVf_idx() { return vf_idx; }
	public void setVf_idx(Integer vf_idx) { this.vf_idx = vf_idx; }
	public Integer getV_idx() { return v_idx; }
	public void setV_idx(Integer v_idx) { this.v_idx = v_idx; }
	public String getVf_date() { return vf_date; }
	public void setVf_date(String vf_date) { this.vf_date = vf_date; }
	public Double getVf_liter() { return vf_liter; }
	public void setVf_liter(Double vf_liter) { this.vf_liter = vf_liter; }
	public Double getVf_cost() { return vf_cost; }
	public void setVf_cost(Double vf_cost) { this.vf_cost = vf_cost; }
	public String getVf_card() { return vf_card; }
	public void setVf_card(String vf_card) { this.vf_card = vf_card; }
	public Double getVf_odo() { return vf_odo; }
	public void setVf_odo(Double vf_odo) { this.vf_odo = vf_odo; }
	public String getVf_station() { return vf_station; }
	public void setVf_station(String vf_station) { this.vf_station = vf_station; }
	public String getVf_memo() { return vf_memo; }
	public void setVf_memo(String vf_memo) { this.vf_memo = vf_memo; }
	public String getV_no() { return v_no; }
	public void setV_no(String v_no) { this.v_no = v_no; }
	public String getV_type() { return v_type; }
	public void setV_type(String v_type) { this.v_type = v_type; }
	public Integer getGap_days() { return gap_days; }
	public void setGap_days(Integer gap_days) { this.gap_days = gap_days; }
	public String getKeyword() { return keyword; }
	public void setKeyword(String keyword) { this.keyword = keyword; }
	public String getCard() { return card; }
	public void setCard(String card) { this.card = card; }
	public String getFromMonth() { return fromMonth; }
	public void setFromMonth(String fromMonth) { this.fromMonth = fromMonth; }
	public String getToMonth() { return toMonth; }
	public void setToMonth(String toMonth) { this.toMonth = toMonth; }
}
