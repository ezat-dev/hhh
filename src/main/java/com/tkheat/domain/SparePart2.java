package com.tkheat.domain;

public class SparePart2 {

	// 부품 마스터
	private Integer spp2_idx;
	private String spp2_no;			//부품번호
	private String spp2_name;			//품명
	private String spp2_category;		//카테고리
	private String spp2_equipment;		//적용설비
	private String spp2_unit;			//단위
	private Integer spp2_min_stock;	//최소재고
	private Integer spp2_replace_cycle;//교체주기(개월)
	private String spp2_reg_date;

	// 재고 현황(계산값)
	private Integer total_in;
	private Integer total_out;
	private Integer current_stock;
	private String stock_status;		//재고없음/부족/정상

	// 조회 조건
	private String category;
	private String keyword;

	// 입출고 이력
	private Integer sph2_idx;
	private String sph2_type;			//IN/OUT
	private Integer sph2_qty;
	private String sph2_equipment;
	private String sph2_workdesc;
	private String sph2_username;
	private String sph2_reg_date;

	// 이력 조회 조건
	private String type;
	private String fromDt;
	private String toDt;

	public Integer getSpp2_idx() {
		return spp2_idx;
	}
	public void setSpp2_idx(Integer spp2_idx) {
		this.spp2_idx = spp2_idx;
	}
	public String getSpp2_no() {
		return spp2_no;
	}
	public void setSpp2_no(String spp2_no) {
		this.spp2_no = spp2_no;
	}
	public String getSpp2_name() {
		return spp2_name;
	}
	public void setSpp2_name(String spp2_name) {
		this.spp2_name = spp2_name;
	}
	public String getSpp2_category() {
		return spp2_category;
	}
	public void setSpp2_category(String spp2_category) {
		this.spp2_category = spp2_category;
	}
	public String getSpp2_equipment() {
		return spp2_equipment;
	}
	public void setSpp2_equipment(String spp2_equipment) {
		this.spp2_equipment = spp2_equipment;
	}
	public String getSpp2_unit() {
		return spp2_unit;
	}
	public void setSpp2_unit(String spp2_unit) {
		this.spp2_unit = spp2_unit;
	}
	public Integer getSpp2_min_stock() {
		return spp2_min_stock;
	}
	public void setSpp2_min_stock(Integer spp2_min_stock) {
		this.spp2_min_stock = spp2_min_stock;
	}
	public Integer getSpp2_replace_cycle() {
		return spp2_replace_cycle;
	}
	public void setSpp2_replace_cycle(Integer spp2_replace_cycle) {
		this.spp2_replace_cycle = spp2_replace_cycle;
	}
	public String getSpp2_reg_date() {
		return spp2_reg_date;
	}
	public void setSpp2_reg_date(String spp2_reg_date) {
		this.spp2_reg_date = spp2_reg_date;
	}
	public Integer getTotal_in() {
		return total_in;
	}
	public void setTotal_in(Integer total_in) {
		this.total_in = total_in;
	}
	public Integer getTotal_out() {
		return total_out;
	}
	public void setTotal_out(Integer total_out) {
		this.total_out = total_out;
	}
	public Integer getCurrent_stock() {
		return current_stock;
	}
	public void setCurrent_stock(Integer current_stock) {
		this.current_stock = current_stock;
	}
	public String getStock_status() {
		return stock_status;
	}
	public void setStock_status(String stock_status) {
		this.stock_status = stock_status;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public Integer getSph2_idx() {
		return sph2_idx;
	}
	public void setSph2_idx(Integer sph2_idx) {
		this.sph2_idx = sph2_idx;
	}
	public String getSph2_type() {
		return sph2_type;
	}
	public void setSph2_type(String sph2_type) {
		this.sph2_type = sph2_type;
	}
	public Integer getSph2_qty() {
		return sph2_qty;
	}
	public void setSph2_qty(Integer sph2_qty) {
		this.sph2_qty = sph2_qty;
	}
	public String getSph2_equipment() {
		return sph2_equipment;
	}
	public void setSph2_equipment(String sph2_equipment) {
		this.sph2_equipment = sph2_equipment;
	}
	public String getSph2_workdesc() {
		return sph2_workdesc;
	}
	public void setSph2_workdesc(String sph2_workdesc) {
		this.sph2_workdesc = sph2_workdesc;
	}
	public String getSph2_username() {
		return sph2_username;
	}
	public void setSph2_username(String sph2_username) {
		this.sph2_username = sph2_username;
	}
	public String getSph2_reg_date() {
		return sph2_reg_date;
	}
	public void setSph2_reg_date(String sph2_reg_date) {
		this.sph2_reg_date = sph2_reg_date;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getFromDt() {
		return fromDt;
	}
	public void setFromDt(String fromDt) {
		this.fromDt = fromDt;
	}
	public String getToDt() {
		return toDt;
	}
	public void setToDt(String toDt) {
		this.toDt = toDt;
	}
}
