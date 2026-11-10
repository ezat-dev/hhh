package com.tkheat.domain;

public class DeliveryRate {

	private String sdate;
	private String edate;
	private String corp_name;

	private int row_num;
	private int total_cnt;      //대상 주문건수
	private int shipped_cnt;    //출고완료 건수
	private int not_shipped_cnt;//미출고 건수(정상 진행중 - 출고예정일이 아직 지나지 않음)
	private int overdue_unshipped_cnt; //기한초과 미출고 건수(출고예정일이 지났는데도 전량 출고가 안 됨, late_cnt에 포함됨)
	private int late_cnt;       //지연 건수(완료됐지만 납기편차 > 0 이거나, 기한초과 미출고)
	private int ontime_cnt;     //정시/조기 건수(납기편차 <= 0)
	private double late_rate;   //지연율(%) = late_cnt(완료지연+기한초과미출고) / total_cnt * 100
	private double compliance_rate; //납기준수율(%) = ontime_cnt / total_cnt * 100 (확정된 공식 지표)
	private double avg_gap_hours;  //평균 납기편차(시간) = 실제출고일 - 출고예정일
	private double avg_late_hours; //지연건만 평균 지연시간(시간)

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
	public String getCorp_name() {
		return corp_name;
	}
	public void setCorp_name(String corp_name) {
		this.corp_name = corp_name;
	}
	public int getRow_num() {
		return row_num;
	}
	public void setRow_num(int row_num) {
		this.row_num = row_num;
	}
	public int getTotal_cnt() {
		return total_cnt;
	}
	public void setTotal_cnt(int total_cnt) {
		this.total_cnt = total_cnt;
	}
	public int getShipped_cnt() {
		return shipped_cnt;
	}
	public void setShipped_cnt(int shipped_cnt) {
		this.shipped_cnt = shipped_cnt;
	}
	public int getNot_shipped_cnt() {
		return not_shipped_cnt;
	}
	public void setNot_shipped_cnt(int not_shipped_cnt) {
		this.not_shipped_cnt = not_shipped_cnt;
	}
	public int getOverdue_unshipped_cnt() {
		return overdue_unshipped_cnt;
	}
	public void setOverdue_unshipped_cnt(int overdue_unshipped_cnt) {
		this.overdue_unshipped_cnt = overdue_unshipped_cnt;
	}
	public int getLate_cnt() {
		return late_cnt;
	}
	public void setLate_cnt(int late_cnt) {
		this.late_cnt = late_cnt;
	}
	public int getOntime_cnt() {
		return ontime_cnt;
	}
	public void setOntime_cnt(int ontime_cnt) {
		this.ontime_cnt = ontime_cnt;
	}
	public double getLate_rate() {
		return late_rate;
	}
	public void setLate_rate(double late_rate) {
		this.late_rate = late_rate;
	}
	public double getCompliance_rate() {
		return compliance_rate;
	}
	public void setCompliance_rate(double compliance_rate) {
		this.compliance_rate = compliance_rate;
	}
	public double getAvg_gap_hours() {
		return avg_gap_hours;
	}
	public void setAvg_gap_hours(double avg_gap_hours) {
		this.avg_gap_hours = avg_gap_hours;
	}
	public double getAvg_late_hours() {
		return avg_late_hours;
	}
	public void setAvg_late_hours(double avg_late_hours) {
		this.avg_late_hours = avg_late_hours;
	}

}
