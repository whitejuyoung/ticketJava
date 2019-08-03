package com.tj.ticketjava.performance.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.tj.ticketjava.performance.model.vo.Performance;
import com.tj.ticketjava.performance.model.vo.PerformanceImg;

@Repository
public class PerformanceDAOImpl implements PerformanceDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public Performance selectTicket(int performanceNo) {
		
		return sqlSession.selectOne("performance.selectPerformance", performanceNo);
	}

	@Override
	public List<Map<String, String>> selectPerformanceRound(Map<String, String> paramMap) {
		
		return sqlSession.selectList("performance.selectPerformanceRound",paramMap);
	}

	@Override
	public int selectTotalPeople(String performanceNo) {
		
		return sqlSession.selectOne("performance.selectTotalPeople",performanceNo);
	}

	@Override
	public int selectGenderF(String performanceNo) {
		
		return sqlSession.selectOne("performance.selectGenderF",performanceNo);
	}

	@Override
	public int selectGenderM(String performanceNo) {
		
		return sqlSession.selectOne("performance.selectGenderM",performanceNo);
	}

	@Override
	public List<String> selectAgeList(String performanceNo) {
		
		return sqlSession.selectList("performance.selectAgeList",performanceNo);
	}

	@Override
	public String selectscheduleNo(Map<String, String> paramMap) {
	
		return sqlSession.selectOne("performance.selectscheduleNo",paramMap);
	}

	@Override
	public List<String> viewSchedule(String performanceNo) {
		
		return sqlSession.selectList("performance.viewSchedule",performanceNo);
	}

	@Override
	public List<PerformanceImg> selectPerformanceImg(int performanceNo) {
		
		return sqlSession.selectList("performance.selectPerformanceImg",performanceNo);
	}
	
	//메인
	@Override
	public List<Performance> selectMainImg() {
		return sqlSession.selectList("performance.selectMainImg");
	}

	@Override
	public int selectMainImgCnt() {
		return sqlSession.selectOne("performance.selectMainImgCnt");
	}
	
	@Override
	public List<Performance> selectByTitle(String performanceTitle) {
		return sqlSession.selectList("performance.selectByTitle",performanceTitle);
	}


	@Override
	public List<Performance> selectMenuImgList(String category) {
		return sqlSession.selectList("performance.selectMenuImgList",category);
	}


	@Override
	public Performance selectMenuImg(String imgdetail) {
		return sqlSession.selectOne("performance.selectMenuImg",imgdetail);
	}


	@Override
	public List<Performance> selectRank() {
		return sqlSession.selectList("performance.selectRank");
	}
	
	@Override
	public List<Performance> selectRankConcert() {
		return sqlSession.selectList("performance.selectRankConcert");
	}
	
	@Override
	public List<Performance> selectRankPlay() {
		return sqlSession.selectList("performance.selectRankPlay");
	}

	//전체보기페이지
	@Override
	public List<Performance> musicalList(int cPage, int numPerPage) {
		RowBounds rowBounds = new RowBounds(numPerPage*(cPage-1), numPerPage);
		return sqlSession.selectList("performance.musicalList", null ,rowBounds);
	}

	@Override
	public int selectMusicalTotalContents() {
		return sqlSession.selectOne("performance.selectMusicalTotalContents");
	}

	@Override
	public List<Performance> concertList(int cPage, int numPerPage) {
		RowBounds rowBounds = new RowBounds(numPerPage*(cPage-1), numPerPage);
		return sqlSession.selectList("performance.concertList", null ,rowBounds);
	}

	@Override
	public int selectConcertTotalContents() {
		return sqlSession.selectOne("performance.selectConcertTotalContents");
	}

	@Override
	public List<Performance> playList(int cPage, int numPerPage) {
		RowBounds rowBounds = new RowBounds(numPerPage*(cPage-1), numPerPage);
		return sqlSession.selectList("performance.playList", null ,rowBounds);
	}

	@Override
	public int selectPlayTotalContents() {
		return sqlSession.selectOne("performance.selectPlayTotalContents");
	}

	
	//좌석선택
	@Override
	public int selectAllSeat(String placeCode) {
		
		return sqlSession.selectOne("performance.selectAllSeat",placeCode);
	}

	@Override
	public int selectSoldSeat(Map<String, String> paramMap3) {
		
		return sqlSession.selectOne("performance.selectSoldSeat",paramMap3);
	}
	
	//자동완성 검색
	@Override
	public List<Performance> searchPerformance(String performanceTitle) {
		return sqlSession.selectList("performance.searchPerformance",performanceTitle);
	}

	@Override
	public int musicalTotalContents(String performanceTitle) {
		return sqlSession.selectOne("performance.musicalTotalContents",performanceTitle);
	}

	@Override
	public int concertTotalContents(String performanceTitle) {
		return sqlSession.selectOne("performance.concertTotalContents",performanceTitle);
	}

	@Override
	public int playTotalContents(String performanceTitle) {
		return sqlSession.selectOne("performance.playTotalContents",performanceTitle);
	}

	@Override
	public List<Performance> endPerformance(String performanceTitle) {
		return sqlSession.selectList("performance.endPerformance",performanceTitle);
	}

	@Override
	public int endTotalContents(String performanceTitle) {
		return sqlSession.selectOne("performance.endTotalContents",performanceTitle);
	}





}
