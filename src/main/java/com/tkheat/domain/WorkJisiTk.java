package com.tkheat.domain;

import java.util.List;

public class WorkJisiTk {

	private String sdate; // 시작일
	private String edate; // 종료일
	private int danch_sunip_chk;
	private String danch_sunip_chk_pw;
	private int danch_total_cnt;
		
	//IPTEST 테이블 (수입검사)
	//private int ord_code;
	private String itst_wp;			//수입검사
		
	//2025-07-24 추가
	private float ord_jung;			//단중
	private String prod_whadeep;
	private String prod_itst_wp;
	private String prod_e2;
	private int ord_before_file_yn;
	private int ord_after_file_yn;
	private int ord_manage_file_yn;
	private String ord_input_view;
	
	private String cell_field;
	private String cell_value;
	private int cell_code;
	
	//입고정보
	private int ord_code;			//입고코드
	private int ord_code1;			//입고코드
	private String ord_input;		//
	private String ord_date;		//입고일
	private String ord_nap;			//출고예정일
	private String ord_lot;			//입고/타각LOT
	private float ord_amnt;			//중량
	private String ord_danw;		//단위
	private float ord_dang;			//단가
	private float ord_mon;			//금액
	private String ord_bigo;		//비고
	private String ord_prn;
	private String ord_nd1;
	private String ord_nd2;
	private String ord_nd3;
	private String ord_nd4;
	private String ord_nd5;
	private String ord_nd6;
	private String ord_nd7;
	private String ord_nd8;
	private String ord_nd9;
	private String ord_nd10;
	private String ord_gyu;
	private int ord_su;				//수량
	private String ord_t01;
	private String ord_t02;
	private String ord_t03;
	private String ord_t04;
	private String ord_pre;
	private float ord_danj;			//단중
	private String ord_name;		//담당자
	private boolean ord_chulhacheck;
	private String ord_sunip;		//선입[선입1~5:선입1~5]
	private String ord_boxsu;
	
	//PRODUCT 테이블(제품정보)
	private int prod_code;
	private String prod_no;			//품번
	private String prod_name;		//품명
	private String prod_gyu;		//규격
	private String prod_jai;		//재질
	private String prod_gubn;		//제품구분
	private String prod_pg;			//표면경도
	private String prod_pg1;		//표면경도1
	private String prod_pg2;		//표면경도2
	private String prod_sg;			//심부경도
	private String prod_sg1;		//심부경도1
	private String prod_sg2;		//심부경도2
	private String prod_gd4;		//기준값1
	private String prod_gd5;		//기준값2
	private String prod_gd;
	private String prod_cd;			//기준값1 ~ 기준값2
	private String prod_e1;			//금속조직
	private String prod_e3;			//
	private String prod_danw;			//
	private String prod_danj;			//
	private String prod_dang;			//
	private String prod_cno;			//
	private String prod_gd1;			//
	private String prod_gd2;			//
	private String prod_gd3;			//
	private String prod_boxsu;			//
	private String prod_chisu1n;
	private String prod_chisu1s;
	private String prod_chisu2n;
	private String prod_chisu2s;
	private String prod_chisu3n;
	private String prod_chisu3s;
	private String prod_chisu4n;
	private String prod_chisu4s;
	private String prod_chisu5n;
	private String prod_chisu5s;
		
	//WORDSTD
	private int wstd_code;
	private String wstd_t32;
	private String wstd_t33;
	private String wstd_t41;
	private String wstd_t42;
	private String wstd_t43;
	private String wstd_t87;
	private String wstd_t44;
	private String wstd_t51;
	private String wstd_t52;
	private String wstd_t53;
	private String wstd_t54;
	private String wstd_t30;
	private String wstd_gj11;
	private String wstd_gj12;
	private String wstd_gj13;
	private String wstd_gj14;
	private String wstd_gj15;
	private String wstd_gj16;
	private String wstd_gj17;
	private String wstd_gj21;
	private String wstd_gj22;
	private String wstd_gj23;
	private String wstd_gj24;
	private String wstd_gj32;
	private String wstd_gj33;
	private String wstd_gj34;
	private String wstd_gj42;
	
	//CORP 테이블(거래처)
	private int corp_code;
	private String corp_name;		//거래처명

	//TECHIN 테이블 (설비정보?)
	private String tech_no;
	private String tech_te;			//공정종류
	
	//설비
	private int fac_code;
	private String fac_name;
	
	private String user_name;
	private String aaa;
	
	private String cost_ea;
	private float cost_kg;
	private String prod_upjong;
	private String jisi_h_cost;
	private String prod_polish;
	private String prod_vnyl;
	private String prod_plt;
	private String prod_pad;
	private String prod_danch;
	private String prod_bangch;
	private String prod_note;
	private String prod_img;
	private String danch_img;
	private String jisi_h_bigo;
	private String fac1;
	private String fac2;
	private String fac3;
	private String fac4;
	private String fac5;
	private String fac6;
	private String fac7;
	
	
	//WORKILBO 테이블
	private int ilbo_code;
	private int ilbo_no;
//	private int ord_code;
	private String ilbo_gubn;
	private String ilbo_lot;
	private float ilbo_su;
	private float ilbo_jung;
	private String ilbo_strt;
	private String ilbo_end;
//	private int fac_code;
	private int user_code;
	private String ilbo_g11;
	private String ilbo_g12;
	private String ilbo_g13;
	private String ilbo_g21;
	private String ilbo_g22;
	private String ilbo_g23;
	private String ilbo_g24;
	private String ilbo_g25;
	private String ilbo_g26;
	private String ilbo_g27;
	private String ilbo_g31;
	private String ilbo_g32;
	private String ilbo_g33;
	private String ilbo_g34;
	private String ilbo_g35;
	private String ilbo_pg1;
	private String ilbo_pg2;
	private String ilbo_pg3;
	private String ilbo_pg4;
	private String ilbo_pg5;
	private String ilbo_pg6;
	private String ilbo_bigo;
//	private int jisi_code;
	private int ilbo_pc;
	private int ilbo_pn;
	private String ilbo_g14;
	private String ilbo_g41;
	private String ilbo_g42;
	private String ilbo_g43;
	private String ilbo_g44;
	private String ilbo_g51;
	private String ilbo_g52;
	private String ilbo_g53;
	private String ilbo_g54;
	private String ilbo_g61;
	private String ilbo_g62;
	private String ilbo_g63;
	private String ilbo_g64;
	private String ilbo_cm;
	private String ilbo_okng;
	private String ilbo_ck01;
	private String ilbo_ck02;
	private String ilbo_ck03;
	private String ilbo_ck04;
	private String ilbo_ck05;	
	
	
	/*출고관리*/
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
		
	//CORP 테이블
	private String corp_gyul2;
		
	private int jaego;
	private int jaego_su;			//재고수
	private float jaego_amnt;		//재고중량
	
	
	//
	private int danch_su;
	private int danch_remain_su;
	private int danch_std_cnt;
	
	private String product_file_name;
	private String apperance_file_name;
	private String heat_file_name;
	private String drawing_file_name;
	
	private String wstd_chim_file_name1;
	private String wstd_chim_file_name2;
	
	private String fac_gyu;
	
	private String ilbo_lot_date;
	private String ilbo_lot_count;
	
	//수주번호 리스트로 선입제품 제외로 사용
	private List<Integer> sunipOrdList;
	
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
	public String getItst_wp() {
		return itst_wp;
	}
	public void setItst_wp(String itst_wp) {
		this.itst_wp = itst_wp;
	}
	public float getOrd_jung() {
		return ord_jung;
	}
	public void setOrd_jung(float ord_jung) {
		this.ord_jung = ord_jung;
	}
	public String getProd_whadeep() {
		return prod_whadeep;
	}
	public void setProd_whadeep(String prod_whadeep) {
		this.prod_whadeep = prod_whadeep;
	}
	public String getProd_itst_wp() {
		return prod_itst_wp;
	}
	public void setProd_itst_wp(String prod_itst_wp) {
		this.prod_itst_wp = prod_itst_wp;
	}
	public String getProd_e2() {
		return prod_e2;
	}
	public void setProd_e2(String prod_e2) {
		this.prod_e2 = prod_e2;
	}
	public int getOrd_before_file_yn() {
		return ord_before_file_yn;
	}
	public void setOrd_before_file_yn(int ord_before_file_yn) {
		this.ord_before_file_yn = ord_before_file_yn;
	}
	public int getOrd_after_file_yn() {
		return ord_after_file_yn;
	}
	public void setOrd_after_file_yn(int ord_after_file_yn) {
		this.ord_after_file_yn = ord_after_file_yn;
	}
	public int getOrd_manage_file_yn() {
		return ord_manage_file_yn;
	}
	public void setOrd_manage_file_yn(int ord_manage_file_yn) {
		this.ord_manage_file_yn = ord_manage_file_yn;
	}
	public String getCell_field() {
		return cell_field;
	}
	public void setCell_field(String cell_field) {
		this.cell_field = cell_field;
	}
	public String getCell_value() {
		return cell_value;
	}
	public void setCell_value(String cell_value) {
		this.cell_value = cell_value;
	}
	public int getCell_code() {
		return cell_code;
	}
	public void setCell_code(int cell_code) {
		this.cell_code = cell_code;
	}
	public int getOrd_code() {
		return ord_code;
	}
	public void setOrd_code(int ord_code) {
		this.ord_code = ord_code;
	}
	public int getOrd_code1() {
		return ord_code1;
	}
	public void setOrd_code1(int ord_code1) {
		this.ord_code1 = ord_code1;
	}
	public String getOrd_input() {
		return ord_input;
	}
	public void setOrd_input(String ord_input) {
		this.ord_input = ord_input;
	}
	public String getOrd_date() {
		return ord_date;
	}
	public void setOrd_date(String ord_date) {
		this.ord_date = ord_date;
	}
	public String getOrd_nap() {
		return ord_nap;
	}
	public void setOrd_nap(String ord_nap) {
		this.ord_nap = ord_nap;
	}
	public String getOrd_lot() {
		return ord_lot;
	}
	public void setOrd_lot(String ord_lot) {
		this.ord_lot = ord_lot;
	}
	public float getOrd_amnt() {
		return ord_amnt;
	}
	public void setOrd_amnt(float ord_amnt) {
		this.ord_amnt = ord_amnt;
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
	public float getOrd_mon() {
		return ord_mon;
	}
	public void setOrd_mon(float ord_mon) {
		this.ord_mon = ord_mon;
	}
	public String getOrd_bigo() {
		return ord_bigo;
	}
	public void setOrd_bigo(String ord_bigo) {
		this.ord_bigo = ord_bigo;
	}
	public String getOrd_prn() {
		return ord_prn;
	}
	public void setOrd_prn(String ord_prn) {
		this.ord_prn = ord_prn;
	}
	public String getOrd_nd1() {
		return ord_nd1;
	}
	public void setOrd_nd1(String ord_nd1) {
		this.ord_nd1 = ord_nd1;
	}
	public String getOrd_nd2() {
		return ord_nd2;
	}
	public void setOrd_nd2(String ord_nd2) {
		this.ord_nd2 = ord_nd2;
	}
	public String getOrd_nd3() {
		return ord_nd3;
	}
	public void setOrd_nd3(String ord_nd3) {
		this.ord_nd3 = ord_nd3;
	}
	public String getOrd_nd4() {
		return ord_nd4;
	}
	public void setOrd_nd4(String ord_nd4) {
		this.ord_nd4 = ord_nd4;
	}
	public String getOrd_nd5() {
		return ord_nd5;
	}
	public void setOrd_nd5(String ord_nd5) {
		this.ord_nd5 = ord_nd5;
	}
	public String getOrd_nd6() {
		return ord_nd6;
	}
	public void setOrd_nd6(String ord_nd6) {
		this.ord_nd6 = ord_nd6;
	}
	public String getOrd_nd7() {
		return ord_nd7;
	}
	public void setOrd_nd7(String ord_nd7) {
		this.ord_nd7 = ord_nd7;
	}
	public String getOrd_nd8() {
		return ord_nd8;
	}
	public void setOrd_nd8(String ord_nd8) {
		this.ord_nd8 = ord_nd8;
	}
	public String getOrd_nd9() {
		return ord_nd9;
	}
	public void setOrd_nd9(String ord_nd9) {
		this.ord_nd9 = ord_nd9;
	}
	public String getOrd_nd10() {
		return ord_nd10;
	}
	public void setOrd_nd10(String ord_nd10) {
		this.ord_nd10 = ord_nd10;
	}
	public String getOrd_gyu() {
		return ord_gyu;
	}
	public void setOrd_gyu(String ord_gyu) {
		this.ord_gyu = ord_gyu;
	}
	public int getOrd_su() {
		return ord_su;
	}
	public void setOrd_su(int ord_su) {
		this.ord_su = ord_su;
	}
	public String getOrd_t01() {
		return ord_t01;
	}
	public void setOrd_t01(String ord_t01) {
		this.ord_t01 = ord_t01;
	}
	public String getOrd_t02() {
		return ord_t02;
	}
	public void setOrd_t02(String ord_t02) {
		this.ord_t02 = ord_t02;
	}
	public String getOrd_t03() {
		return ord_t03;
	}
	public void setOrd_t03(String ord_t03) {
		this.ord_t03 = ord_t03;
	}
	public String getOrd_t04() {
		return ord_t04;
	}
	public void setOrd_t04(String ord_t04) {
		this.ord_t04 = ord_t04;
	}
	public String getOrd_pre() {
		return ord_pre;
	}
	public void setOrd_pre(String ord_pre) {
		this.ord_pre = ord_pre;
	}
	public float getOrd_danj() {
		return ord_danj;
	}
	public void setOrd_danj(float ord_danj) {
		this.ord_danj = ord_danj;
	}
	public String getOrd_name() {
		return ord_name;
	}
	public void setOrd_name(String ord_name) {
		this.ord_name = ord_name;
	}
	public boolean isOrd_chulhacheck() {
		return ord_chulhacheck;
	}
	public void setOrd_chulhacheck(boolean ord_chulhacheck) {
		this.ord_chulhacheck = ord_chulhacheck;
	}
	public String getOrd_sunip() {
		return ord_sunip;
	}
	public void setOrd_sunip(String ord_sunip) {
		this.ord_sunip = ord_sunip;
	}
	public String getOrd_boxsu() {
		return ord_boxsu;
	}
	public void setOrd_boxsu(String ord_boxsu) {
		this.ord_boxsu = ord_boxsu;
	}
	public int getProd_code() {
		return prod_code;
	}
	public void setProd_code(int prod_code) {
		this.prod_code = prod_code;
	}
	public String getProd_no() {
		return prod_no;
	}
	public void setProd_no(String prod_no) {
		this.prod_no = prod_no;
	}
	public String getProd_name() {
		return prod_name;
	}
	public void setProd_name(String prod_name) {
		this.prod_name = prod_name;
	}
	public String getProd_gyu() {
		return prod_gyu;
	}
	public void setProd_gyu(String prod_gyu) {
		this.prod_gyu = prod_gyu;
	}
	public String getProd_jai() {
		return prod_jai;
	}
	public void setProd_jai(String prod_jai) {
		this.prod_jai = prod_jai;
	}
	public String getProd_gubn() {
		return prod_gubn;
	}
	public void setProd_gubn(String prod_gubn) {
		this.prod_gubn = prod_gubn;
	}
	public String getProd_pg() {
		return prod_pg;
	}
	public void setProd_pg(String prod_pg) {
		this.prod_pg = prod_pg;
	}
	public String getProd_pg1() {
		return prod_pg1;
	}
	public void setProd_pg1(String prod_pg1) {
		this.prod_pg1 = prod_pg1;
	}
	public String getProd_pg2() {
		return prod_pg2;
	}
	public void setProd_pg2(String prod_pg2) {
		this.prod_pg2 = prod_pg2;
	}
	public String getProd_sg() {
		return prod_sg;
	}
	public void setProd_sg(String prod_sg) {
		this.prod_sg = prod_sg;
	}
	public String getProd_sg1() {
		return prod_sg1;
	}
	public void setProd_sg1(String prod_sg1) {
		this.prod_sg1 = prod_sg1;
	}
	public String getProd_sg2() {
		return prod_sg2;
	}
	public void setProd_sg2(String prod_sg2) {
		this.prod_sg2 = prod_sg2;
	}
	public String getProd_gd4() {
		return prod_gd4;
	}
	public void setProd_gd4(String prod_gd4) {
		this.prod_gd4 = prod_gd4;
	}
	public String getProd_gd5() {
		return prod_gd5;
	}
	public void setProd_gd5(String prod_gd5) {
		this.prod_gd5 = prod_gd5;
	}
	public String getProd_gd() {
		return prod_gd;
	}
	public void setProd_gd(String prod_gd) {
		this.prod_gd = prod_gd;
	}
	public String getProd_cd() {
		return prod_cd;
	}
	public void setProd_cd(String prod_cd) {
		this.prod_cd = prod_cd;
	}
	public String getProd_e1() {
		return prod_e1;
	}
	public void setProd_e1(String prod_e1) {
		this.prod_e1 = prod_e1;
	}
	public String getProd_e3() {
		return prod_e3;
	}
	public void setProd_e3(String prod_e3) {
		this.prod_e3 = prod_e3;
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
	public String getProd_dang() {
		return prod_dang;
	}
	public void setProd_dang(String prod_dang) {
		this.prod_dang = prod_dang;
	}
	public String getProd_cno() {
		return prod_cno;
	}
	public void setProd_cno(String prod_cno) {
		this.prod_cno = prod_cno;
	}
	public String getProd_gd1() {
		return prod_gd1;
	}
	public void setProd_gd1(String prod_gd1) {
		this.prod_gd1 = prod_gd1;
	}
	public String getProd_gd2() {
		return prod_gd2;
	}
	public void setProd_gd2(String prod_gd2) {
		this.prod_gd2 = prod_gd2;
	}
	public String getProd_gd3() {
		return prod_gd3;
	}
	public void setProd_gd3(String prod_gd3) {
		this.prod_gd3 = prod_gd3;
	}
	public String getProd_boxsu() {
		return prod_boxsu;
	}
	public void setProd_boxsu(String prod_boxsu) {
		this.prod_boxsu = prod_boxsu;
	}
	public String getProd_chisu1n() {
		return prod_chisu1n;
	}
	public void setProd_chisu1n(String prod_chisu1n) {
		this.prod_chisu1n = prod_chisu1n;
	}
	public String getProd_chisu1s() {
		return prod_chisu1s;
	}
	public void setProd_chisu1s(String prod_chisu1s) {
		this.prod_chisu1s = prod_chisu1s;
	}
	public String getProd_chisu2n() {
		return prod_chisu2n;
	}
	public void setProd_chisu2n(String prod_chisu2n) {
		this.prod_chisu2n = prod_chisu2n;
	}
	public String getProd_chisu2s() {
		return prod_chisu2s;
	}
	public void setProd_chisu2s(String prod_chisu2s) {
		this.prod_chisu2s = prod_chisu2s;
	}
	public String getProd_chisu3n() {
		return prod_chisu3n;
	}
	public void setProd_chisu3n(String prod_chisu3n) {
		this.prod_chisu3n = prod_chisu3n;
	}
	public String getProd_chisu3s() {
		return prod_chisu3s;
	}
	public void setProd_chisu3s(String prod_chisu3s) {
		this.prod_chisu3s = prod_chisu3s;
	}
	public String getProd_chisu4n() {
		return prod_chisu4n;
	}
	public void setProd_chisu4n(String prod_chisu4n) {
		this.prod_chisu4n = prod_chisu4n;
	}
	public String getProd_chisu4s() {
		return prod_chisu4s;
	}
	public void setProd_chisu4s(String prod_chisu4s) {
		this.prod_chisu4s = prod_chisu4s;
	}
	public String getProd_chisu5n() {
		return prod_chisu5n;
	}
	public void setProd_chisu5n(String prod_chisu5n) {
		this.prod_chisu5n = prod_chisu5n;
	}
	public String getProd_chisu5s() {
		return prod_chisu5s;
	}
	public void setProd_chisu5s(String prod_chisu5s) {
		this.prod_chisu5s = prod_chisu5s;
	}
	public int getWstd_code() {
		return wstd_code;
	}
	public void setWstd_code(int wstd_code) {
		this.wstd_code = wstd_code;
	}
	public String getWstd_t32() {
		return wstd_t32;
	}
	public void setWstd_t32(String wstd_t32) {
		this.wstd_t32 = wstd_t32;
	}
	public String getWstd_t33() {
		return wstd_t33;
	}
	public void setWstd_t33(String wstd_t33) {
		this.wstd_t33 = wstd_t33;
	}
	public String getWstd_t41() {
		return wstd_t41;
	}
	public void setWstd_t41(String wstd_t41) {
		this.wstd_t41 = wstd_t41;
	}
	public String getWstd_t42() {
		return wstd_t42;
	}
	public void setWstd_t42(String wstd_t42) {
		this.wstd_t42 = wstd_t42;
	}
	public String getWstd_t87() {
		return wstd_t87;
	}
	public void setWstd_t87(String wstd_t87) {
		this.wstd_t87 = wstd_t87;
	}
	public String getWstd_t43() {
		return wstd_t43;
	}
	public void setWstd_t43(String wstd_t43) {
		this.wstd_t43 = wstd_t43;
	}
	public String getWstd_t44() {
		return wstd_t44;
	}
	public void setWstd_t44(String wstd_t44) {
		this.wstd_t44 = wstd_t44;
	}
	public String getWstd_t51() {
		return wstd_t51;
	}
	public void setWstd_t51(String wstd_t51) {
		this.wstd_t51 = wstd_t51;
	}
	public String getWstd_t52() {
		return wstd_t52;
	}
	public void setWstd_t52(String wstd_t52) {
		this.wstd_t52 = wstd_t52;
	}
	public String getWstd_t53() {
		return wstd_t53;
	}
	public void setWstd_t53(String wstd_t53) {
		this.wstd_t53 = wstd_t53;
	}
	public String getWstd_t54() {
		return wstd_t54;
	}
	public void setWstd_t54(String wstd_t54) {
		this.wstd_t54 = wstd_t54;
	}
	public String getWstd_t30() {
		return wstd_t30;
	}
	public void setWstd_t30(String wstd_t30) {
		this.wstd_t30 = wstd_t30;
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
	public String getTech_no() {
		return tech_no;
	}
	public void setTech_no(String tech_no) {
		this.tech_no = tech_no;
	}
	public String getTech_te() {
		return tech_te;
	}
	public void setTech_te(String tech_te) {
		this.tech_te = tech_te;
	}
	public int getFac_code() {
		return fac_code;
	}
	public void setFac_code(int fac_code) {
		this.fac_code = fac_code;
	}
	public String getFac_name() {
		return fac_name;
	}
	public void setFac_name(String fac_name) {
		this.fac_name = fac_name;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getAaa() {
		return aaa;
	}
	public void setAaa(String aaa) {
		this.aaa = aaa;
	}
	public String getCost_ea() {
		return cost_ea;
	}
	public void setCost_ea(String cost_ea) {
		this.cost_ea = cost_ea;
	}
	public float getCost_kg() {
		return cost_kg;
	}
	public void setCost_kg(float cost_kg) {
		this.cost_kg = cost_kg;
	}
	public String getProd_upjong() {
		return prod_upjong;
	}
	public void setProd_upjong(String prod_upjong) {
		this.prod_upjong = prod_upjong;
	}
	public String getJisi_h_cost() {
		return jisi_h_cost;
	}
	public void setJisi_h_cost(String jisi_h_cost) {
		this.jisi_h_cost = jisi_h_cost;
	}
	public String getProd_polish() {
		return prod_polish;
	}
	public void setProd_polish(String prod_polish) {
		this.prod_polish = prod_polish;
	}
	public String getProd_vnyl() {
		return prod_vnyl;
	}
	public void setProd_vnyl(String prod_vnyl) {
		this.prod_vnyl = prod_vnyl;
	}
	public String getProd_plt() {
		return prod_plt;
	}
	public void setProd_plt(String prod_plt) {
		this.prod_plt = prod_plt;
	}
	public String getProd_pad() {
		return prod_pad;
	}
	public void setProd_pad(String prod_pad) {
		this.prod_pad = prod_pad;
	}
	public String getProd_danch() {
		return prod_danch;
	}
	public void setProd_danch(String prod_danch) {
		this.prod_danch = prod_danch;
	}
	public String getProd_bangch() {
		return prod_bangch;
	}
	public void setProd_bangch(String prod_bangch) {
		this.prod_bangch = prod_bangch;
	}
	public String getProd_note() {
		return prod_note;
	}
	public void setProd_note(String prod_note) {
		this.prod_note = prod_note;
	}
	public String getProd_img() {
		return prod_img;
	}
	public void setProd_img(String prod_img) {
		this.prod_img = prod_img;
	}
	public String getDanch_img() {
		return danch_img;
	}
	public void setDanch_img(String danch_img) {
		this.danch_img = danch_img;
	}
	public String getJisi_h_bigo() {
		return jisi_h_bigo;
	}
	public void setJisi_h_bigo(String jisi_h_bigo) {
		this.jisi_h_bigo = jisi_h_bigo;
	}
	public String getFac1() {
		return fac1;
	}
	public void setFac1(String fac1) {
		this.fac1 = fac1;
	}
	public String getFac2() {
		return fac2;
	}
	public void setFac2(String fac2) {
		this.fac2 = fac2;
	}
	public String getFac3() {
		return fac3;
	}
	public void setFac3(String fac3) {
		this.fac3 = fac3;
	}
	public String getFac4() {
		return fac4;
	}
	public void setFac4(String fac4) {
		this.fac4 = fac4;
	}
	public String getFac5() {
		return fac5;
	}
	public void setFac5(String fac5) {
		this.fac5 = fac5;
	}
	public String getFac6() {
		return fac6;
	}
	public void setFac6(String fac6) {
		this.fac6 = fac6;
	}
	public String getFac7() {
		return fac7;
	}
	public void setFac7(String fac7) {
		this.fac7 = fac7;
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
	public String getIlbo_gubn() {
		return ilbo_gubn;
	}
	public void setIlbo_gubn(String ilbo_gubn) {
		this.ilbo_gubn = ilbo_gubn;
	}
	public String getIlbo_lot() {
		return ilbo_lot;
	}
	public void setIlbo_lot(String ilbo_lot) {
		this.ilbo_lot = ilbo_lot;
	}
	public float getIlbo_su() {
		return ilbo_su;
	}
	public void setIlbo_su(float ilbo_su) {
		this.ilbo_su = ilbo_su;
	}
	public float getIlbo_jung() {
		return ilbo_jung;
	}
	public void setIlbo_jung(float ilbo_jung) {
		this.ilbo_jung = ilbo_jung;
	}
	public String getIlbo_strt() {
		return ilbo_strt;
	}
	public void setIlbo_strt(String ilbo_strt) {
		this.ilbo_strt = ilbo_strt;
	}
	public String getIlbo_end() {
		return ilbo_end;
	}
	public void setIlbo_end(String ilbo_end) {
		this.ilbo_end = ilbo_end;
	}
	public int getUser_code() {
		return user_code;
	}
	public void setUser_code(int user_code) {
		this.user_code = user_code;
	}
	public String getIlbo_g11() {
		return ilbo_g11;
	}
	public void setIlbo_g11(String ilbo_g11) {
		this.ilbo_g11 = ilbo_g11;
	}
	public String getIlbo_g12() {
		return ilbo_g12;
	}
	public void setIlbo_g12(String ilbo_g12) {
		this.ilbo_g12 = ilbo_g12;
	}
	public String getIlbo_g13() {
		return ilbo_g13;
	}
	public void setIlbo_g13(String ilbo_g13) {
		this.ilbo_g13 = ilbo_g13;
	}
	public String getIlbo_g21() {
		return ilbo_g21;
	}
	public void setIlbo_g21(String ilbo_g21) {
		this.ilbo_g21 = ilbo_g21;
	}
	public String getIlbo_g22() {
		return ilbo_g22;
	}
	public void setIlbo_g22(String ilbo_g22) {
		this.ilbo_g22 = ilbo_g22;
	}
	public String getIlbo_g23() {
		return ilbo_g23;
	}
	public void setIlbo_g23(String ilbo_g23) {
		this.ilbo_g23 = ilbo_g23;
	}
	public String getIlbo_g24() {
		return ilbo_g24;
	}
	public void setIlbo_g24(String ilbo_g24) {
		this.ilbo_g24 = ilbo_g24;
	}
	public String getIlbo_g25() {
		return ilbo_g25;
	}
	public void setIlbo_g25(String ilbo_g25) {
		this.ilbo_g25 = ilbo_g25;
	}
	public String getIlbo_g26() {
		return ilbo_g26;
	}
	public void setIlbo_g26(String ilbo_g26) {
		this.ilbo_g26 = ilbo_g26;
	}
	public String getIlbo_g27() {
		return ilbo_g27;
	}
	public void setIlbo_g27(String ilbo_g27) {
		this.ilbo_g27 = ilbo_g27;
	}
	public String getIlbo_g31() {
		return ilbo_g31;
	}
	public void setIlbo_g31(String ilbo_g31) {
		this.ilbo_g31 = ilbo_g31;
	}
	public String getIlbo_g32() {
		return ilbo_g32;
	}
	public void setIlbo_g32(String ilbo_g32) {
		this.ilbo_g32 = ilbo_g32;
	}
	public String getIlbo_g33() {
		return ilbo_g33;
	}
	public void setIlbo_g33(String ilbo_g33) {
		this.ilbo_g33 = ilbo_g33;
	}
	public String getIlbo_g34() {
		return ilbo_g34;
	}
	public void setIlbo_g34(String ilbo_g34) {
		this.ilbo_g34 = ilbo_g34;
	}
	public String getIlbo_g35() {
		return ilbo_g35;
	}
	public void setIlbo_g35(String ilbo_g35) {
		this.ilbo_g35 = ilbo_g35;
	}
	public String getIlbo_pg1() {
		return ilbo_pg1;
	}
	public void setIlbo_pg1(String ilbo_pg1) {
		this.ilbo_pg1 = ilbo_pg1;
	}
	public String getIlbo_pg2() {
		return ilbo_pg2;
	}
	public void setIlbo_pg2(String ilbo_pg2) {
		this.ilbo_pg2 = ilbo_pg2;
	}
	public String getIlbo_pg3() {
		return ilbo_pg3;
	}
	public void setIlbo_pg3(String ilbo_pg3) {
		this.ilbo_pg3 = ilbo_pg3;
	}
	public String getIlbo_pg4() {
		return ilbo_pg4;
	}
	public void setIlbo_pg4(String ilbo_pg4) {
		this.ilbo_pg4 = ilbo_pg4;
	}
	public String getIlbo_pg5() {
		return ilbo_pg5;
	}
	public void setIlbo_pg5(String ilbo_pg5) {
		this.ilbo_pg5 = ilbo_pg5;
	}
	public String getIlbo_pg6() {
		return ilbo_pg6;
	}
	public void setIlbo_pg6(String ilbo_pg6) {
		this.ilbo_pg6 = ilbo_pg6;
	}
	public String getIlbo_bigo() {
		return ilbo_bigo;
	}
	public void setIlbo_bigo(String ilbo_bigo) {
		this.ilbo_bigo = ilbo_bigo;
	}
	public int getIlbo_pc() {
		return ilbo_pc;
	}
	public void setIlbo_pc(int ilbo_pc) {
		this.ilbo_pc = ilbo_pc;
	}
	public int getIlbo_pn() {
		return ilbo_pn;
	}
	public void setIlbo_pn(int ilbo_pn) {
		this.ilbo_pn = ilbo_pn;
	}
	public String getIlbo_g14() {
		return ilbo_g14;
	}
	public void setIlbo_g14(String ilbo_g14) {
		this.ilbo_g14 = ilbo_g14;
	}
	public String getIlbo_g41() {
		return ilbo_g41;
	}
	public void setIlbo_g41(String ilbo_g41) {
		this.ilbo_g41 = ilbo_g41;
	}
	public String getIlbo_g42() {
		return ilbo_g42;
	}
	public void setIlbo_g42(String ilbo_g42) {
		this.ilbo_g42 = ilbo_g42;
	}
	public String getIlbo_g43() {
		return ilbo_g43;
	}
	public void setIlbo_g43(String ilbo_g43) {
		this.ilbo_g43 = ilbo_g43;
	}
	public String getIlbo_g44() {
		return ilbo_g44;
	}
	public void setIlbo_g44(String ilbo_g44) {
		this.ilbo_g44 = ilbo_g44;
	}
	public String getIlbo_g51() {
		return ilbo_g51;
	}
	public void setIlbo_g51(String ilbo_g51) {
		this.ilbo_g51 = ilbo_g51;
	}
	public String getIlbo_g52() {
		return ilbo_g52;
	}
	public void setIlbo_g52(String ilbo_g52) {
		this.ilbo_g52 = ilbo_g52;
	}
	public String getIlbo_g53() {
		return ilbo_g53;
	}
	public void setIlbo_g53(String ilbo_g53) {
		this.ilbo_g53 = ilbo_g53;
	}
	public String getIlbo_g54() {
		return ilbo_g54;
	}
	public void setIlbo_g54(String ilbo_g54) {
		this.ilbo_g54 = ilbo_g54;
	}
	public String getIlbo_g61() {
		return ilbo_g61;
	}
	public void setIlbo_g61(String ilbo_g61) {
		this.ilbo_g61 = ilbo_g61;
	}
	public String getIlbo_g62() {
		return ilbo_g62;
	}
	public void setIlbo_g62(String ilbo_g62) {
		this.ilbo_g62 = ilbo_g62;
	}
	public String getIlbo_g63() {
		return ilbo_g63;
	}
	public void setIlbo_g63(String ilbo_g63) {
		this.ilbo_g63 = ilbo_g63;
	}
	public String getIlbo_g64() {
		return ilbo_g64;
	}
	public void setIlbo_g64(String ilbo_g64) {
		this.ilbo_g64 = ilbo_g64;
	}
	public String getIlbo_cm() {
		return ilbo_cm;
	}
	public void setIlbo_cm(String ilbo_cm) {
		this.ilbo_cm = ilbo_cm;
	}
	public String getIlbo_okng() {
		return ilbo_okng;
	}
	public void setIlbo_okng(String ilbo_okng) {
		this.ilbo_okng = ilbo_okng;
	}
	public String getIlbo_ck01() {
		return ilbo_ck01;
	}
	public void setIlbo_ck01(String ilbo_ck01) {
		this.ilbo_ck01 = ilbo_ck01;
	}
	public String getIlbo_ck02() {
		return ilbo_ck02;
	}
	public void setIlbo_ck02(String ilbo_ck02) {
		this.ilbo_ck02 = ilbo_ck02;
	}
	public String getIlbo_ck03() {
		return ilbo_ck03;
	}
	public void setIlbo_ck03(String ilbo_ck03) {
		this.ilbo_ck03 = ilbo_ck03;
	}
	public String getIlbo_ck04() {
		return ilbo_ck04;
	}
	public void setIlbo_ck04(String ilbo_ck04) {
		this.ilbo_ck04 = ilbo_ck04;
	}
	public String getIlbo_ck05() {
		return ilbo_ck05;
	}
	public void setIlbo_ck05(String ilbo_ck05) {
		this.ilbo_ck05 = ilbo_ck05;
	}
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
	public String getCorp_gyul2() {
		return corp_gyul2;
	}
	public void setCorp_gyul2(String corp_gyul2) {
		this.corp_gyul2 = corp_gyul2;
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
	public int getDanch_su() {
		return danch_su;
	}
	public void setDanch_su(int danch_su) {
		this.danch_su = danch_su;
	}
	public int getDanch_remain_su() {
		return danch_remain_su;
	}
	public void setDanch_remain_su(int danch_remain_su) {
		this.danch_remain_su = danch_remain_su;
	}
	public int getDanch_sunip_chk() {
		return danch_sunip_chk;
	}
	public void setDanch_sunip_chk(int danch_sunip_chk) {
		this.danch_sunip_chk = danch_sunip_chk;
	}
	public String getDanch_sunip_chk_pw() {
		return danch_sunip_chk_pw;
	}
	public void setDanch_sunip_chk_pw(String danch_sunip_chk_pw) {
		this.danch_sunip_chk_pw = danch_sunip_chk_pw;
	}
	public int getDanch_total_cnt() {
		return danch_total_cnt;
	}
	public void setDanch_total_cnt(int danch_total_cnt) {
		this.danch_total_cnt = danch_total_cnt;
	}
	public int getDanch_std_cnt() {
		return danch_std_cnt;
	}
	public void setDanch_std_cnt(int danch_std_cnt) {
		this.danch_std_cnt = danch_std_cnt;
	}
	public String getOrd_input_view() {
		return ord_input_view;
	}
	public void setOrd_input_view(String ord_input_view) {
		this.ord_input_view = ord_input_view;
	}
	public List<Integer> getSunipOrdList() {
		return sunipOrdList;
	}
	public void setSunipOrdList(List<Integer> sunipOrdList) {
		this.sunipOrdList = sunipOrdList;
	}
	public String getProduct_file_name() {
		return product_file_name;
	}
	public void setProduct_file_name(String product_file_name) {
		this.product_file_name = product_file_name;
	}
	public String getApperance_file_name() {
		return apperance_file_name;
	}
	public void setApperance_file_name(String apperance_file_name) {
		this.apperance_file_name = apperance_file_name;
	}
	public String getHeat_file_name() {
		return heat_file_name;
	}
	public void setHeat_file_name(String heat_file_name) {
		this.heat_file_name = heat_file_name;
	}
	public String getDrawing_file_name() {
		return drawing_file_name;
	}
	public void setDrawing_file_name(String drawing_file_name) {
		this.drawing_file_name = drawing_file_name;
	}
	public String getWstd_chim_file_name1() {
		return wstd_chim_file_name1;
	}
	public void setWstd_chim_file_name1(String wstd_chim_file_name1) {
		this.wstd_chim_file_name1 = wstd_chim_file_name1;
	}
	public String getWstd_chim_file_name2() {
		return wstd_chim_file_name2;
	}
	public void setWstd_chim_file_name2(String wstd_chim_file_name2) {
		this.wstd_chim_file_name2 = wstd_chim_file_name2;
	}
	public String getFac_gyu() {
		return fac_gyu;
	}
	public void setFac_gyu(String fac_gyu) {
		this.fac_gyu = fac_gyu;
	}
	public String getWstd_gj11() {
		return wstd_gj11;
	}
	public void setWstd_gj11(String wstd_gj11) {
		this.wstd_gj11 = wstd_gj11;
	}
	public String getWstd_gj12() {
		return wstd_gj12;
	}
	public void setWstd_gj12(String wstd_gj12) {
		this.wstd_gj12 = wstd_gj12;
	}
	public String getWstd_gj13() {
		return wstd_gj13;
	}
	public void setWstd_gj13(String wstd_gj13) {
		this.wstd_gj13 = wstd_gj13;
	}
	public String getWstd_gj14() {
		return wstd_gj14;
	}
	public void setWstd_gj14(String wstd_gj14) {
		this.wstd_gj14 = wstd_gj14;
	}
	public String getWstd_gj15() {
		return wstd_gj15;
	}
	public void setWstd_gj15(String wstd_gj15) {
		this.wstd_gj15 = wstd_gj15;
	}
	public String getWstd_gj16() {
		return wstd_gj16;
	}
	public void setWstd_gj16(String wstd_gj16) {
		this.wstd_gj16 = wstd_gj16;
	}
	public String getWstd_gj17() {
		return wstd_gj17;
	}
	public void setWstd_gj17(String wstd_gj17) {
		this.wstd_gj17 = wstd_gj17;
	}
	public String getWstd_gj21() {
		return wstd_gj21;
	}
	public void setWstd_gj21(String wstd_gj21) {
		this.wstd_gj21 = wstd_gj21;
	}
	public String getWstd_gj22() {
		return wstd_gj22;
	}
	public void setWstd_gj22(String wstd_gj22) {
		this.wstd_gj22 = wstd_gj22;
	}
	public String getWstd_gj23() {
		return wstd_gj23;
	}
	public void setWstd_gj23(String wstd_gj23) {
		this.wstd_gj23 = wstd_gj23;
	}
	public String getWstd_gj24() {
		return wstd_gj24;
	}
	public void setWstd_gj24(String wstd_gj24) {
		this.wstd_gj24 = wstd_gj24;
	}
	public String getWstd_gj32() {
		return wstd_gj32;
	}
	public void setWstd_gj32(String wstd_gj32) {
		this.wstd_gj32 = wstd_gj32;
	}
	public String getWstd_gj33() {
		return wstd_gj33;
	}
	public void setWstd_gj33(String wstd_gj33) {
		this.wstd_gj33 = wstd_gj33;
	}
	public String getWstd_gj34() {
		return wstd_gj34;
	}
	public void setWstd_gj34(String wstd_gj34) {
		this.wstd_gj34 = wstd_gj34;
	}
	public String getWstd_gj42() {
		return wstd_gj42;
	}
	public void setWstd_gj42(String wstd_gj42) {
		this.wstd_gj42 = wstd_gj42;
	}
	public String getIlbo_lot_date() {
		return ilbo_lot_date;
	}
	public void setIlbo_lot_date(String ilbo_lot_date) {
		this.ilbo_lot_date = ilbo_lot_date;
	}
	public String getIlbo_lot_count() {
		return ilbo_lot_count;
	}
	public void setIlbo_lot_count(String ilbo_lot_count) {
		this.ilbo_lot_count = ilbo_lot_count;
	}
}
