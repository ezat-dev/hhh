package com.tkheat.domain;

public class RewardItem {

	private Integer ri_idx;
	private String type;		//즉시 포상 / 포인트 적립
	private String name;
	private String c1;
	private String c2;
	private String c3;
	private String c4;
	private Double min;
	private Double max;

	public Integer getRi_idx() { return ri_idx; }
	public void setRi_idx(Integer ri_idx) { this.ri_idx = ri_idx; }
	public String getType() { return type; }
	public void setType(String type) { this.type = type; }
	public String getName() { return name; }
	public void setName(String name) { this.name = name; }
	public String getC1() { return c1; }
	public void setC1(String c1) { this.c1 = c1; }
	public String getC2() { return c2; }
	public void setC2(String c2) { this.c2 = c2; }
	public String getC3() { return c3; }
	public void setC3(String c3) { this.c3 = c3; }
	public String getC4() { return c4; }
	public void setC4(String c4) { this.c4 = c4; }
	public Double getMin() { return min; }
	public void setMin(Double min) { this.min = min; }
	public Double getMax() { return max; }
	public void setMax(Double max) { this.max = max; }
}
