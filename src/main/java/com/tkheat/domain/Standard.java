package com.tkheat.domain;

import com.fasterxml.jackson.annotation.JsonProperty;

public class Standard {

	//WORKSTD 테이블
	
	private int wstd_code;
//	private int prod_code;		//vProduct 중복
	//침탄로 작업표준등록
	private String fac_code1;			//전세척 - 설비	(침탄,고주파동일)
	private String wstd_n01;			//전세척 - 온도(침탄,고주파동일)
	private String wstd_n02;			//전세척 - 시간(침탄,고주파동일)
	private String wstd_t66;			//전세척 - 농도	(침탄,고주파동일)
	private String wstd_gj11;			//공정 - 예열온도
	private String wstd_gj12;			//공정 - 침탄온도
	private String wstd_gj13;			//공정 - 확산온도
	private String wstd_gj14;			//공정 - 강온온도
	private String wstd_gj15;			//공정 - 균열온도
	private String wstd_gj16;			//공정 - 유조온도
	private String wstd_gj17;			//공정 - 교반기온도
	private String wstd_gj18;			//공정 - 냉간시간온도
	private String wstd_gj21;			//공정 - 예열시간[분]
	private String wstd_gj22;			//공정 - 침탄시간[분]
	private String wstd_gj23;			//공정 - 확산시간[분]
	private String wstd_gj24;			//공정 - 강온시간[분]
	private String wstd_gj25;			//공정 - 균열시간[분]
	private String wstd_gj26;			//공정 - 유조시간[분]
	private String wstd_gj27;			//공정 - 교반기시간[분]
	private String wstd_gj28;			//공정 - 냉각시간[분]
	private String wstd_gj31;			//공정 - 예열CP[%]
	private String wstd_gj32;			//공정 - 침탄CP[%]
	private String wstd_gj33;			//공정 - 확산CP[%]
	private String wstd_gj34;			//공정 - 강온CP[%]
	private String wstd_gj35;			//공정 - 균열CP[%]
	private String wstd_gj36;			//공정 - 유조CP[%]
	private String wstd_gj37;			//공정 - 교반기CP[%]
	private String wstd_gj38;			//공정 - 냉각시간CP[%]
	private String wstd_gj39;			//공정 - 예열RX
	private String wstd_gj42;			//공정 - 침탄RX
	private String wstd_gj43;			//공정 - 확산RX
	private String wstd_gj44;			//공정 - 강온RX
	private String wstd_gj45;			//공정 - 균열RX
	private String wstd_gj49;			//공정 - 예열LPG
	private String wstd_gj52;			//공정 - 침탄LPG
	private String wstd_gj53;			//공정 - 확산LPG
	private String wstd_gj54;			//공정 - 강온LPG
	private String wstd_gj55;			//공정 - 균열LPG
	private String wstd_gj59;			//공정 - 예열 CH3OH
	private String wstd_gj62;			//공정 - 침탄 CH3OH
	private String wstd_gj63;			//공정 - 확산 CH3OH
	private String wstd_gj64;			//공정 - 강온 CH3OH
	private String wstd_gj65;			//공정 - 균열 CH3OH
	private String wstd_gj69;			//공정 - 예열 N2	
	private String wstd_gj72;			//공정 - 침탄 N2
	private String wstd_gj73;			//공정 - 확산 N2
	private String wstd_gj74;			//공정 - 강온 N2
	private String wstd_gj75;			//공정 - 균열 N2
	private String wstd_gj79;			//공정 - 예열 NH3
	private String wstd_gj82;			//공정 - 침탄 NH3
	private String wstd_gj83;			//공정 - 확산 NH3
	private String wstd_gj84;			//공정 - 강온 NH3
	private String wstd_gj85;			//공정 - 균열 NH3
	private String wstd_gjsu;			//공정 - 수량
	private String wstd_gjrpm;			//공정 - RPM
	private String wstd_note;			//공정 - 비고
	private int fac_code;				//공정 - 설비(침탄,고주파동일)
	private String report_type;			//공정 - 보고서 유형
	private String fac_code2;			//후세척 - 설비	(침탄,고주파동일)
	private String wstd_n03;			//후세척 - 온도(침탄,고주파동일)
	private String wstd_n04;			//후세척 - 시간(침탄,고주파동일)
	private String wstd_t67;			//후세척 - 농도	(침탄,고주파동일)
	private String wstd_ready;			//1차템퍼링 - 온도(침탄,고주파동일)
	private String wstd_worktime;		//1차템퍼링 - 시간(침탄,고주파동일)
	private String wstd_t62;			//1차템퍼링 - 비고(침탄,고주파동일)
	private String wstd_t63;			//2차템퍼링 - 온도
	private String wstd_t64;			//2차템퍼링 - 시간
	private String wstd_t65;			//2차템퍼링 - 비고
	private String wstd_gj97;			//후처리 - 수량(침탄,고주파동일)
	private String fac_code3;			//후처리 - 설비	(침탄,고주파동일)
	private String wstd_gj98;			//후처리 - 1차처리(침탄,고주파동일)
	private String wstd_gj99;			//후처리 - 1차처리 압력(침탄,고주파동일)
	private String wstd_gj100;			//후처리 - 2차처리(침탄,고주파동일)
	private String wstd_gj101;			//후처리 - 2차처리 압력(침탄,고주파동일)
	private String wstd_t68;			//심냉처리 - 예냉온도
	private String wstd_t69;			//심냉처리 - 예냉시간
	private String wstd_t70;			//심냉처리 - 심냉온도
	private String wstd_t71;			//심냉처리 - 심냉시간
	private String wstd_t72;			//심냉처리 - 방냉후실온
	private String wstd_t73;			//심냉처리 - 비고
	private String wstd_t32;			//단취방법 - EA/줄(판) (침탄,고주파동일)
	private String wstd_t33;			//단취방법 - 줄(판)/단 (침탄,고주파동일)
	private String wstd_t41;			//단취방법 - 단/Tray (침탄,고주파동일)
	private String wstd_t42;			//단취방법 - Tray차지 (침탄,고주파동일)
	private String wstd_t87;			//단취방법 - 추가수량 (침탄,고주파동일)
	private String wstd_t43;			//단취방법 - 단취수량 (침탄,고주파동일)
	private String wstd_t44;			//단취방법 - Jig무게 (침탄,고주파동일)
	private String wstd_t51;			//단취방법 - 제품무게/ch (침탄,고주파동일)
	private String wstd_t52;			//단취방법 - 총단중/ch (침탄,고주파동일)
	private String wstd_t53;			//단취방법 - 단취시 유의사항 -1 (침탄,고주파동일)
	private String wstd_t54;			//단취방법 - 단취시 유의사항 -2 (침탄,고주파동일)
	private String wstd_t30;			//단취방법 - 단취시 유의사항 -3 (침탄,고주파동일)
	private String wstd_t40;			//단취방법 - 단중 (침탄,고주파동일)
	private String wstd_g11;			//개정이력 개정일자-1 (침탄,고주파동일)
	private String wstd_g12;			//개정이력 개정사유-1 (침탄,고주파동일)
	private String wstd_g21;			//개정이력 개정일자-2 (침탄,고주파동일)
	private String wstd_g22;			//개정이력 개정사유-2 (침탄,고주파동일)
	private String wstd_g31;			//개정이력 개정일자-3 (침탄,고주파동일)
	private String wstd_g32;			//개정이력 개정사유-3 (침탄,고주파동일)
	private String wstd_g41;			//개정이력 개정일자-4 (침탄,고주파동일)
	private String wstd_g42;			//개정이력 개정사유-4 (침탄,고주파동일)
										//이미지파일(?)
	
	//고주파로작업표준등록
	private String wstd_h01;			//공정 - PLUG준비
	private String wstd_h02;			//공정 - COIL준비
	private String wstd_h03;			//공정 - COIL받침볼트높이
	private String wstd_h04;			//공정 - 유도자간격
	private String wstd_h05;			//공정 - 내주1차가열[지연시간]
	private String wstd_h06;			//공정 - 외주1차가열[지연시간]
	private String wstd_h07;			//공정 - 내주2차가열[지연시간]
	private String wstd_h08;			//공정 - 외주2차가열[지연시간]
	private String wstd_h09;			//공정 - 내주냉각[지연시간]
	private String wstd_h10;			//공정 - 외주냉각[지연시간]
	private String wstd_h11;			//공정 - 내주1차가열[시간]
	private String wstd_h12;			//공정 - 외주1차가열[시간]
	private String wstd_h13;			//공정 - 내주2차가열[시간]
	private String wstd_h14;			//공정 - 외주2차가열[시간]
	private String wstd_h15;			//공정 - 내주냉각[시간]
	private String wstd_h16;			//공정 - 외주냉각[시간]
	private String wstd_h17;			//공정 - 내주1차가열[전압(유량)]
	private String wstd_h18;			//공정 - 외주1차가열[전압(유량)]
	private String wstd_h19;			//공정 - 내주2차가열[전압(유량)]
	private String wstd_h20;			//공정 - 외주2차가열[전압(유량)]
	private String wstd_h21;			//공정 - 내주냉각[전압(유량)]
	private String wstd_h22;			//공정 - 외주냉각[전압(유량)]
	private String wstd_h23;			//공정 - 소입수AIR BLOW 시간
	private String wstd_h24;			//공정 - AIR BLOW 시간
	private String wstd_h25;			//공정 - 소입수온도
	private String wstd_h26;			//공정 - 소입수농도
	
	
	private String wstd_n05;
	private String wstd_n06;
	private String wstd_n07;
	private String wstd_n08;
	private String wstd_n09;
	private String wstd_n10;
	private String wstd_n11;
	private String wstd_n12;
	private String wstd_n13;
	private String wstd_n14;
//	private int fac_code;			//FACILITY 테이블 중복
	private String wstd_nh3;
	private String wstd_g13;
	private String wstd_g23;
	private String wstd_g24;
	private String wstd_g25;
	private String wstd_g26;
	private String wstd_g27;
	private String wstd_g33;
	private String wstd_g51;
	private String wstd_g52;
	private String wstd_g53;
	private String wstd_worknote;
	private String wstd_t11;
	private String wstd_t12;
	private String wstd_t13;
	private String wstd_t14;
	private String wstd_t21;
	private String wstd_t22;
	private String wstd_t23;
	private String wstd_t24;
	private String wstd_t31;
	private String wstd_t34;
	private String wstd_gubn;
	private String wstd_t55;
	private String wstd_t56;
	private String wstd_t57;
	private String wstd_t58;
	private String wstd_t59;
	private String wstd_t60;
	private String wstd_t61;
	private String wstd_ch3oh;
	private String wstd_gumnote;
	private String wstd_h27;
	private String wstd_h28;
	private String wstd_h29;
	private String wstd_h30;
	private String wstd_h31;
	private String wstd_h32;
	private String wstd_h33;
	private String wstd_h34;
	private String wstd_h35;
	private String wstd_h36;
	private String wstd_h37;
	private String wstd_h38;
	private String wstd_h39;
	private String wstd_h40;
	private String wstd_h41;
	private String wstd_h42;
	private String wstd_h43;
	private String wstd_h44;
	
	private String wstd_t74;
	private String wstd_t75;
	private String wstd_t76;
	private String wstd_t77;
	private String wstd_t78;
	private String wstd_t79;
	private String wstd_t80;
	
	private String wstd_gumnote2;
	private String wstd_worke2;
	private String wstd_t81;
	private String wstd_t82;
	private String wstd_t83;
	private String wstd_t84;
	private String wstd_t85;
	private String wstd_t86;
	private String wstd_tbd;
	private String wstd_ttt;
	private String wstd_tig;
	private String wstd_thj;
	private String wstd_gj19;
	private String wstd_gj1a;
	private String wstd_gj29;
	private String wstd_gj2a;
	private String wstd_gj3a;			
	private String wstd_gj41;			
	
	private String wstd_gj46;
	private String wstd_gj47;
	private String wstd_gj48;
	
	private String wstd_gj4a;
	private String wstd_gj51;
	private String wstd_gj56;
	private String wstd_gj57;
	private String wstd_gj58;
	
	private String wstd_gj5a;
	private String wstd_gj61;
	private String wstd_gj66;
	private String wstd_gj67;
	private String wstd_gj68;

	private String wstd_gj71;			
	private String wstd_gj76;
	private String wstd_gj77;
	private String wstd_gj78;
	
	private String wstd_gj81;
	private String wstd_gj86;
	private String wstd_gj87;
	private String wstd_gj88;	
	private String wstd_gj91;
	private String wstd_gj92;
	private String wstd_gj93;
	private String wstd_gj94;
	private String wstd_gj95;
	private String wstd_gj96;			
	private String wstd_gj102;
	private String wstd_gj103;
	private String wstd_gj104;
	private String wstd_gj105;
	private String wstd_gj106;
	private String wstd_gj107;
	private String wstd_gj108;
	private String wstd_gja6;
	private String wstd_js08;
	private String wstd_step08;
	private String wstd_js07;
	private String wstd_step07;
	private String wstd_t50;
	private String cool;
	
	
	
	//vProduct 뷰테이블(PRODUCT 객체 참조)
	private String corp_name;
    private String prod_name;
    private String prod_no;
    private String prod_gyu;
    private String prod_dang;
    private String prod_danw;
    private String prod_code;
    private String prodpg;
    private String prod_pg1;
    private String prod_pg2;
    private String prodsg;
    private String prod_sg1;
    private String prod_sg2;
    private String prodgd1;
    private String prodgd2;
    private String prodcd;
    private String tech_te;
    private String prod_jai;
    private String prod_gubn;
    private String prod_e1;
    private String prod_e2;
    private String prod_e3;
    private String prod_e4;
    private String prod_pgs;
    private String prod_pgs1;
    private String prod_pgs2;
    private String prod_gd2;
    private String prod_cno;
    private String prod_danj;
    private String prod_e5;
    private String prod_do;
    private String prod_ra;
    private String prod_kijong;
    private String prod_gd4;
    private String prod_gd5;
    private String prod_gd1;
    private String prod_gd3;
    
	//FACILITY 테이블
			
	private String fac_no;			//설비번호
	private String fac_name;		//설비명
	private String fac_gyu;			//설비규격[가스질화/이온질화/침탄/VC/PQ/TEMPERING/진공/세척기/후처리/기타]
	private String fac_hyun;		//설비형식
	private String fac_yong;		//설비용도
	private String fac_man1;		//관리자(정)
	private String fac_man2;		//관리자(부)
	private String fac_plc;			//설치장소
	private String fac_make;		//제조회사
	private String fac_cbuy;		//구입처
	private String fac_buy;			//도입시기
	private String fac_mday;		//제조일자
	private String fac_mon;			//구입가격
	private String fac_able;		//처리용량
	private String fac_time;		//기동시간 기준
	private String fac_test;		//점검주기
	private String fac_bigo;		//비고
	private String fac_tech_no;
	private String fac_gubn;
	private String fac_e1;			//제조번호
	private String fac_e2;			//제조사 국적
	private String fac_e3;			//유지보수업체
	private String fac_e4;			//주변설비 및 관련사항
	private String fac_lot;			//사용부서
	private String fac_dan;			//실적현황 출력
	private String fac_unus;		//특이사항
	private String fac_cau;			//설비점검 주의사항
	private String fac_pda_use;
	private String fac_state;
	private String wstd_chim_file_name1; //단취사진 이름
	private String wstd_chim_file_name2; //사진-3
	private String drawing_file_name;
	private String prod_drawing_file_name;
	private String prod_product_file_name;
	
	
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
	public int getWstd_code() {
		return wstd_code;
	}
	public void setWstd_code(int wstd_code) {
		this.wstd_code = wstd_code;
	}
	public String getWstd_note() {
		return wstd_note;
	}
	public void setWstd_note(String wstd_note) {
		this.wstd_note = wstd_note;
	}
	public String getWstd_n01() {
		return wstd_n01;
	}
	public void setWstd_n01(String wstd_n01) {
		this.wstd_n01 = wstd_n01;
	}
	public String getWstd_n02() {
		return wstd_n02;
	}
	public void setWstd_n02(String wstd_n02) {
		this.wstd_n02 = wstd_n02;
	}
	public String getWstd_n03() {
		return wstd_n03;
	}
	public void setWstd_n03(String wstd_n03) {
		this.wstd_n03 = wstd_n03;
	}
	public String getWstd_n04() {
		return wstd_n04;
	}
	public void setWstd_n04(String wstd_n04) {
		this.wstd_n04 = wstd_n04;
	}
	public String getWstd_n05() {
		return wstd_n05;
	}
	public void setWstd_n05(String wstd_n05) {
		this.wstd_n05 = wstd_n05;
	}
	public String getWstd_n06() {
		return wstd_n06;
	}
	public void setWstd_n06(String wstd_n06) {
		this.wstd_n06 = wstd_n06;
	}
	public String getWstd_n07() {
		return wstd_n07;
	}
	public void setWstd_n07(String wstd_n07) {
		this.wstd_n07 = wstd_n07;
	}
	public String getWstd_n08() {
		return wstd_n08;
	}
	public void setWstd_n08(String wstd_n08) {
		this.wstd_n08 = wstd_n08;
	}
	public String getWstd_n09() {
		return wstd_n09;
	}
	public void setWstd_n09(String wstd_n09) {
		this.wstd_n09 = wstd_n09;
	}
	public String getWstd_n10() {
		return wstd_n10;
	}
	public void setWstd_n10(String wstd_n10) {
		this.wstd_n10 = wstd_n10;
	}
	public String getWstd_n11() {
		return wstd_n11;
	}
	public void setWstd_n11(String wstd_n11) {
		this.wstd_n11 = wstd_n11;
	}
	public String getWstd_n12() {
		return wstd_n12;
	}
	public void setWstd_n12(String wstd_n12) {
		this.wstd_n12 = wstd_n12;
	}
	public String getWstd_n13() {
		return wstd_n13;
	}
	public void setWstd_n13(String wstd_n13) {
		this.wstd_n13 = wstd_n13;
	}
	public String getWstd_n14() {
		return wstd_n14;
	}
	public void setWstd_n14(String wstd_n14) {
		this.wstd_n14 = wstd_n14;
	}
	public String getWstd_ready() {
		return wstd_ready;
	}
	public void setWstd_ready(String wstd_ready) {
		this.wstd_ready = wstd_ready;
	}
	public int getFac_code() {
		return fac_code;
	}
	public void setFac_code(int fac_code) {
		this.fac_code = fac_code;
	}
	public String getWstd_worktime() {
		return wstd_worktime;
	}
	public void setWstd_worktime(String wstd_worktime) {
		this.wstd_worktime = wstd_worktime;
	}
	public String getWstd_nh3() {
		return wstd_nh3;
	}
	public void setWstd_nh3(String wstd_nh3) {
		this.wstd_nh3 = wstd_nh3;
	}
	public String getWstd_g11() {
		return wstd_g11;
	}
	public void setWstd_g11(String wstd_g11) {
		this.wstd_g11 = wstd_g11;
	}
	public String getWstd_g12() {
		return wstd_g12;
	}
	public void setWstd_g12(String wstd_g12) {
		this.wstd_g12 = wstd_g12;
	}
	public String getWstd_g13() {
		return wstd_g13;
	}
	public void setWstd_g13(String wstd_g13) {
		this.wstd_g13 = wstd_g13;
	}
	public String getWstd_g21() {
		return wstd_g21;
	}
	public void setWstd_g21(String wstd_g21) {
		this.wstd_g21 = wstd_g21;
	}
	public String getWstd_g22() {
		return wstd_g22;
	}
	public void setWstd_g22(String wstd_g22) {
		this.wstd_g22 = wstd_g22;
	}
	public String getWstd_g23() {
		return wstd_g23;
	}
	public void setWstd_g23(String wstd_g23) {
		this.wstd_g23 = wstd_g23;
	}
	public String getWstd_g24() {
		return wstd_g24;
	}
	public void setWstd_g24(String wstd_g24) {
		this.wstd_g24 = wstd_g24;
	}
	public String getWstd_g25() {
		return wstd_g25;
	}
	public void setWstd_g25(String wstd_g25) {
		this.wstd_g25 = wstd_g25;
	}
	public String getWstd_g26() {
		return wstd_g26;
	}
	public void setWstd_g26(String wstd_g26) {
		this.wstd_g26 = wstd_g26;
	}
	public String getWstd_g27() {
		return wstd_g27;
	}
	public void setWstd_g27(String wstd_g27) {
		this.wstd_g27 = wstd_g27;
	}
	public String getWstd_g31() {
		return wstd_g31;
	}
	public void setWstd_g31(String wstd_g31) {
		this.wstd_g31 = wstd_g31;
	}
	public String getWstd_g32() {
		return wstd_g32;
	}
	public void setWstd_g32(String wstd_g32) {
		this.wstd_g32 = wstd_g32;
	}
	public String getWstd_g33() {
		return wstd_g33;
	}
	public void setWstd_g33(String wstd_g33) {
		this.wstd_g33 = wstd_g33;
	}
	public String getWstd_g41() {
		return wstd_g41;
	}
	public void setWstd_g41(String wstd_g41) {
		this.wstd_g41 = wstd_g41;
	}
	public String getWstd_g42() {
		return wstd_g42;
	}
	public void setWstd_g42(String wstd_g42) {
		this.wstd_g42 = wstd_g42;
	}
	public String getWstd_g51() {
		return wstd_g51;
	}
	public void setWstd_g51(String wstd_g51) {
		this.wstd_g51 = wstd_g51;
	}
	public String getWstd_g52() {
		return wstd_g52;
	}
	public void setWstd_g52(String wstd_g52) {
		this.wstd_g52 = wstd_g52;
	}
	public String getWstd_g53() {
		return wstd_g53;
	}
	public void setWstd_g53(String wstd_g53) {
		this.wstd_g53 = wstd_g53;
	}
	public String getWstd_worknote() {
		return wstd_worknote;
	}
	public void setWstd_worknote(String wstd_worknote) {
		this.wstd_worknote = wstd_worknote;
	}
	public String getWstd_t11() {
		return wstd_t11;
	}
	public void setWstd_t11(String wstd_t11) {
		this.wstd_t11 = wstd_t11;
	}
	public String getWstd_t12() {
		return wstd_t12;
	}
	public void setWstd_t12(String wstd_t12) {
		this.wstd_t12 = wstd_t12;
	}
	public String getWstd_t13() {
		return wstd_t13;
	}
	public void setWstd_t13(String wstd_t13) {
		this.wstd_t13 = wstd_t13;
	}
	public String getWstd_t14() {
		return wstd_t14;
	}
	public void setWstd_t14(String wstd_t14) {
		this.wstd_t14 = wstd_t14;
	}
	public String getWstd_t21() {
		return wstd_t21;
	}
	public void setWstd_t21(String wstd_t21) {
		this.wstd_t21 = wstd_t21;
	}
	public String getWstd_t22() {
		return wstd_t22;
	}
	public void setWstd_t22(String wstd_t22) {
		this.wstd_t22 = wstd_t22;
	}
	public String getWstd_t23() {
		return wstd_t23;
	}
	public void setWstd_t23(String wstd_t23) {
		this.wstd_t23 = wstd_t23;
	}
	public String getWstd_t24() {
		return wstd_t24;
	}
	public void setWstd_t24(String wstd_t24) {
		this.wstd_t24 = wstd_t24;
	}
	public String getWstd_t31() {
		return wstd_t31;
	}
	public void setWstd_t31(String wstd_t31) {
		this.wstd_t31 = wstd_t31;
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
	public String getWstd_t34() {
		return wstd_t34;
	}
	public void setWstd_t34(String wstd_t34) {
		this.wstd_t34 = wstd_t34;
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
	public String getWstd_gubn() {
		return wstd_gubn;
	}
	public void setWstd_gubn(String wstd_gubn) {
		this.wstd_gubn = wstd_gubn;
	}
	public String getWstd_t55() {
		return wstd_t55;
	}
	public void setWstd_t55(String wstd_t55) {
		this.wstd_t55 = wstd_t55;
	}
	public String getWstd_t56() {
		return wstd_t56;
	}
	public void setWstd_t56(String wstd_t56) {
		this.wstd_t56 = wstd_t56;
	}
	public String getWstd_t57() {
		return wstd_t57;
	}
	public void setWstd_t57(String wstd_t57) {
		this.wstd_t57 = wstd_t57;
	}
	public String getWstd_t58() {
		return wstd_t58;
	}
	public void setWstd_t58(String wstd_t58) {
		this.wstd_t58 = wstd_t58;
	}
	public String getWstd_t59() {
		return wstd_t59;
	}
	public void setWstd_t59(String wstd_t59) {
		this.wstd_t59 = wstd_t59;
	}
	public String getWstd_t60() {
		return wstd_t60;
	}
	public void setWstd_t60(String wstd_t60) {
		this.wstd_t60 = wstd_t60;
	}
	public String getWstd_t61() {
		return wstd_t61;
	}
	public void setWstd_t61(String wstd_t61) {
		this.wstd_t61 = wstd_t61;
	}
	public String getWstd_t62() {
		return wstd_t62;
	}
	public void setWstd_t62(String wstd_t62) {
		this.wstd_t62 = wstd_t62;
	}
	public String getWstd_t63() {
		return wstd_t63;
	}
	public void setWstd_t63(String wstd_t63) {
		this.wstd_t63 = wstd_t63;
	}
	public String getWstd_t64() {
		return wstd_t64;
	}
	public void setWstd_t64(String wstd_t64) {
		this.wstd_t64 = wstd_t64;
	}
	public String getWstd_t65() {
		return wstd_t65;
	}
	public void setWstd_t65(String wstd_t65) {
		this.wstd_t65 = wstd_t65;
	}
	public String getWstd_t66() {
		return wstd_t66;
	}
	public void setWstd_t66(String wstd_t66) {
		this.wstd_t66 = wstd_t66;
	}
	public String getWstd_t67() {
		return wstd_t67;
	}
	public void setWstd_t67(String wstd_t67) {
		this.wstd_t67 = wstd_t67;
	}
	public String getWstd_t68() {
		return wstd_t68;
	}
	public void setWstd_t68(String wstd_t68) {
		this.wstd_t68 = wstd_t68;
	}
	public String getWstd_t69() {
		return wstd_t69;
	}
	public void setWstd_t69(String wstd_t69) {
		this.wstd_t69 = wstd_t69;
	}
	public String getWstd_t70() {
		return wstd_t70;
	}
	public void setWstd_t70(String wstd_t70) {
		this.wstd_t70 = wstd_t70;
	}
	public String getWstd_t71() {
		return wstd_t71;
	}
	public void setWstd_t71(String wstd_t71) {
		this.wstd_t71 = wstd_t71;
	}
	public String getWstd_t72() {
		return wstd_t72;
	}
	public void setWstd_t72(String wstd_t72) {
		this.wstd_t72 = wstd_t72;
	}
	public String getWstd_t73() {
		return wstd_t73;
	}
	public void setWstd_t73(String wstd_t73) {
		this.wstd_t73 = wstd_t73;
	}
	public String getWstd_ch3oh() {
		return wstd_ch3oh;
	}
	public void setWstd_ch3oh(String wstd_ch3oh) {
		this.wstd_ch3oh = wstd_ch3oh;
	}
	public String getWstd_gumnote() {
		return wstd_gumnote;
	}
	public void setWstd_gumnote(String wstd_gumnote) {
		this.wstd_gumnote = wstd_gumnote;
	}
	public String getWstd_h01() {
		return wstd_h01;
	}
	public void setWstd_h01(String wstd_h01) {
		this.wstd_h01 = wstd_h01;
	}
	public String getWstd_h02() {
		return wstd_h02;
	}
	public void setWstd_h02(String wstd_h02) {
		this.wstd_h02 = wstd_h02;
	}
	public String getWstd_h03() {
		return wstd_h03;
	}
	public void setWstd_h03(String wstd_h03) {
		this.wstd_h03 = wstd_h03;
	}
	public String getWstd_h04() {
		return wstd_h04;
	}
	public void setWstd_h04(String wstd_h04) {
		this.wstd_h04 = wstd_h04;
	}
	public String getWstd_h05() {
		return wstd_h05;
	}
	public void setWstd_h05(String wstd_h05) {
		this.wstd_h05 = wstd_h05;
	}
	public String getWstd_h06() {
		return wstd_h06;
	}
	public void setWstd_h06(String wstd_h06) {
		this.wstd_h06 = wstd_h06;
	}
	public String getWstd_h07() {
		return wstd_h07;
	}
	public void setWstd_h07(String wstd_h07) {
		this.wstd_h07 = wstd_h07;
	}
	public String getWstd_h08() {
		return wstd_h08;
	}
	public void setWstd_h08(String wstd_h08) {
		this.wstd_h08 = wstd_h08;
	}
	public String getWstd_h09() {
		return wstd_h09;
	}
	public void setWstd_h09(String wstd_h09) {
		this.wstd_h09 = wstd_h09;
	}
	public String getWstd_h10() {
		return wstd_h10;
	}
	public void setWstd_h10(String wstd_h10) {
		this.wstd_h10 = wstd_h10;
	}
	public String getWstd_h11() {
		return wstd_h11;
	}
	public void setWstd_h11(String wstd_h11) {
		this.wstd_h11 = wstd_h11;
	}
	public String getWstd_h12() {
		return wstd_h12;
	}
	public void setWstd_h12(String wstd_h12) {
		this.wstd_h12 = wstd_h12;
	}
	public String getWstd_h13() {
		return wstd_h13;
	}
	public void setWstd_h13(String wstd_h13) {
		this.wstd_h13 = wstd_h13;
	}
	public String getWstd_h14() {
		return wstd_h14;
	}
	public void setWstd_h14(String wstd_h14) {
		this.wstd_h14 = wstd_h14;
	}
	public String getWstd_h15() {
		return wstd_h15;
	}
	public void setWstd_h15(String wstd_h15) {
		this.wstd_h15 = wstd_h15;
	}
	public String getWstd_h16() {
		return wstd_h16;
	}
	public void setWstd_h16(String wstd_h16) {
		this.wstd_h16 = wstd_h16;
	}
	public String getWstd_h17() {
		return wstd_h17;
	}
	public void setWstd_h17(String wstd_h17) {
		this.wstd_h17 = wstd_h17;
	}
	public String getWstd_h18() {
		return wstd_h18;
	}
	public void setWstd_h18(String wstd_h18) {
		this.wstd_h18 = wstd_h18;
	}
	public String getWstd_h19() {
		return wstd_h19;
	}
	public void setWstd_h19(String wstd_h19) {
		this.wstd_h19 = wstd_h19;
	}
	public String getWstd_h20() {
		return wstd_h20;
	}
	public void setWstd_h20(String wstd_h20) {
		this.wstd_h20 = wstd_h20;
	}
	public String getWstd_h21() {
		return wstd_h21;
	}
	public void setWstd_h21(String wstd_h21) {
		this.wstd_h21 = wstd_h21;
	}
	public String getWstd_h22() {
		return wstd_h22;
	}
	public void setWstd_h22(String wstd_h22) {
		this.wstd_h22 = wstd_h22;
	}
	public String getWstd_h23() {
		return wstd_h23;
	}
	public void setWstd_h23(String wstd_h23) {
		this.wstd_h23 = wstd_h23;
	}
	public String getWstd_h24() {
		return wstd_h24;
	}
	public void setWstd_h24(String wstd_h24) {
		this.wstd_h24 = wstd_h24;
	}
	public String getWstd_h25() {
		return wstd_h25;
	}
	public void setWstd_h25(String wstd_h25) {
		this.wstd_h25 = wstd_h25;
	}
	public String getWstd_h26() {
		return wstd_h26;
	}
	public void setWstd_h26(String wstd_h26) {
		this.wstd_h26 = wstd_h26;
	}
	public String getWstd_h27() {
		return wstd_h27;
	}
	public void setWstd_h27(String wstd_h27) {
		this.wstd_h27 = wstd_h27;
	}
	public String getWstd_h28() {
		return wstd_h28;
	}
	public void setWstd_h28(String wstd_h28) {
		this.wstd_h28 = wstd_h28;
	}
	public String getWstd_h29() {
		return wstd_h29;
	}
	public void setWstd_h29(String wstd_h29) {
		this.wstd_h29 = wstd_h29;
	}
	public String getWstd_h30() {
		return wstd_h30;
	}
	public void setWstd_h30(String wstd_h30) {
		this.wstd_h30 = wstd_h30;
	}
	public String getWstd_h31() {
		return wstd_h31;
	}
	public void setWstd_h31(String wstd_h31) {
		this.wstd_h31 = wstd_h31;
	}
	public String getWstd_h32() {
		return wstd_h32;
	}
	public void setWstd_h32(String wstd_h32) {
		this.wstd_h32 = wstd_h32;
	}
	public String getWstd_h33() {
		return wstd_h33;
	}
	public void setWstd_h33(String wstd_h33) {
		this.wstd_h33 = wstd_h33;
	}
	public String getWstd_h34() {
		return wstd_h34;
	}
	public void setWstd_h34(String wstd_h34) {
		this.wstd_h34 = wstd_h34;
	}
	public String getWstd_h35() {
		return wstd_h35;
	}
	public void setWstd_h35(String wstd_h35) {
		this.wstd_h35 = wstd_h35;
	}
	public String getWstd_h36() {
		return wstd_h36;
	}
	public void setWstd_h36(String wstd_h36) {
		this.wstd_h36 = wstd_h36;
	}
	public String getWstd_h37() {
		return wstd_h37;
	}
	public void setWstd_h37(String wstd_h37) {
		this.wstd_h37 = wstd_h37;
	}
	public String getWstd_h38() {
		return wstd_h38;
	}
	public void setWstd_h38(String wstd_h38) {
		this.wstd_h38 = wstd_h38;
	}
	public String getWstd_h39() {
		return wstd_h39;
	}
	public void setWstd_h39(String wstd_h39) {
		this.wstd_h39 = wstd_h39;
	}
	public String getWstd_h40() {
		return wstd_h40;
	}
	public void setWstd_h40(String wstd_h40) {
		this.wstd_h40 = wstd_h40;
	}
	public String getWstd_h41() {
		return wstd_h41;
	}
	public void setWstd_h41(String wstd_h41) {
		this.wstd_h41 = wstd_h41;
	}
	public String getWstd_h42() {
		return wstd_h42;
	}
	public void setWstd_h42(String wstd_h42) {
		this.wstd_h42 = wstd_h42;
	}
	public String getWstd_h43() {
		return wstd_h43;
	}
	public void setWstd_h43(String wstd_h43) {
		this.wstd_h43 = wstd_h43;
	}
	public String getWstd_h44() {
		return wstd_h44;
	}
	public void setWstd_h44(String wstd_h44) {
		this.wstd_h44 = wstd_h44;
	}
	public String getReport_type() {
		return report_type;
	}
	public void setReport_type(String report_type) {
		this.report_type = report_type;
	}
	public String getWstd_t74() {
		return wstd_t74;
	}
	public void setWstd_t74(String wstd_t74) {
		this.wstd_t74 = wstd_t74;
	}
	public String getWstd_t75() {
		return wstd_t75;
	}
	public void setWstd_t75(String wstd_t75) {
		this.wstd_t75 = wstd_t75;
	}
	public String getWstd_t76() {
		return wstd_t76;
	}
	public void setWstd_t76(String wstd_t76) {
		this.wstd_t76 = wstd_t76;
	}
	public String getWstd_t77() {
		return wstd_t77;
	}
	public void setWstd_t77(String wstd_t77) {
		this.wstd_t77 = wstd_t77;
	}
	public String getWstd_t78() {
		return wstd_t78;
	}
	public void setWstd_t78(String wstd_t78) {
		this.wstd_t78 = wstd_t78;
	}
	public String getWstd_t79() {
		return wstd_t79;
	}
	public void setWstd_t79(String wstd_t79) {
		this.wstd_t79 = wstd_t79;
	}
	public String getWstd_t80() {
		return wstd_t80;
	}
	public void setWstd_t80(String wstd_t80) {
		this.wstd_t80 = wstd_t80;
	}
	public String getFac_code2() {
		return fac_code2;
	}
	public void setFac_code2(String fac_code2) {
		this.fac_code2 = fac_code2;
	}
	public String getWstd_gumnote2() {
		return wstd_gumnote2;
	}
	public void setWstd_gumnote2(String wstd_gumnote2) {
		this.wstd_gumnote2 = wstd_gumnote2;
	}
	public String getWstd_worke2() {
		return wstd_worke2;
	}
	public void setWstd_worke2(String wstd_worke2) {
		this.wstd_worke2 = wstd_worke2;
	}
	public String getWstd_t81() {
		return wstd_t81;
	}
	public void setWstd_t81(String wstd_t81) {
		this.wstd_t81 = wstd_t81;
	}
	public String getWstd_t82() {
		return wstd_t82;
	}
	public void setWstd_t82(String wstd_t82) {
		this.wstd_t82 = wstd_t82;
	}
	public String getWstd_t83() {
		return wstd_t83;
	}
	public void setWstd_t83(String wstd_t83) {
		this.wstd_t83 = wstd_t83;
	}
	public String getWstd_t84() {
		return wstd_t84;
	}
	public void setWstd_t84(String wstd_t84) {
		this.wstd_t84 = wstd_t84;
	}
	public String getWstd_t85() {
		return wstd_t85;
	}
	public void setWstd_t85(String wstd_t85) {
		this.wstd_t85 = wstd_t85;
	}
	public String getWstd_t86() {
		return wstd_t86;
	}
	public void setWstd_t86(String wstd_t86) {
		this.wstd_t86 = wstd_t86;
	}
	public String getWstd_tbd() {
		return wstd_tbd;
	}
	public void setWstd_tbd(String wstd_tbd) {
		this.wstd_tbd = wstd_tbd;
	}
	public String getWstd_ttt() {
		return wstd_ttt;
	}
	public void setWstd_ttt(String wstd_ttt) {
		this.wstd_ttt = wstd_ttt;
	}
	public String getWstd_tig() {
		return wstd_tig;
	}
	public void setWstd_tig(String wstd_tig) {
		this.wstd_tig = wstd_tig;
	}
	public String getWstd_thj() {
		return wstd_thj;
	}
	public void setWstd_thj(String wstd_thj) {
		this.wstd_thj = wstd_thj;
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
	public String getWstd_gj18() {
		return wstd_gj18;
	}
	public void setWstd_gj18(String wstd_gj18) {
		this.wstd_gj18 = wstd_gj18;
	}
	public String getWstd_gj19() {
		return wstd_gj19;
	}
	public void setWstd_gj19(String wstd_gj19) {
		this.wstd_gj19 = wstd_gj19;
	}
	public String getWstd_gj1a() {
		return wstd_gj1a;
	}
	public void setWstd_gj1a(String wstd_gj1a) {
		this.wstd_gj1a = wstd_gj1a;
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
	public String getWstd_gj25() {
		return wstd_gj25;
	}
	public void setWstd_gj25(String wstd_gj25) {
		this.wstd_gj25 = wstd_gj25;
	}
	public String getWstd_gj26() {
		return wstd_gj26;
	}
	public void setWstd_gj26(String wstd_gj26) {
		this.wstd_gj26 = wstd_gj26;
	}
	public String getWstd_gj27() {
		return wstd_gj27;
	}
	public void setWstd_gj27(String wstd_gj27) {
		this.wstd_gj27 = wstd_gj27;
	}
	public String getWstd_gj28() {
		return wstd_gj28;
	}
	public void setWstd_gj28(String wstd_gj28) {
		this.wstd_gj28 = wstd_gj28;
	}
	public String getWstd_gj29() {
		return wstd_gj29;
	}
	public void setWstd_gj29(String wstd_gj29) {
		this.wstd_gj29 = wstd_gj29;
	}
	public String getWstd_gj2a() {
		return wstd_gj2a;
	}
	public void setWstd_gj2a(String wstd_gj2a) {
		this.wstd_gj2a = wstd_gj2a;
	}
	public String getWstd_gj31() {
		return wstd_gj31;
	}
	public void setWstd_gj31(String wstd_gj31) {
		this.wstd_gj31 = wstd_gj31;
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
	public String getWstd_gj35() {
		return wstd_gj35;
	}
	public void setWstd_gj35(String wstd_gj35) {
		this.wstd_gj35 = wstd_gj35;
	}
	public String getWstd_gj36() {
		return wstd_gj36;
	}
	public void setWstd_gj36(String wstd_gj36) {
		this.wstd_gj36 = wstd_gj36;
	}
	public String getWstd_gj37() {
		return wstd_gj37;
	}
	public void setWstd_gj37(String wstd_gj37) {
		this.wstd_gj37 = wstd_gj37;
	}
	public String getWstd_gj38() {
		return wstd_gj38;
	}
	public void setWstd_gj38(String wstd_gj38) {
		this.wstd_gj38 = wstd_gj38;
	}
	public String getWstd_gj39() {
		return wstd_gj39;
	}
	public void setWstd_gj39(String wstd_gj39) {
		this.wstd_gj39 = wstd_gj39;
	}
	public String getWstd_gj3a() {
		return wstd_gj3a;
	}
	public void setWstd_gj3a(String wstd_gj3a) {
		this.wstd_gj3a = wstd_gj3a;
	}
	public String getWstd_gj41() {
		return wstd_gj41;
	}
	public void setWstd_gj41(String wstd_gj41) {
		this.wstd_gj41 = wstd_gj41;
	}
	public String getWstd_gj42() {
		return wstd_gj42;
	}
	public void setWstd_gj42(String wstd_gj42) {
		this.wstd_gj42 = wstd_gj42;
	}
	public String getWstd_gj43() {
		return wstd_gj43;
	}
	public void setWstd_gj43(String wstd_gj43) {
		this.wstd_gj43 = wstd_gj43;
	}
	public String getWstd_gj44() {
		return wstd_gj44;
	}
	public void setWstd_gj44(String wstd_gj44) {
		this.wstd_gj44 = wstd_gj44;
	}
	public String getWstd_gj45() {
		return wstd_gj45;
	}
	public void setWstd_gj45(String wstd_gj45) {
		this.wstd_gj45 = wstd_gj45;
	}
	public String getWstd_gj46() {
		return wstd_gj46;
	}
	public void setWstd_gj46(String wstd_gj46) {
		this.wstd_gj46 = wstd_gj46;
	}
	public String getWstd_gj47() {
		return wstd_gj47;
	}
	public void setWstd_gj47(String wstd_gj47) {
		this.wstd_gj47 = wstd_gj47;
	}
	public String getWstd_gj48() {
		return wstd_gj48;
	}
	public void setWstd_gj48(String wstd_gj48) {
		this.wstd_gj48 = wstd_gj48;
	}
	public String getWstd_gj49() {
		return wstd_gj49;
	}
	public void setWstd_gj49(String wstd_gj49) {
		this.wstd_gj49 = wstd_gj49;
	}
	public String getWstd_gj4a() {
		return wstd_gj4a;
	}
	public void setWstd_gj4a(String wstd_gj4a) {
		this.wstd_gj4a = wstd_gj4a;
	}
	public String getWstd_gj51() {
		return wstd_gj51;
	}
	public void setWstd_gj51(String wstd_gj51) {
		this.wstd_gj51 = wstd_gj51;
	}
	public String getWstd_gj52() {
		return wstd_gj52;
	}
	public void setWstd_gj52(String wstd_gj52) {
		this.wstd_gj52 = wstd_gj52;
	}
	public String getWstd_gj53() {
		return wstd_gj53;
	}
	public void setWstd_gj53(String wstd_gj53) {
		this.wstd_gj53 = wstd_gj53;
	}
	public String getWstd_gj54() {
		return wstd_gj54;
	}
	public void setWstd_gj54(String wstd_gj54) {
		this.wstd_gj54 = wstd_gj54;
	}
	public String getWstd_gj55() {
		return wstd_gj55;
	}
	public void setWstd_gj55(String wstd_gj55) {
		this.wstd_gj55 = wstd_gj55;
	}
	public String getWstd_gj56() {
		return wstd_gj56;
	}
	public void setWstd_gj56(String wstd_gj56) {
		this.wstd_gj56 = wstd_gj56;
	}
	public String getWstd_gj57() {
		return wstd_gj57;
	}
	public void setWstd_gj57(String wstd_gj57) {
		this.wstd_gj57 = wstd_gj57;
	}
	public String getWstd_gj58() {
		return wstd_gj58;
	}
	public void setWstd_gj58(String wstd_gj58) {
		this.wstd_gj58 = wstd_gj58;
	}
	public String getWstd_gj59() {
		return wstd_gj59;
	}
	public void setWstd_gj59(String wstd_gj59) {
		this.wstd_gj59 = wstd_gj59;
	}
	public String getWstd_gj5a() {
		return wstd_gj5a;
	}
	public void setWstd_gj5a(String wstd_gj5a) {
		this.wstd_gj5a = wstd_gj5a;
	}
	public String getWstd_gj61() {
		return wstd_gj61;
	}
	public void setWstd_gj61(String wstd_gj61) {
		this.wstd_gj61 = wstd_gj61;
	}
	public String getWstd_gj62() {
		return wstd_gj62;
	}
	public void setWstd_gj62(String wstd_gj62) {
		this.wstd_gj62 = wstd_gj62;
	}
	public String getWstd_gj63() {
		return wstd_gj63;
	}
	public void setWstd_gj63(String wstd_gj63) {
		this.wstd_gj63 = wstd_gj63;
	}
	public String getWstd_gj64() {
		return wstd_gj64;
	}
	public void setWstd_gj64(String wstd_gj64) {
		this.wstd_gj64 = wstd_gj64;
	}
	public String getWstd_gj71() {
		return wstd_gj71;
	}
	public void setWstd_gj71(String wstd_gj71) {
		this.wstd_gj71 = wstd_gj71;
	}
	public String getWstd_gj72() {
		return wstd_gj72;
	}
	public void setWstd_gj72(String wstd_gj72) {
		this.wstd_gj72 = wstd_gj72;
	}
	public String getWstd_gj73() {
		return wstd_gj73;
	}
	public void setWstd_gj73(String wstd_gj73) {
		this.wstd_gj73 = wstd_gj73;
	}
	public String getWstd_gj74() {
		return wstd_gj74;
	}
	public void setWstd_gj74(String wstd_gj74) {
		this.wstd_gj74 = wstd_gj74;
	}
	public String getWstd_gj81() {
		return wstd_gj81;
	}
	public void setWstd_gj81(String wstd_gj81) {
		this.wstd_gj81 = wstd_gj81;
	}
	public String getWstd_gj82() {
		return wstd_gj82;
	}
	public void setWstd_gj82(String wstd_gj82) {
		this.wstd_gj82 = wstd_gj82;
	}
	public String getWstd_gj83() {
		return wstd_gj83;
	}
	public void setWstd_gj83(String wstd_gj83) {
		this.wstd_gj83 = wstd_gj83;
	}
	public String getWstd_gj84() {
		return wstd_gj84;
	}
	public void setWstd_gj84(String wstd_gj84) {
		this.wstd_gj84 = wstd_gj84;
	}
	public String getWstd_gj85() {
		return wstd_gj85;
	}
	public void setWstd_gj85(String wstd_gj85) {
		this.wstd_gj85 = wstd_gj85;
	}
	public String getWstd_gj91() {
		return wstd_gj91;
	}
	public void setWstd_gj91(String wstd_gj91) {
		this.wstd_gj91 = wstd_gj91;
	}
	public String getWstd_gj92() {
		return wstd_gj92;
	}
	public void setWstd_gj92(String wstd_gj92) {
		this.wstd_gj92 = wstd_gj92;
	}
	public String getWstd_gj93() {
		return wstd_gj93;
	}
	public void setWstd_gj93(String wstd_gj93) {
		this.wstd_gj93 = wstd_gj93;
	}
	public String getWstd_gj94() {
		return wstd_gj94;
	}
	public void setWstd_gj94(String wstd_gj94) {
		this.wstd_gj94 = wstd_gj94;
	}
	public String getWstd_gj95() {
		return wstd_gj95;
	}
	public void setWstd_gj95(String wstd_gj95) {
		this.wstd_gj95 = wstd_gj95;
	}
	public String getWstd_gja6() {
		return wstd_gja6;
	}
	public void setWstd_gja6(String wstd_gja6) {
		this.wstd_gja6 = wstd_gja6;
	}
	public String getWstd_gjsu() {
		return wstd_gjsu;
	}
	public void setWstd_gjsu(String wstd_gjsu) {
		this.wstd_gjsu = wstd_gjsu;
	}
	public String getWstd_gjrpm() {
		return wstd_gjrpm;
	}
	public void setWstd_gjrpm(String wstd_gjrpm) {
		this.wstd_gjrpm = wstd_gjrpm;
	}
	public String getWstd_js08() {
		return wstd_js08;
	}
	public void setWstd_js08(String wstd_js08) {
		this.wstd_js08 = wstd_js08;
	}
	public String getWstd_step08() {
		return wstd_step08;
	}
	public void setWstd_step08(String wstd_step08) {
		this.wstd_step08 = wstd_step08;
	}
	public String getWstd_js07() {
		return wstd_js07;
	}
	public void setWstd_js07(String wstd_js07) {
		this.wstd_js07 = wstd_js07;
	}
	public String getWstd_step07() {
		return wstd_step07;
	}
	public void setWstd_step07(String wstd_step07) {
		this.wstd_step07 = wstd_step07;
	}
	public String getWstd_gj96() {
		return wstd_gj96;
	}
	public void setWstd_gj96(String wstd_gj96) {
		this.wstd_gj96 = wstd_gj96;
	}
	public String getWstd_t30() {
		return wstd_t30;
	}
	public void setWstd_t30(String wstd_t30) {
		this.wstd_t30 = wstd_t30;
	}
	public String getWstd_t50() {
		return wstd_t50;
	}
	public void setWstd_t50(String wstd_t50) {
		this.wstd_t50 = wstd_t50;
	}
	public String getWstd_gj97() {
		return wstd_gj97;
	}
	public void setWstd_gj97(String wstd_gj97) {
		this.wstd_gj97 = wstd_gj97;
	}
	public String getWstd_gj98() {
		return wstd_gj98;
	}
	public void setWstd_gj98(String wstd_gj98) {
		this.wstd_gj98 = wstd_gj98;
	}
	public String getWstd_gj99() {
		return wstd_gj99;
	}
	public void setWstd_gj99(String wstd_gj99) {
		this.wstd_gj99 = wstd_gj99;
	}
	public String getWstd_gj100() {
		return wstd_gj100;
	}
	public void setWstd_gj100(String wstd_gj100) {
		this.wstd_gj100 = wstd_gj100;
	}
	public String getWstd_gj101() {
		return wstd_gj101;
	}
	public void setWstd_gj101(String wstd_gj101) {
		this.wstd_gj101 = wstd_gj101;
	}
	public String getWstd_t40() {
		return wstd_t40;
	}
	public void setWstd_t40(String wstd_t40) {
		this.wstd_t40 = wstd_t40;
	}
	public String getFac_code1() {
		return fac_code1;
	}
	public void setFac_code1(String fac_code1) {
		this.fac_code1 = fac_code1;
	}
	public String getCool() {
		return cool;
	}
	public void setCool(String cool) {
		this.cool = cool;
	}
	public String getWstd_t87() {
		return wstd_t87;
	}
	public void setWstd_t87(String wstd_t87) {
		this.wstd_t87 = wstd_t87;
	}
	public String getWstd_gj65() {
		return wstd_gj65;
	}
	public void setWstd_gj65(String wstd_gj65) {
		this.wstd_gj65 = wstd_gj65;
	}
	public String getWstd_gj75() {
		return wstd_gj75;
	}
	public void setWstd_gj75(String wstd_gj75) {
		this.wstd_gj75 = wstd_gj75;
	}
	public String getWstd_gj69() {
		return wstd_gj69;
	}
	public void setWstd_gj69(String wstd_gj69) {
		this.wstd_gj69 = wstd_gj69;
	}
	public String getWstd_gj79() {
		return wstd_gj79;
	}
	public void setWstd_gj79(String wstd_gj79) {
		this.wstd_gj79 = wstd_gj79;
	}
	public String getWstd_gj66() {
		return wstd_gj66;
	}
	public void setWstd_gj66(String wstd_gj66) {
		this.wstd_gj66 = wstd_gj66;
	}
	public String getWstd_gj67() {
		return wstd_gj67;
	}
	public void setWstd_gj67(String wstd_gj67) {
		this.wstd_gj67 = wstd_gj67;
	}
	public String getWstd_gj68() {
		return wstd_gj68;
	}
	public void setWstd_gj68(String wstd_gj68) {
		this.wstd_gj68 = wstd_gj68;
	}
	public String getWstd_gj76() {
		return wstd_gj76;
	}
	public void setWstd_gj76(String wstd_gj76) {
		this.wstd_gj76 = wstd_gj76;
	}
	public String getWstd_gj77() {
		return wstd_gj77;
	}
	public void setWstd_gj77(String wstd_gj77) {
		this.wstd_gj77 = wstd_gj77;
	}
	public String getWstd_gj78() {
		return wstd_gj78;
	}
	public void setWstd_gj78(String wstd_gj78) {
		this.wstd_gj78 = wstd_gj78;
	}
	public String getWstd_gj86() {
		return wstd_gj86;
	}
	public void setWstd_gj86(String wstd_gj86) {
		this.wstd_gj86 = wstd_gj86;
	}
	public String getWstd_gj87() {
		return wstd_gj87;
	}
	public void setWstd_gj87(String wstd_gj87) {
		this.wstd_gj87 = wstd_gj87;
	}
	public String getFac_code3() {
		return fac_code3;
	}
	public void setFac_code3(String fac_code3) {
		this.fac_code3 = fac_code3;
	}
	public String getWstd_gj102() {
		return wstd_gj102;
	}
	public void setWstd_gj102(String wstd_gj102) {
		this.wstd_gj102 = wstd_gj102;
	}
	public String getWstd_gj103() {
		return wstd_gj103;
	}
	public void setWstd_gj103(String wstd_gj103) {
		this.wstd_gj103 = wstd_gj103;
	}
	public String getWstd_gj104() {
		return wstd_gj104;
	}
	public void setWstd_gj104(String wstd_gj104) {
		this.wstd_gj104 = wstd_gj104;
	}
	public String getWstd_gj105() {
		return wstd_gj105;
	}
	public void setWstd_gj105(String wstd_gj105) {
		this.wstd_gj105 = wstd_gj105;
	}
	public String getWstd_gj106() {
		return wstd_gj106;
	}
	public void setWstd_gj106(String wstd_gj106) {
		this.wstd_gj106 = wstd_gj106;
	}
	public String getWstd_gj107() {
		return wstd_gj107;
	}
	public void setWstd_gj107(String wstd_gj107) {
		this.wstd_gj107 = wstd_gj107;
	}
	public String getWstd_gj108() {
		return wstd_gj108;
	}
	public void setWstd_gj108(String wstd_gj108) {
		this.wstd_gj108 = wstd_gj108;
	}
	public String getWstd_gj88() {
		return wstd_gj88;
	}
	public void setWstd_gj88(String wstd_gj88) {
		this.wstd_gj88 = wstd_gj88;
	}
	public String getCorp_name() {
		return corp_name;
	}
	public void setCorp_name(String corp_name) {
		this.corp_name = corp_name;
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
	public String getProd_dang() {
		return prod_dang;
	}
	public void setProd_dang(String prod_dang) {
		this.prod_dang = prod_dang;
	}
	public String getProd_danw() {
		return prod_danw;
	}
	public void setProd_danw(String prod_danw) {
		this.prod_danw = prod_danw;
	}
	public String getProd_code() {
		return prod_code;
	}
	public void setProd_code(String prod_code) {
		this.prod_code = prod_code;
	}
	@JsonProperty("prod_pg")
	public String getProdpg() {
		return prodpg;
	}
	public void setProdpg(String prodpg) {
		this.prodpg = prodpg;
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
	 @JsonProperty("prod_sg")
	public String getProdsg() {
		return prodsg;
	}
	public void setProdsg(String prodsg) {
		this.prodsg = prodsg;
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
	public String getProdgd1() {
		return prodgd1;
	}
	public void setProdgd1(String prodgd1) {
		this.prodgd1 = prodgd1;
	}
	public String getProdgd2() {
		return prodgd2;
	}
	public void setProdgd2(String prodgd2) {
		this.prodgd2 = prodgd2;
	}
	public String getProdcd() {
		return prodcd;
	}
	public void setProdcd(String prodcd) {
		this.prodcd = prodcd;
	}
	public String getTech_te() {
		return tech_te;
	}
	public void setTech_te(String tech_te) {
		this.tech_te = tech_te;
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
	public String getProd_e1() {
		return prod_e1;
	}
	public void setProd_e1(String prod_e1) {
		this.prod_e1 = prod_e1;
	}
	public String getProd_e2() {
		return prod_e2;
	}
	public void setProd_e2(String prod_e2) {
		this.prod_e2 = prod_e2;
	}
	public String getProd_e3() {
		return prod_e3;
	}
	public void setProd_e3(String prod_e3) {
		this.prod_e3 = prod_e3;
	}
	public String getProd_e4() {
		return prod_e4;
	}
	public void setProd_e4(String prod_e4) {
		this.prod_e4 = prod_e4;
	}
	public String getProd_pgs() {
		return prod_pgs;
	}
	public void setProd_pgs(String prod_pgs) {
		this.prod_pgs = prod_pgs;
	}
	public String getProd_pgs1() {
		return prod_pgs1;
	}
	public void setProd_pgs1(String prod_pgs1) {
		this.prod_pgs1 = prod_pgs1;
	}
	public String getProd_pgs2() {
		return prod_pgs2;
	}
	public void setProd_pgs2(String prod_pgs2) {
		this.prod_pgs2 = prod_pgs2;
	}
	public String getProd_gd2() {
		return prod_gd2;
	}
	public void setProd_gd2(String prod_gd2) {
		this.prod_gd2 = prod_gd2;
	}
	public String getProd_cno() {
		return prod_cno;
	}
	public void setProd_cno(String prod_cno) {
		this.prod_cno = prod_cno;
	}
	public String getProd_danj() {
		return prod_danj;
	}
	public void setProd_danj(String prod_danj) {
		this.prod_danj = prod_danj;
	}
	public String getProd_e5() {
		return prod_e5;
	}
	public void setProd_e5(String prod_e5) {
		this.prod_e5 = prod_e5;
	}
	public String getProd_do() {
		return prod_do;
	}
	public void setProd_do(String prod_do) {
		this.prod_do = prod_do;
	}
	public String getProd_ra() {
		return prod_ra;
	}
	public void setProd_ra(String prod_ra) {
		this.prod_ra = prod_ra;
	}
	public String getProd_kijong() {
		return prod_kijong;
	}
	public void setProd_kijong(String prod_kijong) {
		this.prod_kijong = prod_kijong;
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
	public String getProd_gd1() {
		return prod_gd1;
	}
	public void setProd_gd1(String prod_gd1) {
		this.prod_gd1 = prod_gd1;
	}
	public String getProd_gd3() {
		return prod_gd3;
	}
	public void setProd_gd3(String prod_gd3) {
		this.prod_gd3 = prod_gd3;
	}
	public String getFac_no() {
		return fac_no;
	}
	public void setFac_no(String fac_no) {
		this.fac_no = fac_no;
	}
	public String getFac_name() {
		return fac_name;
	}
	public void setFac_name(String fac_name) {
		this.fac_name = fac_name;
	}
	public String getFac_gyu() {
		return fac_gyu;
	}
	public void setFac_gyu(String fac_gyu) {
		this.fac_gyu = fac_gyu;
	}
	public String getFac_hyun() {
		return fac_hyun;
	}
	public void setFac_hyun(String fac_hyun) {
		this.fac_hyun = fac_hyun;
	}
	public String getFac_yong() {
		return fac_yong;
	}
	public void setFac_yong(String fac_yong) {
		this.fac_yong = fac_yong;
	}
	public String getFac_man1() {
		return fac_man1;
	}
	public void setFac_man1(String fac_man1) {
		this.fac_man1 = fac_man1;
	}
	public String getFac_man2() {
		return fac_man2;
	}
	public void setFac_man2(String fac_man2) {
		this.fac_man2 = fac_man2;
	}
	public String getFac_plc() {
		return fac_plc;
	}
	public void setFac_plc(String fac_plc) {
		this.fac_plc = fac_plc;
	}
	public String getFac_make() {
		return fac_make;
	}
	public void setFac_make(String fac_make) {
		this.fac_make = fac_make;
	}
	public String getFac_cbuy() {
		return fac_cbuy;
	}
	public void setFac_cbuy(String fac_cbuy) {
		this.fac_cbuy = fac_cbuy;
	}
	public String getFac_buy() {
		return fac_buy;
	}
	public void setFac_buy(String fac_buy) {
		this.fac_buy = fac_buy;
	}
	public String getFac_mday() {
		return fac_mday;
	}
	public void setFac_mday(String fac_mday) {
		this.fac_mday = fac_mday;
	}
	public String getFac_mon() {
		return fac_mon;
	}
	public void setFac_mon(String fac_mon) {
		this.fac_mon = fac_mon;
	}
	public String getFac_able() {
		return fac_able;
	}
	public void setFac_able(String fac_able) {
		this.fac_able = fac_able;
	}
	public String getFac_time() {
		return fac_time;
	}
	public void setFac_time(String fac_time) {
		this.fac_time = fac_time;
	}
	public String getFac_test() {
		return fac_test;
	}
	public void setFac_test(String fac_test) {
		this.fac_test = fac_test;
	}
	public String getFac_bigo() {
		return fac_bigo;
	}
	public void setFac_bigo(String fac_bigo) {
		this.fac_bigo = fac_bigo;
	}
	public String getFac_tech_no() {
		return fac_tech_no;
	}
	public void setFac_tech_no(String fac_tech_no) {
		this.fac_tech_no = fac_tech_no;
	}
	public String getFac_gubn() {
		return fac_gubn;
	}
	public void setFac_gubn(String fac_gubn) {
		this.fac_gubn = fac_gubn;
	}
	public String getFac_e1() {
		return fac_e1;
	}
	public void setFac_e1(String fac_e1) {
		this.fac_e1 = fac_e1;
	}
	public String getFac_e2() {
		return fac_e2;
	}
	public void setFac_e2(String fac_e2) {
		this.fac_e2 = fac_e2;
	}
	public String getFac_e3() {
		return fac_e3;
	}
	public void setFac_e3(String fac_e3) {
		this.fac_e3 = fac_e3;
	}
	public String getFac_e4() {
		return fac_e4;
	}
	public void setFac_e4(String fac_e4) {
		this.fac_e4 = fac_e4;
	}
	public String getFac_lot() {
		return fac_lot;
	}
	public void setFac_lot(String fac_lot) {
		this.fac_lot = fac_lot;
	}
	public String getFac_dan() {
		return fac_dan;
	}
	public void setFac_dan(String fac_dan) {
		this.fac_dan = fac_dan;
	}
	public String getFac_unus() {
		return fac_unus;
	}
	public void setFac_unus(String fac_unus) {
		this.fac_unus = fac_unus;
	}
	public String getFac_cau() {
		return fac_cau;
	}
	public void setFac_cau(String fac_cau) {
		this.fac_cau = fac_cau;
	}
	public String getFac_pda_use() {
		return fac_pda_use;
	}
	public void setFac_pda_use(String fac_pda_use) {
		this.fac_pda_use = fac_pda_use;
	}
	public String getFac_state() {
		return fac_state;
	}
	public void setFac_state(String fac_state) {
		this.fac_state = fac_state;
	}
	public String getProd_drawing_file_name() {
		return prod_drawing_file_name;
	}
	public void setProd_drawing_file_name(String prod_drawing_file_name) {
		this.prod_drawing_file_name = prod_drawing_file_name;
	}
	public String getProd_product_file_name() {
		return prod_product_file_name;
	}
	public void setProd_product_file_name(String prod_product_file_name) {
		this.prod_product_file_name = prod_product_file_name;
	}
}
