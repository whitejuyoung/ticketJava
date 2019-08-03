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

div#myPageDiv table#myPageTable td input#passwordCheckSubmitBtn{
	border-color: rgb(192, 57, 43);
	background: rgb(192, 57, 43);
}
div#myPageDiv table#myPageTable img.imgBox{
	width: 300px;
}
</style>

<h2>회원 탈퇴</h2>
<div id="passwordCheckScript">
	<hr /><br />
	<img class="imgBox" id="passwordImgBox" src="${pageContext.request.contextPath }/resources/images/member/ticketjava_enroll.png" />
	<br /><br />
	정말로
	<span id="impactSpan">탈퇴</span>하시겠어요?
</div>
<br /><br />
<form action="${pageContext.request.contextPath}/member/memberDeleteEnd.do"
	  method="post">
	<input type="hidden" name="memberId" value="${memberLoggedIn.memberId}"/>
	<div id="myPageBtnDiv">
		<input type="button" 
			   class="myPageBtn" 
			   id="passwordCheckCancleBtn" 
			   value="취소"
			   onclick="location.href='${pageContext.request.contextPath}/member/memberDeletePasswordCheck.do'"/>
		&nbsp;
		<input type="submit" class="myPageBtn" id="passwordCheckSubmitBtn" value="확인" />
	</div>
</form>

<jsp:include page="/WEB-INF/views/member/memberCommon/myPageFooter.jsp"/>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>