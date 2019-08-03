package com.tj.ticketjava.review.model.vo;

import java.sql.Date;

public class Review {
	
	private int reviewNo;
	private int performanceNo;
	private String memberId;
	private String reviewContent;
	private Date reviewDate;
	private int reviewRating;
	

	
	public Review(int reviewNo, int performanceNo, String memberId, String reviewContent, Date reviewDate,
			int reviewRating) {
		super();
		this.reviewNo = reviewNo;
		this.performanceNo = performanceNo;
		this.memberId = memberId;
		this.reviewContent = reviewContent;
		this.reviewDate = reviewDate;
		this.reviewRating = reviewRating;
	}
	public Review() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	
	public int getReviewNo() {
		return reviewNo;
	}
	public void setReviewNo(int reviewNo) {
		this.reviewNo = reviewNo;
	}
	public int getPerformanceNo() {
		return performanceNo;
	}
	public void setPerformanceNo(int performanceNo) {
		this.performanceNo = performanceNo;
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public String getReviewContent() {
		return reviewContent;
	}
	public void setReviewContent(String reviewContent) {
		this.reviewContent = reviewContent;
	}
	public Date getReviewDate() {
		return reviewDate;
	}
	public void setReviewDate(Date reviewDate) {
		this.reviewDate = reviewDate;
	}
	public int getReviewRating() {
		return reviewRating;
	}
	public void setReviewRating(int reviewRating) {
		this.reviewRating = reviewRating;
	}
	
	
	@Override
	public String toString() {
		return "Review [reviewNo=" + reviewNo + ", performanceNo=" + performanceNo + ", memberId=" + memberId
				+ ", reviewContent=" + reviewContent + ", reviewDate=" + reviewDate + ", reviewRating=" + reviewRating
				+ "]";
	}
	
	

}
