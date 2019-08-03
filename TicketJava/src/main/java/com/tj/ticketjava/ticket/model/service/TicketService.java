package com.tj.ticketjava.ticket.model.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import com.tj.ticketjava.review.model.vo.Review;
import com.tj.ticketjava.ticket.model.vo.Purchase;
import com.tj.ticketjava.ticket.model.vo.Seat;

public interface TicketService {

    List<Seat> insertTicket(List<Seat> list);

    List<Seat> checkSeat(Map<String, String> paramMap);

    int checkTicket(List<Seat> seatList);

	Map<String, Integer> ticketInfo(int object);

	Map<String, Integer> viewSchedule(Map<String, String> paramSelectedData);

	int addPurchase(Purchase purchase);

	int updateStatus(Integer integer);

	int addTicket(Map<Object, Object> map1);

	int esunjoa(Map<Object,Object> map);

	int deleteIng(Integer integer);

	Date checkTicketSchedule(Review review);

	int selectScheduleNo(int tNo);

	String selectSeatRow(int tNo);

	String selectSeatNo(int tNo);

	int deleteSeat(Map<Object, Object> seatMap);

	




}