package com.tkheat.domain;

public class Jaego {
	
	//검색조건
		private String sdate; 
		private String edate;
		
	//재고현황(상세정보)
	//ORDERT 테이블
	private int ord_code;			//수주NO
	private String ord_date;		//입고일
	private int ord_chulhacheck;	//
	private int ord_su;				//입고 수
	private float ord_amnt;			//입고 중량
	private String ord_name;
	private String ord_bigo;
	private String ord_lot;			//입고/타각 LOT
	private String ord_danw;
	private float ord_dang;			//단가
	private float ord_danj;			//단중
	private int ord_code_sum;
	
	//PRODUCT 테이블
	private int prod_code;
	private String prod_gubn;
	private String prod_name;
	private String prod_no;
	private String prod_jai;
	private String prod_gyu;
	private String prod_danw;
	
	
	//CORP 테이블
	private int corp_code;
	private String corp_name;
	private String corp_business;
	
	
	//TECHIN 테이블
	private int tech_no;
	private String tech_te;
	
	
	//OCHULGO 테이블
	private int jaigo_su;			//재고 수
	private int och_su;
	private float jaigo_amnt;		//재고 중량
	private float och_amnt;
	private float och_mon;
	private int count_sum;
	private int och_amnt_sum;
	private int specimen_sum;
	private int och_bigo;
	
	//제품별 재고현황
	//PRODJAIGO 테이블
	private float pjai_pre;			//전월 재고
	private float pjai_ip;			//당월 입고
	private float pjai_ch;			//당월 출고 수
	private float pjai_jai;			//전산 재고 수
	private float pjai_jai_j;		//전산 재고 중량
	private float pjai_jai_mon;		//전산 재고 금액
	private float pjai_real;		//실 재고 수
	private float pjai_real_j;		//실 재고 중량
	private float pjai_real_mon;	//실 재고 금액
	private String pjai_bigo;		//재고 비고
	private float pjai_jo;			//조정 수량
	private float pjai_jo_j;		//조정 중량
	private String pjai_mnth;
	
	public int getOrd_code() {
		return ord_code;
	}
	public void setOrd_code(int ord_code) {
		this.ord_code = ord_code;
	}
	public String getOrd_date() {
		return ord_date;
	}
	public void setOrd_date(String ord_date) {
		this.ord_date = ord_date;
	}
	public int getOrd_chulhacheck() {
		return ord_chulhacheck;
	}
	public void setOrd_chulhacheck(int ord_chulhacheck) {
		this.ord_chulhacheck = ord_chulhacheck;
	}
	public int getOrd_su() {
		return ord_su;
	}
	public void setOrd_su(int ord_su) {
		this.ord_su = ord_su;
	}
	public float getOrd_amnt() {
		return ord_amnt;
	}
	public void setOrd_amnt(float ord_amnt) {
		this.ord_amnt = ord_amnt;
	}
	public String getOrd_name() {
		return ord_name;
	}
	public void setOrd_name(String ord_name) {
		this.ord_name = ord_name;
	}
	public String getOrd_bigo() {
		return ord_bigo;
	}
	public void setOrd_bigo(String ord_bigo) {
		this.ord_bigo = ord_bigo;
	}
	public String getOrd_lot() {
		return ord_lot;
	}
	public void setOrd_lot(String ord_lot) {
		this.ord_lot = ord_lot;
	}
	public String getOrd_danw() {
		return ord_danw;
	}
	public void setOrd_danw(String ord_danw) {
		this.ord_danw = ord_danw;
	}
	public float getOrd_dang() {
		return ord_dang;
	}
	public void setOrd_dang(float ord_dang) {
		this.ord_dang = ord_dang;
	}
	public float getOrd_danj() {
		return ord_danj;
	}
	public void setOrd_danj(float ord_danj) {
		this.ord_danj = ord_danj;
	}
	public int getOrd_code_sum() {
		return ord_code_sum;
	}
	public void setOrd_code_sum(int ord_code_sum) {
		this.ord_code_sum = ord_code_sum;
	}
	public int getProd_code() {
		return prod_code;
	}
	public void setProd_code(int prod_code) {
		this.prod_code = prod_code;
	}
	public String getProd_gubn() {
		return prod_gubn;
	}
	public void setProd_gubn(String prod_gubn) {
		this.prod_gubn = prod_gubn;
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
	public String getProd_jai() {
		return prod_jai;
	}
	public void setProd_jai(String prod_jai) {
		this.prod_jai = prod_jai;
	}
	public String getProd_gyu() {
		return prod_gyu;
	}
	public void setProd_gyu(String prod_gyu) {
		this.prod_gyu = prod_gyu;
	}
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
	public int getTech_no() {
		return tech_no;
	}
	public void setTech_no(int tech_no) {
		this.tech_no = tech_no;
	}
	public int getJaigo_su() {
		return jaigo_su;
	}
	public void setJaigo_su(int jaigo_su) {
		this.jaigo_su = jaigo_su;
	}
	public int getOch_su() {
		return och_su;
	}
	public void setOch_su(int och_su) {
		this.och_su = och_su;
	}
	public float getJaigo_amnt() {
		return jaigo_amnt;
	}
	public void setJaigo_amnt(float jaigo_amnt) {
		this.jaigo_amnt = jaigo_amnt;
	}
	public float getOch_amnt() {
		return och_amnt;
	}
	public void setOch_amnt(float och_amnt) {
		this.och_amnt = och_amnt;
	}
	public float getOch_mon() {
		return och_mon;
	}
	public void setOch_mon(float och_mon) {
		this.och_mon = och_mon;
	}
	public int getCount_sum() {
		return count_sum;
	}
	public void setCount_sum(int count_sum) {
		this.count_sum = count_sum;
	}
	public int getOch_amnt_sum() {
		return och_amnt_sum;
	}
	public void setOch_amnt_sum(int och_amnt_sum) {
		this.och_amnt_sum = och_amnt_sum;
	}
	public int getSpecimen_sum() {
		return specimen_sum;
	}
	public void setSpecimen_sum(int specimen_sum) {
		this.specimen_sum = specimen_sum;
	}
	public String getCorp_business() {
		return corp_business;
	}
	public void setCorp_business(String corp_business) {
		this.corp_business = corp_business;
	}
	public float getPjai_pre() {
		return pjai_pre;
	}
	public void setPjai_pre(float pjai_pre) {
		this.pjai_pre = pjai_pre;
	}
	public float getPjai_ip() {
		return pjai_ip;
	}
	public void setPjai_ip(float pjai_ip) {
		this.pjai_ip = pjai_ip;
	}
	public float getPjai_ch() {
		return pjai_ch;
	}
	public void setPjai_ch(float pjai_ch) {
		this.pjai_ch = pjai_ch;
	}
	public float getPjai_jai() {
		return pjai_jai;
	}
	public void setPjai_jai(float pjai_jai) {
		this.pjai_jai = pjai_jai;
	}
	public float getPjai_real() {
		return pjai_real;
	}
	public void setPjai_real(float pjai_real) {
		this.pjai_real = pjai_real;
	}
	public String getPjai_bigo() {
		return pjai_bigo;
	}
	public void setPjai_bigo(String pjai_bigo) {
		this.pjai_bigo = pjai_bigo;
	}
	public float getPjai_jo() {
		return pjai_jo;
	}
	public void setPjai_jo(float pjai_jo) {
		this.pjai_jo = pjai_jo;
	}
	public float getPjai_jai_j() {
		return pjai_jai_j;
	}
	public void setPjai_jai_j(float pjai_jai_j) {
		this.pjai_jai_j = pjai_jai_j;
	}
	public float getPjai_jai_mon() {
		return pjai_jai_mon;
	}
	public void setPjai_jai_mon(float pjai_jai_mon) {
		this.pjai_jai_mon = pjai_jai_mon;
	}
	public float getPjai_real_j() {
		return pjai_real_j;
	}
	public void setPjai_real_j(float pjai_real_j) {
		this.pjai_real_j = pjai_real_j;
	}
	public float getPjai_real_mon() {
		return pjai_real_mon;
	}
	public void setPjai_real_mon(float pjai_real_mon) {
		this.pjai_real_mon = pjai_real_mon;
	}
	public float getPjai_jo_j() {
		return pjai_jo_j;
	}
	public void setPjai_jo_j(float pjai_jo_j) {
		this.pjai_jo_j = pjai_jo_j;
	}
	public int getOch_bigo() {
		return och_bigo;
	}
	public void setOch_bigo(int och_bigo) {
		this.och_bigo = och_bigo;
	}
	public String getTech_te() {
		return tech_te;
	}
	public void setTech_te(String tech_te) {
		this.tech_te = tech_te;
	}
	public String getProd_danw() {
		return prod_danw;
	}
	public void setProd_danw(String prod_danw) {
		this.prod_danw = prod_danw;
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
	public String getPjai_mnth() {
		return pjai_mnth;
	}
	public void setPjai_mnth(String pjai_mnth) {
		this.pjai_mnth = pjai_mnth;
	}
}
