package com.tj.ticketjava.performance.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.tj.ticketjava.performance.model.service.PerformanceService;
import com.tj.ticketjava.performance.model.vo.Performance;
import com.tj.ticketjava.performance.model.vo.PerformanceImg;

@Controller
@RequestMapping("/performance")
public class PerformanceController {
	
	private Logger logger = LoggerFactory.getLogger(getClass());

	@Autowired
	private PerformanceService performanceService;
	
	@RequestMapping("/performanceView")
	public void performanceView(@RequestParam("performanceNo") int performanceNo,
							Model model) {
		
		Performance performance = new Performance();
					performance = performanceService.selectTicket(performanceNo);
		
		List<PerformanceImg> performanceImg = new ArrayList<>();
					   		performanceImg = performanceService.selectPerformanceImg(performanceNo);
		String posterImg = "";
		String detailImg = "";
		String castingImg = "";
		for(int i = 0;i<performanceImg.size();i++) {
			
			switch (performanceImg.get(i).getImageCategory()) {
			case "P": posterImg = performanceImg.get(i).getRenamedFileName();
				break;
			case "D": detailImg = performanceImg.get(i).getRenamedFileName();
				break;
			case "C": castingImg = performanceImg.get(i).getRenamedFileName();
				break;
			default: 
				break;
			}
		}
		logger.info("img"+posterImg);
		logger.info("img"+detailImg);
		logger.info("img"+castingImg);
					   
		model.addAttribute("performance",performance);
		model.addAttribute("posterImg",posterImg);
		model.addAttribute("detailImg",detailImg);
		model.addAttribute("castingImg",castingImg);
	
	}
	
	
	@RequestMapping("/performanceRound")
	@ResponseBody
	public List<Map<String,String>> selectPerformanceRound(@RequestParam("performanceNo") String performanceNo,
															@RequestParam("selectedDate") String selectedDate){
		
		Map<String,String> paramMap = new HashMap<>();
		paramMap.put("performanceNo", performanceNo);
		paramMap.put("selectedDate", selectedDate);
		
		/*logger.info(paramMap.toString());*/
		
		List<Map<String,String>> list = performanceService.selectPerformanceRound(paramMap);
		
		logger.info("list"+list.toString());
		
		return list;
	}
	
	@RequestMapping("/viewAvailableSeat")
	@ResponseBody
	public Map<String,String> selectAvailableSeat(@RequestParam("time") String time,
										@RequestParam("performanceNo") String performanceNo,
										@RequestParam("placeCode") String placeCode) {
		
		Map<String,String> paramMap2 = new HashMap<>();
		paramMap2.put("performanceNo", performanceNo);
		paramMap2.put("time", time);
		paramMap2.put("placeCode", placeCode);
		
		logger.info(paramMap2.toString());
		
		String scheduleNo = performanceService.selectscheduleNo(paramMap2);
		logger.info("scheduleNo="+scheduleNo);
		
		Map<String,String> paramMap3 = new HashMap<>();
		paramMap3.put("scheduleNo", scheduleNo);
		paramMap3.put("placeCode", placeCode);
		
		logger.info("placeCode"+placeCode);
		
		int soldSeat = performanceService.selectSoldSeat(paramMap3);

		logger.info("soldSeat"+soldSeat);
		
		int allSeat = performanceService.selectAllSeat(placeCode);
		
		String availableSeat = Integer.toString(allSeat - soldSeat);
		Map<String,String> resultMap = new HashMap<>();
		resultMap.put("scheduleNo", scheduleNo);
		resultMap.put("availableSeat", availableSeat);
				
		return resultMap;
	}
	
	@RequestMapping("/viewGenderRate")
	@ResponseBody
	public Map<String,String> selectGenderRate(@RequestParam("performanceNo") String performanceNo) {
		
		//해당 공연 구매자 수 
		int totalPeople = performanceService.selectTotalPeople(performanceNo);
		
		int genderF = performanceService.selectGenderF(performanceNo);
	
		int genderM = performanceService.selectGenderM(performanceNo);
	
		//여자비율
		int rateF = (int)Math.round(((double)genderF / totalPeople)*100);

		//남자비율
		int rateM = (int)Math.round(((double)genderM / totalPeople)*100);

		Map<String,String> map = new HashMap<>();
		map.put("rateF", Integer.toString(rateF));
		map.put("rateM", Integer.toString(rateM));
		
		
		return map;
	}
	
	@RequestMapping("/viewAgeRate")
	@ResponseBody
	public int[] selectAgeList(@RequestParam("performanceNo") String performanceNo){
		
		List<String> ageList = performanceService.selectAgeList(performanceNo);					
		logger.info("list"+ageList);
		//list[25, 1, 1]
		
		int teenager = 0;
		int twenty = 0;
		int thirty = 0;
		int forty = 0;
		int fiffty = 0;
		int sixty = 0;
		
		//리스트의 나이대 별로 분류해서 수 올리기 
		for(int i = 0 ;i<ageList.size();i++) {
			/*logger.info(ageList.get(i));*/
			//10대(1-10살도 10대로 포함)
			if(Integer.parseInt(ageList.get(i))<20)
				teenager ++;
			//20대
	           else if(Integer.parseInt(ageList.get(i)) >= 20 && Integer.parseInt(ageList.get(i))<30)
	               twenty++;
           //30대
           else if(Integer.parseInt(ageList.get(i)) >= 30 && Integer.parseInt(ageList.get(i))<40)
               thirty++;
           //40대
           else if(Integer.parseInt(ageList.get(i)) >= 40 && Integer.parseInt(ageList.get(i))<50)
               forty++;
           //50대
           else if(Integer.parseInt(ageList.get(i)) >= 50 &&Integer.parseInt(ageList.get(i))<60)
               fiffty++;
			//나머지는 60대로 간주 
			else
				sixty++;		
		}
		
		int[] ageArr = {teenager,twenty,thirty,forty,fiffty,sixty};

		return ageArr;
	}

	@RequestMapping("/viewSchedule")
	@ResponseBody
	public List<String> viewSchedule(@RequestParam("performanceNo") String performanceNo){
		
		List<String> schedule = new ArrayList<>();
		
		List<String> scheduleList = performanceService.viewSchedule(performanceNo);
		/*logger.info("scheduleList"+scheduleList);*/
		
		for(int i = 0;i<scheduleList.size();i++) {
			schedule.add(scheduleList.get(i).substring(0, 10));
		}
		/*logger.info("schedule"+schedule);*/
		
		return schedule;
	}
	
	
	//메인
	@RequestMapping("/mainImage.do")
	@ResponseBody
	public List<Performance> selectMainImg(){
		List<Performance> list = performanceService.selectMainImg();
		return list;
	}
	
	@RequestMapping("/mainImageCnt.do")
	@ResponseBody
	public int selectMainImgCnt() {
		int cnt = performanceService.selectMainImgCnt();
		return cnt;
	}
	
	@RequestMapping("/search.do")
	@ResponseBody
	public List<Performance> selectByTitle(@RequestParam("title") String performanceTitle){

		List<Performance> list = performanceService.selectByTitle(performanceTitle);
		
		return list;
		
	}
	
	@RequestMapping("/menuImgList.do")
	@ResponseBody
	public List<Performance> selectMenuImgList(@RequestParam("category") String category){
		
		List<Performance> list = performanceService.selectMenuImgList(category);
		
		return list;
	}
	
	@RequestMapping("/menuImgDetail.do")
	@ResponseBody
	public Performance selectMenuImg(@RequestParam("imgdetail") String imgdetail){
		
		Performance p = performanceService.selectMenuImg(imgdetail);
		
		return p;
	}
	
	@RequestMapping("/rankList.do")
	@ResponseBody
	public List<Performance> selectRank() {
		return performanceService.selectRank();
	}
	
	@RequestMapping("/rankListConcert.do")
	@ResponseBody
	public List<Performance> selectRankConcert() {
		return performanceService.selectRankConcert();
	}
	
	@RequestMapping("/rankListPlay.do")
	@ResponseBody
	public List<Performance> selectRankPlay() {
		return performanceService.selectRankPlay();
	}

	@RequestMapping("/allMusical.do")
	public ModelAndView allMusical(@RequestParam(value="cPage", required=false, defaultValue="1") int cPage) {
		ModelAndView mav = new ModelAndView();
		int numPerPage = 12;
		
		List<Performance> list = performanceService.musicalList(cPage,numPerPage);
	
		int totalContents = performanceService.selectMusicalTotalContents();
		
		mav.addObject("list",list);
		mav.addObject("cPage",cPage);
		mav.addObject("numPerPage",numPerPage);
		mav.addObject("totalContents",totalContents);
		
		return mav;
	}
	
	@RequestMapping("/allConcert.do")
	public ModelAndView allConcert(@RequestParam(value="cPage", required=false, defaultValue="1") int cPage) {
		ModelAndView mav = new ModelAndView();
		int numPerPage = 12;
		
		List<Performance> list = performanceService.concertList(cPage,numPerPage);
	
		int totalContents = performanceService.selectConcertTotalContents();
		
		mav.addObject("list",list);
		mav.addObject("cPage",cPage);
		mav.addObject("numPerPage",numPerPage);
		mav.addObject("totalContents",totalContents);
		
		return mav;
	}
	
	@RequestMapping("/allPlay.do")
	public ModelAndView allPlay(@RequestParam(value="cPage", required=false, defaultValue="1") int cPage) {
		ModelAndView mav = new ModelAndView();
		int numPerPage = 12;
		
		List<Performance> list = performanceService.playList(cPage,numPerPage);
	
		int totalContents = performanceService.selectPlayTotalContents();
		
		mav.addObject("list",list);
		mav.addObject("cPage",cPage);
		mav.addObject("numPerPage",numPerPage);
		mav.addObject("totalContents",totalContents);
		
		return mav;
	}
	
	//자동완성검색
	@RequestMapping("/searchPerformance")
	public ModelAndView performanceTitle(@RequestParam("performanceTitle") String performanceTitle) {
		
		ModelAndView mav = new ModelAndView();
		
		List<Performance> list = performanceService.searchPerformance(performanceTitle);
		
		int musicalContents = performanceService.musicalTotalContents(performanceTitle);
		int concertContents = performanceService.concertTotalContents(performanceTitle);
		int playContents = performanceService.playTotalContents(performanceTitle);
		
		//종료된 공연
		List<Performance> endList = performanceService.endPerformance(performanceTitle);
		
		int endContents = performanceService.endTotalContents(performanceTitle);
		
		
		
		mav.addObject("list",list);
		mav.addObject("performanceTitle",performanceTitle);
		mav.addObject("musicalContents",musicalContents);
		mav.addObject("concertContents",concertContents);
		mav.addObject("playContents",playContents);
	
		mav.addObject("endList",endList);
		mav.addObject("endContents",endContents);
		
		return mav;
	}
	
	
	
}
