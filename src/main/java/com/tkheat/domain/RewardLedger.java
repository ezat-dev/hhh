package com.tkheat.domain;

public class RewardLedger {

	private Integer rl_idx;
	private String date;
	private String worker_no;
	private String name;
	private String dept;
	private String title;
	private String type;
	private String item;
	private String detail;
	private Double amount;
	private Double points;
	private String approver;
	private String status;

	public Integer getRl_idx() { return rl_idx; }
	public void setRl_idx(Integer rl_idx) { this.rl_idx = rl_idx; }
	public String getDate() { return date; }
	public void setDate(String date) { this.date = date; }
	public String getWorker_no() { return worker_no; }
	public void setWorker_no(String worker_no) { this.worker_no = worker_no; }
	public String getName() { return name; }
	public void setName(String name) { this.name = name; }
	public String getDept() { return dept; }
	public void setDept(String dept) { this.dept = dept; }
	public String getTitle() { return title; }
	public void setTitle(String title) { this.title = title; }
	public String getType() { return type; }
	public void setType(String type) { this.type = type; }
	public String getItem() { return item; }
	public void setItem(String item) { this.item = item; }
	public String getDetail() { return detail; }
	public void setDetail(String detail) { this.detail = detail; }
	public Double getAmount() { return amount; }
	public void setAmount(Double amount) { this.amount = amount; }
	public Double getPoints() { return points; }
	public void setPoints(Double points) { this.points = points; }
	public String getApprover() { return approver; }
	public void setApprover(String approver) { this.approver = approver; }
	public String getStatus() { return status; }
	public void setStatus(String status) { this.status = status; }
}
