<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/performance/allPerformance.css" />
<div id=performanceContainer>
	<div id=search-result>
		<span>${performanceTitle }</span>에 대한 검색 결과 입니다.	
		<hr />
	</div>
		<c:if test="${!empty list }">
			<!-- 뮤지컬 -->
			<c:if test="${musicalContents ne 0}">
				<div id=performanceContainer-title>
					<span id=performanceContainer-title-kr>뮤지컬 </span> <span id=performanceContainer-title-en>| MUSICAL</span><br />
					<span id=performance-total>총 <span id=performance-total-cnt>${musicalContents }개</span>의 상품이 있습니다.</span><br />
				</div>	
				<c:forEach var="p" items="${list }">
					<c:if test="${p.performanceCode eq 'MU' }">
						<ul class=allPerformanceList>
							<li><img class="allTableImg" src="${pageContext.request.contextPath }/resources/upload/performance/${p.renamedFileName }" onclick="img_click(${p.performanceNo })"/></li>
							<li class="list-title"><strong>${p.performanceTitle }</strong></li>
							<li class="list-date"><span>${p.startDate }</span>~<span>${p.endDate }</span></li>
							<li class="list-place">${p.placeName }</li>
						</ul>
					</c:if>
				</c:forEach>
				<hr />
			</c:if>
			
			<!-- 콘서트 -->
			<c:if test="${concertContents ne 0}">
				<div id=performanceContainer-title>
					<span id=performanceContainer-title-kr>콘서트 </span> <span id=performanceContainer-title-en>| CONCERT</span><br />
					<span id=performance-total>총 <span id=performance-total-cnt>${concertContents }개</span>의 상품이 있습니다.</span><br />
				</div>
				<c:forEach var="p" items="${list }">
					<c:if test="${p.performanceCode eq 'CO' }">
						<ul class=allPerformanceList>
							<li><img class="allTableImg" src="${pageContext.request.contextPath }/resources/upload/performance/${p.renamedFileName }" onclick="img_click(${p.performanceNo })"/></li>
							<li class="list-title"><strong>${p.performanceTitle }</strong></li>
							<li class="list-date"><span>${p.startDate }</span>~<span>${p.endDate }</span></li>
							<li class="list-place">${p.placeName }</li>
						</ul>
					</c:if>
				</c:forEach>
				<hr />
			</c:if>
			
			<!-- 연극 -->
			<c:if test="${playContents ne 0}">
				<div id=performanceContainer-title>
					<span id=performanceContainer-title-kr>연극 </span> <span id=performanceContainer-title-en>| PLAY</span><br />
					<span id=performance-total>총 <span id=performance-total-cnt>${playContents }개</span>의 상품이 있습니다.</span><br />
				</div>
				<c:forEach var="p" items="${list }">	
					<c:if test="${p.performanceCode eq 'TH' }">
						<ul class=allPerformanceList>
							<li><img class="allTableImg" src="${pageContext.request.contextPath }/resources/upload/performance/${p.renamedFileName }" onclick="img_click(${p.performanceNo })"/></li>
							<li class="list-title"><strong>${p.performanceTitle }</strong></li>
							<li class="list-date"><span>${p.startDate }</span>~<span>${p.endDate }</span></li>
							<li class="list-place">${p.placeName }</li>
						</ul>
					</c:if>
				</c:forEach>
				<hr />
			</c:if>
		</c:if>
		
		<!-- 종료된 상품 -->
		<c:if test="${!empty endList }">
			<c:if test="${endContents ne 0}">
				<div id=performanceContainer-title>
					<span id=performanceContainer-title-kr>판매종료 </span> <span id=performanceContainer-title-en>| SALE ENDS</span><br />
					<span id=performance-total>총 <span id=performance-total-cnt>${endContents }개</span>의 상품이 있습니다.</span><br />
				</div>
				<c:forEach var="p" items="${endList }">	
					<ul class=allPerformanceList>
						<li><img class="allTableImg" src="${pageContext.request.contextPath }/resources/upload/performance/${p.renamedFileName }" onclick="img_click(${p.performanceNo })"/></li>
						<li class="list-title"><strong>${p.performanceTitle }</strong></li>
						<li class="list-date"><span>${p.startDate }</span>~<span>${p.endDate }</span></li>
						<li class="list-place">${p.placeName }</li>
					</ul>
				</c:forEach>
			</c:if>
		</c:if>
		
		<!-- 검색결과 없을때 -->
		<c:if test="${empty list && empty endList}">
			<div id=none-search>
				<img src="${pageContext.request.contextPath }/resources/images/performance/none-search-icon.png"/><br />
				<p>검색결과가 없습니다.</p>
			</div>
		</c:if>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>