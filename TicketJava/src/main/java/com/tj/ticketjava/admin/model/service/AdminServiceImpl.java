package com.tj.ticketjava.admin.model.service;

import java.util.List;
import java.util.Map;

import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tj.ticketjava.admin.model.dao.AdminDAO;
import com.tj.ticketjava.admin.model.excetion.adminException;
import com.tj.ticketjava.admin.model.vo.PerformanceImage;
import com.tj.ticketjava.admin.model.vo.Schedule;
import com.tj.ticketjava.ticket.model.vo.Ticket;

@Service
public class AdminServiceImpl implements AdminService {

	@Autowired
	AdminDAO adminDAO;
	

	@Override
	public List<Map<String, String>> selectMemberList() {
		return adminDAO.selectMemberList();
	}

	@Override
	public List<Map<String, String>> selectperformanceList() {
		
		return adminDAO. selectperformanceList();
	}
	
	
	@Override
	public int insertPerformance(Map<String, String> param, List<PerformanceImage> performanceImageList) {
		
		int result = 0;
		int PerformanceNo = 0;
		

		result = adminDAO.insertPerformance(param);
		
		if(result == 0)
			throw new adminException("게시물 등록 오류!");
		
		// 현재 시퀀스 값 
		PerformanceNo = adminDAO.selectPerformanceno();
		
		//인덱스 0-2 코드부여 
		performanceImageList.get(0).setImageCategory("P");
		performanceImageList.get(1).setImageCategory("D");
		performanceImageList.get(2).setImageCategory("C");
		if(performanceImageList.size()==4)
			performanceImageList.get(3).setImageCategory("M");
	
		
		if(performanceImageList.size() > 0) {
			for(PerformanceImage a: performanceImageList) {
				//새로 부여받은 boardNo를 attachment.boardNo 필드에 대입

				a.setPerformanceNo(PerformanceNo);
				result = adminDAO.PerformanceImage(a);
				
				if(result == 0)
					throw new adminException("게시물 등록(첨부파일) 오류!");
			}
		}
		return PerformanceNo;
	}

	@Override
	public Map<String, String> selectperformanceOne(int performanceNo) {
		return adminDAO. selectperformanceOne(performanceNo);
	}

	@Override
	public List<PerformanceImage> selectperformanceOnefile(int performanceNo) {
		return adminDAO. selectperformanceOnefile(performanceNo);
	}

	@Override
	public int updatePerformance(Map<String, String> param, List<PerformanceImage> performanceImageList) {
		
		int result = 0;
		
		result= adminDAO.updatePerformance(param);
		
		if(result == 0)
			throw new adminException("게시물 등록 오류!");
		

				if(performanceImageList.size() > 0) {
					for(PerformanceImage a: performanceImageList) {
						//새로 부여받은 boardNo를 attachment.boardNo 필드에 대입

						a.setPerformanceNo(Integer.parseInt(param.get("performanceNo")));
						result = adminDAO.PerformanceImageupdate(a);
						
						if(result == 0)
							throw new adminException("게시물 등록(첨부파일) 오류!");
					}
				}
				return result;
	}

	@Override
	public List<Map<String, String>>selectPerformanceList(int cPage, int numPerPage,Map<String, String> param) {
		
		return adminDAO.selectPerformanceList(cPage,numPerPage,param);
	}

	@Override
	public int selectPerformanceTotalContents() {
		return adminDAO.selectPerformanceTotalContents();
	}

	@Override
	public List<Map<String, String>> selectplaceList() {
		return adminDAO.selectplaceList();
	}

	@Override
	public int searchCount(Map<String, String> param) {
		return adminDAO.searchCount(param);
	}

	@Override
	public List<Schedule> selectSchedule(int performanceNo) {
		return adminDAO.selectSchedule(performanceNo);
	}

	@Override
	public int insertplace(Map<String, String> param) {
		return adminDAO.insertplace(param);
	}

	@Override
	public int insertSchedule(Map<String, String> param) {
		return adminDAO.insertSchedule(param);
	}

	@Override
	public int deleteSchedule(Map<String, String> param) {
		return adminDAO.deleteSchedule(param);
	}

	@Override
	public List<Ticket> selectbuyList(Map<String, String> param) {
		return adminDAO.selectbuyList(param);
	}

	@Override
	public List<Map<String, String>> selectschedule() {
		return adminDAO.selectschedule();
	}

	@Override
	public List<Map<String, String>> selectMemberList(Map<String, String> param) {
		return adminDAO.selectMemberList(param);
	}

	@Override
	public int searchmemberCount(Map<String, String>param) {
		return adminDAO.searchmemberCount(param);
	}


	@Override
	public int memberTotalCount() {
		return adminDAO.memberTotalCount();
	}

	@Override
	public int memberdelete(String memberId) {
		

		return adminDAO.memberdelete(memberId);
	}

	@Override
	public int performanceTotalCount() {
		return adminDAO.performanceTotalCount();
	}

	@Override
	public int todaypurchaseCount() {
		return adminDAO.todaypurchaseCount();
	}

	@Override
	public int todayScheduleCount() {
		return adminDAO.todayScheduleCount();
	}

	@Override
	public List<Map<String, String>> selectplaceStatistics() {
		return adminDAO.selectplaceStatistics();
	}



		
	}
	
	



	


