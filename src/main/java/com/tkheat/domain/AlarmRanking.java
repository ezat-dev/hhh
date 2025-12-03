package com.tkheat.domain;

public class AlarmRanking {

	//SQLite alarmdata 테이블
	private String tagname;
	private String alarmgroup;
	private String alarmdesc;
	private int alarmcount;
	
	private String regtime;
    private String releaseTime;
   private String a_hogi;
   private Integer a_value;
   private String a_addr;
   private String a_comment;
   private String tagName;
   private String displayValue;
   
	//조회
	private String sdateTime;
	private String edateTime;;
	
	
	public String getTagname() {
		return tagname;
	}
	public void setTagname(String tagname) {
		this.tagname = tagname;
	}
	public String getAlarmgroup() {
		return alarmgroup;
	}
	public void setAlarmgroup(String alarmgroup) {
		this.alarmgroup = alarmgroup;
	}
	public String getAlarmdesc() {
		return alarmdesc;
	}
	public void setAlarmdesc(String alarmdesc) {
		this.alarmdesc = alarmdesc;
	}
	public int getAlarmcount() {
		return alarmcount;
	}
	public void setAlarmcount(int alarmcount) {
		this.alarmcount = alarmcount;
	}
	public String getSdateTime() {
		return sdateTime;
	}
	public void setSdateTime(String sdateTime) {
		this.sdateTime = sdateTime;
	}
	public String getEdateTime() {
		return edateTime;
	}
	public void setEdateTime(String edateTime) {
		this.edateTime = edateTime;
	}
	public String getRegtime() {
		return regtime;
	}
	public void setRegtime(String regtime) {
		this.regtime = regtime;
	}
	public String getA_hogi() {
		return a_hogi;
	}
	public void setA_hogi(String a_hogi) {
		this.a_hogi = a_hogi;
	}
	public String getA_addr() {
		return a_addr;
	}
	public void setA_addr(String a_addr) {
		this.a_addr = a_addr;
	}
	public Integer getA_value() {
		return a_value;
	}
	public void setA_value(Integer a_value) {
		this.a_value = a_value;
	}
	public String getA_comment() {
		return a_comment;
	}
	public void setA_comment(String a_comment) {
		this.a_comment = a_comment;
	}
	public String getTagName() {
		return tagName;
	}
	public void setTagName(String tagName) {
		this.tagName = tagName;
	}
	public String getReleaseTime() {
		return releaseTime;
	}
	public void setReleaseTime(String releaseTime) {
		this.releaseTime = releaseTime;
	}
	public String getDisplayValue() {
		return displayValue;
	}
	public void setDisplayValue(String displayValue) {
		this.displayValue = displayValue;
	}
}