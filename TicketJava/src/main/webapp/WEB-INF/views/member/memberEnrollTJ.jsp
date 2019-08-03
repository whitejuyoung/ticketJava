<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/member/memberEnrollTJ.css" />

<div id="memberEnrollDiv">
<form id="memberEnrollForm"
	  action="${pageContext.request.contextPath}/member/memberEnrollEnd.do"
	  method="post"
	  onsubmit="return submitInvalid();">

	<h2 id="memberEnrollDiv-Title">회원가입</h2>
	<hr />
	<h6 class="memberEnrollDiv-infoTitle"><span id="span-EnrollNecessaryInfo-span">필수 </span>정보 입력</h6>
		<table class="memberEnrollTable" id="memberEnrollTable-first">
			<tr>
				<th>아이디</th>
				<td>
					<input type="text" id="memberId" name="memberId" placeholder="띄어쓰기 없는 영문, 숫자로만 4~12자" required/>
					<input type="button" value="중복 확인" id="idDuplicateCheckBtn" onclick="checkIdDuplicate();"/>
					<input type="hidden" id="isValid" value="0"/>
					<input type="hidden" value="${googleMemberId}" name="googleMemberId"/>
					<input type="hidden" value="${facebookMemberId}" name="facebookMemberId"/>
					<input type="hidden" value="${kakaoMemberId}" name="kakaoMemberId"/>
				</td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td>
					<input type="password" id="password" name="password" required/>
					<div class="memberEnrollGuideDiv">
						<span class="memberEnrollGuideSpan" id="passwordGuideSpan">
							영문, 숫자, 특수문자를 조합하여 8~15자까지 설정해 주세요.
						</span>
					</div>
					
				</td>
			</tr>
			<tr>
				<th>비밀번호 확인</th>
				<td>
					<input type="password" id="passwordCheck" required/>
					<div class="memberEnrollGuideDiv">
							<span class="memberEnrollGuideSpan" id="passwordCheckGuideSpan">
							</span>
					</div>
				</td>
			</tr>
			<tr>
				<th>이름</th>
				<td><input type="text" id="memberName" name="memberName" value="${memberName}" required/></td>
			</tr>
		</table>
		
		<table class="memberEnrollTable" id="memberEnrollTable-second">
			<tr>
				<th>휴대 전화</th>
				<td><input type="tel" id="phone" name="phone" placeholder="- 제외하고 입력해 주세요 (01012345678)" required/></td>
			</tr>
			<tr>
				<th>E-mail</th>
				<td>
					<input type="email" id="email" name="email" value="${email}" <c:if test="${email!=''}">readonly</c:if> required/>
				<input type="button" value="중복 확인" id="emailDuplicateCheckBtn" onclick="checkEmailDuplicate();"/>
					<input type="hidden" id="emailIsValid" value="0"/>
				</td>
			</tr>
			<tr>
				<th>성별</th>
				<td>
					<input type="radio" name="gender" id="genderF" value="F" checked/>
					<label for="genderF">여자</label>
					<input type="radio" name="gender" id="genderM" value="M"/>
					<label for="genderM">남자</label>
				</td>
			</tr>
			<tr>
				<th>생년월일</th>
				<td>
					<input type="date" name="birthDate" id="birthDate" required/>
				</td>
			</tr>
		</table>
	
	
	<h6 class="memberEnrollDiv-infoTitle"><span id="span-EnrollChoiceInfo-span">선택 </span>정보 입력</h6>
		<table class="memberEnrollTable" id="memberEnrollTable-third">
			<tr>
				<th>추천인</th>
				<td>
					<input type="text" id="recommendId" name="recommendId"/>
					<input type="button" value="아이디 확인" id="recommendIdCheckBtn" onclick="recommendIdCheck();"/>
				</td>
			</tr>
		</table>

	<input type="submit" value="회원가입" id="memberEnrollBtn"/>
	

</form>
</div>

<script>
function submitInvalid(){
	//유효성 검사 시작
	//1.아이디
	var regExp1 = /^[a-z\d]{4,12}$/;
    if(!regExpTest(regExp1, "memberId", "사용자 아이디가 부적합합니다.")){
         return false;
    }
    
    //2.아이디 중복 검사
	var isValid = $("#isValid").val();
	if(isValid == "0"){
		alert("아이디 중복 검사를 해 주세요.");
		return false;
	}
	
	//이메일 중복 검사
	var emailIsValid = $("#emailIsValid").val();
	if(emailIsValid == "0"){
		alert("이메일 중복 검사를 해 주세요.");
		return false;
	}
	
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
	
  	//4.이름 검사 : 한글2글자 이상만 허용. 
    var regExp3 = /^[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]{2,}$/;
    if(!regExpTest(regExp3, "memberName", "이름을 정확히 입력해 주세요.")){
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
    
    //전화번호 검사
    var regExp4 = /^01[0-9]{9}$/;
    if(!regExpTest(regExp4, "phone", "전화번호를 정확히 입력해 주세요.")){
    	return false;
    }
    
    //이메일 검사
	<%--/ / 안에 있는 내용은 정규표현식 검증에 사용되는 패턴이 이 안에 위치함
	/ /i 정규표현식에 사용된 패턴이 대소문자를 구분하지 않도록 i를 사용함
	^ 표시는 처음시작하는 부분부터 일치한다는 표시임
	[0-9a-zA-Z] 하나의 문자가 []안에 위치한 규칙을 따른다는 것으로 숫자와 알파벳 소문지 대문자인 경우를 뜻 함
	* 이 기호는 0또는 그 이상의 문자가 연속될 수 있음을 말함--%>
    var regExp5 = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;

    if(!regExpTest(regExp5, "email", "이메일을 정확히 입력해 주세요.")){
    	return false;
    }
    
    jqueryLoading();
    
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

//비밀번호 유효성 검사 충족 못 하면 가이드 안내문 띄움
//비밀번호 유효성 검사 충족하면 O 띄움
//숫자/문자/특수문자 포함 형태의 8~15자리 이내의 암호 정규식 
$("#password").keyup(function(){
	var regExp = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g;
	if(!regExp.test(document.querySelector("#password").value)){
		$("span#passwordGuideSpan").html("영문, 숫자, 특수문자를 조합하여 8~15자까지 설정해 주세요.");
		$("span#passwordGuideSpan").css("color", "red")
								   .css("font-weight", "normal");
	}
	else{
		$("span#passwordGuideSpan").html("&nbsp;&nbsp;O");
	    $("span#passwordGuideSpan").css("color", "blue")
	    						   .css("font-weight", "bold");
	}
});

//비밀번호 확인 틀리면 비밀번호 재확인 문구 띄움
//비밀번호 확인 일치하면 아무것도 안 뜸
$("#passwordCheck").keyup(function(){
    var pwd = document.getElementById("password");
    var pwdcheck = document.getElementById("passwordCheck");

    if(pwd.value == pwdcheck.value){
    	$("span#passwordCheckGuideSpan").html("");
        return true;
    }
    else{
    	$("span#passwordCheckGuideSpan").html("비밀번호 재확인");
    	$("span#passwordCheckGuideSpan").css("color", "red")
    }
});

$("#password").keyup(function(){
    var pwd = document.getElementById("password");
    var pwdcheck = document.getElementById("passwordCheck");

    if(pwd.value == pwdcheck.value){
    	$("span#passwordCheckGuideSpan").html("");
        return true;
    }
    else{
    	$("span#passwordCheckGuideSpan").html("비밀번호 재확인");
    	$("span#passwordCheckGuideSpan").css("color", "red").css("font-weight", "bold")
    }
});


//아이디, 이메일 수정하면 중복 검사 다시 해야 됨
$("#memberId").keyup(function(){
	$("#isValid").val("0");
});
$("#email").keyup(function(){
	$("#emailIsValid").val("0");
});

//아이디 중복 검사 버튼 클릭
function checkIdDuplicate(){
	var regExp1 = /^[a-z\d]{4,12}$/;
    if(!regExpTest(regExp1, "memberId", "사용자 아이디가 부적합합니다.")){
         return false;
    }
	
    var param = {
    	memberId : $("#memberId").val()		
    }
    
	$.ajax({
		url: "${pageContext.request.contextPath}/member/checkIdDuplicate.do",
		data: param,
		type: "get",
		success: function(data){
			if(data == "true"){
				//아이디 사용 가능
				$("#isValid").val("1");
				alert("사용 가능한 아이디입니다!");
			}
			else{
				//아이디 이미 존재
				$("#isValid").val("0");
				alert("이미 존재하는 아이디입니다.");
			}
		},
		error: function(jqxhr, textStatus, errorThrown){
			console.log("ajax 처리 실패ㅠ~!~!");
			console.log(jqxhr);
			console.log(textStatus);
			console.log(errorThrown);
		}
	});
}

//이메일 중복 검사 버튼 클릭
function checkEmailDuplicate(){
	var regExp5 = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	if(!regExpTest(regExp5, "email", "이메일을 정확히 입력해 주세요.")){
    	return false;
    }
	
    var param = {
    	email : $("#email").val()		
    }
    
	$.ajax({
		url: "${pageContext.request.contextPath}/member/checkEmailDuplicate.do",
		data: param,
		type: "get",
		success: function(data){
			if(data.msg == "O"){
				//이메일 사용 가능
				$("#emailIsValid").val("1");
				alert("사용 가능한 이메일입니다!");
			}
			else{
				//이메일 이미 존재
				$("#emailIsValid").val("0");
				alert("이미 사용 중인 이메일입니다.");
			}
		},
		error: function(jqxhr, textStatus, errorThrown){
			console.log("ajax 처리 실패ㅠ~!~!");
			console.log(jqxhr);
			console.log(textStatus);
			console.log(errorThrown);
		}
	});
}

//추천인 아이디 확인 버튼 클릭
function recommendIdCheck(){
	if($("input#recommendId").val().trim().length == 0){
		alert("추천인 아이디를 입력하세요.");
		$("input#recommendId").focus();
		return false;
	}
	
	var param = {
	    	memberId : $("#recommendId").val()			
	}
	    
		$.ajax({
			url: "${pageContext.request.contextPath}/member/checkIdDuplicate.do",
			data: param,
			type: "get",
			success: function(data){
				if(data == "true"){
					//없는 아이디
					alert("존재하지 않는 회원입니다.");
				}
				else{
					//있는 아이디
					alert("아이디가 확인되었습니다!");
				}
			},
			error: function(jqxhr, textStatus, errorThrown){
				console.log("ajax 처리 실패ㅠ~!~!");
				console.log(jqxhr);
				console.log(textStatus);
				console.log(errorThrown);
			}
		});
}

</script>



<jsp:include page="/WEB-INF/views/common/footer.jsp"/>