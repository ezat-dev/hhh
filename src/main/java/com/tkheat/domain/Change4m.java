package com.tkheat.domain;

public class Change4m {

	private Integer c4m_idx;
	private String c4m_no;			//관리번호
	private String c4m_recv;		//접수일
	private String c4m_scope;		//변경구분(사내/사외)
	private String c4m_m4;			//4M 구분
	private String c4m_origin;		//변경 발생처
	private String c4m_dept;		//담당부서
	private String c4m_owner;		//담당자

	private Integer c4m_prod_code;	//품번 조회용(PRODUCT.PROD_CODE, 선택사항)
	private String c4m_cust;		//고객사
	private String c4m_model;		//적용차종
	private String c4m_pn;			//품번
	private String c4m_pname;		//품명
	private String c4m_target;		//대상 공정/설비/자재/작업자
	private String c4m_before;		//변경 전
	private String c4m_after;		//변경 후
	private String c4m_why;			//변경 사유

	private String c4m_grade;		//변경등급(A/B/C)
	private String c4m_rep;			//고객 신고일
	private String c4m_appr;		//고객 승인일
	private String c4m_vitem;		//검증 항목
	private String c4m_vres;		//검증 결과

	private String c4m_plan;		//적용 예정일
	private String c4m_start;		//최초 적용일
	private Integer c4m_flow;		//초기유동관리 기간(일)
	private String c4m_status;		//진행상태
	private String c4m_end;			//종결일
	private String c4m_memo;
	private String c4m_reg_date;

	//계산값(응답 표시용, DB 미저장)
	private String resp;			//고객 대응(사전승인/사후통보/내부관리)
	private String flow_end;		//초기유동관리 종료일
	private String delay;			//지연여부
	private Integer days;			//경과일

	//조회 조건
	private String keyword;
	private String scope;
	private String m4;
	private String status;

	public Integer getC4m_idx() { return c4m_idx; }
	public void setC4m_idx(Integer c4m_idx) { this.c4m_idx = c4m_idx; }
	public String getC4m_no() { return c4m_no; }
	public void setC4m_no(String c4m_no) { this.c4m_no = c4m_no; }
	public String getC4m_recv() { return c4m_recv; }
	public void setC4m_recv(String c4m_recv) { this.c4m_recv = c4m_recv; }
	public String getC4m_scope() { return c4m_scope; }
	public void setC4m_scope(String c4m_scope) { this.c4m_scope = c4m_scope; }
	public String getC4m_m4() { return c4m_m4; }
	public void setC4m_m4(String c4m_m4) { this.c4m_m4 = c4m_m4; }
	public String getC4m_origin() { return c4m_origin; }
	public void setC4m_origin(String c4m_origin) { this.c4m_origin = c4m_origin; }
	public String getC4m_dept() { return c4m_dept; }
	public void setC4m_dept(String c4m_dept) { this.c4m_dept = c4m_dept; }
	public String getC4m_owner() { return c4m_owner; }
	public void setC4m_owner(String c4m_owner) { this.c4m_owner = c4m_owner; }
	public Integer getC4m_prod_code() { return c4m_prod_code; }
	public void setC4m_prod_code(Integer c4m_prod_code) { this.c4m_prod_code = c4m_prod_code; }
	public String getC4m_cust() { return c4m_cust; }
	public void setC4m_cust(String c4m_cust) { this.c4m_cust = c4m_cust; }
	public String getC4m_model() { return c4m_model; }
	public void setC4m_model(String c4m_model) { this.c4m_model = c4m_model; }
	public String getC4m_pn() { return c4m_pn; }
	public void setC4m_pn(String c4m_pn) { this.c4m_pn = c4m_pn; }
	public String getC4m_pname() { return c4m_pname; }
	public void setC4m_pname(String c4m_pname) { this.c4m_pname = c4m_pname; }
	public String getC4m_target() { return c4m_target; }
	public void setC4m_target(String c4m_target) { this.c4m_target = c4m_target; }
	public String getC4m_before() { return c4m_before; }
	public void setC4m_before(String c4m_before) { this.c4m_before = c4m_before; }
	public String getC4m_after() { return c4m_after; }
	public void setC4m_after(String c4m_after) { this.c4m_after = c4m_after; }
	public String getC4m_why() { return c4m_why; }
	public void setC4m_why(String c4m_why) { this.c4m_why = c4m_why; }
	public String getC4m_grade() { return c4m_grade; }
	public void setC4m_grade(String c4m_grade) { this.c4m_grade = c4m_grade; }
	public String getC4m_rep() { return c4m_rep; }
	public void setC4m_rep(String c4m_rep) { this.c4m_rep = c4m_rep; }
	public String getC4m_appr() { return c4m_appr; }
	public void setC4m_appr(String c4m_appr) { this.c4m_appr = c4m_appr; }
	public String getC4m_vitem() { return c4m_vitem; }
	public void setC4m_vitem(String c4m_vitem) { this.c4m_vitem = c4m_vitem; }
	public String getC4m_vres() { return c4m_vres; }
	public void setC4m_vres(String c4m_vres) { this.c4m_vres = c4m_vres; }
	public String getC4m_plan() { return c4m_plan; }
	public void setC4m_plan(String c4m_plan) { this.c4m_plan = c4m_plan; }
	public String getC4m_start() { return c4m_start; }
	public void setC4m_start(String c4m_start) { this.c4m_start = c4m_start; }
	public Integer getC4m_flow() { return c4m_flow; }
	public void setC4m_flow(Integer c4m_flow) { this.c4m_flow = c4m_flow; }
	public String getC4m_status() { return c4m_status; }
	public void setC4m_status(String c4m_status) { this.c4m_status = c4m_status; }
	public String getC4m_end() { return c4m_end; }
	public void setC4m_end(String c4m_end) { this.c4m_end = c4m_end; }
	public String getC4m_memo() { return c4m_memo; }
	public void setC4m_memo(String c4m_memo) { this.c4m_memo = c4m_memo; }
	public String getC4m_reg_date() { return c4m_reg_date; }
	public void setC4m_reg_date(String c4m_reg_date) { this.c4m_reg_date = c4m_reg_date; }
	public String getResp() { return resp; }
	public void setResp(String resp) { this.resp = resp; }
	public String getFlow_end() { return flow_end; }
	public void setFlow_end(String flow_end) { this.flow_end = flow_end; }
	public String getDelay() { return delay; }
	public void setDelay(String delay) { this.delay = delay; }
	public Integer getDays() { return days; }
	public void setDays(Integer days) { this.days = days; }
	public String getKeyword() { return keyword; }
	public void setKeyword(String keyword) { this.keyword = keyword; }
	public String getScope() { return scope; }
	public void setScope(String scope) { this.scope = scope; }
	public String getM4() { return m4; }
	public void setM4(String m4) { this.m4 = m4; }
	public String getStatus() { return status; }
	public void setStatus(String status) { this.status = status; }
}
