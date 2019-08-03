<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/performance/allPerformance.css" />

<script>
function img_click(performanceNo){
	location.href="${pageContext.request.contextPath }/performance/performanceView?performanceNo="+performanceNo;
}
</script>

<div id=performanceContainer>
	<div id=performanceContainer-title>
		<span id=performanceContainer-title-kr>연극 </span> <span id=performanceContainer-title-en>| PLAY</span><br />
		<span id=performance-total>총 <span id=performance-total-cnt>${totalContents }개</span>의 상품이 있습니다.</span><br />
	</div>
	<div id="performanceList-container">
		<c:forEach var="p" items="${list }">
			<ul class=allPerformanceList>
				<li><img class="allTableImg" src="${pageContext.request.contextPath }/resources/upload/performance/${p.renamedFileName }" onclick="img_click(${p.performanceNo })"/></li>
				<li class="list-title"><strong>${p.performanceTitle }</strong></li>
				<li class="list-date"><span>${p.startDate }</span>~<span>${p.endDate }</span></li>
				<li class="list-place">${p.placeName }</li>
			</ul>
		</c:forEach>
	</div>
	
	<!-- 페이지바 -->
	<div id="ticketListPageBarDiv">
		<%
			int totalContents = Integer.parseInt(String.valueOf(request.getAttribute("totalContents")));
			int numPerPage = Integer.parseInt(String.valueOf(request.getAttribute("numPerPage")));
			int cPage = Integer.parseInt(String.valueOf(request.getAttribute("cPage")));
			
		%>
		<%= com.tj.ticketjava.common.util.Utils.getPageBar(totalContents, cPage, numPerPage, "allConcert.do?o=o")%>
	</div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>