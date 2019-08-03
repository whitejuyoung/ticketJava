package com.tj.ticketjava.member.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;

import com.tj.ticketjava.member.model.service.MailService;
import com.tj.ticketjava.member.model.service.MemberService;
import com.tj.ticketjava.member.model.vo.Member;
import com.tj.ticketjava.member.model.vo.Point;
import com.tj.ticketjava.ticket.model.service.TicketService;
import com.tj.ticketjava.ticket.model.vo.Purchase;
import com.tj.ticketjava.ticket.model.vo.Ticket;


@Controller
@RequestMapping("/member")
@SessionAttributes(value="memberLoggedIn")
public class MemberController {
	
	private Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired
	private MemberService memberService;
	@Autowired
    private MailService mailService;
	@Autowired
	private TicketService ticketService;
	
	
	@Autowired
	BCryptPasswordEncoder bcryptPasswordEncoder;

	public void setMailService(MailService mailService) {
        this.mailService = mailService;
    }
	
	@RequestMapping("/memberEnroll.do")
	public void memberEnroll() {
		//내용 없음 연결만 함
	}
	
	@RequestMapping("/memberEnrollTJ.do")
	public ModelAndView memberEnrollTJ(@RequestParam(value="googleMemberId", 
								required=false, defaultValue="") String googleMemberId,
								@RequestParam(value="facebookMemberId", 
								required=false, defaultValue="") String facebookMemberId,
							    @RequestParam(value="memberName", 
							    required=false, defaultValue="") String memberName,
							    @RequestParam(value="email", 
								required=false, defaultValue="") String email){
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("googleMemberId", googleMemberId);
		mav.addObject("facebookMemberId", facebookMemberId);
		mav.addObject("memberName", memberName);
		mav.addObject("email", email);
		
		return mav;
	}
	
	@RequestMapping("/memberEnrollEnd.do")
	public String memberEnrollEnd(Member member, Model model,
							@RequestParam(value="recommendId", 
							required=false, defaultValue="") String recommendId) {
		//비밀번호 암호화 처리
		String rawPassword = member.getPassword();
		String encodedPassword = bcryptPasswordEncoder.encode(rawPassword);
		
		//암호화된 비밀번호로 바꿔 줌
		member.setPassword(encodedPassword);
		
		int result = memberService.insertMember(member);
		
		String loc = result>0?"/member/memberLogin.do":"/member/memberEnroll.do";
		String msg = result>0?"티켓자바의 회원이 되신 것을 환영합니다!":"회원가입 오류 발생: 관리자에게 문의 바랍니다";
		
		if(result>0) {
			//회원가입 오류 없이 성공했을 경우 추천인 포인트 주는 로직
			Member recommendMember = memberService.selectOneMember(recommendId);
			if(recommendMember != null) {
				//포인트 주는 로직
				//desc ACCUMULATEPOINT;
				//포인트 넣기 / 포인트 내역 넣기 총 로직 두 개씩
				
				//회원 가입 하는 회원한테 2000포인트
				member.setPoint(2000);
				int result2 = memberService.updatePoint(member);
				
				Point ap = new Point();
				ap.setMemberId(member.getMemberId());
				ap.setPoint(2000);
				ap.setPointMessage("추천인 등록");
				ap.setPointStatus("적립");
				
				int result3 = memberService.insertAccumulatePoint(ap);
				
				//추천한 회원한테 1000포인트
				recommendMember.setPoint(recommendMember.getPoint()+1000);
				int result4 = memberService.updatePoint(recommendMember);
				
				ap.setMemberId(recommendMember.getMemberId());
				ap.setPoint(1000);
				ap.setPointMessage("추천인 회원 가입");
				int result5 = memberService.insertAccumulatePoint(ap);
				
				if(result2>0 && result3>0 && result4>0 && result5>0) {
					loc = "/member/memberLogin.do";
					msg = "티켓자바의 회원이 되신 것을 환영합니다!";
					
					//회원가입 축하 이메일 발송
					String subject = "TicketJava에 가입하신 것을 환영합니다!";
	            	StringBuilder sb = new StringBuilder();
	            	sb.append(member.getMemberName()+"님, 티켓자바 회원가입을 축하드립니다~!");
	            	mailService.send(subject, sb.toString(), "finalticketjava@gmail.com", member.getEmail(), null);
	            }
				else {
					loc = "/member/memberEnroll.do";
					msg = "회원가입 오류 발생: 관리자에게 문의 바랍니다";
				}
			}
			else {
				//추천인 없음
				//회원가입 축하 이메일 발송
				String subject = "TicketJava에 가입하신 것을 환영합니다!";
            	StringBuilder sb = new StringBuilder();
            	sb.append(member.getMemberName()+"님, 티켓자바 회원가입을 축하드립니다~!");
            	mailService.send(subject, sb.toString(), "finalticketjava@gmail.com", member.getEmail(), null);
            }
		}
		
		model.addAttribute("loc", loc);
		model.addAttribute("msg", msg);
		
		return "common/msg";
	}
	
	@RequestMapping("/memberMyPage.do")
	public void memberMyPage(){
		//내용 없음 연결만 함
	}
	
	@RequestMapping("/memberLogin.do")
	public void memberLogin(){
		//내용 없음 연결만 함
	}
	
	@RequestMapping("/memberLoginEnd.do")
	public ModelAndView memberLoginEnd(@RequestParam() String memberId,
				       		   @RequestParam String password,
				       		   @RequestParam(value="saveId", 
				       		   required=false, defaultValue="") String saveId,
				       		   ModelAndView mav,
				       		   HttpServletResponse response,
				       		   HttpServletRequest request) {
		//ModelAndView를 리턴해 줘야 함

		if(logger.isDebugEnabled()) {
			logger.debug("로그인 요청 ~!~!~!~!~!");	
		}
		
		//String encodedPassword = bcryptPasswordEncoder.encode(password);
		
		
		//1. 업무로직
		//bcrypt 방식의 비밀번호 비교를 위해 회원 정보 가져오기
		Member m = memberService.selectOneMember(memberId);
		
		String msg = "";
		String loc = "/";
		
		if(m == null) {
			msg = "존재하지 않는 회원입니다!";
			loc = "/member/memberLogin.do";
		}
		else {
			//회원이 존재하긴 함
			//BCryptPasswordEncoder.matches(CharSequence rawPassword, String encodedPassword)
			boolean bool = bcryptPasswordEncoder.matches(password, m.getPassword());
			
			if(bool) {
				//로그인 성공
				//비밀번호 일치: true
				HttpSession session = request.getSession();
				session.setAttribute("memberLoggedIn", m);
				msg = "로그인 성공~! ♪"+m.getMemberName()+"♬님 반갑습니다!!~!~";
				
				//mav.addObject("memberLoggedIn", m);
				
				//로그인 성공시 아이디 저장 쿠키 처리
				if("on".equals(saveId)) {
					Cookie c = new Cookie("saveId", memberId); //키 밸류 쌍으로 저장
					c.setMaxAge(7*24*60*60); //초 단위로 유효기간 설정
					c.setPath("/"); //현재 도메인 전역에서 사용하겠다는 의미
					response.addCookie(c); //사용자에게 응답 보낼 때 이 쿠키값 가지고 가서 클라이언트에게 이 쿠키 저장
					mav.addObject(c);
				} 
				else {
					//쿠키 는 별도의 삭제 메소드 없이 maxAge값을 0으로 해서 바로 삭제하게 만듦
					Cookie c = new Cookie("saveId", memberId);
					c.setMaxAge(0); //즉시 삭제. 음수값 사용시 현재 세션 객체가 유효한 동안만 사용하겠다는 의미
					c.setPath("/");
					response.addCookie(c);
					mav.addObject(c);
				}
				
			}
			else {
				//로그인 실패
				//비밀번호 불일치: false
				msg = "비밀번호가 일치하지 않습니다!";
				loc = "/member/memberLogin.do";
			}
		}
		
		//2.view단 처리
		mav.addObject("msg", msg);
		mav.addObject("loc", loc);
		
		//view단 지정
		mav.setViewName("/common/msg");
		
		return mav;
	}
	
	@RequestMapping("/memberLoginSNS.do")
	public ModelAndView memberLoginSNS(ModelAndView mav,
									HttpServletRequest request,
									@RequestParam(value="googleMemberId", 
		    		   				required=false, defaultValue="") String googleMemberId,
									@RequestParam(value="facebookMemberId", 
		    		   				required=false, defaultValue="") String facebookMemberId) {
		
		Member m = null;
		
		if(!"".equals(googleMemberId)) {
			m = memberService.selectOneMemberByGoogle(googleMemberId);			
		}
		if(!"".equals(facebookMemberId)) {
			m = memberService.selectOneMemberByFacebook(facebookMemberId);
		}
		
		String msg = "";
		String loc = "/";
		
		if(m != null) {
			//회원 있음 
			msg = "로그인 성공~! ♪"+m.getMemberName()+"♬님 반갑습니다!!~!~";
			HttpSession session = request.getSession();
			session.setAttribute("memberLoggedIn", m);
			mav.addObject("memberLoggedIn", m);
		}
		else {
			//sns로 횐갑 안 했음...
			msg = "회원가입 페이지에서 SNS로 회원가입을 해 주세요!";
		}
		
		//2.view단 처리
		mav.addObject("msg", msg);
		mav.addObject("loc", loc);
		
		//view단 지정
		mav.setViewName("/common/msg");
				
		return mav;
	}
	
	/*카카오톡*/
	@RequestMapping("/memberLoginSNSforKakao.do")
	@ResponseBody
	public Map<String,String> memberLoginSNSforKakao(HttpServletRequest request,@RequestParam(value="kakaoMemberId", 
		    		   				required=false, defaultValue="") String kakaoMemberId,
										@RequestParam(value="email", required=false, defaultValue="") 
										String email, @RequestParam(value="name", required=false, defaultValue="") 
																										String name) {
		
		Member m = memberService.selectOneMemberByKakao(kakaoMemberId);
		logger.info("m"+m);
		logger.info("ka"+kakaoMemberId);
		Map<String,String> map = new HashMap<>(); 
		String result = "";
		map.put("kakaoMemberId",kakaoMemberId );
		map.put("email",email );
		map.put("name",name );
		logger.info(email);
		logger.info(name);

		if(m != null) {
			//회원 있음 
			map.put("result", "1");
			HttpSession session = request.getSession();
			session.setAttribute("memberLoggedIn", m);
			
		}
		else {
			//sns로 횐갑 안 했음...
			map.put("result", "0");
		}
			
		return map;
	}
	
	@RequestMapping("/memberEnrollKa.do")
	public ModelAndView memberEnrollKa(@RequestParam(value="kakaoMemberId", 
								required=false, defaultValue="") String kakaoMemberId,
							   @RequestParam(value="name", 
							    required=false, defaultValue="") String memberName,
							   @RequestParam(value="email", 
								required=false, defaultValue="") String email){
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("kakaoMemberId", kakaoMemberId);
		mav.addObject("memberName", memberName);
		mav.addObject("email", email);
		mav.setViewName("member/memberEnrollTJ");
		
		return mav;
	}
	
	/*카카오 계정 연동하기*/
	@RequestMapping("/memberSNSConnectForKakao.do")
	@ResponseBody
	public Map<String,String> memberSNSConnectForKakao(@RequestParam(value="kakaoMemberId", 
										required=false, defaultValue="") String kakaoMemberId,
										   @RequestParam(value="email", 
											required=false, defaultValue="") String email,
										   HttpServletRequest request) {
		
		Map<String,String> map = new HashMap<>();
		
		Member checkKakao = memberService.selectOneMemberByKakao(kakaoMemberId);
		
		HttpSession session = request.getSession();
		Member m = (Member)session.getAttribute("memberLoggedIn");
		String result = "";
		
		Map<String,String> paramMap = new HashMap<>();
		paramMap.put("memberId", m.getMemberId());
		paramMap.put("kakaoMemberId", kakaoMemberId);
		
		if(checkKakao != null) {
			result = "0";
		}
		else {
			int result2 = memberService.updateMemberKakao(paramMap);
			
			/*연결성공!*/
			if(result2>0) {
				result = "1";
				m.setKakaoMemberId(kakaoMemberId);
				session.setAttribute("memberLoggedIn", m);
			}
			/*오류*/
			else {
				result = "2";
			}
		}
		
		map.put("result", result);

		return map;
	}
	
	@RequestMapping("/memberLogout.do")
	public String memberLogout(SessionStatus sessionStatus, Model model){
		//로그인 했을 때, HttpSession객체.setAttribute를 통해 로그인 사용자 정보를 담았다면
		//원래는 HttpSession객체.invalidate(); 이렇게 했음
		
		//modelAttribute(sessionAttribute)에 로그인 사용자 정보를 담았다면
		//sessionStatus 객체의 setComplete 메소드로 무효화 해야 됨
		
		//끝나지 않은 경우에만 실행하라고 한 번 검사해 줌
		if(!sessionStatus.isComplete())
			sessionStatus.setComplete();
		
		model.addAttribute("loc", "/member/memberLogin.do");
		model.addAttribute("msg", "정상적으로 로그아웃되었습니다!");
		
		return "common/msg";
	}
	
	@GetMapping("/checkIdDuplicate")
	public void checkIdDuplicate(String memberId, 
								 HttpServletResponse response)
								 throws ServletException, IOException{
		Member m = memberService.selectOneMember(memberId);
		
		String isUsable = "false";
		if(m == null) {
			isUsable = "true";
		}
		
		response.getWriter().print(isUsable);
	}
	
	@GetMapping("/checkEmailDuplicate")
	@ResponseBody
	public Map<String, String> checkEmailDuplicate(String email, 
								 HttpServletResponse response)
								 throws ServletException, IOException{
		Member m = memberService.selectOneMemberByEmail(email);
		Map<String, String > map = new HashMap<>();
		String msg = "X";
		if(m == null) {
			msg = "O";
		}
		map.put("msg", msg);
		
		return map;
	}
	
	@RequestMapping("/memberInfoUpdatePasswordCheck.do")
	public void memberInfoUpdatePasswordCheck() {
		//내용 없음 연결만 함
	}
	
	@RequestMapping("/memberPasswordUpdatePasswordCheck.do")
	public void memberPasswordUpdatePasswordCheck() {
		//내용 없음 연결만 함
	}
	
	@RequestMapping("/memberDeletePasswordCheck.do")
	public void memberDeletePasswordCheck() {
		//내용 없음 연결만 함
	}
	
	@RequestMapping("/memberPasswordCheck.do")
	public void memberPasswordCheck(@RequestParam() String memberId,
											@RequestParam() String password,
							    		    HttpServletRequest request,
							    		    HttpServletResponse response,
							    		    Model model) {
		//어디서 넘어왔는지 주소 구하기
		String referer = request.getHeader("Referer");
		String origin = request.getHeader("Origin");
		String url = request.getRequestURL().toString();
		String uri = request.getRequestURI();
		
		System.out.println(referer);
		System.out.println(origin); // http://localhost:9090이 넘어올 수도 있고 null일 수도
		System.out.println(url);
		System.out.println(uri);
		
		if(origin == null) {
			origin = url.replace(uri, "");
		}
		String loc = referer.replace(origin+request.getContextPath(), "");
		String msg = "";
		
		//비밀번호 일치 여부 확인
		Member m = memberService.selectOneMember(memberId);
		boolean bool = bcryptPasswordEncoder.matches(password, m.getPassword());
		
		if(bool) {
			//비밀번호 일치: true
			msg = "비밀번호가 확인되었습니다!";
			model.addAttribute("member", m);
			if("/member/memberInfoUpdatePasswordCheck.do".equals(loc)) {
				loc="/member/memberInfoUpdate.do";
			}
			else if("/member/memberPasswordUpdatePasswordCheck.do".equals(loc)) {
				loc="/member/memberPasswordUpdate.do";
			}
			else if("/member/memberDeletePasswordCheck.do".equals(loc)) {
				loc="/member/memberDelete.do";
			}
		}
		else {
			//로그인 실패
			//비밀번호 불일치: false
			msg = "비밀번호가 일치하지 않습니다!";
		}
		
		request.setAttribute("loc", loc);
		request.setAttribute("msg", msg);
		request.setAttribute("memberId", memberId);
		
		try {
			request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp")
			   	   .forward(request, response);
			
		} catch (ServletException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
	
	@RequestMapping("/memberInfoUpdate.do")
	public void memberInfoUpdate(Member member, Model model) {
		model.addAttribute("member", member);
		
	}
	
	@RequestMapping("/memberInfoUpdateEnd.do")
	public String memberInfoUpdateEnd(Member m, Model model) {
		if(logger.isDebugEnabled()) {
			logger.debug("member@update="+m);	
		}
		
		int result = memberService.memberInfoUpdate(m);
		
		String loc = "/member/memberInfoUpdate.do";
		String msg = result>0?"회원 정보 수정 성공!":"회원 정보 수정 오류 발생: 관리자에게 문의 바랍니다";
		
		if(result>0) {
			m = memberService.selectOneMember(m.getMemberId());
			model.addAttribute("memberLoggedIn", m);
		}
		
		model.addAttribute("loc", loc);
		model.addAttribute("msg", msg);
		
		return "common/msg";
	}
	
	@RequestMapping("/memberPasswordUpdate.do")
	public void memberPasswordUpdate(){
	}
	
	@RequestMapping("/memberPasswordUpdateEnd.do")
	public String memberPasswordUpdateEnd(@RequestParam() String memberId,
							       		   @RequestParam String password,
							       		   Model model) {
		Member member = new Member();
		member.setMemberId(memberId);
		member.setPassword(password);
		
		//비밀번호 암호화 처리
		String rawPassword = member.getPassword();
		String encodedPassword = bcryptPasswordEncoder.encode(rawPassword);
		
		//암호화된 비밀번호로 바꿔 줌
		member.setPassword(encodedPassword);
		
		int result = memberService.memberPasswordUpdate(member);
		
		if(result>0) {
			member = memberService.selectOneMember(memberId);
			model.addAttribute("memberLoggedIn", member);
		}
		
		String loc = "/member/memberPasswordUpdate.do";
		String msg = result>0?"비밀번호 수정 성공!":"비밀번호 수정 오류 발생: 관리자에게 문의 바랍니다";
		
		
		model.addAttribute("loc", loc);
		model.addAttribute("msg", msg);
		
		return "common/msg";
	}
	
	@RequestMapping("/memberDelete.do")
	public void memberDelete(){
	}
	
	@RequestMapping("/memberDeleteEnd.do")
	public String memberDeleteEnd(@RequestParam() String memberId, 
								SessionStatus sessionStatus,
								Model model){
		int result = memberService.deleteMember(memberId);
		
		String loc = result>0?"/":"/member/memberDelete.do";
		String msg = result>0?"성공적으로 탈퇴되었습니다.":"탈퇴 오류 발생: 관리자에게 문의 바랍니다";
		
		if(result>0) {
			if(!sessionStatus.isComplete())
				sessionStatus.setComplete();
		}
		
		model.addAttribute("loc", loc);
		model.addAttribute("msg", msg);
		
		return "common/msg";
	}
	
	@RequestMapping("/memberGrade.do")
	public void memberGrade(@RequestParam() String memberId, Model model) {
		logger.debug("memberId@Controller(memberGrade)="+memberId);
		//총 주문 건수 
		int totalPurchaseCnt = memberService.countTotalPurchase(memberId);
		logger.debug("totalPurchaseCnt=======+"+totalPurchaseCnt);
	
		//총 주문 금액
		//purchase 테이블 말고 ticket 테이블에서 가져와야 함!!!!!!
		int totalPurchasePrice = memberService.priceTotalPurchase(memberId);
		logger.debug("totalPurchasePrice=======+"+totalPurchasePrice);
		
		model.addAttribute("totalPurchaseCnt", totalPurchaseCnt);
		model.addAttribute("totalPurchasePrice", totalPurchasePrice);
	}
	
	@RequestMapping("/ticketList.do")
	public ModelAndView ticketList(@RequestParam(value="cPage", 
							required=false, defaultValue="1") int cPage,
							@RequestParam() String memberId) {
		
		ModelAndView mav = new ModelAndView();
		
		int numPerPage = 10;
		int totalContents = memberService.selectTicketTotalContents(memberId);
		
		List<Purchase> purchaseList = memberService.purchaseList(cPage, numPerPage, memberId);
		
		List<Purchase> deleteList = memberService.deleteTicketList(memberId);
		
		List<Ticket> ticketList = memberService.ticketListByMemberId(memberId);
		
		List<Map<Integer, Integer>> usableList = memberService.selectUsableTicketCnt(memberId);
		
		logger.info("usableListusableList@@@!!!=="+usableList);
		mav.addObject("usableList", usableList);
		mav.addObject("memberId", memberId);
		mav.addObject("purchaseList", purchaseList);
		mav.addObject("ticketList", ticketList);
		mav.addObject("deleteList", deleteList);
		mav.addObject("totalContents", totalContents);
		mav.addObject("numPerPage", numPerPage);
		mav.addObject("cPage", cPage);
		
		return mav;
	}
	
	@RequestMapping("/ticketView.do")
	public ModelAndView ticketView(@RequestParam() int purchaseNo) {
		ModelAndView mav = new ModelAndView();
		
		List<Ticket> ticketList = memberService.ticketList(purchaseNo);
		Purchase p = memberService.selectOnePurchase(purchaseNo);
		List<Ticket> deleteTicketList = memberService.deleteTicketListByPurchaseNo(purchaseNo);
		String renamedFileName = memberService.selectPosterRenamedFileName(ticketList.get(0).getPerformanceNo());
		logger.info("renamedFileName@@@@@@=="+renamedFileName);
		mav.addObject("ticketList", ticketList);
		mav.addObject("renamedFileName", renamedFileName);
		mav.addObject("deleteTicketList", deleteTicketList);
		mav.addObject("p", p);
		
		return mav;
	}
	
	@RequestMapping("/ticketSend.do")
	public ModelAndView ticketSend(@RequestParam int purchaseNo) {
		logger.info("구매번호@@@@@="+purchaseNo);
		
		ModelAndView mav = new ModelAndView();
		
		List<Ticket> ticketList = memberService.ticketList(purchaseNo);
		logger.info("ticketList@@@@@@="+ticketList);
		Purchase p = memberService.selectOnePurchase(purchaseNo);
		
		mav.addObject("ticketList", ticketList);
		mav.addObject("p", p);
		
		return mav;
	}
	
	@RequestMapping("/ticketSendEnd.do")
	public String ticketSendEnd(@RequestParam int ticketNo,
								@RequestParam int purchaseNo,
								@RequestParam String receiverId,
								Model model) {
		//상태 GIFTED로 만들기
		//받은 사람 아이디 채우기
		Ticket t = new Ticket();
		t.setTicketNo(ticketNo);
		t.setReceiverId(receiverId);
		
		int result = memberService.sendTicket(t);
		
		String loc = result>0?"/member/ticketView.do?purchaseNo="+purchaseNo:"/member/ticketSend.do?purchaseNo="+purchaseNo;
		String msg = result>0?receiverId+"님에게 티켓을 선물하셨습니다!":"선물 오류 발생: 관리자에게 문의 바랍니다";
		
		model.addAttribute("loc", loc);
		model.addAttribute("msg", msg);
		
		return "common/msg";
	}
	
	@RequestMapping("/ticketGiftList.do")
	public ModelAndView ticketGiftList(@RequestParam(value="cPage", 
									required=false, defaultValue="1") int cPage,
									@RequestParam String memberId) {
		ModelAndView mav = new ModelAndView();
		
		int numPerPage = 10;
		int totalContents = memberService.selectGiftTotalContents(memberId);
		
		List<Ticket> giftList = memberService.giftList(cPage, numPerPage, memberId);
		List<Purchase> giftPurchaseList = memberService.giftPurchaseList(memberId);
		
		mav.addObject("memberId", memberId);
		mav.addObject("totalContents", totalContents);
		mav.addObject("numPerPage", numPerPage);
		mav.addObject("cPage", cPage);
		mav.addObject("giftPurchaseList", giftPurchaseList);
		mav.addObject("giftList", giftList);
		
		logger.info("giftList@@@="+giftList);
		logger.info("giftPurchaseList@@@="+giftPurchaseList);
		
		return mav;
	}
	
	@RequestMapping("/ticketGiftView")
	public ModelAndView ticketGiftView(@RequestParam() int ticketNo,
									@RequestParam() int purchaseNo) {
		ModelAndView mav = new ModelAndView();
		
		Ticket t = memberService.selectOneTicket(ticketNo);
		Purchase p = memberService.selectOnePurchase(purchaseNo);
		String renamedFileName = memberService.selectPosterRenamedFileName(t.getPerformanceNo());
		
		logger.info("!!!!!!"+t);
		mav.addObject("p", p);
		mav.addObject("t", t);
		mav.addObject("renamedFileName", renamedFileName);
				
		return mav;
	}
	
	@RequestMapping("/findMember.do")
	public void findMember() {
	}
	
	@RequestMapping("/findId.do")
	public String findId(@RequestParam String memberName,
					@RequestParam(value="phone", 
					required=false, defaultValue="") String phone,
					@RequestParam(value="email", 
					required=false, defaultValue="") String email,
					Model model) {
		
		Member m = new Member();
		Member findMember = new Member();
		if(!"".equals(phone)) {
			//폰으로 검사
			m.setPhone(phone);
			m.setMemberName(memberName);
			findMember = memberService.selectOneMemberByPhoneAndName(m);
			
			if(findMember != null) {
				//회원 있음
				model.addAttribute("result", "O");
				model.addAttribute("memberId", findMember.getMemberId());
			}
			else {
				//없음
				model.addAttribute("result", "X");
			}
		}
		else if(!"".equals(email)) {
			//이메일로 찾기
			findMember = memberService.selectOneMemberByEmail(email);
			if(findMember != null && memberName.equals(findMember.getMemberName())) {
				model.addAttribute("result", "O");
				model.addAttribute("memberId", findMember.getMemberId());
			}
			else {
				model.addAttribute("result", "X");
			}
		}
		
		return "member/findMemberEnd";
	}
	
	@RequestMapping("/pointList.do")
	public ModelAndView pointList(@RequestParam(value="cPage", 
								required=false, defaultValue="1") int cPage,
								@RequestParam String memberId) {
		ModelAndView mav = new ModelAndView();
		
		logger.info("cPage@@@@="+cPage);
		int numPerPage = 5;
		int totalContents = memberService.selectPointTotalContents(memberId);
		List<Point> pointList = memberService.pointList(cPage, numPerPage, memberId);
		
		logger.info("pointList@@@="+pointList);
		
		mav.addObject("memberId", memberId);
		mav.addObject("totalContents", totalContents);
		mav.addObject("numPerPage", numPerPage);
		mav.addObject("cPage", cPage);
		mav.addObject("pointList", pointList);
		
		return mav;
	}
	
	@RequestMapping("/ticketDelete.do")
	public ModelAndView ticketDelete(@RequestParam int purchaseNo) {
		ModelAndView mav = new ModelAndView();
		
		List<Ticket> ticketList = memberService.ticketList(purchaseNo);
		logger.info("ticketList@@@@@@="+ticketList);
		Purchase p = memberService.selectOnePurchase(purchaseNo);
		
		mav.addObject("p", p);
		mav.addObject("ticketList", ticketList);
		
		return mav;
	}
	
	@ResponseBody
	@RequestMapping("/deleteTicketEnd.do")
	public Map<String, String> deleteTicketEnd(@RequestBody Ticket ticket){
		Map<String, String> map = new HashMap<>();
		Ticket t = memberService.selectOneTicket(ticket.getTicketList().get(0).getTicketNo());
		Member m = memberService.selectOneMember(t.getMemberId());
		Purchase p = memberService.selectOnePurchase(t.getPurchaseNo());
		int cnt = ticket.getTicketList().size();
		
		int result = 0;
		
		if(p.getUsePoint() != 0 && p.getUsePoint() > 0) {
			//구매에 사용한 포인트가 있다면 회원에게 포인트 환불해 주고
			m.setPoint(m.getPoint() + p.getUsePoint());
			result = memberService.updatePoint(m);
			
			if(result>0) {
				//포인트 내역 업데이트
				Point point = new Point();
				point.setMemberId(t.getMemberId());
				point.setPoint(p.getUsePoint());
				point.setPointMessage("티켓 구매 환불");
				point.setPointStatus("사용");
				result = memberService.insertAccumulatePoint(point);				
				
				p.setUsePoint(0);
				//주문 테이블에 업데이트 하기!!
				result = memberService.updatePurchasePoint(p);
				
				int totalPrice = p.getTotalPrice() - ((t.getPrice()+1000) * cnt);
				p.setTotalPrice(totalPrice);
				memberService.updatePurchaseTotalPrice(p);
			}
		}
		
		logger.info("삭제할ticket={}", ticket.getTicketList());
		int result2 = 0;
		for(int i=0; i<ticket.getTicketList().size(); i++) {
			int tNo = ticket.getTicketList().get(i).getTicketNo();
			int scheduleNo = ticketService.selectScheduleNo(tNo);
			String seatRow = ticketService.selectSeatRow(tNo);
			String seatNo = ticketService.selectSeatNo(tNo);
			System.out.println(scheduleNo);
			System.out.println(seatRow);
			System.out.println(seatNo);
			Map<Object, Object> seatMap = new HashMap<Object, Object>();
			seatMap.put("scheduleNo",scheduleNo);
			seatMap.put("seatRow",seatRow);
			seatMap.put("seatNo",seatNo);
			result2 = ticketService.deleteSeat(seatMap);
		}
		
		


		
		
		result = memberService.deleteTicket(ticket.getTicketList());
		
		
		
		String msg = result>0?"티켓이 성공적으로 취소되었습니다!":"티켓 예매 취소 오류 발생: 관리자에게 문의 바랍니다";
		map.put("msg", msg);
		
		return map;
	}
	
	@GetMapping("/updateMemberLoggedIn.do")
	public ModelAndView updateMemberLoggedIn(String memberId) {
		ModelAndView mav = new ModelAndView();
		
		Member m = memberService.selectOneMember(memberId);
		
		mav.addObject("memberLoggedIn", m);
		
		return mav;
	}
	
	@RequestMapping("/memberSNS.do")
	public void memberSNS() {
		
	}
	
	@RequestMapping("/memberSNSConnect.do")
	public ModelAndView memberSNSConnect(Member m, ModelAndView mav) {
		
		Member checkMember = null;
		String msg = "";
		
		if(!"".equals(m.getfacebookMemberId())) {
			//페이스북 연동
			checkMember = memberService.checkFacebookIdDuplicate(m.getfacebookMemberId());
			if(checkMember != null) {
				msg = "이미 연결된 SNS 계정입니다!";
			}
			else {
				int result = memberService.updateMemberGoogle(m);
				if(result>0) {
					msg = "페이스북 아이디 연결 성공!";
				}
				else {
					msg = "페이스북 연동 오류 발생: 관리자에게 문의 바랍니다.";
				}
			}
		}
		if(!"".equals(m.getGoogleMemberId())) {
			//구글 연동
			checkMember = memberService.checkGoogleIdDuplicate(m.getGoogleMemberId());
			if(checkMember != null) {
				msg = "이미 연결된 SNS 계정입니다!";
			}
			else {
				int result = memberService.updateMemberGoogle(m);
				if(result>0) {
					msg = "구글 아이디 연결 성공!";
				}
				else {
					msg = "구글 연동 오류 발생: 관리자에게 문의 바랍니다.";
				}
			}
		}
		
		Member memberLoggedIn = memberService.selectOneMember(m.getMemberId());		
		String loc = "/member/memberSNS.do";
		
		mav.addObject("loc", loc);
		mav.addObject("msg", msg);
		mav.setViewName("/common/msg");
		
		mav.addObject("memberLoggedIn", memberLoggedIn);
		
		return mav;
	}
	
	@PostMapping("/updateAddress")
	public void updateAddress(@RequestParam("purchaseNo") String purchaseNo,
							 @RequestParam("address") String address,
							 HttpServletResponse response)
							 throws ServletException, IOException{
		logger.info("purchaseNo=="+purchaseNo);
		logger.info("address=="+address);
		
		Map<String, String> map = new HashMap<>();
		map.put("purchaseNo", purchaseNo);
		map.put("address", address);
		
		int result = memberService.updatePurchaseAddress(map);
		String msg = result>0?"O":"X";
		
		response.getWriter().print(msg);
	}
	
	@PostMapping("/checkGoogleIdDuplicate")
	public void checkGoogleIdDuplicate(@RequestParam("googleMemberId") String googleMemberId,
										HttpServletResponse response) throws IOException {
		Member member = memberService.checkGoogleIdDuplicate(googleMemberId);
		
		String msg = "";
		if(member != null) {
			//이미 연동됨
			msg = "X";
		}
		else {
			msg = "O";
		}
		
		response.getWriter().print(msg);
	}
	
	@PostMapping("/checkFacebookIdDuplicate")
	public void checkFacebookIdDuplicate(@RequestParam("facebookMemberId") String facebookMemberId,
										HttpServletResponse response) throws IOException {
		Member member = memberService.checkFacebookIdDuplicate(facebookMemberId);
		
		String msg = "";
		if(member != null) {
			//이미 연동됨
			msg = "X";
		}
		else {
			msg = "O";
		}
		
		response.getWriter().print(msg);
	}
}