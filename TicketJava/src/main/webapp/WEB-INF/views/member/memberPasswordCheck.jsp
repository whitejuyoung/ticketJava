<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/member/memberPasswordCheck.css" />


<!-- 이거 왜 있는 건지...? -->
<div id="myPageDiv">
	<table id="myPageTable">
	<tr>
		<td class="memberMyPageIndex" id="memberInfoTd">
			<img id="smileImgBox" src="${pageContext.request.contextPath }/resources/images/member/mypage_smile.png" />
				<br /><br />
				<span id="myPageGradeInfo">${memberLoggedIn.memberName}님은
				<br />
				현재
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
			<h2>비밀번호 인증</h2>
			<div id="passwordCheckScript">
				<hr /><br />
				<img class="imgBox" id="passwordImgBox" src="${pageContext.request.contextPath }/resources/images/member/mypage_password.png" />
				<br /><br />
				정보를 안전하게 보호하기 위해
				<br />
				<span id="impactSpan">비밀번호를 다시 한 번 </span>확인합니다
				<br /><br />
				<span class="mypageGuideInfoSpan">비밀번호가 타인에게 노출되지 않게 항상 주의해 주세요</span>
			</div>
			<br /><br />
			<form action="">
				<label for="memberId">아이디</label>&nbsp;&nbsp;
				<input type="text" name="memberId" id="memeberId" value="${memberLoggedIn.memberId}" readonly="readonly" />
				<br /><br />
				<label for="password">비밀번호</label>
				<input type="password" name="password" id="password" />
			</form>
		</td>
	</tr>
	<tr>
		<td class="memberMyPageIndex" id="memberUpdateIndex">
			회원정보 수정
		</td>
	</tr>
	<tr>
		<td class="memberMyPageIndex" id="memberPasswordUpdateIndex">
			비밀번호 변경
		</td>
	</tr>
	<tr>
		<td class="memberMyPageIndex" id="memberSnsIndex">
			SNS 연결 설정
		</td>
	</tr>
	<tr>
		<td class="memberMyPageIndex" id="memberDeleteIndex">
			회원 탈퇴
		</td>
	</tr>
	</table>

</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>