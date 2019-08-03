package com.tj.ticketjava.ticket.model.dao;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.tj.ticketjava.review.model.vo.Review;
import com.tj.ticketjava.ticket.model.vo.Purchase;
import com.tj.ticketjava.ticket.model.vo.Seat;

@Repository
public class TicketDAOImpl implements TicketDAO {

    
    @Autowired
    SqlSessionTemplate sqlSession;


    @Override
    public int insertTicket(Seat seat) {
        return sqlSession.insert("ticket.insertTicket", seat);
    }

    
    @Override
    public int checkTicket(Seat seatList) {
        return sqlSession.selectOne("ticket.checkTicket", seatList);
    }
    

    @Override
    public List<Seat> checkSeat(Map<String, String> paramMap) {
        
        return sqlSession.selectList("ticket.checkSeat",paramMap);
    }


	@Override
	public Seat selectTicket(Seat seat) {
		
		return sqlSession.selectOne("ticket.selectTicket", seat);
	}


	@Override
	public Map<String, Integer> ticketInfo(int object) {
		
		return sqlSession.selectOne("ticket.ticketInfo", object);
	}


	@Override
	public Map<String, Integer> viewSchedule(Map<String,String> selectedDate) {
		
		return sqlSession.selectOne("ticket.viewSchedule", selectedDate);
	}


	@Override
	public int addPurchase(Purchase purchase) {
		
		return sqlSession.insert("ticket.addPurchase", purchase);
	}


	@Override
	public int updateStatus(Integer seatKey) {
		
		return sqlSession.update("ticket.updateStatus", seatKey);
	}


	@Override
	public int addTicket(Map<Object, Object> listMap) {
		
		return sqlSession.insert("ticket.addTicket", listMap);
	}


	@Override
	public int esunjoa(Map<Object,Object> map) {

		return sqlSession.selectOne("ticket.esunjoa", map);
	}


	@Override
	public int deleteIng(Integer integer) {

		return sqlSession.delete("ticket.deleteIng", integer);
	}

	@Override
	public Date checkTicketSchedule(Review review) {
		return sqlSession.selectOne("ticket.checkTicketSchedule", review);
	}	


	@Override
	public int selectScheduleNo(int tNo) {
		
		return sqlSession.selectOne("ticket.selectScheduleNo", tNo);
	}


	@Override
	public String selectSeatRow(int tNo) {
		return sqlSession.selectOne("ticket.selectSeatRow", tNo);
	}
	

	@Override
	public String selectSeatNo(int tNo) {
		return sqlSession.selectOne("ticket.selectSeatNo", tNo);
	}


	@Override
	public int deleteSeat(Map<Object, Object> seatMap) {
		
		return sqlSession.delete("ticket.deleteSeat", seatMap);
	}









}