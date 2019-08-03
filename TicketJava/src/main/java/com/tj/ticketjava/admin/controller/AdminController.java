package com.tj.ticketjava.admin.controller;

import java.io.File;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.tj.ticketjava.admin.model.service.AdminService;
import com.tj.ticketjava.admin.model.vo.PerformanceImage;
import com.tj.ticketjava.admin.model.vo.Schedule;
import com.tj.ticketjava.ticket.model.vo.Ticket;

@Controller
@RequestMapping("/admin")
public class AdminController {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired
	AdminService adminService;
	
	@RequestMapping("admin.do")
	public ModelAndView admin(
			@RequestParam(value="cPage", required=false, defaultValue="1") int cPage,
			@RequestParam(value="searchType", required=false, defaultValue="") String searchType,
			@RequestParam(value="searchKeyword", required=false, defaultValue="") String searchKeyword
			) {
		
		ModelAndView mav = new ModelAndView();
		
		int numPerPage = 10;//한페이지당 수 
			
		Map<String,String> param = new HashMap<>();
		param.put("searchType", searchType);
		param.put("searchKeyword", searchKeyword);
		
		List<Map<String,String>> list = null;
		
		logger.info("키워드"+searchKeyword);
		logger.info("타입"+searchType);
			
		// 현재페이지 컨텐츠수
		list = adminService.selectPerformanceList(cPage, numPerPage,param);
		
		// 전체컨텐츠수 
		int totalContents = adminService.searchCount(param);
		
		mav.addObject("searchKeyword",searchKeyword);
		mav.addObject("searchType",searchType);
		mav.addObject("list",list);
		mav.addObject("totalContents",totalContents);
		mav.addObject("numPerPage",numPerPage);
		mav.addObject("cPage", cPage);
		
		//멤버
		
		List<Map<String,String>> memberList = null;
		// 현재페이지 컨텐츠수
			
		memberList = adminService.selectMemberList();
		
		logger.info("멤버리스트"+memberList);
		
		// 전체컨텐츠수 
		int member_totalContents = adminService.memberTotalCount();
		logger.info("전체컨텐트수"+member_totalContents);
		
		mav.addObject("memberList",memberList);
		mav.addObject("member_totalContents",member_totalContents);
		
		//금일판매티켓
		int todaypurchaseCount = adminService.todaypurchaseCount();
		mav.addObject("todaypurchaseCount",String.valueOf(todaypurchaseCount));
		
		//금일공연수
		int todayScheduleCount = adminService.todayScheduleCount();
		mav.addObject("todayScheduleCount",String.valueOf(todayScheduleCount));
		
		//전체공연수
		int performanceTotalCount = adminService.performanceTotalCount();
		mav.addObject("performanceTotalCount",performanceTotalCount);
		logger.info("공연리스트2"+list);
		mav.addObject("performanceList",list);
		
		//공연장 이름
		List<Map<String,String>> place = adminService.selectplaceList();
		logger.info("공연장리스트"+place);
		mav.addObject("place",place);
		

		//회원통계 연령,성별 
		List<Map<String,String>>  statistics = adminService.selectplaceStatistics();
		logger.info("statistics="+statistics);
		
		mav.addObject("statistics",statistics);

		
		return mav;
		
	}
	
	
	//value = "testOk", method = RequestMethod.POST
	
	@RequestMapping("/performanceinsert.do")
	public ModelAndView insertperformance(@RequestParam("endDate") String endDate,
			@RequestParam("runningTime") String runningTime,
			@RequestParam("viewingClass") String viewingClass,
			@RequestParam("casting") String casting,
			@RequestParam("performanceTitle") String performanceTitle,
			@RequestParam("startDate") String startDate,
			@RequestParam("placeCode") String placeCode,
			@RequestParam("performanceCode") String performanceCode,
			@RequestParam("price") String price,
			String[] tag,
																  MultipartFile[] upFile,
																  HttpServletRequest request,
																  ModelAndView mav){
		
		Map<String,String> param = new HashMap<>();
		param.put("price", price);
		param.put("performanceCode", performanceCode);
		param.put("placeCode", placeCode);
		param.put("startDate", startDate);
		param.put("performanceTitle", performanceTitle);
		param.put("casting",casting);
		param.put("viewingClass",viewingClass);
		param.put("runningTime", runningTime);
		param.put("endDate",endDate);
		
		logger.info("공연등록 들어옴"+param);
		int result = 0;
		
		try {
			
			String saveDirectory =  request.getServletContext().getRealPath("resources/upload/performance");
					
			
			List<PerformanceImage> performanceImageList = new ArrayList<>();
			
			for(MultipartFile f:  upFile) {
				if(!f.isEmpty()) {
					String originalFileName = f.getOriginalFilename();
					String ext = originalFileName.substring(originalFileName.lastIndexOf(".")+1);
					SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd_HHmmssSSS");
					int rndNum = (int)(Math.random()*1000);
					
					String renamedFileName
						= sdf.format(new Date())+"_"+rndNum+"."+ext;
					
					try {
						//서버 지정위치에 파일 보관
						f.transferTo(new File(saveDirectory+"/"+renamedFileName));
					} catch (IllegalStateException e) {
						e.printStackTrace();
					} catch (IOException e) {
						e.printStackTrace();
					}
					
					//vo객체에 담기
					PerformanceImage attach = new PerformanceImage();
					attach.setOriginalFileName(originalFileName);
					attach.setRenamedFileName(renamedFileName);
					
					//list에 vo담기
					performanceImageList.add(attach);
					
				}
			}
		
			logger.debug("performanceImageList={}",performanceImageList);
		
	result = adminService.insertPerformance(param,performanceImageList);
			
		} catch(Exception e) {
			logger.error("게시물 등록 에러", e);
		}
		
		
		String loc = "/admin/admin.do";
		String msg = result>0?"공연등록성공!":"공연등록실패!";

		mav.addObject("loc",loc);
		mav.addObject("msg", msg);
		mav.setViewName("common/msg");
		return mav;
		
		
	}
	
	
	@RequestMapping("/performanceupdateend.do")
	public ModelAndView updateperformance(@RequestParam("endDate") String endDate,
			@RequestParam("runningTime") String runningTime,
			@RequestParam("viewingClass") String viewingClass,
			@RequestParam("casting") String casting,
			@RequestParam("performanceTitle") String performanceTitle,
			@RequestParam("startDate") String startDate,
			@RequestParam("placeCode") String placeCode,
			@RequestParam("performanceCode") String performanceCode,
			@RequestParam("price") String price,
			@RequestParam("performanceNo") String performanceNo,
			String[] tag,
			MultipartFile[] upFile,
			HttpServletRequest request,
			ModelAndView mav){
		Map<String,String> param = new HashMap<>();
		param.put("price", price);
		param.put("performanceCode", performanceCode);
		param.put("placeCode", placeCode);
		param.put("startDate", startDate);
		param.put("performanceTitle", performanceTitle);
		param.put("casting",casting);
		param.put("viewingClass",viewingClass);
		param.put("runningTime", runningTime);
		param.put("endDate",endDate);
		param.put("performanceNo", performanceNo);
		

		logger.info("공연수정 들어옴"+param);
		int result = 0;
		

		try {

			
			String saveDirectory = request.getServletContext().getRealPath("resources/upload/performance");
			
			
			//1. 파일업로드
			
			List<PerformanceImage> performanceImageList = new ArrayList<>();
			
			for(MultipartFile f:  upFile) {
				if(!f.isEmpty()) {
					String originalFileName = f.getOriginalFilename();
					String ext = originalFileName.substring(originalFileName.lastIndexOf(".")+1);
					SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd_HHmmssSSS");
					int rndNum = (int)(Math.random()*1000);
					
					String renamedFileName
					= sdf.format(new Date())+"_"+rndNum+"."+ext;
					
					try {
						//서버 지정위치에 파일 보관
						f.transferTo(new File(saveDirectory+"/"+renamedFileName));
					} catch (IllegalStateException e) {
						e.printStackTrace();
					} catch (IOException e) {
						e.printStackTrace();
					}
					
					//vo객체에 담기
					PerformanceImage attach = new PerformanceImage();
					attach.setOriginalFileName(originalFileName);
					attach.setRenamedFileName(renamedFileName);
		
					//list에 vo담기
					performanceImageList.add(attach);
					
				}
			}

			//수정할땐 파일 하나만 수정 가능해야해서 넣음
			
			for (int i = 0; i<performanceImageList.size(); i++) {
				
		if(!tag[0].isEmpty()&& tag[0].substring(3).equals(performanceImageList.get(i).getOriginalFileName())) 
					performanceImageList.get(i).setImageCategory(tag[0].substring(1, 2));	
					
			else if(!tag[1].isEmpty()&& tag[1].substring(3).equals(performanceImageList.get(i).getOriginalFileName())) 
					performanceImageList.get(i).setImageCategory(tag[1].substring(1, 2));	
			
			else if(!tag[2].isEmpty()&& tag[2].substring(3).equals(performanceImageList.get(i).getOriginalFileName())) 
				performanceImageList.get(i).setImageCategory(tag[2].substring(1, 2));	
		
			else if(!tag[3].isEmpty()&& tag[3].substring(3).equals(performanceImageList.get(i).getOriginalFileName())) 
				performanceImageList.get(i).setImageCategory(tag[3].substring(1, 2));	
					
					}
				
			logger.info("performanceImageList={}",performanceImageList);
			

			result = adminService.updatePerformance(param,performanceImageList);
			
		} catch(Exception e) {
			logger.error("게시물 등록 에러", e);
		}
		
		String loc = "/admin/admin.do";
		String msg = result>0?"공연수정성공!":"공연수정실패!";
		
		mav.addObject("loc", loc);
		mav.addObject("msg", msg);
		mav.setViewName("common/msg");
		return mav;
		
	}
	
	
	@RequestMapping("/performanceupdate.do")
	public ModelAndView test( HttpServletRequest request,
			@RequestParam("performanceNo") int performanceNo,
			ModelAndView mav) {
		
		logger.info("수정폼 들어옴"+performanceNo);
		
		
		Map<String,String> performance = adminService.selectperformanceOne(performanceNo);
		logger.info("공연"+performance);
		mav.addObject("performance",performance);
		
		List<PerformanceImage> image = adminService.selectperformanceOnefile(performanceNo);
		logger.info("파일리스트"+image);
		
		List<Map<String,String>> place = adminService.selectplaceList();
		logger.info("공연장리스트"+place);
		mav.addObject("place",place);
		
		/*	 파일객체 입력불가 
		String saveDirectory = ("C:/Workspaces/spring_workspace/TicketJava/src/main/webapp/resources/upload/performance");
		
	File pFile = new File(saveDirectory+"/"+image.get(0).getRenamedFileName());
		File dFile = new File(saveDirectory+"/"+image.get(1).getRenamedFileName());
		File cFile = new File(saveDirectory+"/"+image.get(2).getRenamedFileName());
		
		mav.addObject("pFile",pFile);
		mav.addObject("dFile",dFile);
		mav.addObject("cFile",cFile);*/
		
		mav.addObject("image",image);
		mav.addObject("performanceNo",performanceNo);
		return mav;
		
}
	
	@RequestMapping("/performanceSchedule")
	public ModelAndView performanceSchedule(@RequestParam("performanceNo") int performanceNo,
			ModelAndView mav) {
		
		logger.info("스케쥴드루옴"+performanceNo);
		List<Schedule> schedule = adminService.selectSchedule(performanceNo);
		logger.info("스케쥴"+schedule);
		Map<String,String> performance = adminService.selectperformanceOne(performanceNo);
		mav.addObject("performance",performance);
		logger.info("스케쥴2"+performance);
		mav.addObject("Schedule",schedule);
		
		return mav;
	}
	
	@RequestMapping("/insertplace.do")
	public ModelAndView insertplace(
			ModelAndView mav) {

		return mav;
	}
	
	@RequestMapping("/jusoPopup.do")
	public ModelAndView jusoPopup(
			ModelAndView mav) {
		
		return mav;
	}
	
	@RequestMapping("/insertplaceend.do")
	public ModelAndView insertplaceend(@RequestParam("placeCode") String placeCode,
			@RequestParam("placeName") String placeName,
			@RequestParam("addRess") String addRess,
			@RequestParam("seatCount") String seatCount,
			HttpServletRequest request,
			ModelAndView mav){
		
		
		Map<String,String> param = new HashMap<>();
	
		param.put("seatCount", seatCount);
		param.put("placeCode", placeCode);
		param.put("placeName",placeName);
		param.put("addRess", addRess);
		
		logger.info("공연장추가 들어옴"+param);
		
		int result = 0;
		
		result = adminService.insertplace(param);
		
		String msg = result>0?"공연장 등록 성공!":"공연장 등록 실패!";
		String loc = "/admin/insertplace.do";
		mav.addObject("loc", loc);
		mav.addObject("msg", msg);
		mav.setViewName("common/msg");
		
		return mav;
	}
	
	@RequestMapping("/scheduleend.do")
	public ModelAndView scheduleend(@RequestParam("performanceNo") String performanceNo,
			@RequestParam("scheduleDate") String scheduleDate,
			@RequestParam("scheduleTime") String scheduleTime,
			HttpServletRequest request,
		
			ModelAndView mav){
		
	    scheduleDate = scheduleDate+" "+scheduleTime;
		Map<String,String> param = new HashMap<>();
	
		param.put("performanceNo", performanceNo);
		param.put("scheduleDate",scheduleDate);
		logger.info("스케쥴추가"+param);
		
		int result = 0;
		
		result = adminService.insertSchedule(param);
		
		String msg = result>0?"일정 추가 성공!":"일정 추가 실패!";
		String loc = "/admin/performanceSchedule?performanceNo="+performanceNo;
		mav.addObject("loc", loc);
		mav.addObject("msg", msg);
		mav.setViewName("common/msg");
		
		return mav;
	}
	
	@RequestMapping("/scheduledeleteend.do")
	public ModelAndView scheduledeleteend(@RequestParam("scheduleNo") String scheduleNo,
			@RequestParam("performanceNo") String performanceNo,
			HttpServletRequest request,
			ModelAndView mav){
		

		Map<String,String> param = new HashMap<>();
	
		param.put("scheduleNo",scheduleNo);
		logger.info("스케쥴추가"+param);
		
		int result = 0;
		
		result = adminService.deleteSchedule(param);
		
		String msg = result>0?"일정 삭제 성공!":"일정 삭제 실패!";
		String loc = "/admin/performanceSchedule?performanceNo="+performanceNo;
		mav.addObject("loc", loc);
		mav.addObject("msg", msg);
		mav.setViewName("common/msg");
		
		return mav;
	}
	
	
	@RequestMapping("/buyView.do")
	public ModelAndView buyView(@RequestParam("scheduleNo") String scheduleNo,
			@RequestParam("performanceNo") String performanceNo,
			HttpServletRequest request,
			ModelAndView mav) {
		
		
		Map<String,String> param = new HashMap<>();
		
		param.put("scheduleNo",scheduleNo);
		param.put("performanceNo",performanceNo);
		
		
		List<Ticket> buyList = adminService.selectbuyList(param);
		logger.info("구매목록"+buyList);
		mav.addObject("buyList",buyList);
		
		return mav;
		
	}
	
	//실시간 예매일정
	
	@RequestMapping(value = "/schedulesoon.do", method = RequestMethod.POST)
	  @ResponseBody
	  public List<Map<String,String>>schedulesoon() throws Exception{
	     
			List<Map<String,String>> soon = adminService.selectschedule();
			
			logger.info("가져온애들"+soon);
		

			DateFormat sdFormat = new SimpleDateFormat("MM/dd  ah시 ");
		
			for (int i = 0; i < soon.size(); i ++) {
				
				String regDate = sdFormat.format((soon.get(i).get("MIN_DATE")));
				logger.info(regDate);
				
				soon.get(i).put("MIN_DATE",regDate);
				
				soon.get(i).put("RANK",String.valueOf(soon.get(i).get("RANK")));
				
				soon.get(i).put("PERFORMANCE_NO",String.valueOf(soon.get(i).get("PERFORMANCE_NO")));
			}
			
			return soon;
	  }
	
	@RequestMapping("/selectmember.do")
	  @ResponseBody
	public List<Map<String,String>> selectmember(
			@RequestParam(value="searchType", required=false, defaultValue="") String searchType,
			@RequestParam(value="searchKeyword", required=false, defaultValue="") String searchKeyword) 
	{
		
		Map<String,String> param = new HashMap<>();
		param.put("searchType", searchType);	
		param.put("searchKeyword", searchKeyword);
		
		
		ModelAndView mav = new ModelAndView();
		
		List<Map<String,String>> memberList = null;
		// 현재페이지 컨텐츠수
		logger.info("mㅅ키워드"+searchKeyword);
		logger.info("mㅅ타입"+searchType);
			
		memberList = adminService.selectMemberList(param);
		
		int searchCount = adminService.searchmemberCount(param);
		
		logger.info("멤버카운트"+searchCount);
		logger.info("멤버리스트"+memberList);
		
		memberList.get(0).put("searchCount", String.valueOf(searchCount));
		
		for (int i = 0; i < memberList.size(); i ++) {
			
			
			memberList.get(i).put("POINT",String.valueOf(memberList.get(i).get("POINT")));
			
			memberList.get(i).put("TOTAL_PRICE",String.valueOf(memberList.get(i).get("TOTAL_PRICE")));
			
			memberList.get(i).put("BIRTH_DATE",String.valueOf(memberList.get(i).get("BIRTH_DATE")));
		}
		
		
		return memberList;

		//ajax로 table 갈아치우기
		
	}
	
	@RequestMapping("/memberdelete.do")
	@ResponseBody
	public int memberdelete(ModelAndView mav,
			@RequestParam(value="memberId", required=false, defaultValue="") String memberId) {
		
		 int result = adminService.memberdelete(memberId);
		

		return result;
	}
	
	
	
}
