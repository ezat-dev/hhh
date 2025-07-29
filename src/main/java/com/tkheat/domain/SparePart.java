package com.tkheat.domain;

public class SparePart {
	
	private Integer spp_idx;
	private Integer spp_idx_his;
	private String spp_purchase; //매입처
	private String spp_no; //품번
	private String spp_name; //품명
	private String spp_gyu; //규격
	private String spp_yong; //교체주기
	private int spp_proper; //적정재고
	private String spp_bigo; //비고
	private int sph_input; //입고
	private int sph_suriout; //수리출고
	private int sph_jasanout; //자산출고
	private int spp_jaigo; //재고
	private String spp_image;
	
	private String file_name; //사진 파일 이름
	
	// 관리내역
	private String spp_purchase_his;
	private String spp_no_his; //품번
	private String spp_name_his; //품명
	private String spp_gyu_his; //규격
	private String spp_yong_his; //교체주기
	private String sph_time; //입력시간
	private String sph_user; //담당자
	private String sph_bigo; //비고
	
	private Integer sph_idx;
	
	
	
	
	
	
	public String getSpp_purchase() {
		return spp_purchase;
	}
	public void setSpp_purchase(String spp_purchase) {
		this.spp_purchase = spp_purchase;
	}
	public String getSpp_no() {
		return spp_no;
	}
	public void setSpp_no(String spp_no) {
		this.spp_no = spp_no;
	}
	public String getSpp_name() {
		return spp_name;
	}
	public void setSpp_name(String spp_name) {
		this.spp_name = spp_name;
	}
	public String getSpp_gyu() {
		return spp_gyu;
	}
	public void setSpp_gyu(String spp_gyu) {
		this.spp_gyu = spp_gyu;
	}
	public String getSpp_yong() {
		return spp_yong;
	}
	public void setSpp_yong(String spp_yong) {
		this.spp_yong = spp_yong;
	}
	public int getSpp_proper() {
		return spp_proper;
	}
	public void setSpp_proper(int spp_proper) {
		this.spp_proper = spp_proper;
	}
	public String getSpp_bigo() {
		return spp_bigo;
	}
	public void setSpp_bigo(String spp_bigo) {
		this.spp_bigo = spp_bigo;
	}
	public int getSph_input() {
		return sph_input;
	}
	public void setSph_input(int sph_input) {
		this.sph_input = sph_input;
	}
	public int getSph_suriout() {
		return sph_suriout;
	}
	public void setSph_suriout(int sph_suriout) {
		this.sph_suriout = sph_suriout;
	}
	public int getSph_jasanout() {
		return sph_jasanout;
	}
	public void setSph_jasanout(int sph_jasanout) {
		this.sph_jasanout = sph_jasanout;
	}
	public int getSpp_jaigo() {
		return spp_jaigo;
	}
	public void setSpp_jaigo(int spp_jaigo) {
		this.spp_jaigo = spp_jaigo;
	}
	public Integer getSpp_idx() {
		return spp_idx;
	}
	public void setSpp_idx(Integer spp_idx) {
		this.spp_idx = spp_idx;
	}
	public String getSpp_purchase_his() {
		return spp_purchase_his;
	}
	public void setSpp_purchase_his(String spp_purchase_his) {
		this.spp_purchase_his = spp_purchase_his;
	}
	public String getSpp_no_his() {
		return spp_no_his;
	}
	public void setSpp_no_his(String spp_no_his) {
		this.spp_no_his = spp_no_his;
	}
	public String getSpp_name_his() {
		return spp_name_his;
	}
	public void setSpp_name_his(String spp_name_his) {
		this.spp_name_his = spp_name_his;
	}
	public String getSpp_gyu_his() {
		return spp_gyu_his;
	}
	public void setSpp_gyu_his(String spp_gyu_his) {
		this.spp_gyu_his = spp_gyu_his;
	}
	public String getSpp_yong_his() {
		return spp_yong_his;
	}
	public void setSpp_yong_his(String spp_yong_his) {
		this.spp_yong_his = spp_yong_his;
	}
	public String getSph_time() {
		return sph_time;
	}
	public void setSph_time(String sph_time) {
		this.sph_time = sph_time;
	}
	public String getSph_user() {
		return sph_user;
	}
	public void setSph_user(String sph_user) {
		this.sph_user = sph_user;
	}
	public String getSph_bigo() {
		return sph_bigo;
	}
	public void setSph_bigo(String sph_bigo) {
		this.sph_bigo = sph_bigo;
	}
	public String getSpp_image() {
		return spp_image;
	}
	public void setSpp_image(String spp_image) {
		this.spp_image = spp_image;
	}
	public Integer getSpp_idx_his() {
		return spp_idx_his;
	}
	public void setSpp_idx_his(Integer spp_idx_his) {
		this.spp_idx_his = spp_idx_his;
	}
	public Integer getSph_idx() {
		return sph_idx;
	}
	public void setSph_idx(Integer sph_idx) {
		this.sph_idx = sph_idx;
	}
	public String getFile_name() {
		return file_name;
	}
	public void setFile_name(String file_name) {
		this.file_name = file_name;
	}

}
