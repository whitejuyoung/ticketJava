package com.tj.ticketjava.performance.model.service;

import java.sql.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tj.ticketjava.performance.model.dao.PerformanceDAO;
import com.tj.ticketjava.performance.model.vo.Performance;
import com.tj.ticketjava.performance.model.vo.PerformanceImg;

@Service
public class PerformanceServiceImpl implements PerformanceService {

	@Autowired
	private PerformanceDAO performanceDAO;

	@Override
	public Performance selectTicket(int performanceNo) {
		
		return performanceDAO.selectTicket(performanceNo);
	}

	@Override
	public List<Map<String, String>> selectPerformanceRound(Map<String, String> paramMap) {
		
		return performanceDAO.selectPerformanceRound(paramMap);
	}


	@Override
	public int selectTotalPeople(String performanceNo) {
		
		return performanceDAO.selectTotalPeople(performanceNo);
	}

	@Override
	public int selectGenderF(String performanceNo) {
		
		return performanceDAO.selectGenderF(performanceNo);
	}

	@Override
	public int selectGenderM(String performanceNo) {
		
		return performanceDAO.selectGenderM(performanceNo);
	}

	@Override
	public List<String> selectAgeList(String performanceNo) {
		
		return performanceDAO.selectAgeList(performanceNo);
	}

	@Override
	public String selectscheduleNo(Map<String, String> paramMap) {
		
		return performanceDAO.selectscheduleNo(paramMap);
	}

	@Override
	public List<String> viewSchedule(String performanceNo) {
		
		return performanceDAO.viewSchedule(performanceNo);
	}

	@Override
	public List<PerformanceImg> selectPerformanceImg(int performanceNo) {
		
		return performanceDAO.selectPerformanceImg(performanceNo);
	}
	
	//메인
	@Override
	public List<Performance> selectMainImg() {
		return performanceDAO.selectMainImg();
	}

	@Override
	public int selectMainImgCnt() {
		return performanceDAO.selectMainImgCnt();
	}
	
	
	@Override
	public List<Performance> selectByTitle(String performanceTitle) {
		return performanceDAO.selectByTitle(performanceTitle);
	}

	@Override
	public List<Performance> selectMenuImgList(String category) {
		return performanceDAO.selectMenuImgList(category);
	}

	@Override
	public Performance selectMenuImg(String imgdetail) {
		return performanceDAO.selectMenuImg(imgdetail);
	}

	@Override
	public List<Performance> selectRank() {
		return performanceDAO.selectRank();
	}
	
	@Override
	public List<Performance> selectRankConcert() {
		return performanceDAO.selectRankConcert();
	}
	
	@Override
	public List<Performance> selectRankPlay() {
		return performanceDAO.selectRankPlay();
	}
	

	
	//전체보기 페이지
	@Override
	public List<Performance> musicalList(int cPage, int numPerPage) {
		return performanceDAO.musicalList(cPage,numPerPage);
	}

	@Override
	public int selectMusicalTotalContents() {
		return performanceDAO.selectMusicalTotalContents();
	}

	@Override
	public List<Performance> concertList(int cPage, int numPerPage) {
		return performanceDAO.concertList(cPage,numPerPage);
	}

	@Override
	public int selectConcertTotalContents() {
		return performanceDAO.selectConcertTotalContents();
	}

	@Override
	public List<Performance> playList(int cPage, int numPerPage) {
		return performanceDAO.playList(cPage,numPerPage);
	}

	@Override
	public int selectPlayTotalContents() {
		return performanceDAO.selectPlayTotalContents();
	}
	
	//좌석선택

	@Override
	public int selectAllSeat(String placeCode) {
		
		return performanceDAO.selectAllSeat(placeCode);
	}

	@Override
	public int selectSoldSeat(Map<String, String> paramMap3) {
		
		return performanceDAO.selectSoldSeat(paramMap3);
	}

	//자동완성검색
	@Override
	public List<Performance> searchPerformance(String performanceTitle) {
		return performanceDAO.searchPerformance(performanceTitle);
	}

	@Override
	public int musicalTotalContents(String performanceTitle) {
		return performanceDAO.musicalTotalContents(performanceTitle);
	}

	@Override
	public int concertTotalContents(String performanceTitle) {
		return performanceDAO.concertTotalContents(performanceTitle);
	}

	@Override
	public int playTotalContents(String performanceTitle) {
		return performanceDAO.playTotalContents(performanceTitle);
	}

	@Override
	public List<Performance> endPerformance(String performanceTitle) {
		return performanceDAO.endPerformance(performanceTitle);
	}

	@Override
	public int endTotalContents(String performanceTitle) {
		return performanceDAO.endTotalContents(performanceTitle);
	}


	


}
