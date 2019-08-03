package com.tj.ticketjava.member.model.dao;

import java.util.List;
import java.util.Map;

import com.tj.ticketjava.member.model.vo.Member;
import com.tj.ticketjava.member.model.vo.Point;
import com.tj.ticketjava.ticket.model.vo.Purchase;
import com.tj.ticketjava.ticket.model.vo.Ticket;

public interface MemberDAO {

	int insertMember(Member member);

	Member selectOneMember(String memberId);

	int memberInfoUpdate(Member m);

	int memberPasswordUpdate(Member member);

	int deleteMember(String memberId);

	int countTotalPurchase(String memberId);

	int priceTotalPurchase(String memberId);

	int selectTicketTotalContents(String memberId);

	List<Purchase> purchaseList(int cPage, int numPerPage, String memberId);

	List<Ticket> ticketList(int purchaseNo);

	int sendTicket(Ticket t);

	List<Ticket> giftList(int cPage, int numPerPage, String memberId);

	int selectGiftTotalContents(String memberId);

	Ticket selectOneTicket(int ticketNo);

	Member selectOneMemberByMemberName(String memberName);

	Member selectOneMemberByEmail(String email);

	int updatePoint(Member member);

	int insertAccumulatePoint(Point ap);

	int selectPointTotalContents(String memberId);

	List<Point> pointList(int cPage, int numPerPage, String memberId);

	Purchase selectOnePurchase(int purchaseNo);

	int deleteTicket(Ticket ticket);

	int selectDeleteTicketTotalContents(String memberId);

	List<Purchase> deleteTicketList(String memberId);

	List<Ticket> deleteTicketListByPurchaseNo(int purchaseNo);

	List<Ticket> ticketListByMemberId(String memberId);

	List<Map<Integer, Integer>> selectUsableTicketCnt(String memberId);

	String selectPosterRenamedFileName(int performanceNo);

	Member selectOneMemberByGoogle(String googleMemberId);

	int updateMemberGoogle(Member m);

	Member selectOneMemberByPhoneAndName(Member m);

	List<Purchase> giftPurchaseList(String memberId);

	int updatePurchasePoint(Purchase p);

	int updatePurchaseAddress(Map<String, String> map);

	void updatePurchaseTotalPrice(Purchase p);

	Member checkGoogleIdDuplicate(String googleMemberId);

	Member checkFacebookIdDuplicate(String facebookMemberId);

	Member selectOneMemberByFacebook(String facebookMemberId);

	Member selectOneMemberByKakao(String kakaoMemberId);

	int updateMemberKakao(Map<String, String> paramMap);

}
