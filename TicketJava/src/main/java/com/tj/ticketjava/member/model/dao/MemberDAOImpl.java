package com.tj.ticketjava.member.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.tj.ticketjava.member.model.vo.Member;
import com.tj.ticketjava.member.model.vo.Point;
import com.tj.ticketjava.ticket.model.vo.Purchase;
import com.tj.ticketjava.ticket.model.vo.Ticket;

@Repository
public class MemberDAOImpl implements MemberDAO {

	@Autowired
	SqlSessionTemplate sqlSession;

	@Override
	public int insertMember(Member member) {
		return sqlSession.insert("member.insertMember", member);
	}

	@Override
	public Member selectOneMember(String memberId) {
		return sqlSession.selectOne("member.selectOneMember", memberId);
	}

	@Override
	public int memberInfoUpdate(Member m) {
		return sqlSession.update("member.memberInfoUpdate", m);
	}

	@Override
	public int memberPasswordUpdate(Member member) {
		return sqlSession.update("member.memberPasswordUpdate", member);
	}

	@Override
	public int deleteMember(String memberId) {
		return sqlSession.delete("member.deleteMember", memberId);
	}

	@Override
	public int countTotalPurchase(String memberId) {
		return sqlSession.selectOne("member.countTotalPurchase", memberId);
	}

	@Override
	public int priceTotalPurchase(String memberId) {
		return sqlSession.selectOne("member.priceTotalPurchase", memberId);
	}

	@Override
	public int selectTicketTotalContents(String memberId) {
		return sqlSession.selectOne("member.selectTicketTotalContents", memberId);
	}

	@Override
	public List<Purchase> purchaseList(int cPage, int numPerPage, String memberId) {
		//RowBounds rowBounds = new RowBounds(offset, limit);
		//offset: 게시물 몇 개를 건너뛸 것인가?
		//cPage=1: offset->0
		//cPage=2: offset->numPerPage*1
		//cPage=3: offset->numPerPage*2
		//--> numPerPage*(cPage-1)
		//limit: 한 페이지당 게시물 수
		RowBounds rowBounds = new RowBounds(numPerPage*(cPage-1), numPerPage);
		
		return sqlSession.selectList("member.purchaseList", memberId, rowBounds);
		
	}

	@Override
	public List<Ticket> ticketList(int purchaseNo) {
		return sqlSession.selectList("member.ticketList", purchaseNo);
	}

	@Override
	public int sendTicket(Ticket t) {
		return sqlSession.update("member.sendTicket", t);
	}

	@Override
	public List<Ticket> giftList(int cPage, int numPerPage, String memberId) {
		RowBounds rowBounds = new RowBounds(numPerPage*(cPage-1), numPerPage);
		return sqlSession.selectList("member.giftList", memberId, rowBounds);
	}

	@Override
	public int selectGiftTotalContents(String memberId) {
		return sqlSession.selectOne("member.selectGiftTotalContents", memberId);
	}

	@Override
	public Ticket selectOneTicket(int ticketNo) {
		return sqlSession.selectOne("member.selectOneTicket", ticketNo);
	}

	@Override
	public Member selectOneMemberByMemberName(String memberName) {
		return sqlSession.selectOne("member.selectOneMemberByMemberName", memberName);
	}

	@Override
	public Member selectOneMemberByEmail(String email) {
		return sqlSession.selectOne("member.selectOneMemberByEmail", email);
	}

	@Override
	public int updatePoint(Member member) {
		return sqlSession.update("member.updatePoint", member);
	}

	@Override
	public int insertAccumulatePoint(Point ap) {
		return sqlSession.insert("member.insertAccumulatePoint", ap);
	}

	@Override
	public int selectPointTotalContents(String memberId) {
		return sqlSession.selectOne("member.selectPointTotalContents", memberId);
	}

	@Override
	public List<Point> pointList(int cPage, int numPerPage, String memberId) {
		RowBounds rowBounds = new RowBounds(numPerPage*(cPage-1), numPerPage);
		return sqlSession.selectList("member.pointList", memberId, rowBounds);
	}

	@Override
	public Purchase selectOnePurchase(int purchaseNo) {
		return sqlSession.selectOne("member.selectOnePurchase", purchaseNo);
	}

	@Override
	public int deleteTicket(Ticket ticket) {
		return sqlSession.delete("member.deleteTicket", ticket);
	}

	@Override
	public int selectDeleteTicketTotalContents(String memberId) {
		return sqlSession.selectOne("member.selectDeleteTicketTotalContents", memberId);
	}

	@Override
	public List<Purchase> deleteTicketList(String memberId) {
		return sqlSession.selectList("member.deleteTicketList", memberId);
	}

	@Override
	public List<Ticket> deleteTicketListByPurchaseNo(int purchaseNo) {
		return sqlSession.selectList("member.deleteTicketListByPurchaseNo", purchaseNo);
	}

	@Override
	public List<Ticket> ticketListByMemberId(String memberId) {
		return sqlSession.selectList("member.ticketListByMemberId", memberId);
	}

	@Override
	public List<Map<Integer, Integer>> selectUsableTicketCnt(String memberId) {
		return sqlSession.selectList("member.selectUsableTicketCnt", memberId);
	}

	@Override
	public String selectPosterRenamedFileName(int performanceNo) {
		return sqlSession.selectOne("member.selectPosterRenamedFileName", performanceNo);
	}

	@Override
	public Member selectOneMemberByGoogle(String googleMemberId) {
		return sqlSession.selectOne("member.selectOneMemberByGoogle", googleMemberId);
	}

	@Override
	public int updateMemberGoogle(Member m) {
		return sqlSession.update("member.updateMemberGoogle", m);
	}

	@Override
	public Member selectOneMemberByPhoneAndName(Member m) {
		return sqlSession.selectOne("member.selectOneMemberByPhoneAndName", m);
	}

	@Override
	public List<Purchase> giftPurchaseList(String memberId) {
		return sqlSession.selectList("member.giftPurchaseList", memberId);
	}

	@Override
	public int updatePurchasePoint(Purchase p) {
		return sqlSession.update("member.updatePurchasePoint", p);
	}

	@Override
	public int updatePurchaseAddress(Map<String, String> map) {
		return sqlSession.update("member.updatePurchaseAddress", map);
	}

	@Override
	public void updatePurchaseTotalPrice(Purchase p) {
		sqlSession.update("member.updatePurchaseTotalPrice", p);
	}

	@Override
	public Member checkGoogleIdDuplicate(String googleMemberId) {
		return sqlSession.selectOne("member.checkGoogleIdDuplicate", googleMemberId);
	}

	@Override
	public Member checkFacebookIdDuplicate(String facebookMemberId) {
		return sqlSession.selectOne("member.checkFacebookIdDuplicate", facebookMemberId);
	}

	@Override
	public Member selectOneMemberByFacebook(String facebookMemberId) {
		return sqlSession.selectOne("member.selectOneMemberByFacebook", facebookMemberId);
	}

	@Override
	public Member selectOneMemberByKakao(String kakaoMemberId) {
		return sqlSession.selectOne("member.selectOneMemberByKakao", kakaoMemberId);
	}

	@Override
	public int updateMemberKakao(Map<String, String> paramMap) {
		return sqlSession.update("member.updateMemberKakao", paramMap);
	}
}
