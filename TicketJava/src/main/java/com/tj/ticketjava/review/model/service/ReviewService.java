package com.tj.ticketjava.review.model.service;

import java.util.List;
import java.util.Map;

import com.tj.ticketjava.review.model.vo.Review;

public interface ReviewService {

	List<Review> selectReviewList(int cPage, int numPerPage, int performanceNo);

	int selectReviewTotalContents(int performanceNo);

	int insertReview(Review review);

	int checkReview(Review review);


}
