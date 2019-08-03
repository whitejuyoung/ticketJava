package com.tj.ticketjava.review.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tj.ticketjava.review.model.dao.ReviewDAO;
import com.tj.ticketjava.review.model.vo.Review;

@Service
public class ReviewServiceImpl implements ReviewService{
	
	@Autowired
	private ReviewDAO reviewDAO;

	@Override
	public List<Review> selectReviewList(int cPage, int numPerPage, int performanceNo) {
		return reviewDAO.selectReviewList(cPage, numPerPage, performanceNo);
	}

	@Override
	public int selectReviewTotalContents(int performanceNo) {
		return reviewDAO.selectReviewTotalContents(performanceNo);
	}

	@Override
	public int insertReview(Review review) {
		return reviewDAO.insertReview(review);
	}

	@Override
	public int checkReview(Review review) {
		return reviewDAO.checkReview(review);
	}



}
