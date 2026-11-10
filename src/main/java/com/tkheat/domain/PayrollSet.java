package com.tkheat.domain;

public class PayrollSet {

	private Integer pst_idx;
	private String co;
	private String fromEmail;
	private String fn;
	private String mode;
	private String bcc;
	private Double np;
	private Double hi;
	private Double lt;
	private Double ei;
	private Double tx;
	private Double mealLimit;

	//SMTP 발송 설정
	private String smtpHost;
	private Integer smtpPort;
	private String smtpUser;
	private String smtpPass;

	public Integer getPst_idx() { return pst_idx; }
	public void setPst_idx(Integer pst_idx) { this.pst_idx = pst_idx; }
	public String getCo() { return co; }
	public void setCo(String co) { this.co = co; }
	public String getFromEmail() { return fromEmail; }
	public void setFromEmail(String fromEmail) { this.fromEmail = fromEmail; }
	public String getFn() { return fn; }
	public void setFn(String fn) { this.fn = fn; }
	public String getMode() { return mode; }
	public void setMode(String mode) { this.mode = mode; }
	public String getBcc() { return bcc; }
	public void setBcc(String bcc) { this.bcc = bcc; }
	public Double getNp() { return np; }
	public void setNp(Double np) { this.np = np; }
	public Double getHi() { return hi; }
	public void setHi(Double hi) { this.hi = hi; }
	public Double getLt() { return lt; }
	public void setLt(Double lt) { this.lt = lt; }
	public Double getEi() { return ei; }
	public void setEi(Double ei) { this.ei = ei; }
	public Double getTx() { return tx; }
	public void setTx(Double tx) { this.tx = tx; }
	public Double getMealLimit() { return mealLimit; }
	public void setMealLimit(Double mealLimit) { this.mealLimit = mealLimit; }
	public String getSmtpHost() { return smtpHost; }
	public void setSmtpHost(String smtpHost) { this.smtpHost = smtpHost; }
	public Integer getSmtpPort() { return smtpPort; }
	public void setSmtpPort(Integer smtpPort) { this.smtpPort = smtpPort; }
	public String getSmtpUser() { return smtpUser; }
	public void setSmtpUser(String smtpUser) { this.smtpUser = smtpUser; }
	public String getSmtpPass() { return smtpPass; }
	public void setSmtpPass(String smtpPass) { this.smtpPass = smtpPass; }
}
