package com.tj.ticketjava.member.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tj.ticketjava.member.model.dao.MemberDAO;
import com.tj.ticketjava.member.model.vo.Member;
import com.tj.ticketjava.member.model.vo.Point;
import com.tj.ticketjava.ticket.model.vo.Purchase;
import com.tj.ticketjava.ticket.model.vo.Ticket;


@Service
public class MemberServiceImpl implements MemberService {
	@Autowired
	MemberDAO memberDAO;

	@Override
	public int insertMember(Member member) {
		return memberDAO.insertMember(member);
	}

	@Override
	public Member selectOneMember(String memberId) {
		return memberDAO.selectOneMember(memberId);
	}

	@Override
	public int memberInfoUpdate(Member m) {
		return memberDAO.memberInfoUpdate(m);
	}

	@Override
	public int memberPasswordUpdate(Member member) {
		return memberDAO.memberPasswordUpdate(member);
	}

	@Override
	public int deleteMember(String memberId) {
		return memberDAO.deleteMember(memberId);
	}

	@Override
	public int countTotalPurchase(String memberId) {
		return memberDAO.countTotalPurchase(memberId);
	}

	@Override
	public int priceTotalPurchase(String memberId) {
		return memberDAO.priceTotalPurchase(memberId);
	}

	@Override
	public int selectTicketTotalContents(String memberId) {
		return memberDAO.selectTicketTotalContents(memberId);
	}

	@Override
	public List<Purchase> purchaseList(int cPage, int numPerPage, String memberId) {
		return memberDAO.purchaseList(cPage, numPerPage, memberId);
	}

	@Override
	public List<Ticket> ticketList(int purchaseNo) {
		return memberDAO.ticketList(purchaseNo);
	}

	@Override
	public int sendTicket(Ticket t) {
		return memberDAO.sendTicket(t);
	}

	@Override
	public List<Ticket> giftList(int cPage, int numPerPage,String memberId) {
		return memberDAO.giftList(cPage, numPerPage, memberId);
	}

	@Override
	public int selectGiftTotalContents(String memberId) {
		return memberDAO.selectGiftTotalContents(memberId);
	}

	@Override
	public Ticket selectOneTicket(int ticketNo) {
		return memberDAO.selectOneTicket(ticketNo);
	}

	@Override
	public Member selectOneMemberByMemberName(String memberName) {
		return memberDAO.selectOneMemberByMemberName(memberName);
	}

	@Override
	public Member selectOneMemberByEmail(String email) {
		return memberDAO.selectOneMemberByEmail(email);
	}

	@Override
	public int updatePoint(Member member) {
		return memberDAO.updatePoint(member);
	}

	@Override
	public int insertAccumulatePoint(Point ap) {
		return memberDAO.insertAccumulatePoint(ap);
	}

	@Override
	public int selectPointTotalContents(String memberId) {
		return memberDAO.selectPointTotalContents(memberId);
	}

	@Override
	public List<Point> pointList(int cPage, int numPerPage, String memberId) {
		return memberDAO.pointList(cPage, numPerPage, memberId);
	}

	@Override
	public Purchase selectOnePurchase(int purchaseNo) {
		return memberDAO.selectOnePurchase(purchaseNo);
	}

	@Override
	public int deleteTicket(List<Ticket> ticketList) {
		ticketList.forEach((ticket)->{
			int result = memberDAO.deleteTicket(ticket);
			if(result < 1) throw new RuntimeException("티켓 취소 오류!");
		});
		//중간에 0으로 바꼈을 수도 있고 실패했으면 예외가 던져졌을 것임
		//일부러 1 적은 거임 여기까지 왔으면 어차피 성공한 것
		return 1;
	}

	@Override
	public int selectDeleteTicketTotalContents(String memberId) {
		return memberDAO.selectDeleteTicketTotalContents(memberId);
	}

	@Override
	public List<Purchase> deleteTicketList(String memberId) {
		return memberDAO.deleteTicketList(memberId);
	}

	@Override
	public List<Ticket> deleteTicketListByPurchaseNo(int purchaseNo) {
		return memberDAO.deleteTicketListByPurchaseNo(purchaseNo);
	}

	@Override
	public List<Ticket> ticketListByMemberId(String memberId) {
		return memberDAO.ticketListByMemberId(memberId);
	}

	@Override
	public List<Map<Integer, Integer>> selectUsableTicketCnt(String memberId) {
		return memberDAO.selectUsableTicketCnt(memberId);
	}

	@Override
	public String selectPosterRenamedFileName(int performanceNo) {
		return memberDAO.selectPosterRenamedFileName(performanceNo);
	}

	@Override
	public Member selectOneMemberByGoogle(String googleMemberId) {
		return memberDAO.selectOneMemberByGoogle(googleMemberId);
	}

	@Override
	public int updateMemberGoogle(Member m) {
		return memberDAO.updateMemberGoogle(m);
	}

	@Override
	public Member selectOneMemberByPhoneAndName(Member m) {
		return memberDAO.selectOneMemberByPhoneAndName(m);
	}

	@Override
	public List<Purchase> giftPurchaseList(String memberId) {
		return memberDAO.giftPurchaseList(memberId);
	}

	@Override
	public int updatePurchasePoint(Purchase p) {
		return memberDAO.updatePurchasePoint(p);
	}

	@Override
	public int updatePurchaseAddress(Map<String, String> map) {
		return memberDAO.updatePurchaseAddress(map);
	}

	@Override
	public void updatePurchaseTotalPrice(Purchase p) {
		memberDAO.updatePurchaseTotalPrice(p);
	}

	@Override
	public Member checkGoogleIdDuplicate(String googleMemberId) {
		return memberDAO.checkGoogleIdDuplicate(googleMemberId);
	}

	@Override
	public Member checkFacebookIdDuplicate(String facebookMemberId) {
		return memberDAO.checkFacebookIdDuplicate(facebookMemberId);
	}

	@Override
	public Member selectOneMemberByFacebook(String facebookMemberId) {
		return memberDAO.selectOneMemberByFacebook(facebookMemberId);
	}

	@Override
	public Member selectOneMemberByKakao(String kakaoMemberId) {
		return memberDAO.selectOneMemberByKakao(kakaoMemberId);
	}

	@Override
	public int updateMemberKakao(Map<String, String> paramMap) {
		return memberDAO.updateMemberKakao(paramMap);
	}

}
