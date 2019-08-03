package com.tj.ticketjava.admin.model.vo;

import java.util.Date;

public class Schedule {
	private int scheduleNo;
	private int performanceNo;
	private Date scheduleDate;
	private Date startTicketDate;
	public int getScheduleNo() {
		return scheduleNo;
	}
	public void setScheduleNo(int scheduleNo) {
		this.scheduleNo = scheduleNo;
	}
	public int getPerformanceNo() {
		return performanceNo;
	}
	public void setPerformanceNo(int performanceNo) {
		this.performanceNo = performanceNo;
	}
	public Date getScheduleDate() {
		return scheduleDate;
	}
	public void setScheduleDate(Date scheduleDate) {
		this.scheduleDate = scheduleDate;
	}
	public Date getStartTicketDate() {
		return startTicketDate;
	}
	public void setStartTicketDate(Date startTicketDate) {
		this.startTicketDate = startTicketDate;
	}
	
	public Schedule() {}
	
	public Schedule(int scheduleNo, int performanceNo, Date scheduleDate, Date startTicketDate) {
		super();
		this.scheduleNo = scheduleNo;
		this.performanceNo = performanceNo;
		this.scheduleDate = scheduleDate;
		this.startTicketDate = startTicketDate;
	}
	@Override
	public String toString() {
		return "Schedule [scheduleNo=" + scheduleNo + ", performanceNo=" + performanceNo + ", scheduleDate="
				+ scheduleDate + ", startTicketDate=" + startTicketDate + "]";
	}
	
	
	
	
}