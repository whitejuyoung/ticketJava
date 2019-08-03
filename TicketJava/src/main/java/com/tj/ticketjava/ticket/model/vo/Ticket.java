package com.tj.ticketjava.ticket.model.vo;
import java.sql.Date;
import java.util.List;
public class Ticket {
    private int ticketNo;
    private int performanceNo;
    private String placeCode;
    private int scheduleNo;
    private int purchaseNo;
    private String memberId;
    private int price;
    private String couponName;
    private String performanceTitle;
    private Date purchaseDate;
    private Date scheduleDate;
    private String placeName;
    private String memberName;
    private String ticketStatus;
    private String seatRow;
    private String seatNo;
    private String ticketWay;
    private String address;
    private String paymentStatus;
    private String receiverId;
    private List<Ticket> ticketList;
    private String performanceCode;
    
    
    public Ticket() {}
    
    
    public Ticket(int ticketNo, int performanceNo, String placeCode, int scheduleNo, int purchaseNo, String memberId,
            int price, String couponName, String performanceTitle, Date purchaseDate, Date scheduleDate,
            String placeName, String memberName, String ticketStatus, String seatRow, String seatNo, String ticketWay,
            String address, String paymentStatus, String receiverId, List<Ticket> ticketList, String performanceCode) {
        super();
        this.ticketNo = ticketNo;
        this.performanceNo = performanceNo;
        this.placeCode = placeCode;
        this.scheduleNo = scheduleNo;
        this.purchaseNo = purchaseNo;
        this.memberId = memberId;
        this.price = price;
        this.couponName = couponName;
        this.performanceTitle = performanceTitle;
        this.purchaseDate = purchaseDate;
        this.scheduleDate = scheduleDate;
        this.placeName = placeName;
        this.memberName = memberName;
        this.ticketStatus = ticketStatus;
        this.seatRow = seatRow;
        this.seatNo = seatNo;
        this.ticketWay = ticketWay;
        this.address = address;
        this.paymentStatus = paymentStatus;
        this.receiverId = receiverId;
        this.ticketList = ticketList;
        this.performanceCode = performanceCode;
    }
    public int getTicketNo() {
        return ticketNo;
    }
    public void setTicketNo(int ticketNo) {
        this.ticketNo = ticketNo;
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
    public int getScheduleNo() {
        return scheduleNo;
    }
    public void setScheduleNo(int scheduleNo) {
        this.scheduleNo = scheduleNo;
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
    public int getPrice() {
        return price;
    }
    public void setPrice(int price) {
        this.price = price;
    }
    public String getCouponName() {
        return couponName;
    }
    public void setCouponName(String couponName) {
        this.couponName = couponName;
    }
    public String getPerformanceTitle() {
        return performanceTitle;
    }
    public void setPerformanceTitle(String performanceTitle) {
        this.performanceTitle = performanceTitle;
    }
    public Date getPurchaseDate() {
        return purchaseDate;
    }
    public void setPurchaseDate(Date purchaseDate) {
        this.purchaseDate = purchaseDate;
    }
    public Date getScheduleDate() {
        return scheduleDate;
    }
    public void setScheduleDate(Date scheduleDate) {
        this.scheduleDate = scheduleDate;
    }
    public String getPlaceName() {
        return placeName;
    }
    public void setPlaceName(String placeName) {
        this.placeName = placeName;
    }
    public String getMemberName() {
        return memberName;
    }
    public void setMemberName(String memberName) {
        this.memberName = memberName;
    }
    public String getTicketStatus() {
        return ticketStatus;
    }
    public void setTicketStatus(String ticketStatus) {
        this.ticketStatus = ticketStatus;
    }
    
    
    public String getSeatRow() {
        return seatRow;
    }
    public void setSeatRow(String seatRow) {
        this.seatRow = seatRow;
    }
    public String getSeatNo() {
        return seatNo;
    }
    public void setSeatNo(String seatNo) {
        this.seatNo = seatNo;
    }
    
    public String getTicketWay() {
        return ticketWay;
    }
    public void setTicketWay(String ticketWay) {
        this.ticketWay = ticketWay;
    }
    public String getAddress() {
        return address;
    }
    public void setAddress(String address) {
        this.address = address;
    }
    public String getPaymentStatus() {
        return paymentStatus;
    }
    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }
    public String getReceiverId() {
        return receiverId;
    }
    public void setReceiverId(String receiverId) {
        this.receiverId = receiverId;
    }
    
    public List<Ticket> getTicketList() {
        return ticketList;
    }
    public void setTicketList(List<Ticket> ticketList) {
        this.ticketList = ticketList;
    }
    
    
    public String getPerformanceCode() {
        return performanceCode;
    }
    public void setPerformanceCode(String performanceCode) {
        this.performanceCode = performanceCode;
    }
    @Override
    public String toString() {
        return "Ticket [ticketNo=" + ticketNo + ", performanceNo=" + performanceNo + ", placeCode=" + placeCode
                + ", scheduleNo=" + scheduleNo + ", purchaseNo=" + purchaseNo + ", memberId=" + memberId + ", price="
                + price + ", couponName=" + couponName + ", performanceTitle=" + performanceTitle + ", purchaseDate="
                + purchaseDate + ", scheduleDate=" + scheduleDate + ", placeName=" + placeName + ", memberName="
                + memberName + ", ticketStatus=" + ticketStatus + ", seatRow=" + seatRow + ", seatNo=" + seatNo
                + ", ticketWay=" + ticketWay + ", address=" + address + ", paymentStatus=" + paymentStatus
                + ", receiverId=" + receiverId + ", ticketList=" + ticketList + ", performanceCode=" + performanceCode
                + "]";
    }
    
    
    
    
}
