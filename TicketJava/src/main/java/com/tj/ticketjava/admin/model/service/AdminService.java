package com.tj.ticketjava.admin.model.service;

import java.util.List;
import java.util.Map;

import com.tj.ticketjava.admin.model.vo.PerformanceImage;
import com.tj.ticketjava.admin.model.vo.Schedule;
import com.tj.ticketjava.ticket.model.vo.Ticket;

public interface AdminService {

	List<Map<String, String>> selectMemberList();

	int insertPerformance(Map<String, String> param, List<PerformanceImage> performanceImageList);

	List<Map<String, String>> selectperformanceList();

	Map<String, String> selectperformanceOne(int performanceNo);

	List<PerformanceImage> selectperformanceOnefile(int performanceNo);

	int updatePerformance(Map<String, String> param, List<PerformanceImage> performanceImageList);

	List<Map<String, String>> selectPerformanceList(int cPage, int numPerPage, Map<String, String> param);

	int selectPerformanceTotalContents();

	List<Map<String, String>> selectplaceList();

	int searchCount(Map<String, String> param);

	List<Schedule> selectSchedule(int performanceNo);

	int insertplace(Map<String, String> param);

	int insertSchedule(Map<String, String> param);

	int deleteSchedule(Map<String, String> param);

	List<Ticket> selectbuyList(Map<String, String> param);

	List<Map<String, String>> selectschedule();

	List<Map<String, String>> selectMemberList(Map<String, String> member_param);

	int searchmemberCount(Map<String, String>param);

	int memberTotalCount();

	int memberdelete(String memberId);

	int performanceTotalCount();

	int todaypurchaseCount();

	int todayScheduleCount();

	List<Map<String, String>> selectplaceStatistics();



}
