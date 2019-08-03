<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<jsp:include page="/WEB-INF/views/member/memberCommon/myPageHeader.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/member/memberPasswordCheck.css" />

<style>
div#myPageDiv table#myPageTable td#memberUpdateIndex{
	/* 현재 선택된 페이지 */
	/* memberUpdateIndex
	memberPasswordUpdateIndex
	memberSnsIndex
	memberDeleteIndex */
	color: rgb(41, 128, 185);
}
</style>

<h2>회원정보 수정</h2>
<hr />
<br /><br />
<form id="memberInfoUpdateForm"
	  action="${pageContext.request.contextPath}/member/memberInfoUpdateEnd.do"
	  method="post"
	  onsubmit="return submitInvalid();">
	<label for="memberId">아이디</label>
	<input type="text" name="memberId" id="memeberId" value="${memberLoggedIn.memberId}" readonly="readonly" />
	<br /><br />
	<label for="memberName">이름</label>
	<input type="text" name="memberName" id="memberName" value="${memberLoggedIn.memberName}" readonly="readonly" />
	<br /><br />
	<label for="gender">성별</label>
	<input type="text" name="gender" id="gender" value="${memberLoggedIn.gender}" readonly="readonly" />
	<br /><br />
	<label for="birthDate">생년월일</label>
	<input type="text" name="birthDate" id="birthDate" value="${memberLoggedIn.birthDate}" readonly="readonly" />
	<br /><br />
	
	<label for="phone">휴대 전화</label>
	<input type="tel" name="phone" id="phone" value="${memberLoggedIn.phone}" placeholder="- 제외하고 입력해 주세요 (01012345678)" required/>
	<br /><br />
	<label for="email">E-mail</label>
	<input type="email" name="email" id="email" value="${memberLoggedIn.email}" required />
	<br /><br />
	
	
	<br /><br /><br />
	<div id="myPageBtnDiv">
		<input type="button" 
			   class="myPageBtn" 
			   id="passwordCheckCancleBtn" 
			   value="취소"
			   onclick="location.href='${pageContext.request.contextPath}/member/memberInfoUpdatePasswordCheck.do'"/>
		&nbsp;
		<input type="submit" class="myPageBtn" id="passwordCheckSubmitBtn" value="확인" />
	</div>
</form>
		
<script>
function submitInvalid(){
	//전화번호 검사
    var regExp4 = /^01[0-9]{9}$/;
    if(!regExpTest(regExp4, "phone", "전화번호를 정확히 입력해 주세요.")){
    	return false;
    }
    
    var regExp5 = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	if(!regExpTest(regExp5, "email", "이메일을 정확히 입력해 주세요.")){
    	return false;
    }
    
    return true;
} 

//유효성 검사용 알림창 띄우는 함수
function regExpTest(regExp, id, msg){
    if(regExp.test(document.querySelector("#"+id).value)){
        return true;
    }
    alert(msg);
    return false;
}
</script>

<jsp:include page="/WEB-INF/views/member/memberCommon/myPageFooter.jsp"/>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>