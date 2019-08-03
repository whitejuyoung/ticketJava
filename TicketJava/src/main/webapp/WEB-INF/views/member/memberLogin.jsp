<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/member/memberLogin.css" />

<%
	//쿠키 관련 처리
	Cookie[] cookies = request.getCookies();
	boolean saveIdFlag = false;
	String memberIdSaved = "";
	
	if(cookies != null){
		for(Cookie c: cookies){
			String key = c.getName();
			String value = c.getValue();
			if("saveId".equals(key)){
				saveIdFlag = true;
				memberIdSaved = value;
			}
		}
	}
%>

<!-- 카카오톡 로그인 -->
<script type='text/javascript'>
 //<![CDATA[
   // 사용할 앱의 JavaScript 키를 설정해 주세요.
   Kakao.init('b0324449782ac528ee7c3b8a7689f174');
   function loginWithKakao() {
     // 로그인 창을 띄웁니다.
     Kakao.Auth.login({
       success: function(authObj) {
           Kakao.API.request({
               url: '/v1/user/me',
               success: function(res) {
                console.log(res);
                var kakaoMemberId = res.id;      //유저의 카카오톡 고유 id
                var email = res.kaccount_email;   //유저의 이메일
                var name = res.properties.nickname; //유저가 등록한 별명
                console.log(kakaoMemberId);
                console.log(email);
                console.log(name);
                
                    $.ajax({
                       url:"${pageContext.request.contextPath}/member/memberLoginSNSforKakao.do",
                       data: {kakaoMemberId:kakaoMemberId},
                       dataType:"json",
                       success:function(data){
                           console.log(data);
                           if(data.result === "0"){
                               alert("회원가입 페이지에서 SNS로 회원가입을 해 주세요!");                             
                           }
                           else{
                               location.href="${pageContext.request.contextPath}/";
                           }
                       },
                       error: function(jqxhr){
                            console.log("ajax 처리 실패:"+jqxhr.status);
                       }
                    });
                
                },
               fail: function(error) {
                alert(JSON.stringify(error));
               }
              });
       },
       fail: function(err) {
         alert(JSON.stringify(err));
       }
     });
   };
 //]]>
</script>


<div id="loginDiv">
<form id="memberLoginForm"
	  action="${pageContext.request.contextPath}/member/memberLoginEnd.do"
	  method="post"
	  onsubmit="return loginSubmit();">
	
	<input type="text" id="memberId" name="memberId" placeholder="아이디" value="<%=saveIdFlag?memberIdSaved:"" %>" required/>
	<br />
	<input type="password" name="password" id="password" placeholder="비밀번호" required/>
	<br />
	<input type="submit" class="Login-start-btn" id="loginSubmitBtn" value="로그인" />
	<br /><br />
	<input type="checkbox" name="saveId" id="saveId" <%=saveIdFlag?"checked":""%>/>
	<label for="saveId">아이디 저장</label>
	<span id="findMember" onclick="findMember();">아이디 / 비밀번호 찾기</span>
	
</form>

	<br />
	<button href="javascript:void(0);" onclick="fbLoginAction();" class="Login-start-btn" id="Login-facebook-btn">페이스북으로 시작하기</button><br />
	<button class="Login-start-btn" onclick="loginWithKakao();" id="Login-kakao-btn">카카오톡으로 시작하기</button><br />
	<div class="g-signin2" data-onsuccess="onSignIn">
	</div>
		<span id="googleLoginSpan">구글로 시작하기</span>
	<!-- <button class="Login-start-btn" id="Login-google-btn">구글로 시작하기</button> -->
	<br /><br />
	
	<span>※ 개인정보 보호를 위해 공용 PC에서 사용 후 SNS계정의 <br />로그아웃 상태를 반드시 확인해 주세요.</span>
			
	<div id="googleLoginMemberInfo">
		<form id="googleLoginMemberInfoForm"
		  action="${pageContext.request.contextPath}/member/memberLoginSNS.do"
			  method="post">
			  <input type="text" name="googleMemberId" />
			  <input type="text" name="facebookMemberId" />
		</form>
	</div>
</div>

<!-- 페이스북으로 로그인 -->
<script type="text/javascript">
(function(d, s, id) {
    var js, fjs = d.getElementsByTagName(s)[0];
    if (d.getElementById(id)) 
    	return;
    js = d.createElement(s); js.id = id;
    js.src = "//connect.facebook.net/ko_KR/sdk.js#xfbml=1&version=v2.9&appId=661049387745717";
    fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));

window.fbAsyncInit = function() {
    FB.init({
        appId   : '661049387745717',
        cookie  : true,
        xfbml   : true,
        version : 'v2.8'
    });
    
    FB.getLoginStatus(function(response) {
    	console.log('statusChangeCallback');
    	console.log(response);
    	
    	if(response.status === 'connected'){
    		console.log("status : connected");
    	}
    	else{
    		console.log(response);
    	}
    });
};

function fbLoginAction(){
	FB.login(function(response){
		var fbname;
		var accessToken = response.authResponse.accessToken;
		FB.api('/me?fields=id,name,age_range,birthday,gender,email', function(response){
			var fb_data = jQuery.parseJSON(JSON.stringify(response));
			console.log("fb_id : "+fb_data.id);
			console.log("email : "+fb_data.email);
			console.log("name : "+fb_data.name);
			
			$("input[name=facebookMemberId]").val(fb_data.id);
			
			$("form#googleLoginMemberInfoForm").submit();
			  
		});
	}, {scope: 'public_profile, email'});
}
</script>

<script>
function onSignIn(googleUser) {
  // Useful data for your client-side scripts:
  var profile = googleUser.getBasicProfile();
  
  console.log("ID: " + profile.getId()); // Don't send this directly to your server!
  console.log('Full Name: ' + profile.getName());
  console.log('Given Name: ' + profile.getGivenName());
  console.log('Family Name: ' + profile.getFamilyName());
  console.log("Image URL: " + profile.getImageUrl());
  console.log("Email: " + profile.getEmail());

  // The ID token you need to pass to your backend:
  var id_token = googleUser.getAuthResponse().id_token;
  console.log("ID Token: " + id_token);
  
  $("input[name=googleMemberId]").val(profile.getId());
  
  var auth2 = gapi.auth2.getAuthInstance();
  auth2.signOut().then(function () {
    console.log('User signed out.');
  });
  
  $("form#googleLoginMemberInfoForm").submit();
  
}
	
function loginSubmit(){
	if($("#memberId").val().trim().length == 0){
		alert("아이디를 입력하세요.");
		$("#memberId").focus();
		return;
	}
	
	if($("#password").val().trim().length == 0){
		alert("비밀번호를 입력하세요.");
		$("#password").focus();
		return;
	}
}

function findMember(){
	//아이디, 비밀번호 찾기 팝업 생성
	var url = "${pageContext.request.contextPath}/member/findMember.do";
	var title = "findMember";
	var spec = "width=800px, height=400px, left=100px, top=100px, resizable=no";
		
	var popup = open(url, title, spec); 
}
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>