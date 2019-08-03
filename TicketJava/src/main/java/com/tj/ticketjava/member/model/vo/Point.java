package com.tj.ticketjava.member.model.vo;

import java.sql.Date;

public class Point {
	private String memberId;
	private int point;
	private Date pointDate;
	private String pointMessage;
	private String pointStatus;
	
	public Point() {}

	public Point(String memberId, int point, Date pointDate, String pointMessage, String pointStatus) {
		super();
		this.memberId = memberId;
		this.point = point;
		this.pointDate = pointDate;
		this.pointMessage = pointMessage;
		this.pointStatus = pointStatus;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public int getPoint() {
		return point;
	}

	public void setPoint(int point) {
		this.point = point;
	}

	public Date getPointDate() {
		return pointDate;
	}

	public void setPointDate(Date pointDate) {
		this.pointDate = pointDate;
	}

	public String getPointMessage() {
		return pointMessage;
	}

	public void setPointMessage(String pointMessage) {
		this.pointMessage = pointMessage;
	}

	public String getPointStatus() {
		return pointStatus;
	}

	public void setPointStatus(String pointStatus) {
		this.pointStatus = pointStatus;
	}

	@Override
	public String toString() {
		return "Point [memberId=" + memberId + ", point=" + point + ", pointDate=" + pointDate + ", pointMessage="
				+ pointMessage + ", pointStatus=" + pointStatus + "]";
	}

	
}