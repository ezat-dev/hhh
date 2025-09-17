package com.tkheat.domain;

public class Suip {

	
	private String sdate;
	private String edate;
	
	private int prod_code;
	private int corp_code;
	private String corp_name;           //거래처명
	private String prod_name;			//품명
	private String prod_no;				//품번
	private String prod_gyu;			//규격
	private String prod_jai;			//재질
	private String prod_danj;			//단중
	private String prod_danw;			//단위
	private String prod_dang;			//단가
	
	
	

	private String ord_date; //입고일
	private int ord_su;
	private String ord_lot;

	//TECH 테이블
	private String tech_no;					//공정

	
	// 수입검사
	private Integer itst_code;
	private String itst_date; //검검사일
	private String itst_p;
	private String itst_bigo;
	private String itst_su;
	private String itst_test;
	private String itst_poor; //불량수
	private String itst_wp; //판정
	private String itst_wn;
	private String itst_ws;
	private String itst_w1;
	private String itst_w2;
	private String itst_w3;
	private String itst_w4;
	private String itst_w5;
	private String itst_05n;
	private String itst_05s;
	private String itst_051;
	private String itst_052;
	private String itst_053;
	private String itst_054;
	private String itst_055;
	private String itst_03n;
	private String itst_03s;
	private String itst_031;
	private String itst_032;
	private String itst_033;
	private String itst_034;
	private String itst_035;
	private String itst_01n;
	private String itst_01s;
	private String itst_011;
	private String itst_012;
	private String itst_013;
	private String itst_014;
	private String itst_015;
	private String itst_06n;
	private String itst_06s;
	private String itst_061;
	private String itst_062;
	private String itst_063;
	private String itst_064;
	private String itst_065;
	private String itst_07n;
	private String itst_07s;
	private String itst_071;
	private String itst_072;
	private String itst_073;
	private String itst_074;
	private String itst_075;
	private String itst_08n;
	private String itst_08s;
	private String itst_081;
	private String itst_082;
	private String itst_083;
	private String itst_084;
	private String itst_085;
	private String itst_04n;
	private String itst_04s;
	private String itst_041;
	private String itst_042;
	private String itst_043;
	private String itst_044;
	private String itst_045;
	private String itst_02n;
	private String itst_02s;
	private String itst_021;
	private String itst_022;
	private String itst_023;
	private String itst_024;
	private String itst_025;
	
	
	
	
	
	
	

    //Cpk 조회조건, 기준정보 리스트
    private String h_regdate;		//측정일
    private String h_regtime;		//측정시간
    private String h_sdate;			//조회시작일
    private String h_edate;			//조회종료일
    private String h_pnum;			//품번
    private String h_pname;			//품명
    private String h_gang;			//강종
    private String h_t_gb;			//T급
    private String h_hard_up;		//상한경도값
    private String h_hard_dw;		//하한경도값
    
    //Cpk 측정값 리스트
    private String h_day;			//일자
    private String h_time;			//시간
    private float h_x1;				//측정값 -1
    private float h_x2;				//측정값 -2
    private float h_x3;				//측정값 -3
    private float h_avg;			//평균값
    private float h_range;			//값 범위
    
    //Cpk 계산값 
    private int n;					//관리도계수표 n
    private double d2;				//관리도계수표 d2
    private double a2;				//관리도계수표 a2
    private double d4;				//관리도계수표 d4
    
    private String ucl_x;			//관리상한(UCL - X)
    private String cl_x;				//평균값(CL - X)
    private String lcl_x;			//관리하한(LCL - X)
    private String ucl_r;			//관리상한(UCL - R)
    private String cl_r;				//평균값(UCL - R)
    private String lcl_r;			//관리하한(UCL - R)
    
    private String r_d2;				//공정능력분석 R/d2
    private String cp;				//공정능력분석 CP
    private String k;				//공정능력분석 k
    private String cpk;				//공정능력분석 CPk
    
    //Cpk 트렌드용
    private double g_ucl_x;
    private double g_cl_x;
    private double g_lcl_x;
    private double g_ucl_r;
    private double g_cl_r;
    private double g_max;
    private double g_min;
    private double g_avg;
    private double g_range;
    private String g_tdatetime;
    private int g_idx;
	
	
	
	
	
	
	
	
	
	

	public int getOrd_su() {
		return ord_su;
	}
	public void setOrd_su(int ord_su) {
		this.ord_su = ord_su;
	}
	public String getOrd_lot() {
		return ord_lot;
	}
	public void setOrd_lot(String ord_lot) {
		this.ord_lot = ord_lot;
	}
	public String getItst_p() {
		return itst_p;
	}
	public void setItst_p(String itst_p) {
		this.itst_p = itst_p;
	}
	public String getItst_bigo() {
		return itst_bigo;
	}
	public void setItst_bigo(String itst_bigo) {
		this.itst_bigo = itst_bigo;
	}
	public String getItst_su() {
		return itst_su;
	}
	public void setItst_su(String itst_su) {
		this.itst_su = itst_su;
	}
	public String getItst_test() {
		return itst_test;
	}
	public void setItst_test(String itst_test) {
		this.itst_test = itst_test;
	}
	public String getItst_wn() {
		return itst_wn;
	}
	public void setItst_wn(String itst_wn) {
		this.itst_wn = itst_wn;
	}
	public String getItst_ws() {
		return itst_ws;
	}
	public void setItst_ws(String itst_ws) {
		this.itst_ws = itst_ws;
	}
	public String getItst_w1() {
		return itst_w1;
	}
	public void setItst_w1(String itst_w1) {
		this.itst_w1 = itst_w1;
	}
	public String getItst_w2() {
		return itst_w2;
	}
	public void setItst_w2(String itst_w2) {
		this.itst_w2 = itst_w2;
	}
	public String getItst_w3() {
		return itst_w3;
	}
	public void setItst_w3(String itst_w3) {
		this.itst_w3 = itst_w3;
	}
	public String getItst_w4() {
		return itst_w4;
	}
	public void setItst_w4(String itst_w4) {
		this.itst_w4 = itst_w4;
	}
	public String getItst_w5() {
		return itst_w5;
	}
	public void setItst_w5(String itst_w5) {
		this.itst_w5 = itst_w5;
	}
	public String getItst_05n() {
		return itst_05n;
	}
	public void setItst_05n(String itst_05n) {
		this.itst_05n = itst_05n;
	}
	public String getItst_05s() {
		return itst_05s;
	}
	public void setItst_05s(String itst_05s) {
		this.itst_05s = itst_05s;
	}
	public String getItst_051() {
		return itst_051;
	}
	public void setItst_051(String itst_051) {
		this.itst_051 = itst_051;
	}
	public String getItst_052() {
		return itst_052;
	}
	public void setItst_052(String itst_052) {
		this.itst_052 = itst_052;
	}
	public String getItst_053() {
		return itst_053;
	}
	public void setItst_053(String itst_053) {
		this.itst_053 = itst_053;
	}
	public String getItst_054() {
		return itst_054;
	}
	public void setItst_054(String itst_054) {
		this.itst_054 = itst_054;
	}
	public String getItst_055() {
		return itst_055;
	}
	public void setItst_055(String itst_055) {
		this.itst_055 = itst_055;
	}
	public String getItst_03n() {
		return itst_03n;
	}
	public void setItst_03n(String itst_03n) {
		this.itst_03n = itst_03n;
	}
	public String getItst_03s() {
		return itst_03s;
	}
	public void setItst_03s(String itst_03s) {
		this.itst_03s = itst_03s;
	}
	public String getItst_031() {
		return itst_031;
	}
	public void setItst_031(String itst_031) {
		this.itst_031 = itst_031;
	}
	public String getItst_032() {
		return itst_032;
	}
	public void setItst_032(String itst_032) {
		this.itst_032 = itst_032;
	}
	public String getItst_033() {
		return itst_033;
	}
	public void setItst_033(String itst_033) {
		this.itst_033 = itst_033;
	}
	public String getItst_034() {
		return itst_034;
	}
	public void setItst_034(String itst_034) {
		this.itst_034 = itst_034;
	}
	public String getItst_035() {
		return itst_035;
	}
	public void setItst_035(String itst_035) {
		this.itst_035 = itst_035;
	}
	public String getItst_01n() {
		return itst_01n;
	}
	public void setItst_01n(String itst_01n) {
		this.itst_01n = itst_01n;
	}
	public String getItst_01s() {
		return itst_01s;
	}
	public void setItst_01s(String itst_01s) {
		this.itst_01s = itst_01s;
	}
	public String getItst_011() {
		return itst_011;
	}
	public void setItst_011(String itst_011) {
		this.itst_011 = itst_011;
	}
	public String getItst_012() {
		return itst_012;
	}
	public void setItst_012(String itst_012) {
		this.itst_012 = itst_012;
	}
	public String getItst_013() {
		return itst_013;
	}
	public void setItst_013(String itst_013) {
		this.itst_013 = itst_013;
	}
	public String getItst_014() {
		return itst_014;
	}
	public void setItst_014(String itst_014) {
		this.itst_014 = itst_014;
	}
	public String getItst_015() {
		return itst_015;
	}
	public void setItst_015(String itst_015) {
		this.itst_015 = itst_015;
	}
	public String getItst_06n() {
		return itst_06n;
	}
	public void setItst_06n(String itst_06n) {
		this.itst_06n = itst_06n;
	}
	public String getItst_06s() {
		return itst_06s;
	}
	public void setItst_06s(String itst_06s) {
		this.itst_06s = itst_06s;
	}
	public String getItst_061() {
		return itst_061;
	}
	public void setItst_061(String itst_061) {
		this.itst_061 = itst_061;
	}
	public String getItst_062() {
		return itst_062;
	}
	public void setItst_062(String itst_062) {
		this.itst_062 = itst_062;
	}
	public String getItst_063() {
		return itst_063;
	}
	public void setItst_063(String itst_063) {
		this.itst_063 = itst_063;
	}
	public String getItst_064() {
		return itst_064;
	}
	public void setItst_064(String itst_064) {
		this.itst_064 = itst_064;
	}
	public String getItst_065() {
		return itst_065;
	}
	public void setItst_065(String itst_065) {
		this.itst_065 = itst_065;
	}
	public String getItst_07n() {
		return itst_07n;
	}
	public void setItst_07n(String itst_07n) {
		this.itst_07n = itst_07n;
	}
	public String getItst_07s() {
		return itst_07s;
	}
	public void setItst_07s(String itst_07s) {
		this.itst_07s = itst_07s;
	}
	public String getItst_071() {
		return itst_071;
	}
	public void setItst_071(String itst_071) {
		this.itst_071 = itst_071;
	}
	public String getItst_072() {
		return itst_072;
	}
	public void setItst_072(String itst_072) {
		this.itst_072 = itst_072;
	}
	public String getItst_073() {
		return itst_073;
	}
	public void setItst_073(String itst_073) {
		this.itst_073 = itst_073;
	}
	public String getItst_074() {
		return itst_074;
	}
	public void setItst_074(String itst_074) {
		this.itst_074 = itst_074;
	}
	public String getItst_075() {
		return itst_075;
	}
	public void setItst_075(String itst_075) {
		this.itst_075 = itst_075;
	}
	public String getItst_08n() {
		return itst_08n;
	}
	public void setItst_08n(String itst_08n) {
		this.itst_08n = itst_08n;
	}
	public String getItst_08s() {
		return itst_08s;
	}
	public void setItst_08s(String itst_08s) {
		this.itst_08s = itst_08s;
	}
	public String getItst_081() {
		return itst_081;
	}
	public void setItst_081(String itst_081) {
		this.itst_081 = itst_081;
	}
	public String getItst_082() {
		return itst_082;
	}
	public void setItst_082(String itst_082) {
		this.itst_082 = itst_082;
	}
	public String getItst_083() {
		return itst_083;
	}
	public void setItst_083(String itst_083) {
		this.itst_083 = itst_083;
	}
	public String getItst_084() {
		return itst_084;
	}
	public void setItst_084(String itst_084) {
		this.itst_084 = itst_084;
	}
	public String getItst_085() {
		return itst_085;
	}
	public void setItst_085(String itst_085) {
		this.itst_085 = itst_085;
	}
	public String getItst_04n() {
		return itst_04n;
	}
	public void setItst_04n(String itst_04n) {
		this.itst_04n = itst_04n;
	}
	public String getItst_04s() {
		return itst_04s;
	}
	public void setItst_04s(String itst_04s) {
		this.itst_04s = itst_04s;
	}
	public String getItst_041() {
		return itst_041;
	}
	public void setItst_041(String itst_041) {
		this.itst_041 = itst_041;
	}
	public String getItst_042() {
		return itst_042;
	}
	public void setItst_042(String itst_042) {
		this.itst_042 = itst_042;
	}
	public String getItst_043() {
		return itst_043;
	}
	public void setItst_043(String itst_043) {
		this.itst_043 = itst_043;
	}
	public String getItst_044() {
		return itst_044;
	}
	public void setItst_044(String itst_044) {
		this.itst_044 = itst_044;
	}
	public String getItst_045() {
		return itst_045;
	}
	public void setItst_045(String itst_045) {
		this.itst_045 = itst_045;
	}
	public String getItst_02n() {
		return itst_02n;
	}
	public void setItst_02n(String itst_02n) {
		this.itst_02n = itst_02n;
	}
	public String getItst_02s() {
		return itst_02s;
	}
	public void setItst_02s(String itst_02s) {
		this.itst_02s = itst_02s;
	}
	public String getItst_021() {
		return itst_021;
	}
	public void setItst_021(String itst_021) {
		this.itst_021 = itst_021;
	}
	public String getItst_022() {
		return itst_022;
	}
	public void setItst_022(String itst_022) {
		this.itst_022 = itst_022;
	}
	public String getItst_023() {
		return itst_023;
	}
	public void setItst_023(String itst_023) {
		this.itst_023 = itst_023;
	}
	public String getItst_024() {
		return itst_024;
	}
	public void setItst_024(String itst_024) {
		this.itst_024 = itst_024;
	}
	public String getItst_025() {
		return itst_025;
	}
	public void setItst_025(String itst_025) {
		this.itst_025 = itst_025;
	}
	public int getProd_code() {
		return prod_code;
	}
	public void setProd_code(int prod_code) {
		this.prod_code = prod_code;
	}
	public int getCorp_code() {
		return corp_code;
	}
	public void setCorp_code(int corp_code) {
		this.corp_code = corp_code;
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
	public String getProd_jai() {
		return prod_jai;
	}
	public void setProd_jai(String prod_jai) {
		this.prod_jai = prod_jai;
	}
	public String getProd_danj() {
		return prod_danj;
	}
	public void setProd_danj(String prod_danj) {
		this.prod_danj = prod_danj;
	}
	public String getProd_danw() {
		return prod_danw;
	}
	public void setProd_danw(String prod_danw) {
		this.prod_danw = prod_danw;
	}
	public String getProd_dang() {
		return prod_dang;
	}
	public void setProd_dang(String prod_dang) {
		this.prod_dang = prod_dang;
	}
	public String getTech_no() {
		return tech_no;
	}
	public void setTech_no(String tech_no) {
		this.tech_no = tech_no;
	}
	public String getCorp_name() {
		return corp_name;
	}
	public void setCorp_name(String corp_name) {
		this.corp_name = corp_name;
	}
	public String getItst_date() {
		return itst_date;
	}
	public void setItst_date(String itst_date) {
		this.itst_date = itst_date;
	}
	public String getOrd_date() {
		return ord_date;
	}
	public void setOrd_date(String ord_date) {
		this.ord_date = ord_date;
	}
	public String getItst_poor() {
		return itst_poor;
	}
	public void setItst_poor(String itst_poor) {
		this.itst_poor = itst_poor;
	}
	public String getItst_wp() {
		return itst_wp;
	}
	public void setItst_wp(String itst_wp) {
		this.itst_wp = itst_wp;
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
	public Integer getItst_code() {
		return itst_code;
	}
	public void setItst_code(Integer itst_code) {
		this.itst_code = itst_code;
	}
	public String getH_regdate() {
		return h_regdate;
	}
	public void setH_regdate(String h_regdate) {
		this.h_regdate = h_regdate;
	}
	public String getH_regtime() {
		return h_regtime;
	}
	public void setH_regtime(String h_regtime) {
		this.h_regtime = h_regtime;
	}
	public String getH_sdate() {
		return h_sdate;
	}
	public void setH_sdate(String h_sdate) {
		this.h_sdate = h_sdate;
	}
	public String getH_edate() {
		return h_edate;
	}
	public void setH_edate(String h_edate) {
		this.h_edate = h_edate;
	}
	public String getH_pnum() {
		return h_pnum;
	}
	public void setH_pnum(String h_pnum) {
		this.h_pnum = h_pnum;
	}
	public String getH_pname() {
		return h_pname;
	}
	public void setH_pname(String h_pname) {
		this.h_pname = h_pname;
	}
	public String getH_gang() {
		return h_gang;
	}
	public void setH_gang(String h_gang) {
		this.h_gang = h_gang;
	}
	public String getH_t_gb() {
		return h_t_gb;
	}
	public void setH_t_gb(String h_t_gb) {
		this.h_t_gb = h_t_gb;
	}
	public String getH_hard_up() {
		return h_hard_up;
	}
	public void setH_hard_up(String h_hard_up) {
		this.h_hard_up = h_hard_up;
	}
	public String getH_hard_dw() {
		return h_hard_dw;
	}
	public void setH_hard_dw(String h_hard_dw) {
		this.h_hard_dw = h_hard_dw;
	}
	public String getH_day() {
		return h_day;
	}
	public void setH_day(String h_day) {
		this.h_day = h_day;
	}
	public String getH_time() {
		return h_time;
	}
	public void setH_time(String h_time) {
		this.h_time = h_time;
	}
	public float getH_x1() {
		return h_x1;
	}
	public void setH_x1(float h_x1) {
		this.h_x1 = h_x1;
	}
	public float getH_x2() {
		return h_x2;
	}
	public void setH_x2(float h_x2) {
		this.h_x2 = h_x2;
	}
	public float getH_x3() {
		return h_x3;
	}
	public void setH_x3(float h_x3) {
		this.h_x3 = h_x3;
	}
	public float getH_avg() {
		return h_avg;
	}
	public void setH_avg(float h_avg) {
		this.h_avg = h_avg;
	}
	public float getH_range() {
		return h_range;
	}
	public void setH_range(float h_range) {
		this.h_range = h_range;
	}
	public int getN() {
		return n;
	}
	public void setN(int n) {
		this.n = n;
	}
	public double getD2() {
		return d2;
	}
	public void setD2(double d2) {
		this.d2 = d2;
	}
	public double getA2() {
		return a2;
	}
	public void setA2(double a2) {
		this.a2 = a2;
	}
	public double getD4() {
		return d4;
	}
	public void setD4(double d4) {
		this.d4 = d4;
	}
	public String getUcl_x() {
		return ucl_x;
	}
	public void setUcl_x(String ucl_x) {
		this.ucl_x = ucl_x;
	}
	public String getCl_x() {
		return cl_x;
	}
	public void setCl_x(String cl_x) {
		this.cl_x = cl_x;
	}
	public String getLcl_x() {
		return lcl_x;
	}
	public void setLcl_x(String lcl_x) {
		this.lcl_x = lcl_x;
	}
	public String getUcl_r() {
		return ucl_r;
	}
	public void setUcl_r(String ucl_r) {
		this.ucl_r = ucl_r;
	}
	public String getCl_r() {
		return cl_r;
	}
	public void setCl_r(String cl_r) {
		this.cl_r = cl_r;
	}
	public String getLcl_r() {
		return lcl_r;
	}
	public void setLcl_r(String lcl_r) {
		this.lcl_r = lcl_r;
	}
	public String getR_d2() {
		return r_d2;
	}
	public void setR_d2(String r_d2) {
		this.r_d2 = r_d2;
	}
	public String getCp() {
		return cp;
	}
	public void setCp(String cp) {
		this.cp = cp;
	}
	public String getK() {
		return k;
	}
	public void setK(String k) {
		this.k = k;
	}
	public String getCpk() {
		return cpk;
	}
	public void setCpk(String cpk) {
		this.cpk = cpk;
	}
	public double getG_ucl_x() {
		return g_ucl_x;
	}
	public void setG_ucl_x(double g_ucl_x) {
		this.g_ucl_x = g_ucl_x;
	}
	public double getG_cl_x() {
		return g_cl_x;
	}
	public void setG_cl_x(double g_cl_x) {
		this.g_cl_x = g_cl_x;
	}
	public double getG_lcl_x() {
		return g_lcl_x;
	}
	public void setG_lcl_x(double g_lcl_x) {
		this.g_lcl_x = g_lcl_x;
	}
	public double getG_ucl_r() {
		return g_ucl_r;
	}
	public void setG_ucl_r(double g_ucl_r) {
		this.g_ucl_r = g_ucl_r;
	}
	public double getG_cl_r() {
		return g_cl_r;
	}
	public void setG_cl_r(double g_cl_r) {
		this.g_cl_r = g_cl_r;
	}
	public double getG_max() {
		return g_max;
	}
	public void setG_max(double g_max) {
		this.g_max = g_max;
	}
	public double getG_min() {
		return g_min;
	}
	public void setG_min(double g_min) {
		this.g_min = g_min;
	}
	public double getG_avg() {
		return g_avg;
	}
	public void setG_avg(double g_avg) {
		this.g_avg = g_avg;
	}
	public double getG_range() {
		return g_range;
	}
	public void setG_range(double g_range) {
		this.g_range = g_range;
	}
	public String getG_tdatetime() {
		return g_tdatetime;
	}
	public void setG_tdatetime(String g_tdatetime) {
		this.g_tdatetime = g_tdatetime;
	}
	public int getG_idx() {
		return g_idx;
	}
	public void setG_idx(int g_idx) {
		this.g_idx = g_idx;
	}

}
