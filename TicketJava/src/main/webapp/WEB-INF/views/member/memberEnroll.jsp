<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/member/memberEnroll.css" />

<div id="Enroll-first-div">
	<table id="Enroll-table">
		<tr>
			<td>
				<img src="${pageContext.request.contextPath }/resources/images/member/ticketjava_enroll.png" />
			</td>
			<td>
				<br /><br />
				<button class="Enroll-start-btn" id="Enroll-tj-btn" onclick="location.href='${pageContext.request.contextPath}/member/memberEnrollTJ.do'">간편회원가입</button><br /><br />
				<button href="javascript:void(0);" onclick="fbLoginAction();" class="Enroll-start-btn" id="Enroll-facebook-btn">페이스북으로 시작하기</button><br />
				<button onclick="loginWithKakao();" class="Enroll-start-btn" id="Enroll-kakao-btn">카카오톡으로 시작하기</button><br />
				<div class="g-signin2" data-onsuccess="onSignIn">
				</div>
					<span id="googleLoginSpan">구글로 시작하기</span>
				<br /><br />
				<!-- <button class="Enroll-start-btn" id="Enroll-google-btn">구글로 시작하기</button> -->
				
				<span id="infoScript">※ 개인정보 보호를 위해 공용 PC에서 사용 후 SNS계정의 <br />로그아웃 상태를 반드시 확인해 주세요.</span>
			</td>
		</tr>
	</table>
	
	<div id="googleLoginMemberInfo">
		<form id="googleLoginMemberInfoForm"
		  action="${pageContext.request.contextPath}/member/memberEnrollTJ.do"
		  method="post">
		  <input type="text" name="googleMemberId" />
		  <input type="text" name="memberName"/>
		  <input type="email" name="email"/>
		  <input type="text" name="facebookMemberId" />
		</form>
	</div>
	
	
<form action="${pageContext.request.contextPath}/member/memberEnrollKa.do" method="post" id="kakaoEnrollFrm">
<input type="hidden" name="kakaoMemberId" />
<input type="hidden" name="name" />
<input type="hidden" name="email" />
</form>

	
</div>



<!-- 페이스북 로그인 버튼 -->
<!-- <div class="fb-login-button" 
	 data-width="" data-size="large" 
	 data-button-type="continue_with" 
	 data-auto-logout-link="true" 
	 data-use-continue-as="false">
</div>
<div id="fb-root"></div> -->

<!-- <a href="javascript:void(0);" onclick="fbLoginAction();">페이스북 로그인</a> -->

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
			$("input[name=memberName]").val(fb_data.name);
			$("input[name=email]").val(fb_data.email);
			
			var param = {
					facebookMemberId : fb_data.id
			};
			
			$.ajax({
				url: "${pageContext.request.contextPath}/member/checkFacebookIdDuplicate.do",
				data: param,
				type: "post",
				success: function(data){
					console.log(data);
					if(data == "X"){
						alert("이미 연동된 계정입니다. 로그인을 해 주세요!");
						location.href = "${pageContext.request.contextPath}/member/memberLogin.do";
					}
					else{
						$("form#googleLoginMemberInfoForm").submit();
					}
				},
				error: function(jqxhr, textStatus, errorThrown){
					console.log("ajax 처리 실패ㅠ~!~!");
					console.log(jqxhr);
					console.log(textStatus);
					console.log(errorThrown);
				}
			});
			  
		});
	}, {scope: 'public_profile, email'});
}
</script>

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
   	    	    	 data: {kakaoMemberId:kakaoMemberId, email:email,name:name},
   	    	    	 dataType:"json",
   	    	    	 success:function(data){
   	    	    		 console.log(data);
   	    	    		 console.log(data.email);
   	    	    		 console.log(data.name);
   	    	    		 if(data.result === "0"){
   							
   							$("#kakaoEnrollFrm input[name=kakaoMemberId]").val(kakaoMemberId);
   							$("#kakaoEnrollFrm input[name=name]").val(name);
   							$("#kakaoEnrollFrm input[name=email]").val(email);
   							
   							
   							$("#kakaoEnrollFrm").submit();
   	    	    		 }
   	    	    		 else{
   	    	    			 alert("아이디가 존재합니다. 해당아이디로 로그인합니다.");
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
  $("input[name=memberName]").val(profile.getName());
  $("input[name=email]").val(profile.getEmail());
  
  var auth2 = gapi.auth2.getAuthInstance();
  auth2.signOut().then(function () {
    console.log('User signed out.');
  });
  
	var param = {
		googleMemberId : profile.getId()
	};
  
  $.ajax({
		url: "${pageContext.request.contextPath}/member/checkGoogleIdDuplicate.do",
		data: param,
		type: "post",
		success: function(data){
			console.log(data);
			if(data == "X"){
				alert("이미 연동된 계정입니다. 로그인을 해 주세요!");
				location.href = "${pageContext.request.contextPath}/member/memberLogin.do";
			}
			else{
				$("form#googleLoginMemberInfoForm").submit();
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