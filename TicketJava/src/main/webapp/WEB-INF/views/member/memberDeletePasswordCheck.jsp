<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<jsp:include page="/WEB-INF/views/member/memberCommon/myPageHeader.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/member/memberPasswordCheck.css" />

<style>
div#myPageDiv table#myPageTable td#memberDeleteIndex{
	/* 현재 선택된 페이지 */
	/* memberUpdateIndex
	memberPasswordUpdateIndex
	memberSnsIndex
	memberDeleteIndex */
	color: rgb(41, 128, 185);
}
</style>

<div id="passwordCheckScript">
	<img class="imgBox" id="passwordImgBox" src="${pageContext.request.contextPath }/resources/images/member/mypage_password.png" />
	<br /><br />
	정보를 안전하게 보호하기 위해
	<br />
	<span id="impactSpan">비밀번호를 다시 한 번 </span>확인합니다.
	<br /><br />
	<span class="mypageGuideInfoSpan">비밀번호가 타인에게 노출되지 않게 항상 주의해 주세요.</span>
</div>
<br /><br />
<form id="memberEnrollForm"
	  action="${pageContext.request.contextPath}/member/memberPasswordCheck.do"
	  method="post"
	  onsubmit="return submitInvalid();">
	<label for="memberId">아이디</label>
	<input type="text" name="memberId" id="memeberId" value="${memberLoggedIn.memberId}" readonly="readonly" />
	<br /><br />
	<label for="password">비밀번호</label>
	<input type="password" name="password" id="password" />
	<br /><br /><br />
	<div id="myPageBtnDiv">
		<input type="button" 
			   class="myPageBtn" 
			   id="passwordCheckCancleBtn" 
			   value="취소"
			   onclick="location.href='${pageContext.request.contextPath}/member/memberMyPage.do'"/>
		&nbsp;
		<input type="submit" class="myPageBtn" id="passwordCheckSubmitBtn" value="확인" />
	</div>
</form>

<jsp:include page="/WEB-INF/views/member/memberCommon/myPageFooter.jsp"/>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>