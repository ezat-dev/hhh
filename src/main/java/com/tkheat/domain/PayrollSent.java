package com.tkheat.domain;

public class PayrollSent {

	private Integer ps_idx;
	private String ym;
	private String worker_no;
	private String sentDate;

	public Integer getPs_idx() { return ps_idx; }
	public void setPs_idx(Integer ps_idx) { this.ps_idx = ps_idx; }
	public String getYm() { return ym; }
	public void setYm(String ym) { this.ym = ym; }
	public String getWorker_no() { return worker_no; }
	public void setWorker_no(String worker_no) { this.worker_no = worker_no; }
	public String getSentDate() { return sentDate; }
	public void setSentDate(String sentDate) { this.sentDate = sentDate; }
}
