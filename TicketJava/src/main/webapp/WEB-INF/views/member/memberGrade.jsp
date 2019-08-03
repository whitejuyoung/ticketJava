<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/member/memberGrade.css" />

<div id="gradeDiv">
	<h2>등급 혜택</h2>
	<br />
	<div id="memberGradeDiv">
		<table id="memberGradeTable">
			<tr id="memberGradeTabelTopTr">
				<td rowspan="3">
					<img id="smileImgBox" width="70px" src="${pageContext.request.contextPath}/resources/images/member/mypage_smile.png"/>
				</td>
				
				<td class="memberGradeBorder" id="memberGradeInfo">
					<span id="memberGradeTd-memberName">${memberLoggedIn.memberName}</span>님의 회원 등급은
					<span id="memberGradeTd-grade">
						<c:choose>
							<c:when test="${memberLoggedIn.memberGrade eq 'S'}">
								SILVER
							</c:when>
							<c:when test="${memberLoggedIn.memberGrade eq 'G'}">
								GOLD
							</c:when>
							<c:when test="${memberLoggedIn.memberGrade eq 'P'}">
								FLATINUM
							</c:when>
							<c:otherwise>
								DIAMOND
							</c:otherwise>
						</c:choose>
					</span>입니다.
				</td>
				
				<td class="memberPointInfoTd"><span id="memberPointInfo">POINT</span></td>
				<td class="memberPointInfoTd"><fmt:formatNumber value="${memberLoggedIn.point}" pattern="#,###"/>p</td>
			</tr>
			<tr id="memberGradeTr2">
				<td class="memberGradeBorder">
					주문 ${totalPurchaseCnt}건 &nbsp;&nbsp; | &nbsp;&nbsp;주문금액 <fmt:formatNumber value="${memberLoggedIn.totalPrice}" pattern="#,###"/>원
					
				</td>
				<td colspan="2"></td>
			</tr>
			
			<tr>
				<td class="memberGradeBorder">
					<button id="purchaseBtn" onclick="location.href='${pageContext.request.contextPath}/member/ticketList.do?memberId=${memberLoggedIn.memberId}'">구매 실적 상세 보기 > </button>
				</td>
				<td colspan="2">
					<button id="pointBtn" onclick="location.href='${pageContext.request.contextPath}/member/pointList.do?memberId=${memberLoggedIn.memberId}'">전체 point 내역 보기 > </button>
				</td>
			</tr>
		</table>
	</div>
	<br /><br /><br />
	<hr />
	<h2>등급별 혜택 안내</h2>
	<img id="smileImgBox" width="900px" src="${pageContext.request.contextPath}/resources/images/member/grade.png"/>
	
</div>




<jsp:include page="/WEB-INF/views/common/footer.jsp"/>

