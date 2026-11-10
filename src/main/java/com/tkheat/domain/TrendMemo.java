package com.tkheat.domain;

public class TrendMemo {

	private int memo_code;
	private String hogi_code;
	private String memo_time;
	private String memo_text;
	private String reg_user;
	private String reg_date;
	private Double memo_value;		//메모가 찍힌 선의 실제 값(온도 또는 CP 원래 값)
	private Integer yaxis_index;		//0=온도축, 1=CP축 - 어느 축 기준 값인지
	private String series_name;		//어느 계열(선)에 찍었는지 표시용(예: "BCF1 CF(PV)")

	//조회 조건(기간)용 - 저장 자체에는 쓰이지 않음
	private String sdate;
	private String edate;

	public int getMemo_code() {
		return memo_code;
	}

	public void setMemo_code(int memo_code) {
		this.memo_code = memo_code;
	}

	public String getHogi_code() {
		return hogi_code;
	}

	public void setHogi_code(String hogi_code) {
		this.hogi_code = hogi_code;
	}

	public String getMemo_time() {
		return memo_time;
	}

	public void setMemo_time(String memo_time) {
		this.memo_time = memo_time;
	}

	public String getMemo_text() {
		return memo_text;
	}

	public void setMemo_text(String memo_text) {
		this.memo_text = memo_text;
	}

	public String getReg_user() {
		return reg_user;
	}

	public void setReg_user(String reg_user) {
		this.reg_user = reg_user;
	}

	public String getReg_date() {
		return reg_date;
	}

	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
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

	public Double getMemo_value() {
		return memo_value;
	}

	public void setMemo_value(Double memo_value) {
		this.memo_value = memo_value;
	}

	public Integer getYaxis_index() {
		return yaxis_index;
	}

	public void setYaxis_index(Integer yaxis_index) {
		this.yaxis_index = yaxis_index;
	}

	public String getSeries_name() {
		return series_name;
	}

	public void setSeries_name(String series_name) {
		this.series_name = series_name;
	}
}
