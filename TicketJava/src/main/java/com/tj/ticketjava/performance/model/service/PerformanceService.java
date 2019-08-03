package com.tj.ticketjava.performance.model.service;

import java.util.List;
import java.util.Map;

import com.tj.ticketjava.performance.model.vo.Performance;
import com.tj.ticketjava.performance.model.vo.PerformanceImg;

public interface PerformanceService {

	Performance selectTicket(int performanceNo);

	List<Map<String, String>> selectPerformanceRound(Map<String, String> paramMap);

	int selectSoldSeat(Map<String, String> paramMap3);

	int selectAllSeat(String placeCode);

	int selectTotalPeople(String performanceNo);

	int selectGenderF(String performanceNo);

	int selectGenderM(String performanceNo);

	List<String> selectAgeList(String performanceNo);

	String selectscheduleNo(Map<String, String> paramMap);

	List<String> viewSchedule(String performanceNo);

	List<PerformanceImg> selectPerformanceImg(int performanceNo);
	
	//메인
	List<Performance> selectMainImg();

	int selectMainImgCnt();
	
	List<Performance> selectByTitle(String performanceTitle);

	List<Performance> selectMenuImgList(String category);

	Performance selectMenuImg(String imgdetail);

	List<Performance> selectRank();
	
	List<Performance> selectRankConcert();
	
	List<Performance> selectRankPlay();
	
	//전체보기 페이지
	List<Performance> musicalList(int cPage, int numPerPage);

	int selectMusicalTotalContents();

	List<Performance> concertList(int cPage, int numPerPage);

	int selectConcertTotalContents();

	List<Performance> playList(int cPage, int numPerPage);

	int selectPlayTotalContents();
	
	//자동완성검색
	List<Performance> searchPerformance(String performanceTitle);

	int musicalTotalContents(String performanceTitle);

	int concertTotalContents(String performanceTitle);

	int playTotalContents(String performanceTitle);

	List<Performance> endPerformance(String performanceTitle);

	int endTotalContents(String performanceTitle);




}
