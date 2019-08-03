package com.tj.ticketjava.ticket.model.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tj.ticketjava.review.model.vo.Review;
import com.tj.ticketjava.ticket.model.dao.TicketDAO;
import com.tj.ticketjava.ticket.model.vo.Purchase;
import com.tj.ticketjava.ticket.model.vo.Seat;

@Service
public class TicketServiceImpl implements TicketService {

    @Autowired
    TicketDAO ticketDAO;

    @Transactional
    @Override
    public List<Seat> insertTicket(List<Seat> list) {
        list.forEach((seat)->{
            int result = ticketDAO.insertTicket(seat);
            if(result < 1) throw new RuntimeException("좌석 예약 오류!");
        });
        
        List<Seat> sList = new ArrayList<Seat>();
        list.forEach((seat)->{
        	Seat s = ticketDAO.selectTicket(seat);
        	
        	sList.add(s);
        });
        
        
        return sList;
    }

    @Transactional
    @Override
    public int checkTicket(List<Seat> seatList) {
        seatList.forEach((seat)->{
        	int result = ticketDAO.checkTicket(seat);
            
            if(result > 0) throw new RuntimeException("좌석 예약 오류!");
        });
        return 0;
    }


    @Override
    public List<Seat> checkSeat(Map<String, String> paramMap) {
        
        return ticketDAO.checkSeat(paramMap);
    }

	@Override
	public Map<String, Integer> ticketInfo(int object) {
		
		return ticketDAO.ticketInfo(object);
	}



	@Override
	public Map<String, Integer> viewSchedule(Map<String,String> selectedDate) {
		
		return ticketDAO.viewSchedule(selectedDate);
	}

	@Override
	public int addPurchase(Purchase purchase) {
		
		return ticketDAO.addPurchase(purchase);
	}

	@Override
	public int updateStatus(Integer integer) {

		return ticketDAO.updateStatus(integer);
	}

	@Override
	public int addTicket(Map<Object, Object> listMap) {

		return ticketDAO.addTicket(listMap);
	}

	@Override
	public int esunjoa(Map<Object,Object> map) {
		
		return ticketDAO.esunjoa(map);
	}

	@Override
	public int deleteIng(Integer integer) {
		
		return ticketDAO.deleteIng(integer);
	}

	@Override
	public Date checkTicketSchedule(Review review) {
		return ticketDAO.checkTicketSchedule(review);
	}

	@Override
	public int selectScheduleNo(int tNo) {
		return ticketDAO.selectScheduleNo(tNo);
	}

	@Override
	public String selectSeatRow(int tNo) {
		return ticketDAO.selectSeatRow(tNo);
		
	}
	
	@Override
	public String selectSeatNo(int tNo) {
		return ticketDAO.selectSeatNo(tNo);
		
	}

	@Override
	public int deleteSeat(Map<Object, Object> seatMap) {
		
		return ticketDAO.deleteSeat(seatMap);
	}
	



}