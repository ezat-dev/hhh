package com.tkheat.domain;

public class AlarmRanking {

	//SQLite alarmdata 테이블
	private String tagname;
	private String alarmgroup;
	private String alarmdesc;
	private int alarmcount;
	
	//조회
	private String sdateTime;
	private String edateTime;
	
	
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
}