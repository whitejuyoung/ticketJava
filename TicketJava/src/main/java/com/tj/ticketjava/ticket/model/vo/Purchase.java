package com.tj.ticketjava.ticket.model.vo;

import java.sql.Date;


public class Purchase {
	private int purchaseNo;
	private String memberId;
	private int totalPrice;
	private int purchaseCount;
	private Date purchaseDate;
	private String performanceTitle;
	private String scheduleDate;
	private int usePoint;
	
	public Purchase() {}
	
	

	public Purchase(int purchaseNo, String memberId, int totalPrice, int purchaseCount, Date purchaseDate,
			String performanceTitle, String scheduleDate, int usePoint) {
		super();
		this.purchaseNo = purchaseNo;
		this.memberId = memberId;
		this.totalPrice = totalPrice;
		this.purchaseCount = purchaseCount;
		this.purchaseDate = purchaseDate;
		this.performanceTitle = performanceTitle;
		this.scheduleDate = scheduleDate;
		this.usePoint = usePoint;
	}



	public int getUsePoint() {
		return usePoint;
	}



	public void setUsePoint(int usePoint) {
		this.usePoint = usePoint;
	}



	public int getPurchaseNo() {
		return purchaseNo;
	}

	public void setPurchaseNo(int purchaseNo) {
		this.purchaseNo = purchaseNo;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public int getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(int totalPrice) {
		this.totalPrice = totalPrice;
	}

	public int getPurchaseCount() {
		return purchaseCount;
	}

	public void setPurchaseCount(int purchaseCount) {
		this.purchaseCount = purchaseCount;
	}

	public Date getPurchaseDate() {
		return purchaseDate;
	}

	public void setPurchaseDate(Date purchaseDate) {
		this.purchaseDate = purchaseDate;
	}

	public String getPerformanceTitle() {
		return performanceTitle;
	}

	public void setPerformanceTitle(String performanceTitle) {
		this.performanceTitle = performanceTitle;
	}

	public String getScheduleDate() {
		return scheduleDate;
	}

	public void setScheduleDate(String scheduleDate) {
		this.scheduleDate = scheduleDate;
	}



	@Override
	public String toString() {
		return "Purchase [purchaseNo=" + purchaseNo + ", memberId=" + memberId + ", totalPrice=" + totalPrice
				+ ", purchaseCount=" + purchaseCount + ", purchaseDate=" + purchaseDate + ", performanceTitle="
				+ performanceTitle + ", scheduleDate=" + scheduleDate + ", usePoint=" + usePoint + "]";
	}



	
	
	

}
