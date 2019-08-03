package com.tj.ticketjava.review.model.dao;

import java.util.List;

import com.tj.ticketjava.review.model.vo.Review;

public interface ReviewDAO {

	List<Review> selectReviewList(int cPage, int numPerPage, int performanceNo);

	int selectReviewTotalContents(int performanceNo);

	int insertReview(Review review);

	int checkReview(Review review);

}
