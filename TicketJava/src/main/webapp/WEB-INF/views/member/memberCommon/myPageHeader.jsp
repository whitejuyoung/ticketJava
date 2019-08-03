<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/member/memberPasswordCheck.css" />


<div id="myPageDiv">
	<table id="myPageTable">
	<tr>
		<td class="memberMyPageIndex" 
			id="memberInfoTd"
			onclick="location.href='${pageContext.request.contextPath}/member/memberMyPage.do'">
			<img id="smileImgBox" src="${pageContext.request.contextPath }/resources/images/member/mypage_smile.png" />
				<br /><br />
				<span id="myPageGradeInfo">${memberLoggedIn.memberName}님은 현재
				<br />
				<span id="myPageGrade">
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
				</span>
				등급입니다.</span>
		</td>
		
		<td rowspan="5" id="myPageContentTd">
		
		
