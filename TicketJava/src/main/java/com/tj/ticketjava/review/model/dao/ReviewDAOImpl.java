package com.tj.ticketjava.review.model.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.tj.ticketjava.review.model.vo.Review;

@Repository
public class ReviewDAOImpl implements ReviewDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public List<Review> selectReviewList(int cPage, int numPerPage, int performanceNo) {
		//org.apache.ibatis.session.RowBounds.RowBounds(int offset, int limit)
				RowBounds rowBounds = new RowBounds((cPage-1)*numPerPage, numPerPage);
				return sqlSession.selectList("review.selectReviewList",performanceNo,rowBounds);
	}

	@Override
	public int selectReviewTotalContents(int performanceNo) {
		return sqlSession.selectOne("review.selectReviewTotalContents",performanceNo);
	}

	@Override
	public int insertReview(Review review) {
		return sqlSession.insert("review.insertReview",review);
	}

	@Override
	public int checkReview(Review review) {
		return sqlSession.selectOne("review.checkReview",review);
	}
}
