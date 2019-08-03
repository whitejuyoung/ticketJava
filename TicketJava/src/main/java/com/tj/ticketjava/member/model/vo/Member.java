package com.tj.ticketjava.member.model.vo;

import java.sql.Date;

public class Member {
	private String memberId;
	private String memberGrade;
	private String password;
	private String memberName;
	private String phone;
	private String email;
	private int point;
	private String gender;
	private String kakaoMemberId;
	private String facebookMemberId;
	private String googleMemberId;
	private Date birthDate;
	private String recommendId;
	private int totalPrice;
	
	public Member() {}
	
	public Member(String memberId, String memberGrade, String password, String memberName, String phone, String email,
			int point, String gender, String kakaoMemberId, String facebookMemberId, String googleMemberId, Date birthDate,
			String recommendId, int totalPrice) {
		super();
		this.memberId = memberId;
		this.memberGrade = memberGrade;
		this.password = password;
		this.memberName = memberName;
		this.phone = phone;
		this.email = email;
		this.point = point;
		this.gender = gender;
		this.kakaoMemberId = kakaoMemberId;
		this.facebookMemberId = facebookMemberId;
		this.googleMemberId = googleMemberId;
		this.birthDate = birthDate;
		this.recommendId = recommendId;
		this.totalPrice = totalPrice;
	}

	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public String getMemberGrade() {
		return memberGrade;
	}
	public void setMemberGrade(String memberGrade) {
		this.memberGrade = memberGrade;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getMemberName() {
		return memberName;
	}
	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public int getPoint() {
		return point;
	}
	public void setPoint(int point) {
		this.point = point;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getKakaoMemberId() {
		return kakaoMemberId;
	}
	public void setKakaoMemberId(String kakaoMemberId) {
		this.kakaoMemberId = kakaoMemberId;
	}
	public String getfacebookMemberId() {
		return facebookMemberId;
	}
	public void setfacebookMemberId(String facebookMemberId) {
		this.facebookMemberId = facebookMemberId;
	}
	public String getGoogleMemberId() {
		return googleMemberId;
	}
	public void setGoogleMemberId(String googleMemberId) {
		this.googleMemberId = googleMemberId;
	}
	public Date getBirthDate() {
		return birthDate;
	}
	public void setBirthDate(Date birthDate) {
		this.birthDate = birthDate;
	}
	public String getRecommendId() {
		return recommendId;
	}
	public void setRecommendId(String recommendId) {
		this.recommendId = recommendId;
	}
	public int getTotalPrice() {
		return totalPrice;
	}
	public void setTotalPrice(int totalPrice) {
		this.totalPrice = totalPrice;
	}

	@Override
	public String toString() {
		return "Member [memberId=" + memberId + ", memberGrade=" + memberGrade + ", password=" + password
				+ ", memberName=" + memberName + ", phone=" + phone + ", email=" + email + ", point=" + point
				+ ", gender=" + gender + ", kakaoMemberId=" + kakaoMemberId + ", facebookMemberId=" + facebookMemberId
				+ ", googleMemberId=" + googleMemberId + ", birthDate=" + birthDate + ", recommendId=" + recommendId
				+ ", totalPrice=" + totalPrice + "]";
	}
		
	
	
}
