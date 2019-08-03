package com.tj.ticketjava.admin.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.tj.ticketjava.admin.model.vo.PerformanceImage;
import com.tj.ticketjava.admin.model.vo.Schedule;
import com.tj.ticketjava.ticket.model.vo.Ticket;

@Repository
public class AdminDAOImpl implements AdminDAO {

	@Autowired
	SqlSessionTemplate sqlSession;
	
	@Override
	public List<Map<String, String>> selectMemberList() {
		return sqlSession.selectList("admin.selectMemberList");
	}

	@Override
	public int insertPerformance(Map<String, String> param) {
		return sqlSession.insert("admin.insertPerformance",param);
	}

	@Override
	public int PerformanceImage(com.tj.ticketjava.admin.model.vo.PerformanceImage a) {
		return sqlSession.insert("admin.insertinsertPerformanceImage",a);
	}

	@Override
	public int selectPerformanceno() {
		return sqlSession.selectOne("admin.selectPerformanceno");
	}

	@Override
	public List<Map<String, String>> selectperformanceList() {
		return sqlSession.selectList("admin.selectPerformanceList");
	}

	@Override
	public Map<String, String> selectperformanceOne(int performanceNo) {
		
		return sqlSession.selectOne("admin.selectperformanceOne",performanceNo);
	}

	@Override
	public List<PerformanceImage> selectperformanceOnefile(int performanceNo) {
		return sqlSession.selectList("admin.selectperformanceOnefile",performanceNo);
	}


	@Override
	public int updatePerformance(Map<String, String> param) {
		return sqlSession.update("admin.updatePerformance",param);

	}

	@Override
	public int PerformanceImageupdate(PerformanceImage param) {
		
		LoggerFactory.getLogger(getClass()).info("카테고리="+param.getImageCategory());
		return sqlSession.update("admin.PerformanceImageupdate",param);
	}

	@Override
	public List<Map<String, String>> selectPerformanceList(int cPage, int numPerPage,Map<String, String> param) {
		//org.apache.ibatis.session.RowBounds.RowBounds(int offset, int limit)
		
				RowBounds rowBounds = new RowBounds((cPage-1)*numPerPage, numPerPage);
				return sqlSession.selectList("admin.selectPerformance",param,rowBounds);
	}

	@Override
	public int selectPerformanceTotalContents() {
		return sqlSession.selectOne("admin.selectPerformanceTotalContents");
	}

	@Override
	public List<Map<String, String>> selectplaceList() {
		return  sqlSession.selectList("admin.selectplaceList");
	}

	@Override
	public int searchCount(Map<String, String> param) {
		return sqlSession.selectOne("admin.searchCount",param);
	}

	@Override
	public List<Schedule> selectSchedule(int performanceNo) {
		
		return sqlSession.selectList("admin.selectSchedule",performanceNo);
	}

	@Override
	public int insertplace(Map<String, String> param) {
		return sqlSession.insert("admin.insertplace",param);
	}

	@Override
	public int insertSchedule(Map<String, String> param) {
		return sqlSession.insert("admin.insertSchedule",param);
	}

	@Override
	public int deleteSchedule(Map<String, String> param) {
		return sqlSession.delete("admin.deleteSchedule",param);
	}

	@Override
	public List<Ticket> selectbuyList(Map<String, String> param) {
		return sqlSession.selectList("admin.selectbuyList", param);
	}

	@Override
	public List<Map<String, String>> selectschedule() {
		return sqlSession.selectList("admin.selectschedule");
	}

	@Override
	public List<Map<String, String>> selectMemberList(Map<String, String> param) {
		return sqlSession.selectList("admin.selectMemberList2",param);
	}

	@Override
	public int searchmemberCount(Map<String, String> param) {
		return sqlSession.selectOne("admin.searchmemberCount",param);
	}


	@Override
	public int memberTotalCount() {
		return sqlSession.selectOne("admin.memberTotalCount");
	}

	@Override
	public int memberdelete(String memberId) {
		return sqlSession.delete("admin.memberdelete",memberId);
	}

	@Override
	public int performanceTotalCount() {
		return sqlSession.selectOne("admin.performanceTotalCount");
	}

	

	@Override
	public int todaypurchaseCount() {
		return sqlSession.selectOne("admin.todaypurchaseCount");
	}

	@Override
	public int todayScheduleCount() {
		return sqlSession.selectOne("admin.todayScheduleCount");
	}

	@Override
	public List<Map<String, String>> selectplaceStatistics() {
		return sqlSession.selectList("admin.selectplaceStatistics");
	}




}
