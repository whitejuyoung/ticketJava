package com.tj.ticketjava.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.tj.ticketjava.member.model.vo.Member;


public class LoginInterceptor extends HandlerInterceptorAdapter{
	//알트 시프트 S + V 하면 어떤 메소드를 오버라이딩 할 수 있는지 보여 줌

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		Member memberLoggedIn = (Member)session.getAttribute("memberLoggedIn");
		if(memberLoggedIn == null) {		
			
			String referer = request.getHeader("Referer");
			String origin = request.getHeader("Origin");
			String url = request.getRequestURL().toString();
			String uri = request.getRequestURI();
			
			System.out.println(referer);
			System.out.println(origin); // http://localhost:9090이 넘어올 수도 있고 null일 수도
			System.out.println(url);
			System.out.println(uri);
			
			/*http://localhost:9090/spring/board/boardList.do
			null
			http://localhost:9090/spring/board/boardForm.do
			/spring/board/boardForm.do*/
			
			//referer에서 /board/boardList.do 이것만 추출해내야 됨
			
			if(origin == null) {
				origin = url.replace(uri, "");
			}
			String loc = referer.replace(origin+request.getContextPath(), "");
			
			request.setAttribute("msg", "로그인을 먼저 해 주세요~!");
			request.setAttribute("loc", loc);
			request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp")
				   .forward(request, response);
						
			//꼭 리턴 false 적어 줘야 다음으로 진행이 안 됨
			return false;
		}
		
		//로그인은 글쓰기 하기 전에 인터셉터 해서 검사해야 하므로 preHandle만 오버라이딩 할 것
		//무조건 true를 리턴함
		//중간에 막고 싶다면 이전에 중간에서 false 리턴하면 됨
		return super.preHandle(request, response, handler);
		
		//다 작성한 후 인터셉터로 등록해 줘야 함 servlet-context.xml에서
	}
}
