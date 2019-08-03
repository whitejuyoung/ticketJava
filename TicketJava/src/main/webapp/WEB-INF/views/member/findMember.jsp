<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 비밀번호 찾기</title>
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.4.0.js"></script>
<!-- 사용자작성 css -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/member/findMember.css" />
</head>
<body>

<div id="findMemberDiv">
	<table id="findMemberTable">
		<tr>
			<td id="findIdTd">
				<div id="findIdDiv">
					<h2>&nbsp;&nbsp;&nbsp;아이디 찾기</h2>
					<div class="findIdTitle" id="findIdByPhone">전화번호로 찾기</div>
					<div class="findIdContent" id="findIdContentByPhone">
						<form id="findIdByPhoneForm"
							  action="${pageContext.request.contextPath}/member/findId.do"
							  method="post"
							  onsubmit="return submitInvalidPhone();">
							<input type="text" id="memberNameByPhone" name="memberName" placeholder="이름"/>
							<br />
							<input type="tel" id="phone" name="phone" placeholder="전화번호 (- 없이 입력)"/>
							<br />
							<button type="submit">확인</button>
						</form>
					</div>
					<div class="findIdTitle" id="findIdByEmail">이메일로 찾기</div>
					<div class="findIdContent">
						<form id="findIdByEmailForm"
							  action="${pageContext.request.contextPath}/member/findId.do"
							  method="post"
							  onsubmit="return submitInvalidEmail();">
							<input type="text" id="memberNameByEmail" name="memberName" placeholder="이름"/>
							<br />
							<input type="email" id="email" name="email" placeholder="이메일"/>
							<br />
							<button type="submit">확인</button>
						</form>
					</div>
				</div>
			</td>
			<td id="findPasswordTd">
				<div id="findPasswordDiv">
					<h2>&nbsp;&nbsp;&nbsp;비밀번호 찾기</h2>
					<div class="findPasswordContent">
						<form id="findPasswordForm"
							  action="${pageContext.request.contextPath}/sendMail/password.do"
							  method="post"
							  onsubmit="return submitInvalid();">
							<input type="text" id="memberNameForFindPassword" name="memberName" placeholder="이름"/>
							<br />
							<input type="text" id="memberIdForFindPassword" name="memberId" placeholder="아이디"/>
							<br />
							<input type="email" id="emailForFindPassword" name="email" placeholder="이메일"/>
							<br />
							<button type="submit">비밀번호 찾기</button>
						</form>
					</div>
				</div>
			</td>
		</tr>
	</table>
</div>

<script>
$("div.findIdTitle").click(function(){
	var target = $(this);
	
	$("div.findIdTitle").next().each(function(){
		if($(this).is(target.next())){
		    $(this).slideToggle();
		}
		else{
		    $(this).slideUp();
		}
    });
	
});

function submitInvalidPhone(){
	if($("input#memberNameByPhone").val().trim().length == 0){
		alert("이름을 입력하세요.");
		$("input#memberNameByPhone").focus();
		return false;
	}
	if($("input#phone").val().trim().length == 0){
		alert("전화번호를 입력하세요.");
		$("input#phone").focus();
		return false;
	}
	
	return true;
}

function submitInvalidEmail(){
	if($("input#memberNameByEmail").val().trim().length == 0){
		alert("이름을 입력하세요.");
		$("input#memberNameByEmail").focus();
		return false;
	}
	if($("input#email").val().trim().length == 0){
		alert("이메일을 입력하세요.");
		$("input#email").focus();
		return false;
	}
	return true;
}

function submitInvalid(){
	if($("input#memberNameForFindPassword").val().trim().length == 0){
		alert("이름을 입력하세요.");
		$("input#memberNameForFindPassword").focus();
		return false;
	}
	
	if($("input#memberIdForFindPassword").val().trim().length == 0){
		alert("아이디를 입력하세요.");
		$("input#memberIdForFindPassword").focus();
		return false;
	}
	
	if($("input#emailForFindPassword").val().trim().length == 0){
		alert("이메일을 입력하세요.");
		$("input#emailForFindPassword").focus();
		return false;
	}
	
	return true;
}


</script>

</body>
</html>