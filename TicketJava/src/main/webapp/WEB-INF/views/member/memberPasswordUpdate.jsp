<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<jsp:include page="/WEB-INF/views/member/memberCommon/myPageHeader.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/member/memberPasswordCheck.css" />

<style>
div#myPageDiv table#myPageTable td#memberPasswordUpdateIndex{
	/* 현재 선택된 페이지 */
	/* memberUpdateIndex
	memberPasswordUpdateIndex
	memberSnsIndex
	memberDeleteIndex */
	color: rgb(41, 128, 185);
}
</style>

<h2>비밀번호 변경</h2>
<hr />
<br /><br />

<div id="passwordCheckScript">
	<img class="imgBox" id="passwordImgBox" src="${pageContext.request.contextPath }/resources/images/member/mypage_password.png" />
	<br /><br />
	주기적인 <span id="impactSpan">비밀번호 변경</span>을 통해<br />
	개인정보를 안전하게 보호하세요.
	<br /><br /><br />
	
	<form id="memberPasswordUpdateForm"
	  action="${pageContext.request.contextPath}/member/memberPasswordUpdateEnd.do"
	  method="post"
	  onsubmit="return submitInvalid();">
		<input type="hidden" name="memberId" id="memeberId" value="${memberLoggedIn.memberId}" readonly="readonly" />
		
		<input type="password" name="password" id="password" placeholder="새 비밀번호" required/>
		<br /><br />
		<input type="password" name="passwordCheck" id="passwordCheck" placeholder="새 비밀번호 확인" required/>
		<br /><br />
		<span class="mypageGuideInfoSpan">비밀번호는 영문, 숫자, 특수문자를 조합하여 8~15자까지 만들어 주세요.</span>
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

</div>


		
<script>
function submitInvalid(){
	//3.비밀번호 검사
    //숫자/문자/특수문자 포함 형태의 8~15자리 이내의 암호 정규식 
    var regExp2 = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g;
    //전체길이검사 /(?=^.{8,15}$)/
    //숫자하나 반드시 포함 /(?=.*\d)/ 또는  (?=\d)
    //영문자 반드시 포함 /(?=.*[a-zA-Z])/
    //특수문자 반드시 포함  /(?=.*[^a-zA-Z0-9])/
    //앞뒤에 ^.* .*$를 반드시 작성해야 한다.
    if(!regExpTest(regExp2, "password", "비밀번호는 8~15자리 숫자/문자/특수문자를 포함해야 합니다.")){
        return false;
        
    }
    
  //비밀번호일치여부 검사
    var pwd = document.getElementById("password");
    var pwdcheck = document.getElementById("passwordCheck");
    if(pwd.value != pwdcheck.value){
    	alert("비밀번호가 일치하지 않습니다.");
    	pwd.select();
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