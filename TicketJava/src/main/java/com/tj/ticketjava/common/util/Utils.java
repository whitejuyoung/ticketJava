package com.tj.ticketjava.common.util;

public class Utils {
	
	public static String getPageBar(int totalContents, 
									int cPage,
									int numPerPage,
									String url) {
		
		String pageBar = "";
		
		//페이지바에 표시할 페이지 수
		int pageBarSize = 5;
		
		//총 페이지 수 공식
		int totalPage = (int)Math.ceil((double)totalContents/numPerPage);
		
		//pageBar 순회용 변수
		int pageNo = ((cPage-1)/pageBarSize) * pageBarSize + 1;
		
		//마지막 페이지 번호
		int pageEnd = pageNo + pageBarSize - 1 ;
		
		pageBar += "<ul class='ticketListPageBar'>";
		//[이전] section
		if(pageNo == 1) {
			pageBar += "<li class='ticketListPageBar-disabled'>";
			pageBar += "<a href='#'>이전</a>";
			pageBar += "</li>";
		}
		else {
			pageBar += "<li class='ticketListPageBar-prev'>";
			pageBar += "<a href='javascript:paging("+(pageNo-1)+")'>이전</a>";
			pageBar += "</li>";
		}
		
		//pageNo section
		while(!(pageNo>pageEnd || pageNo>totalPage)) {
			//현재 페이지인 경우
			if(pageNo == cPage) {
				pageBar += "<li class='ticketListPageBar-page-cPage'>";
				pageBar += "<a>"+pageNo+"</a>";
				pageBar += "</li>";
			}
			else {
				pageBar += "<li class='ticketListPageBar-page'>";
				pageBar += "<a href='javascript:paging("+(pageNo)+")'>"+pageNo+"</a>";
				pageBar += "</li>";
			}
			
			pageNo ++;
		}
		
		//[다음] section
		//다음 페이지가 없는 경우
		if(pageNo > totalPage) {
			pageBar += "<li class='ticketListPageBar-disabled'>";
			pageBar += "<a href='#'>다음</a>";
			pageBar += "</li>";
		}
		else {
			pageBar += "<li class='ticketListPageBar-next'>";
			pageBar += "<a href='javascript:paging("+(pageNo)+")'>다음</a>";
						//pageNo + 1 안 해 줘도 되는 이유는 위에서 반복문 돌리면서 +1 돼서 내려옴
			pageBar += "</li>";
		}
		
		pageBar += "</ul>";
		
		
		//paging 함수
		pageBar += "<script>";
		pageBar += "function paging(cPage){";
		pageBar += "	location.href ='"+url+"&cPage='+cPage;";
					//url은 현재 자바변수
		pageBar += "}";
		pageBar += "</script>";
		
		return pageBar;
	}
}
