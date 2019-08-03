<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<jsp:include page="/WEB-INF/views/member/memberCommon/myPageHeader.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/member/memberPasswordCheck.css" />

<style>
div#myPageDiv table#myPageTable td#memberSnsIndex{
	/* 현재 선택된 페이지 */
	/* memberUpdateIndex
	memberPasswordUpdateIndex
	memberSnsIndex
	memberDeleteIndex */
	color: rgb(41, 128, 185);
}
</style>

<h2>SNS 연결</h2>
<hr />
<br />
	<div id="passwordCheckScript">
	SNS 계정 연결을 통해 간편하게 로그인하세요.
	<br /><br />
	<span class="mypageGuideInfoSpan">
		개인정보 보호를 위해 공용 PC에서 사용 후, <br />
		SNS 계정의 로그아웃 상태를 반드시 확인해 주세요.
	</span>
</div>
<br /><br />
	<c:choose>
		<c:when test="${memberLoggedIn.facebookMemberId == '' or memberLoggedIn.facebookMemberId == null}">
			<button href="javascript:void(0);" onclick="fbLoginAction();" class="Login-start-btn" id="Login-facebook-btn">페이스북 연결하기</button><br />
		</c:when>
		<c:otherwise>
			<button class="Login-start-btn Complete" id="SNS-Facebook-Complete">페이스북 연결 완료</button>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${memberLoggedIn.kakaoMemberId == '' or memberLoggedIn.kakaoMemberId == null}">
			<button class="Login-start-btn" id="Login-kakao-btn" onclick="loginWithKakao();">카카오톡 연결하기</button><br />
		</c:when>
		<c:otherwise>
			<button class="Login-start-btn Complete" id="SNS-Kakao-Complete">카카오톡 연결 완료</button>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${memberLoggedIn.googleMemberId == '' or memberLoggedIn.googleMemberId == null}">
			<!-- <button class="Login-start-btn" id="Login-google-btn">구글 연결하기</button> -->
			<div class="g-signin2" data-onsuccess="onSignIn">
			</div>
				<span id="googleLoginSpan">구글 연결하기</span>
		</c:when>
		<c:otherwise>
			<button class="Login-start-btn Complete" id="SNS-Google-Complete">구글 연결 완료</button>
		</c:otherwise>
	</c:choose>
	
	<br /><br />
	
<div id="googleLoginMemberInfo">
	<form id="googleLoginMemberInfoForm"
	  action="${pageContext.request.contextPath}/member/memberSNSConnect.do"
	  method="post">
	  <input type="text" name="googleMemberId" />
	  <input type="text" name="facebookMemberId" />
	  <input type="text" name="email" />
	  <input type="text" name="memberId" value="${memberLoggedIn.memberId}"/>
	</form>
</div>


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
	    	    	 url:"${pageContext.request.contextPath}/member/memberSNSConnectForKakao.do",
	    	    	 data: {kakaoMemberId:kakaoMemberId, email:email},
	    	    	 dataType:"json",
	    	    	 success:function(data){
	    	    		 console.log(data);
	    	    		 if(data.result === "0"){
							 alert("이미 연결된 sns 계정입니다.");	    	    			 
	    	    		 }
	    	    		 else if(data.result === "1"){
	    	    			 alert("카카오 계정 연결 성공!");
	    	    			 location.reload();
	    	    		 }
	    	    		 else{
	    	    			 alert("오류! 관리자에게 연락하세요!");
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


<!-- 페이스북 로그인 -->
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
			$("input[name=email]").val(fb_data.email);
			
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
  $("input[name=email]").val(profile.getEmail());
  
  var auth2 = gapi.auth2.getAuthInstance();
  auth2.signOut().then(function () {
    console.log('User signed out.');
  });
  
  $("form#googleLoginMemberInfoForm").submit();
  
}


</script>
	
<jsp:include page="/WEB-INF/views/member/memberCommon/myPageFooter.jsp"/>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>