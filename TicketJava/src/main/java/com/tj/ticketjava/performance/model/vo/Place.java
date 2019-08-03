package com.tj.ticketjava.performance.model.vo;

public class Place {
	
	private String placeCode;
	private String placeName;
	private int placeSeatCnt;
	private String address;
	
	public Place() {}

	public Place(String placeCode, String placeName, int placeSeatCnt, String address) {
		super();
		this.placeCode = placeCode;
		this.placeName = placeName;
		this.placeSeatCnt = placeSeatCnt;
		this.address = address;
	}

	public String getPlaceCode() {
		return placeCode;
	}

	public void setPlaceCode(String placeCode) {
		this.placeCode = placeCode;
	}

	public String getPlaceName() {
		return placeName;
	}

	public void setPlaceName(String placeName) {
		this.placeName = placeName;
	}

	public int getPlaceSeatCnt() {
		return placeSeatCnt;
	}

	public void setPlaceSeatCnt(int placeSeatCnt) {
		this.placeSeatCnt = placeSeatCnt;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	@Override
	public String toString() {
		return "Place [placeCode=" + placeCode + ", placeName=" + placeName + ", placeSeatCnt=" + placeSeatCnt
				+ ", address=" + address + "]";
	}
	
	
	
	

}
