package com.tj.ticketjava.member.controller;

import java.util.Random;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.tj.ticketjava.member.model.service.MailService;
import com.tj.ticketjava.member.model.service.MemberService;
import com.tj.ticketjava.member.model.vo.Member;

@Controller
public class MailController {
	
	@Autowired
    private MailService mailService;
	@Autowired
    private MemberService memberService;
	
	@Autowired
	BCryptPasswordEncoder bcryptPasswordEncoder;
 
    public void setMailService(MailService mailService) {
        this.mailService = mailService;
    }
    
    // 비밀번호 찾기
    @RequestMapping(value = "/sendMail/password.do", method = RequestMethod.POST)
    public String sendMailPassword(HttpSession session,
    							@RequestParam String memberId,
    							@RequestParam String memberName,
    							@RequestParam String email,
    							Model model) {
       
    	Member m = memberService.selectOneMember(memberId);
    	String loc = "/member/findMember.do";
		String msg = "";
    	if(m != null) {
    		//아이디로 찾은 멤버 있음
    		if(m.getEmail().equals(email)) {
    			//이메일 일치
    			if(m.getMemberName().equals(memberName)) {
    				//이름 일치
    				//이메일 전송
    				int random = new Random().nextInt(100000) + 10000; // 10000 ~ 99999
    	            String password = String.valueOf(random);
    	            String encodedPassword = bcryptPasswordEncoder.encode(password);
    	            
    	            // 해당 유저의 DB정보 변경
    	            m.setPassword(encodedPassword);
    	            int result = memberService.memberPasswordUpdate(m);
    	            
    	            if(result>0) {
    	            	
    	            	String subject = "TicketJava 임시 비밀번호 발급 안내입니다. ";
    	            	StringBuilder sb = new StringBuilder();
    	            	sb.append("귀하의 임시 비밀번호는 ["+ password +"] 입니다.");
    	            	sb.append("\n");
    	            	sb.append(System.getProperty("line.separator"));
    	            	sb.append(System.lineSeparator());
    	            	sb.append("로그인 후 꼭 비밀번호를 변경해 주세요.");
    	            	mailService.send(subject, sb.toString(), "finalticketjava@gmail.com", email, null);
    	            	
    	            	msg = "귀하의 이메일로 임시 비밀번호를 전송하였습니다!";
    	            }
    	            else {
    	            	//비밀번호 변경 실패
    	            	msg = "비밀번호 찾기 실패: 관리자에게 문의해 주세요.";
    	            }
    			}
    			else {
    				//이름 불일치
	            	msg = "입력된 회원 정보가 존재하지 않습니다. 비회원일 경우 회원 가입 후 이용해 주세요.";
    			}
    		}
    		else {
    			//이메일 불일치
    			msg = "입력된 회원 정보가 존재하지 않습니다. 비회원일 경우 회원 가입 후 이용해 주세요.";
    		}
    	}
    	else {
    		//아이디랑 일치하는 멤버 없음
    		msg = "입력된 회원 정보가 존재하지 않습니다. 비회원일 경우 회원 가입 후 이용해 주세요.";
    	}
		
    	model.addAttribute("loc", loc);
		model.addAttribute("msg", msg);
		
        return "common/msg";
    }


}
