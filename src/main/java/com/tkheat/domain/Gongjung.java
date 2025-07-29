package com.tkheat.domain;

public class Gongjung {

	//공정작업현황
	
	//검색조건
		private String sdate; 
		private String edate;
	
	//CORP 테이블
	private int corp_code;			//거래처코드
	private String corp_name;		//거래처명
	
	//PRODUCT 테이블
	private int prod_code;
	private String prod_name;		//품명
	private String prod_no;			//품번
	private String prod_gyu;		//규격
	private String prod_jai;		//재질
	private int prod_j;          //준비
	private int prod_p;          //전세정
	private int prod_a;          //침탄
	private int prod_h;          //고주파
	private int prod_f;          //후세정 
	private int prod_r;          //템퍼링
	private int prod_s;          //쇼트
	
	
	
	
	//OCHULGO 테이블
	private float och_su;			//출고수량
	
	//ORDERT 테이블
	private int ord_code;			//입고코드
	private String ord_lot;			//입고/타각LOT
	private int ord_su;				//수량
	private String ord_name;        //담당자
	
	//입출고 삭제현황	
	//DEL_LOG 테이블
	private String del_date;		//삭제일
	private int del_id;				//삭제 키
	private String del_kind;		//구분[입고/출고]
	private String del_amnt;		//삭제중량
	private String del_su;			//삭제수량
	private String session_name;	//담당자
	
	//ORDERT 테이블	
	private String ord_date;		//입고일
	
	//OCHULGO 테이블
	private String och_date;		//출고일
	
	
	public int getCorp_code() {
		return corp_code;
	}
	public void setCorp_code(int corp_code) {
		this.corp_code = corp_code;
	}
	public String getCorp_name() {
		return corp_name;
	}
	public void setCorp_name(String corp_name) {
		this.corp_name = corp_name;
	}
	public int getProd_code() {
		return prod_code;
	}
	public void setProd_code(int prod_code) {
		this.prod_code = prod_code;
	}
	public String getProd_name() {
		return prod_name;
	}
	public void setProd_name(String prod_name) {
		this.prod_name = prod_name;
	}
	public String getProd_no() {
		return prod_no;
	}
	public void setProd_no(String prod_no) {
		this.prod_no = prod_no;
	}
	public String getProd_gyu() {
		return prod_gyu;
	}
	public void setProd_gyu(String prod_gyu) {
		this.prod_gyu = prod_gyu;
	}
	public float getOch_su() {
		return och_su;
	}
	public void setOch_su(float och_su) {
		this.och_su = och_su;
	}
	public int getOrd_code() {
		return ord_code;
	}
	public void setOrd_code(int ord_code) {
		this.ord_code = ord_code;
	}
	public String getOrd_lot() {
		return ord_lot;
	}
	public void setOrd_lot(String ord_lot) {
		this.ord_lot = ord_lot;
	}
	public int getOrd_su() {
		return ord_su;
	}
	public void setOrd_su(int ord_su) {
		this.ord_su = ord_su;
	}
	public String getDel_date() {
		return del_date;
	}
	public void setDel_date(String del_date) {
		this.del_date = del_date;
	}
	public int getDel_id() {
		return del_id;
	}
	public void setDel_id(int del_id) {
		this.del_id = del_id;
	}
	public String getDel_kind() {
		return del_kind;
	}
	public void setDel_kind(String del_kind) {
		this.del_kind = del_kind;
	}
	public String getDel_amnt() {
		return del_amnt;
	}
	public void setDel_amnt(String del_amnt) {
		this.del_amnt = del_amnt;
	}
	public String getDel_su() {
		return del_su;
	}
	public void setDel_su(String del_su) {
		this.del_su = del_su;
	}
	public String getSession_name() {
		return session_name;
	}
	public void setSession_name(String session_name) {
		this.session_name = session_name;
	}
	public String getOrd_date() {
		return ord_date;
	}
	public void setOrd_date(String ord_date) {
		this.ord_date = ord_date;
	}
	public String getOch_date() {
		return och_date;
	}
	public void setOch_date(String och_date) {
		this.och_date = och_date;
	}
	public String getOrd_name() {
		return ord_name;
	}
	public void setOrd_name(String ord_name) {
		this.ord_name = ord_name;
	}
	public String getProd_jai() {
		return prod_jai;
	}
	public void setProd_jai(String prod_jai) {
		this.prod_jai = prod_jai;
	}
	public int getProd_j() {
		return prod_j;
	}
	public void setProd_j(int prod_j) {
		this.prod_j = prod_j;
	}
	public int getProd_p() {
		return prod_p;
	}
	public void setProd_p(int prod_p) {
		this.prod_p = prod_p;
	}
	public int getProd_a() {
		return prod_a;
	}
	public void setProd_a(int prod_a) {
		this.prod_a = prod_a;
	}
	public int getProd_h() {
		return prod_h;
	}
	public void setProd_h(int prod_h) {
		this.prod_h = prod_h;
	}
	public int getProd_f() {
		return prod_f;
	}
	public void setProd_f(int prod_f) {
		this.prod_f = prod_f;
	}
	public int getProd_r() {
		return prod_r;
	}
	public void setProd_r(int prod_r) {
		this.prod_r = prod_r;
	}
	public int getProd_s() {
		return prod_s;
	}
	public void setProd_s(int prod_s) {
		this.prod_s = prod_s;
	}
	public String getSdate() {
		return sdate;
	}
	public void setSdate(String sdate) {
		this.sdate = sdate;
	}
	public String getEdate() {
		return edate;
	}
	public void setEdate(String edate) {
		this.edate = edate;
	}
}
