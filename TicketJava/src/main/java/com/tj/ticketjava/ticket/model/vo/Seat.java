package com.tj.ticketjava.ticket.model.vo;

import java.util.List;

public class Seat {

   private int scheduleNo;
   private int performanceNo;
   private String placeCode;
   private int seatRow;
   private int seatNo;
   private String seatStatus;
   private int seatKey;
   private String time;
   private List<Seat> seatList;



   



public String getTime() {
	return time;
}






public void setTime(String time) {
	this.time = time;
}






public Seat(int scheduleNo, int performanceNo, String placeCode, int seatRow, int seatNo, String seatStatus,
		int seatKey, String time, List<Seat> seatList) {
	super();
	this.scheduleNo = scheduleNo;
	this.performanceNo = performanceNo;
	this.placeCode = placeCode;
	this.seatRow = seatRow;
	this.seatNo = seatNo;
	this.seatStatus = seatStatus;
	this.seatKey = seatKey;
	this.time = time;
	this.seatList = seatList;
}






public Seat() {
       super();
   }






   public int getSeatKey() {
	return seatKey;
}



public void setSeatKey(int seatKey) {
	this.seatKey = seatKey;
}



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



   public String getPlaceCode() {
       return placeCode;
   }



   public void setPlaceCode(String placeCode) {
       this.placeCode = placeCode;
   }



   public int getSeatRow() {
       return seatRow;
   }



   public void setSeatRow(int seatRow) {
       this.seatRow = seatRow;
   }



   public int getSeatNo() {
       return seatNo;
   }



   public void setSeatNo(int seatNo) {
       this.seatNo = seatNo;
   }



   public String getSeatStatus() {
       return seatStatus;
   }



   public void setSeatStatus(String seatStatus) {
       this.seatStatus = seatStatus;
   }



   public List<Seat> getSeatList() {
       return seatList;
   }



   public void setSeatList(List<Seat> seatList) {
       this.seatList = seatList;
   }






@Override
public String toString() {
	return "Seat [scheduleNo=" + scheduleNo + ", performanceNo=" + performanceNo + ", placeCode=" + placeCode
			+ ", seatRow=" + seatRow + ", seatNo=" + seatNo + ", seatStatus=" + seatStatus + ", seatKey=" + seatKey
			+ ", time=" + time + ", seatList=" + seatList + "]";
}





  



}