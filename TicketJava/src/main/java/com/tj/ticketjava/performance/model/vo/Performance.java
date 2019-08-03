package com.tj.ticketjava.performance.model.vo;

import java.sql.Date;

public class Performance {
	
	private int performanceNo;
	private String performanceCode;
	private String placeCode;
	private String performanceTitle;
	private Date startDate;
	private Date endDate;
	private int totalRating;
	private int ratingCount;
	private int runningTime;
	private int viewingClass;
	private String casting;
	private int price;
	
	//필드추가
	private String performanceCodeName;
	private String placeName;
	private String address;
	private int cnt;
	private int allSeat;
	private int totalPeople;
	private int genderF;
	private int genderM;
	private String age;
	private String originalFileName;
	private String renamedFileName;

	public Performance() {}

	public Performance(int performanceNo, String performanceCode, String placeCode, String performanceTitle,
			Date startDate, Date endDate, int totalRating, int ratingCount, int runningTime, int viewingClass,
			String casting, int price, String performanceCodeName, String placeName, String address, int cnt,
			int allSeat, int totalPeople, int genderF, int genderM, String age, String originalFileName,
			String renamedFileName) {
		super();
		this.performanceNo = performanceNo;
		this.performanceCode = performanceCode;
		this.placeCode = placeCode;
		this.performanceTitle = performanceTitle;
		this.startDate = startDate;
		this.endDate = endDate;
		this.totalRating = totalRating;
		this.ratingCount = ratingCount;
		this.runningTime = runningTime;
		this.viewingClass = viewingClass;
		this.casting = casting;
		this.price = price;
		this.performanceCodeName = performanceCodeName;
		this.placeName = placeName;
		this.address = address;
		this.cnt = cnt;
		this.allSeat = allSeat;
		this.totalPeople = totalPeople;
		this.genderF = genderF;
		this.genderM = genderM;
		this.age = age;
		this.originalFileName = originalFileName;
		this.renamedFileName = renamedFileName;
	}

	public int getPerformanceNo() {
		return performanceNo;
	}

	public void setPerformanceNo(int performanceNo) {
		this.performanceNo = performanceNo;
	}

	public String getPerformanceCode() {
		return performanceCode;
	}

	public void setPerformanceCode(String performanceCode) {
		this.performanceCode = performanceCode;
	}

	public String getPlaceCode() {
		return placeCode;
	}

	public void setPlaceCode(String placeCode) {
		this.placeCode = placeCode;
	}

	public String getPerformanceTitle() {
		return performanceTitle;
	}

	public void setPerformanceTitle(String performanceTitle) {
		this.performanceTitle = performanceTitle;
	}

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public int getTotalRating() {
		return totalRating;
	}

	public void setTotalRating(int totalRating) {
		this.totalRating = totalRating;
	}

	public int getRatingCount() {
		return ratingCount;
	}

	public void setRatingCount(int ratingCount) {
		this.ratingCount = ratingCount;
	}

	public int getRunningTime() {
		return runningTime;
	}

	public void setRunningTime(int runningTime) {
		this.runningTime = runningTime;
	}

	public int getViewingClass() {
		return viewingClass;
	}

	public void setViewingClass(int viewingClass) {
		this.viewingClass = viewingClass;
	}

	public String getCasting() {
		return casting;
	}

	public void setCasting(String casting) {
		this.casting = casting;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public String getPerformanceCodeName() {
		return performanceCodeName;
	}

	public void setPerformanceCodeName(String performanceCodeName) {
		this.performanceCodeName = performanceCodeName;
	}

	public String getPlaceName() {
		return placeName;
	}

	public void setPlaceName(String placeName) {
		this.placeName = placeName;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public int getCnt() {
		return cnt;
	}

	public void setCnt(int cnt) {
		this.cnt = cnt;
	}

	public int getAllSeat() {
		return allSeat;
	}

	public void setAllSeat(int allSeat) {
		this.allSeat = allSeat;
	}

	public int getTotalPeople() {
		return totalPeople;
	}

	public void setTotalPeople(int totalPeople) {
		this.totalPeople = totalPeople;
	}

	public int getGenderF() {
		return genderF;
	}

	public void setGenderF(int genderF) {
		this.genderF = genderF;
	}

	public int getGenderM() {
		return genderM;
	}

	public void setGenderM(int genderM) {
		this.genderM = genderM;
	}

	public String getAge() {
		return age;
	}

	public void setAge(String age) {
		this.age = age;
	}

	public String getOriginalFileName() {
		return originalFileName;
	}

	public void setOriginalFileName(String originalFileName) {
		this.originalFileName = originalFileName;
	}

	public String getRenamedFileName() {
		return renamedFileName;
	}

	public void setRenamedFileName(String renamedFileName) {
		this.renamedFileName = renamedFileName;
	}

	@Override
	public String toString() {
		return "Performance [performanceNo=" + performanceNo + ", performanceCode=" + performanceCode + ", placeCode="
				+ placeCode + ", performanceTitle=" + performanceTitle + ", startDate=" + startDate + ", endDate="
				+ endDate + ", totalRating=" + totalRating + ", ratingCount=" + ratingCount + ", runningTime="
				+ runningTime + ", viewingClass=" + viewingClass + ", casting=" + casting + ", price=" + price
				+ ", performanceCodeName=" + performanceCodeName + ", placeName=" + placeName + ", address=" + address
				+ ", cnt=" + cnt + ", allSeat=" + allSeat + ", totalPeople=" + totalPeople + ", genderF=" + genderF
				+ ", genderM=" + genderM + ", age=" + age + ", originalFileName=" + originalFileName
				+ ", renamedFileName=" + renamedFileName + "]";
	}
	
	
	

	
	

}
