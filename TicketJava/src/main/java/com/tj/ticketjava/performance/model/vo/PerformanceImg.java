package com.tj.ticketjava.performance.model.vo;

public class PerformanceImg {
	
	private int performanceNo;
	private String imageCategory;
	private String renamedFileName;

	public PerformanceImg() {}

	public PerformanceImg(int performanceNo, String imageCategory, String renamedFileName) {
		super();
		this.performanceNo = performanceNo;
		this.imageCategory = imageCategory;
		this.renamedFileName = renamedFileName;
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

	public String getRenamedFileName() {
		return renamedFileName;
	}

	public void setRenamedFileName(String renamedFileName) {
		this.renamedFileName = renamedFileName;
	}

	@Override
	public String toString() {
		return "PerformanceImg [performanceNo=" + performanceNo + ", imageCategory=" + imageCategory
				+ ", renamedFileName=" + renamedFileName + "]";
	}
	
	
	

}
