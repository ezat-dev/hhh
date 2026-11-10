package com.tkheat.domain;

public class PayrollEmp {

	private Integer pe_idx;
	private String worker_no;		//USERT.USER_NO(사번) 느슨한 참조
	private String email;
	private Double base;			//기본급
	private Double meal;			//식대
	private Double pos;			//직책수당
	private Double car;			//차량유지비

	//USERT 조인 표시용(읽기전용)
	private String name;
	private String dept;
	private String rank;
	private String joinDate;

	public Integer getPe_idx() { return pe_idx; }
	public void setPe_idx(Integer pe_idx) { this.pe_idx = pe_idx; }
	public String getWorker_no() { return worker_no; }
	public void setWorker_no(String worker_no) { this.worker_no = worker_no; }
	public String getEmail() { return email; }
	public void setEmail(String email) { this.email = email; }
	public Double getBase() { return base; }
	public void setBase(Double base) { this.base = base; }
	public Double getMeal() { return meal; }
	public void setMeal(Double meal) { this.meal = meal; }
	public Double getPos() { return pos; }
	public void setPos(Double pos) { this.pos = pos; }
	public Double getCar() { return car; }
	public void setCar(Double car) { this.car = car; }
	public String getName() { return name; }
	public void setName(String name) { this.name = name; }
	public String getDept() { return dept; }
	public void setDept(String dept) { this.dept = dept; }
	public String getRank() { return rank; }
	public void setRank(String rank) { this.rank = rank; }
	public String getJoinDate() { return joinDate; }
	public void setJoinDate(String joinDate) { this.joinDate = joinDate; }
}
