package com.tj.ticketjava.admin.model.vo;


public class PerformanceImage {

	private int performanceNo;
	private String imageCategory;
	private String originalFileName;
	private String renamedFileName;
	@Override
	public String toString() {
		return "PerformanceImage [performanceNo=" + performanceNo + ", imageCategory=" + imageCategory
				+ ", originalFileName=" + originalFileName + ", renamedFileName=" + renamedFileName + "]";
	}
	public int getPerformanceNo() {
		return performanceNo;
	}
	public void setPerformanceNo(int performanceNo) {
		this.performanceNo = performanceNo;
	}
	public String getImageCategory() {
		return imageCategory;
	}
	public void setImageCategory(String imageCategory) {
		this.imageCategory = imageCategory;
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
	public PerformanceImage(int performanceNo, String imageCategory, String originalFileName, String renamedFileName) {
		super();
		this.performanceNo = performanceNo;
		this.imageCategory = imageCategory;
		this.originalFileName = originalFileName;
		this.renamedFileName = renamedFileName;
	}
	
	
	public PerformanceImage() {}
	
	
	
	
}
