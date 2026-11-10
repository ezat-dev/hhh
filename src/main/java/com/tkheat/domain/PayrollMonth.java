package com.tkheat.domain;

public class PayrollMonth {

	private Integer pm_idx;
	private String ym;				//yyyy-MM
	private String worker_no;

	//지급(빈 값이면 PayrollEmp 기본값 사용 - 화면에서 처리)
	private Double base;
	private Double meal;
	private Double pos;
	private Double car;
	private Double ot;
	private Double night;
	private Double sat;
	private Double spec;
	private Double bonus;

	//공제(원 단위 직접 입력, 빈 값이면 0)
	private Double npa;
	private Double hia;
	private Double lta;
	private Double eia;
	private Double tax;
	private Double loca;
	private Double yj;
	private Double hs;
	private Double ded;

	public Integer getPm_idx() { return pm_idx; }
	public void setPm_idx(Integer pm_idx) { this.pm_idx = pm_idx; }
	public String getYm() { return ym; }
	public void setYm(String ym) { this.ym = ym; }
	public String getWorker_no() { return worker_no; }
	public void setWorker_no(String worker_no) { this.worker_no = worker_no; }
	public Double getBase() { return base; }
	public void setBase(Double base) { this.base = base; }
	public Double getMeal() { return meal; }
	public void setMeal(Double meal) { this.meal = meal; }
	public Double getPos() { return pos; }
	public void setPos(Double pos) { this.pos = pos; }
	public Double getCar() { return car; }
	public void setCar(Double car) { this.car = car; }
	public Double getOt() { return ot; }
	public void setOt(Double ot) { this.ot = ot; }
	public Double getNight() { return night; }
	public void setNight(Double night) { this.night = night; }
	public Double getSat() { return sat; }
	public void setSat(Double sat) { this.sat = sat; }
	public Double getSpec() { return spec; }
	public void setSpec(Double spec) { this.spec = spec; }
	public Double getBonus() { return bonus; }
	public void setBonus(Double bonus) { this.bonus = bonus; }
	public Double getNpa() { return npa; }
	public void setNpa(Double npa) { this.npa = npa; }
	public Double getHia() { return hia; }
	public void setHia(Double hia) { this.hia = hia; }
	public Double getLta() { return lta; }
	public void setLta(Double lta) { this.lta = lta; }
	public Double getEia() { return eia; }
	public void setEia(Double eia) { this.eia = eia; }
	public Double getTax() { return tax; }
	public void setTax(Double tax) { this.tax = tax; }
	public Double getLoca() { return loca; }
	public void setLoca(Double loca) { this.loca = loca; }
	public Double getYj() { return yj; }
	public void setYj(Double yj) { this.yj = yj; }
	public Double getHs() { return hs; }
	public void setHs(Double hs) { this.hs = hs; }
	public Double getDed() { return ded; }
	public void setDed(Double ded) { this.ded = ded; }
}
