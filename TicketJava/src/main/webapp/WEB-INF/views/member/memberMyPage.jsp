<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/member/memberMyPage.css" />

<div id="myPageDiv">
	<table id="myPageTable">
		<tr>
			<td colspan="2">
				<img id="smileImgBox" src="${pageContext.request.contextPath }/resources/images/member/mypage_smile.png" />
				<br /><br />
				<span id="myPageGradeInfo">${memberLoggedIn.memberName}님은 현재
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
				<br /><br />
				<hr />
				<br />
				<a href="${pageContext.request.contextPath}/member/memberGrade.do?memberId=${memberLoggedIn.memberId}">등급별 혜택 보기</a>
			</td>
		</tr>
		<tr>
			<td class="pointerTd" onclick="location.href='${pageContext.request.contextPath}/member/memberInfoUpdatePasswordCheck.do'">
				<img class="imgBox" id="passwordImgBox" src="${pageContext.request.contextPath }/resources/images/member/mypage_password.png" />
				<div class="mypageGuideDiv">
					<span class="mypageGuideTitleSpan">회원정보 수정</span>
					<br /><br />
					<span class="mypageGuideInfoSpan">
						휴대 전화 번호, 이메일 등
						<br />
						내 정보를 수정하세요
					</span>
				</div>
			</td>
			<td class="pointerTd" onclick="location.href='${pageContext.request.contextPath}/member/memberPasswordUpdatePasswordCheck.do'">
				<img class="imgBox" id="passwordImgBox" src="${pageContext.request.contextPath }/resources/images/member/mypage_password.png" />
				<div class="mypageGuideDiv">
					<span class="mypageGuideTitleSpan">비밀번호 변경</span>
					<br /><br />
					<span class="mypageGuideInfoSpan">
						주기적인 변경으로
						<br />
						내 정보를 보호하세요
					</span>
				</div>
			</td>
		</tr>
		<tr>
			<td class="pointerTd" onclick="location.href='${pageContext.request.contextPath}/member/memberSNS.do'">
				<img class="imgBox" id="passwordImgBox" src="${pageContext.request.contextPath }/resources/images/member/mypage_sns.png" />
				<div class="mypageGuideDiv">
					<span class="mypageGuideTitleSpan">SNS 연결 설정</span>
					<br /><br />
					<span class="mypageGuideInfoSpan">
						페이스북, 카카오톡, 구글로
						<br />
						간편하게 로그인하세요
					</span>
				</div>
			</td>
			<td class="pointerTd" onclick="location.href='${pageContext.request.contextPath}/member/memberDeletePasswordCheck.do'">
				<img class="imgBox" id="passwordImgBox" src="${pageContext.request.contextPath }/resources/images/member/mypage_delete.png" />
				<div class="mypageGuideDiv">
					<span class="mypageGuideTitleSpan">회원 탈퇴</span>
					<br /><br />
					<span class="mypageGuideInfoSpan">
						티켓자바를 이용해 주셔서
						<br />
						감사했습니다!
					</span>
				</div>
			</td>
		</tr>
	</table>
</div>


<jsp:include page="/WEB-INF/views/common/footer.jsp"/>