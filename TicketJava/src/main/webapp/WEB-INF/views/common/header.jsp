<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Ticket Java!</title>
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.4.0.js"></script>
<!-- 부트스트랩관련 라이브러리 -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js" integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm" crossorigin="anonymous"></script>
<!-- 사용자작성 css -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/common/header.css" />

<!-- 로딩 css -->
<link href="${pageContext.request.contextPath }/resources/css/common/jquery.loading.css" rel="stylesheet">
<script src="${pageContext.request.contextPath }/resources/js/jquery.loading.js"></script>

<!-- 실검 js -->
<script src="${pageContext.request.contextPath }/resources/js/jquery.vticker.min.js"></script>


<!-- 구글로 회원가입, 로그인 -->
<meta name="google-signin-scope" content="profile email">
<meta name="google-signin-client_id" content="700008619813-t0fj95slcjg3415rtskuarcp5hhhfcr1.apps.googleusercontent.com">
<script src="https://apis.google.com/js/platform.js" async defer></script>

<!-- 카카오톡로그인 -->
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width"/>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
 
<!-- 주소 검색 api -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

<!-- 페이스북 로그인 -->
<script async defer crossorigin="anonymous" src="https://connect.facebook.net/ko_KR/sdk.js#xfbml=1&version=v3.3&appId=661049387745717&autoLogAppEvents=1"></script>


<script>
	function jqueryLoading () {
	    $('body').loading('start');
	}
	function jqueryLoadingStop () {
	    $('body').loading('stop');
	}
	
	$(function(){
		/********* 메뉴바호버 ***********/	
		$("#menu-nav a").hover(function(){
			if($("#hover-menu").css("display","none")){
				$("#hover-menu").css("display","inline-block");
			}
			else{
				$("#hover-menu").css("display","none");		
			}
		});

	 	$("#hover-menu").hover(function(){
			$("#hover-menu").css("display","inline-block");
		},function(){
			$("#hover-menu").css("display","none");
		});
	 	
		$("#menu-nav").mouseleave(function(){
			$(".hover-menu").css("display","none");				
		});

		
		/****** 메뉴이미지 가져오기 *******/
	 	$("#menu-nav a").hover(function(){
			var category = $(this)[0].innerHTML;
			$.ajax({
				url: "${pageContext.request.contextPath}/performance/menuImgList.do",
				data: "category="+category,
				success: function(data){
				 	 var html = "<table>";
						html += "<tr>";
						html += "<td rowspan='2'></td>";
						html += "<td rowspan='2'><span class='menu-title'>"+data[0].performanceCodeName+"</span></td>";
						for(var i in data){
							if(i<3){
								html += "<td><img onclick='img_click("+data[i].performanceNo+");' class='hover-menu-img' src='${pageContext.request.contextPath }/resources/upload/performance/"+data[i].renamedFileName+"'/></td>";														
							}
						}
						html += "<td colspan='2' rowspan='2'>";
						html += "<div id='imgDetail-div'>";
						html += "</div>"
						html += "</td>";
						html += "</tr><tr>";
						for(var i in data){
							if(i>=3 && i<6){
								html += "<td><img onclick='img_click("+data[i].performanceNo+");' class='hover-menu-img' src='${pageContext.request.contextPath }/resources/upload/performance/"+data[i].renamedFileName+"'/></td>";							
							}
						}
						html += "</tr></table>";
					$("#hover-menu").html(html);
					
					//메뉴바 호버시 공연 상세보기
					 menuDetail();
				},
				error: function(jqxhr){
					console.log("ajax처리실패:"+jqxhr.status);
				}
			}); 
		});
		

		
		/****** 메뉴바 호버시 공연 상세보기 *******/
	 	function menuDetail(){
			$(".hover-menu-img").mouseenter(function(){
				var imgdetail = $(this).attr('src').replace('/ticketjava/resources/upload/performance/','');
				$.ajax({
					url: "${pageContext.request.contextPath}/performance/menuImgDetail.do",
					data: "imgdetail="+imgdetail,
					success: function(data){

						var html2 = "";
						html2 += "<div id='p-div'>"
						html2 += "<p id='img-detail-title'>"+data.performanceTitle+"</p>"
						html2 += "&nbsp;<p class='img-detail-date' id='img-detail-sDate'>"+getFormatDate(new Date(data.startDate))+"&nbsp;&nbsp;&nbsp;~</p>"
						html2 += "<p class='img-detail-date' id='img-detail-eDate'>"+getFormatDate(new Date(data.endDate))+"</p>"
						html2 += "<p id='img-detail-pName'>&nbsp;"+data.placeName+"</p>"
						html2 += "</div>"
						html2 += "<img id='img-detail-img'src='${pageContext.request.contextPath }/resources/upload/performance/"+imgdetail+"'/>"
						$("#imgDetail-div").html(html2);
					},
					error: function(jqxhr){
						console.log("ajax처리실패:"+jqxhr.status);
					}
				}); 
			}); 
			
			
	 	} 
		
		/****** 날짜포맷 *******/
		function getFormatDate(date){
		    var year = date.getFullYear();		//yyyy
		    var month = (1 + date.getMonth());		//M
		    month = month >= 10 ? month : '0' + month;	//month 두자리로 저장
		    var day = date.getDate();			//d
		    day = day >= 10 ? day : '0' + day;		//day 두자리로 저장
		    return  year + '-' + month + '-' + day;
		}
		
		
		
		
		/****** 자동완성 *******/
	     $("#header-search-input").keyup(function(e){
			//눌린 키가 뭔지 알기 위해서 e라고 이벤트 객체를 받겠음
			var title = $("#header-search-input").val();
			
			
			
			//사용자 입력값이 공백인 경우, ajax 요청하지 않는다.
			if(title.length == 0){
				$("#autocomplete").css("display","none");
				return;
			}
			
			var $sel = $(".sel");
			var $li = $("#autocomplete li");
					
			//사용자 입력값이 ArrowUp인 경우 (화살표 키 위로)
			if(e.key == 'ArrowUp'){
				
				if($sel.length == 0){
					//처리 없음
				}
				//현재 선택된 요소가 $li 첫 번째 요소인 경우
				else if($sel.is($li.first())){
					$sel.removeClass("sel");
				}
				else{
					$sel.removeClass("sel")
						.prev()
						.addClass("sel");
					$("#header-search-input").val($sel.prev().text());
				}
				
			}
			//사용자 입력값이 ArrowDown인 경우 (화살표 키 밑으로)
			else if(e.key == 'ArrowDown'){
				if($sel.length == 0){
					$li.first().addClass("sel");
					$("#header-search-input").val($li.first().text());
				}
				//현재 선택된 요소가 $li 마지막 요소인 경우
				else if($sel.is($li.last())){
					//처리 코드 없음
				}
				else{
					$sel.removeClass("sel")
						.next()
						.addClass("sel");
					$("#header-search-input").val($sel.next().text());
				}
			}
			//사용자 입력값이 Enter인 경우
			else if(e.key == 'Enter'){
				//현재선택값을 input태그에 입력
				$(this).val($sel.text());
				//검색어 목록을 감추고, li태그 삭제
				$("#autocomplete").hide().children().remove();

			}
			

			else{
				$.ajax({
					url: "${pageContext.request.contextPath}/performance/search.do",
					data: "title="+title,
					success: function(data){
						$("#autocomplete").css("display","block");
						var html = "";
						if(data == ""){
						 	html = "<span id='srch-none'>"+"검색결과가 없습니다."+"</span>";				
						}
						else{
							for(var i in data){
								html += "<li>"+data[i].performanceTitle.replace(title, "<span class='srchval'>"+title+"</span>")+"</li>";
							}
						}
						$("#autocomplete").html(html);	
					},
					error: function(jqxhr){
						console.log("ajax처리실패:"+jqxhr.status);
					}
				}); //end of ajax
			}
	 	});//end of $("#header-search-input").keyup
	 	
	 	////이벤트 버블링을 통해 이벤트 처리
	 	$("#autocomplete").on("click", "li", function(){
	 		//실제 이벤트가 발생한 자식 요소의 태그를 줌. 이벤트 버블링
	 		//클릭 이벤트가 일어난 li 태그의 text를 input태그에 입력
	 		console.log($(this));
	 		$("#header-search-input").val($(this).text());
	 		$("#autocomplete").hide()
	 						  .children().remove();
	 	});
	 	
	 	//마우스 오버, 마우스 아웃 처리
	 	$("#autocomplete").on("mouseover", "li", function(){
	 		$(this).siblings().removeClass("sel");
	 		$(this).addClass("sel");
	 	});
	 	$("#autocomplete").on("mouseout", "li", function(){
	 		$(this).removeClass("sel");
	 	});
	});


	/* 이미지 클릭시 상세페이지로 이동 */
	function img_click(performanceNo){
		location.href="${pageContext.request.contextPath }/performance/performanceView?performanceNo="+performanceNo;
	}

	function search_click(){
		var val = $("#header-search-input").val();
		location.href="${pageContext.request.contextPath }/performance/searchPerformance?performanceTitle="+val;
	}
	
//가까운 티켓예매 실시간목록 링크
	
 	$(function(){
		var ticker = $("#ticker");
		
			 $.ajax({
				    type: "POST",
				    url : "${pageContext.request.contextPath}/admin/schedulesoon.do",
				    dataType: "json",
				    contentType:"application/json;charset=UTF-8",
				    async: false,
				    success : function(data, status, xhr) {
			
				      for(var i in data){
				  		 $("#ticker").append("<li><a id='slideTitle' href='${pageContext.request.contextPath }/performance/performanceView?performanceNo="+data[i].PERFORMANCE_NO+"'> <span>"+data[i].RANK+".&nbsp;</span>"+data[i].PERFORMANCE_TITLE+"</a>&nbsp;&nbsp;&nbsp;<span class='date_span'>"+data[i].MIN_DATE+"</span></li>");
				      }

				    },
				    error: function(jqXHR, textStatus, errorThrown) {
				      alert("error= " + errorThrown);
				    }
				   
				  });	
			 $('#slider').vTicker();
	}); 
	
	
	
</script>



</head>
<body>
    <div id="container">
        <header>
            <div id="header-container">
                <nav class="header-nav-bar" id="header-nav">
                    <ul>
                    <!-- 로그인 분기 처리 -->
                        <c:if test="${memberLoggedIn == null}">
                        <%--로그인 안 한 경우 --%>
                          <li class="nav-item"><a href="${pageContext.request.contextPath}/member/memberLogin.do">로그인</a>&nbsp;&nbsp;</li>
                          <li class="nav-item"><a href="${pageContext.request.contextPath}/member/memberEnroll.do">회원가입</a>&nbsp;&nbsp;</li>
                        </c:if>
                        <c:if test="${memberLoggedIn != null }">
                        <%--로그인 한 경우 --%>
                        <c:if test="${memberLoggedIn.memberId eq 'admin' }">
                          <li class="nav-item"><a href="${pageContext.request.contextPath}/admin/admin.do">관리자페이지</a>&nbsp;&nbsp;</li>
                        </c:if>
                          <li class="nav-item"><a href="${pageContext.request.contextPath}/member/memberLogout.do">로그아웃</a>&nbsp;&nbsp;</li>
                        </c:if>
                          <li class="nav-item"><a href="${pageContext.request.contextPath}/member/ticketList.do?memberId=${memberLoggedIn.memberId}">예매확인/취소</a>&nbsp;&nbsp;</li>
                          <li class="nav-item"><a href="${pageContext.request.contextPath}/member/memberMyPage.do">마이페이지</a>&nbsp;&nbsp;</li>
                    	
                    </ul>
                </nav>
                
                <div id="header-container-content">
		             <a href="${pageContext.request.contextPath}">
		             	<div id=logo-container>
		             		<span id=logo-kr>&nbsp;티켓자바</span><br />
		              		<span id=logo-en>&nbsp;TICKET JAVA&nbsp;</span>
		             	</div>
		             </a>
	                 <div id="search">
	                    <input type="text" id="header-search-input" placeholder="검색어를 입력하세요" onkeypress="if(event.keyCode == 13){search_click()}"/>
	                    <ul id="autocomplete"></ul>
	                    <button type="button" id="btn-search" onclick="search_click();">검색</button>
	                    <div id="hidden-input-div"></div>
	                 </div>
	                 <img id="adImgBox" 
	                 	  src="${pageContext.request.contextPath }/resources/images/header/1advertisement.png" 
	                 	  alt="광고 이미지"
	                 	  onclick="location.href='${pageContext.request.contextPath}/performance/performanceView?performanceNo=83'"/>
	            </div>    
	            <nav class="header-nav-bar" id=menu-nav>
	                <ul>
	                 <li class="headerMenu">
                      <img id="allmenubar" src="${pageContext.request.contextPath }/resources/images/header/menubar.jpg"/>&nbsp;                    
                      </li>
                      <li class="header-menu-category"><a id=menu-nav0 href="${pageContext.request.contextPath}/performance/allMusical.do">뮤지컬</a>｜</li>
                      <li class="header-menu-category"><a id=menu-nav1 href="${pageContext.request.contextPath}/performance/allConcert.do">콘서트</a>｜</li>
                      <li class="header-menu-category"><a id=menu-nav2 href="${pageContext.request.contextPath}/performance/allPlay.do">연극</a>｜</li>
	               </ul>

               <div  id="slider" style="position: absolute; top: -35px; left: 700px; color: black; height: 50px;">
                <ul id="ticker" style="width : 300px; height: 50px;" >
                  
          
                </ul>
            </div>
				
				<!-- 메뉴바 호버시 나타나는 메뉴 : ajax처리 -->
	            <div class="hover-menu" id="hover-menu"></div>
            </div>
        </header>
        

        
        
        <section id="content">