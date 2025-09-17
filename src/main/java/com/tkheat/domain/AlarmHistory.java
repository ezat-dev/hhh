package com.tkheat.domain;

public class AlarmHistory {

	//SQLite alarmdata 테이블
	private String tagname;
	private float tagvalue;
	private String alarmstate;
	private String alarmlevel;
	private String alarmgroup;
	private String alarmname;
	private String alarmdesc;
	private String trigger;
	private String time;
	private String lead_alarmstate;
	private String lead_alarmtime;
	
	//조회
	private String sdateTime;
	private String edateTime;
	
	
	public String getTagname() {
		return tagname;
	}
	public void setTagname(String tagname) {
		this.tagname = tagname;
	}
	public float getTagvalue() {
		return tagvalue;
	}
	public void setTagvalue(float tagvalue) {
		this.tagvalue = tagvalue;
	}
	public String getAlarmstate() {
		return alarmstate;
	}
	public void setAlarmstate(String alarmstate) {
		this.alarmstate = alarmstate;
	}
	public String getAlarmlevel() {
		return alarmlevel;
	}
	public void setAlarmlevel(String alarmlevel) {
		this.alarmlevel = alarmlevel;
	}
	public String getAlarmgroup() {
		return alarmgroup;
	}
	public void setAlarmgroup(String alarmgroup) {
		this.alarmgroup = alarmgroup;
	}
	public String getAlarmname() {
		return alarmname;
	}
	public void setAlarmname(String alarmname) {
		this.alarmname = alarmname;
	}
	public String getAlarmdesc() {
		return alarmdesc;
	}
	public void setAlarmdesc(String alarmdesc) {
		this.alarmdesc = alarmdesc;
	}	
	public String getTrigger() {
		return trigger;
	}
	public void setTrigger(String trigger) {
		this.trigger = trigger;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
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
	public String getLead_alarmstate() {
		return lead_alarmstate;
	}
	public void setLead_alarmstate(String lead_alarmstate) {
		this.lead_alarmstate = lead_alarmstate;
	}
	public String getLead_alarmtime() {
		return lead_alarmtime;
	}
	public void setLead_alarmtime(String lead_alarmtime) {
		this.lead_alarmtime = lead_alarmtime;
	}
	
	
}