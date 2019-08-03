package com.tj.ticketjava.review.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tj.ticketjava.member.model.service.MemberService;
import com.tj.ticketjava.member.model.vo.Member;
import com.tj.ticketjava.member.model.vo.Point;
import com.tj.ticketjava.performance.model.service.PerformanceService;
import com.tj.ticketjava.performance.model.vo.Performance;
import com.tj.ticketjava.review.model.service.ReviewService;
import com.tj.ticketjava.review.model.vo.Review;
import com.tj.ticketjava.ticket.model.service.TicketService;

@Controller
@RequestMapping("/review")
public class ReviewController {
	
	@Autowired
	private ReviewService reviewService;
	@Autowired
	private MemberService memberService;
	@Autowired
	private TicketService ticketService;
	@Autowired
	private PerformanceService performanceService;
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@RequestMapping("/reviewList")
	@ResponseBody
	public Map<Object, Object> reviewList(@RequestParam(value="cPage", required=false, defaultValue="1") int cPage,
										  @RequestParam int performanceNo,
										  HttpServletRequest request) {
		Map<Object, Object> map = new HashMap<>();
	
		
		int numPerPage = 5;//한페이지당 수 
		
		logger.info("========================== cPage = "+cPage);
		logger.info("========================== performanceNo = "+performanceNo);
		
		
		//업무로직처리
		//1. 현재페이지 컨텐츠 구하기
		List<Review> reviewList = reviewService.selectReviewList(cPage, numPerPage, performanceNo);
		logger.info("ReviewList========="+reviewList);
		
		//2. 전체컨텐츠수 구하기
		int totalContents = reviewService.selectReviewTotalContents(performanceNo);
		logger.info("totalContents========="+totalContents);
		
		
		map.put("reviewList",reviewList);
		map.put("totalContents",totalContents);
		map.put("numPerPage",numPerPage);
		map.put("cPage", cPage);
		
	
		
		return map;
	}
	
	@RequestMapping("/reviewWrite")
	@ResponseBody
	public Map<Object, Object> reviewWrite(Review review) {
		//map에 result 저장 뜻
		//result = 0 -> 리뷰 등록 성공  
		//result = 1 -> 이미 리뷰를 작성한 상태
		//result = 2 -> 리뷰 등록 실패, (공연 시작 시간 이전 리뷰 작성)
		//result = 3 -> 티켓 구매 바람 ( 티켓 구매도 안하고 리뷰 작성하려고 할때,) 
		
		
		Map<Object, Object> map = new HashMap<>();
		logger.info(review.toString());
		
		int checkReview = reviewService.checkReview(review);
		
		if(checkReview>0) {
			//리뷰가 이미있을때,
			map.put("result", 1);
		}else {
			//리뷰가 없을때, 
			java.util.Date checkTicketSchedule = ticketService.checkTicketSchedule(review);
			
			if(checkTicketSchedule == null) {
				map.put("result", 3);
			}else {
				logger.info("checkTicketSchedule : "+checkTicketSchedule);
				java.util.Date nowDate = new java.util.Date();
				
				if(checkTicketSchedule.getTime() < nowDate.getTime()) {
					//리뷰 등록 
					//공연 관람 시간 이후
					int result = reviewService.insertReview(review);
					map.put("result", 0);	
					
					Member m = memberService.selectOneMember(review.getMemberId());
					Performance p = performanceService.selectTicket(review.getPerformanceNo());
					int point = 0;
					Point ap = new Point();
					//S 1%
					//G 2%
					//P 3%
					//D 5%
					
					if("S".equals(m.getMemberGrade())) {
						point = m.getPoint() + (int)(p.getPrice() * 0.01);
					}
					else if("G".equals(m.getMemberGrade())) {
						point = m.getPoint() + (int)(p.getPrice() * 0.02);
					}
					else if("P".equals(m.getMemberGrade())) {
						point = m.getPoint() + (int)(p.getPrice() * 0.03);		
					}
					else if("D".equals(m.getMemberGrade())) {
						point = m.getPoint() + (int)(p.getPrice() * 0.05);
					}
					
					m.setPoint(point);
					result = memberService.updatePoint(m);
					
					ap.setMemberId(m.getMemberId());
					ap.setPoint(point);
					ap.setPointMessage("티켓 구매 적립");
					ap.setPointStatus("적립");
					
					result = memberService.insertAccumulatePoint(ap);
					
					
				}else {
					//공연 관람 이전
					map.put("result", 2);
				}
				
			}
		}		
		
		
		return map;
	}

}
