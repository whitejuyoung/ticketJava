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
			<td id="findMemberResultTd">
				<div id="findIdDiv">
					<h2>TICKET JAVA</h2>
					<div class="findIdContent" id="findIdContentByPhone">
						<c:if test="${result == 'X'}">
							<div class="resultInfoDiv">
								입력된 회원 정보가 존재하지 않습니다.<br />
								비회원일 경우 회원 가입 후 이용해 주세요.
							</div>
							<button type="button" onclick="location.href='${pageContext.request.contextPath}/member/findMember.do'">돌아가기</button>
						</c:if>
						<c:if test="${result == 'O'}">
							<div class="resultInfoDiv">
								회원님의 아이디는 [<span id="memberIdSpan">${memberId}</span>]입니다.
							</div>
							<br />
							<button type="button" onclick="location.href='${pageContext.request.contextPath}/member/findMember.do'">비밀번호 찾기</button>
							<button type="button" id="closePopupBtn">확인</button>
						</c:if>
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


</script>

</body>
</html>