package com.tj.ticketjava.performance.model.vo;

public class Classification {
	
	private String performanceCode;
	private String performanceCodeName;
	
	public Classification() {}

	public Classification(String performanceCode, String performanceCodeName) {
		super();
		this.performanceCode = performanceCode;
		this.performanceCodeName = performanceCodeName;
	}

	public String getPerformanceCode() {
		return performanceCode;
	}

	public void setPerformanceCode(String performanceCode) {
		this.performanceCode = performanceCode;
	}

	public String getPerformanceCodeName() {
		return performanceCodeName;
	}

	public void setPerformanceCodeName(String performanceCodeName) {
		this.performanceCodeName = performanceCodeName;
	}

	@Override
	public String toString() {
		return "Classification [performanceCode=" + performanceCode + ", performanceCodeName=" + performanceCodeName
				+ "]";
	}
	
	

}
