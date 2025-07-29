package com.tkheat.domain;

public class Chulgo {

	
	//검색조건
	private String sdate; 
	private String edate;
	
	
	//출고관리
	//OCHULGO 테이블
	private int och_code;			//출고코드
//	private int ord_code;			
	private String och_date;		//출고일
	private float och_amnt;			//출고중량
	private String och_danw;
	private String och_lot;			//입고/타각LOT
	private String och_dang;		//출고단가
	private String och_mon;			//출고금액
	private String och_danj;		//출고단중
	private String och_bigo;		//출고비고
	private int och_prn;			//출력횟수
	private float och_su;			//출고수량
	private String och_ma;			//출고마감월
	private String och_chk;
	private String och_chkd;
	private int tend_code;
	private String och_gubn;
	private int och_no;
	private int ilbo_code;
	private int ilbo_no;
	private float och_specimen;
	private float och_totalsu;
	private String och_name;
	private int och_mon_sum;
	private int och_mon_tax; //부가세
	private int och_mon_total; //합계금액
	
	private int mm_total;
	
	
	private int mm1;
	private int mm2;
	private int mm3;
	private int mm4;
	private int mm5;
	private int mm6;
	private int mm7;
	private int mm8;
	private int mm9;
	private int mm10;
	private int mm11;
	private int mm12;
	
	
	//ORDERT 테이블
	private String ord_date;
	private int ord_code;
	
	//PRODUCT 테이블
	private int prod_code;
	private String prod_gubn;		//구분
	private String prod_name;		//
	private String prod_no;			//
	private String prod_jai;		//
	private String prod_gyu;		//
	private String prod_danw;		//
	private String prod_danj;		//
	
	//CORP 테이블
	private int corp_code;
	private String corp_gyul2;
	private String corp_name;

	//TECHIN 테이블
	private int tech_no;
	private String tech_te;
	
	//출고대기현황
	private int ord_chulhacheck;
	private int ord_su;
	private float ord_amnt;
	private String ord_name;
	private String ord_bigo;
	private String ord_lot;
	private String ord_danw;
	private float ord_dang;
	private float ord_danj;
	
	
	private int jaego;
	private int jaego_su;			//재고수
	private float jaego_amnt;		//재고중량
	
	//WORKILBO 테이블
	private int ilbo_su;			//생산수
	private float ilbo_jung;		//생산중량
	
	
	
	
	public int getOch_code() {
		return och_code;
	}
	public void setOch_code(int och_code) {
		this.och_code = och_code;
	}
	public String getOch_date() {
		return och_date;
	}
	public void setOch_date(String och_date) {
		this.och_date = och_date;
	}
	public float getOch_amnt() {
		return och_amnt;
	}
	public void setOch_amnt(float och_amnt) {
		this.och_amnt = och_amnt;
	}
	public String getOch_danw() {
		return och_danw;
	}
	public void setOch_danw(String och_danw) {
		this.och_danw = och_danw;
	}
	public String getOch_lot() {
		return och_lot;
	}
	public void setOch_lot(String och_lot) {
		this.och_lot = och_lot;
	}
	public String getOch_dang() {
		return och_dang;
	}
	public void setOch_dang(String och_dang) {
		this.och_dang = och_dang;
	}
	public String getOch_mon() {
		return och_mon;
	}
	public void setOch_mon(String och_mon) {
		this.och_mon = och_mon;
	}
	public String getOch_danj() {
		return och_danj;
	}
	public void setOch_danj(String och_danj) {
		this.och_danj = och_danj;
	}
	public String getOch_bigo() {
		return och_bigo;
	}
	public void setOch_bigo(String och_bigo) {
		this.och_bigo = och_bigo;
	}
	public int getOch_prn() {
		return och_prn;
	}
	public void setOch_prn(int och_prn) {
		this.och_prn = och_prn;
	}
	public float getOch_su() {
		return och_su;
	}
	public void setOch_su(float och_su) {
		this.och_su = och_su;
	}
	public String getOch_ma() {
		return och_ma;
	}
	public void setOch_ma(String och_ma) {
		this.och_ma = och_ma;
	}
	public String getOch_chk() {
		return och_chk;
	}
	public void setOch_chk(String och_chk) {
		this.och_chk = och_chk;
	}
	public String getOch_chkd() {
		return och_chkd;
	}
	public void setOch_chkd(String och_chkd) {
		this.och_chkd = och_chkd;
	}
	public int getTend_code() {
		return tend_code;
	}
	public void setTend_code(int tend_code) {
		this.tend_code = tend_code;
	}
	public String getOch_gubn() {
		return och_gubn;
	}
	public void setOch_gubn(String och_gubn) {
		this.och_gubn = och_gubn;
	}
	public int getOch_no() {
		return och_no;
	}
	public void setOch_no(int och_no) {
		this.och_no = och_no;
	}
	public int getIlbo_code() {
		return ilbo_code;
	}
	public void setIlbo_code(int ilbo_code) {
		this.ilbo_code = ilbo_code;
	}
	public int getIlbo_no() {
		return ilbo_no;
	}
	public void setIlbo_no(int ilbo_no) {
		this.ilbo_no = ilbo_no;
	}
	public float getOch_specimen() {
		return och_specimen;
	}
	public void setOch_specimen(float och_specimen) {
		this.och_specimen = och_specimen;
	}
	public float getOch_totalsu() {
		return och_totalsu;
	}
	public void setOch_totalsu(float och_totalsu) {
		this.och_totalsu = och_totalsu;
	}
	public String getOch_name() {
		return och_name;
	}
	public void setOch_name(String och_name) {
		this.och_name = och_name;
	}
	public String getOrd_date() {
		return ord_date;
	}
	public void setOrd_date(String ord_date) {
		this.ord_date = ord_date;
	}
	public int getOrd_code() {
		return ord_code;
	}
	public void setOrd_code(int ord_code) {
		this.ord_code = ord_code;
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
	public String getProd_danw() {
		return prod_danw;
	}
	public void setProd_danw(String prod_danw) {
		this.prod_danw = prod_danw;
	}
	public String getProd_danj() {
		return prod_danj;
	}
	public void setProd_danj(String prod_danj) {
		this.prod_danj = prod_danj;
	}
	public int getCorp_code() {
		return corp_code;
	}
	public void setCorp_code(int corp_code) {
		this.corp_code = corp_code;
	}
	public String getCorp_gyul2() {
		return corp_gyul2;
	}
	public void setCorp_gyul2(String corp_gyul2) {
		this.corp_gyul2 = corp_gyul2;
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
	public String getTech_te() {
		return tech_te;
	}
	public void setTech_te(String tech_te) {
		this.tech_te = tech_te;
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
	public int getJaego() {
		return jaego;
	}
	public void setJaego(int jaego) {
		this.jaego = jaego;
	}
	public int getJaego_su() {
		return jaego_su;
	}
	public void setJaego_su(int jaego_su) {
		this.jaego_su = jaego_su;
	}
	public float getJaego_amnt() {
		return jaego_amnt;
	}
	public void setJaego_amnt(float jaego_amnt) {
		this.jaego_amnt = jaego_amnt;
	}
	public int getIlbo_su() {
		return ilbo_su;
	}
	public void setIlbo_su(int ilbo_su) {
		this.ilbo_su = ilbo_su;
	}
	public float getIlbo_jung() {
		return ilbo_jung;
	}
	public void setIlbo_jung(float ilbo_jung) {
		this.ilbo_jung = ilbo_jung;
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
	public int getMm1() {
		return mm1;
	}
	public void setMm1(int mm1) {
		this.mm1 = mm1;
	}
	public int getMm2() {
		return mm2;
	}
	public void setMm2(int mm2) {
		this.mm2 = mm2;
	}
	public int getMm3() {
		return mm3;
	}
	public void setMm3(int mm3) {
		this.mm3 = mm3;
	}
	public int getMm4() {
		return mm4;
	}
	public void setMm4(int mm4) {
		this.mm4 = mm4;
	}
	public int getMm5() {
		return mm5;
	}
	public void setMm5(int mm5) {
		this.mm5 = mm5;
	}
	public int getMm6() {
		return mm6;
	}
	public void setMm6(int mm6) {
		this.mm6 = mm6;
	}
	public int getMm7() {
		return mm7;
	}
	public void setMm7(int mm7) {
		this.mm7 = mm7;
	}
	public int getMm8() {
		return mm8;
	}
	public void setMm8(int mm8) {
		this.mm8 = mm8;
	}
	public int getMm9() {
		return mm9;
	}
	public void setMm9(int mm9) {
		this.mm9 = mm9;
	}
	public int getMm10() {
		return mm10;
	}
	public void setMm10(int mm10) {
		this.mm10 = mm10;
	}
	public int getMm11() {
		return mm11;
	}
	public void setMm11(int mm11) {
		this.mm11 = mm11;
	}
	public int getMm12() {
		return mm12;
	}
	public void setMm12(int mm12) {
		this.mm12 = mm12;
	}
	public int getOch_mon_sum() {
		return och_mon_sum;
	}
	public void setOch_mon_sum(int och_mon_sum) {
		this.och_mon_sum = och_mon_sum;
	}
	public int getOch_mon_tax() {
		return och_mon_tax;
	}
	public void setOch_mon_tax(int och_mon_tax) {
		this.och_mon_tax = och_mon_tax;
	}
	public int getOch_mon_total() {
		return och_mon_total;
	}
	public void setOch_mon_total(int och_mon_total) {
		this.och_mon_total = och_mon_total;
	}
	public int getMm_total() {
		return mm_total;
	}
	public void setMm_total(int mm_total) {
		this.mm_total = mm_total;
	}
}
