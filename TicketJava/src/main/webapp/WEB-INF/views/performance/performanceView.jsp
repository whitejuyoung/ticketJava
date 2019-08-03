<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<script src="${pageContext.request.contextPath }/resources/js/calendar.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<%-- 지도 추가 --%>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=fec16ca1aeba46a4457588b0ab7db309&libraries=services"></script>
<%-- 별점 추가 --%>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery.raty.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/jquery.vticker.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/performance/performanceView.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/performance/calendar.css" />

<script>
	google.charts.load('current', {packages:['corechart']});
</script>
<script type="text/javascript">
window.onload = function () {
	$.ajax({
		url:"${pageContext.request.contextPath}/performance/viewSchedule",
		data:{performanceNo:"${performance.performanceNo}"},
		dataType:"json",
		success:function(data){
			
			//오늘 날짜
			tYear = Number(tYear) ;
			tMonth = Number(tMonth);
			tDay = Number(tDay);
			
			//["2019/07/23", "2019/07/24", "2019/07/25", "2019/07/26", "2019/07/27"]
			for(var i = 0;i<data.length;i++){
				var year = data[i].substr(0,4);
				var month = data[i].substr(5,2);
				var day = data[i].substr(8,2);
				var m="";
				var d="";
				for(var j=1 ; j<10 ; j++){
					
					if(month === ('0'+j)){
						m = month.replace('0'+j,j);
					}
					if(day === ('0'+j)){
						d = day.replace('0'+j,j);
					}
				}
				if(m === "")
					m = month;
				if(d === "")
					d = day;
				//공연 날짜
				var nYear = Number(year);
				var nMonth = Number(month);
				var nDay = Number(day);
				
				//공연날짜가 지나지 않았을때만 표시
				if((nYear === tYear && nMonth === tMonth && nDay > tDay) ||
						(nYear === tYear && nMonth > tMonth)){
					//console.log("#"+year+"-"+m+"-"+d);
					//console.log($("#"+year+"-"+m+"-"+d));
					$("#"+year+"-"+m+"-"+d).css({"background":"#f39c12","color":"rgb(41, 41, 41)"});
				}
				
			}
			
		},
		error: function(jqxhr){
    		  console.log("ajax 처리 실패:"+jqxhr.status);
    		  console.log("ajax 처리 실패:"+jqxhr.textStatus);
    		  console.log("ajax 처리 실패:"+jqxhr.errorThrown);

    	}
	});
}

	$(function(){
		console.log("온로드실행");		
		/* <jsp:useBean id="today" class="java.util.Date" />
		<fmt:formatDate value="${today}" pattern="M" var="today" />  
		console.log(${today}-1);
		
		$("#cal-mth").val("10");
		console.log($("select#cal-mth")); */
		
		
		
		var time = null;
		var scheduleNo = null;
		var performanceNo = ${performance.performanceNo};
		var selectedDate = null;
		/*성별 통계*/			
		$.ajax({
			url:"${pageContext.request.contextPath}/performance/viewGenderRate",
			data:{performanceNo:"${performance.performanceNo }"},
			dataType: "json",
			success:function(data){
/* 				console.log(data);
				console.log(data.rateF);
				console.log(data.rateM); */
				
				var html = "<span class='genderTag' id='tagFemale'>여자</span><br />";
				html += "<span class='genderPercentage'>"+data.rateF+"%</span><br /><br />";
				html += "<span class='genderTag'>남자</span><br />";
				html += "<span class='genderPercentage'>"+data.rateM+"%</span>";
				
				$("#ticketingGenderRate").html(html);
		},
		error: function(jqxhr){
    		  console.log("ajax 처리 실패:"+jqxhr.status);
    	}

		});
		
		/*연령별 통계*/
		$.ajax({
			url:"${pageContext.request.contextPath}/performance/viewAgeRate",
			data:{performanceNo:"${performance.performanceNo }"},
			dataType: "json",
			success:function(data){
				/* console.log(data); */

				var teenager = data[0];
				var twenty = data[1];
				var thirty = data[2];
				var forty = data[3];
				var fiffty = data[4];
				var sixty = data[5];
				
				google.charts.load('current', {packages: ['corechart', 'bar']});
				
				google.charts.setOnLoadCallback(drawBasic);
				
				function drawBasic() {
					var data = new google.visualization.DataTable();
					
						data.addColumn('string');
						data.addColumn('number');
						data.addRows([
							
							['10대', teenager],
							['20대', twenty],
							['30대', thirty],
							['40대', forty],
							['50대', fiffty],
							['60대', sixty],
					
					]);
					var option = {
					          legend: 'none',
					          colors: ['rgb(224, 224, 224)']
					        };
					var chart = new google.visualization.ColumnChart(
									document.getElementById('chart_div'));
					
					chart.draw(data, option);
				}
		},
		error: function(jqxhr){
    		  console.log("ajax 처리 실패:"+jqxhr.status);
    	}
			
		});
		
	});
	

	/* 달력 날짜 클릭시 이벤트  */
	function clickDay(){
		  $(".dd").css({"background":"white","color":"#292929"}); 
		  
		   var e = event.target;
		   var $e = $("#"+e.id); //클릭한 날의 div jquery객체
		   
		   $.ajax({
				url:"${pageContext.request.contextPath}/performance/viewSchedule",
				data:{performanceNo:"${performance.performanceNo }"},
				dataType:"json",
				success:function(data){
					console.log(data);	
					
					//오늘 날짜
					tYear = Number(tYear) ;
					tMonth = Number(tMonth);
					tDay = Number(tDay);

					for(var i = 0;i<data.length;i++){
						console.log(data[i]);

						var year = data[i].substr(0,4);
						var month = data[i].substr(5,2);
						var day = data[i].substr(8,2);
						var m="";
						var d="";
						
						for(var j=1 ; j<10 ; j++){
							
							if(month === ('0'+j)){
								m = month.replace('0'+j,j);
							}
							if(day === ('0'+j)){
								d = day.replace('0'+j,j);
							}
						}
						if(m === "")
							m = month;
						if(d === "")
							d = day;
						
						//공연 날짜
						var nYear = Number(year);
						var nMonth = Number(month);
						var nDay = Number(day);
						
						//공연날짜가 지나지 않았을때만 표시
						if((nYear === tYear && nMonth === tMonth && nDay > tDay) ||
								(nYear === tYear && nMonth > tMonth)){
							console.log("#"+year+"-"+m+"-"+d);
							console.log($("#"+year+"-"+m+"-"+d));
							$("#"+year+"-"+m+"-"+d).css({"background":"#f39c12","color":"rgb(41, 41, 41)"});
						
							$e.css({"background":"rgb(231, 76, 60)","color":"white"});
						}
						
						}
					
					$e.css({"background":"rgb(231, 76, 60)","color":"white"});
					
				},
				error: function(jqxhr){
		    		  console.log("ajax 처리 실패:"+jqxhr.status);
		    		  console.log("ajax 처리 실패:"+jqxhr.textStatus);
		    		  console.log("ajax 처리 실패:"+jqxhr.errorThrown);

		    	}
			});
		   

	      $e.css({"background":"rgb(231, 76, 60)","color":"white"});
	      
	      //선택한 년,월,일
	      var selectedYear = parseInt(document.getElementById("cal-yr").value);
	      var selectedMonth = parseInt(document.getElementById("cal-mth").value)+1;
	      var selectedDay = $e.html();
	      
	      //ex)2019/7/17
	      selectedDate = selectedYear+"/"+selectedMonth+"/"+selectedDay;
	      
	   	  /* console.log(selectedYear);
	      console.log(selectedMonth);
	      console.log(selectedDay);  
	      console.log(selectedDate);  */
	      
	      $.ajax({
	    	  url:"${pageContext.request.contextPath}/performance/performanceRound",
	    	  data:{performanceNo:'${performance.performanceNo }', selectedDate:selectedDate},
	    	  dataType: "json",
	    	  success:function(data){
/* 	    		  console.log(data);
	    		  for(var k=0;k<data.length;k++){
	    			  console.log(data[k].PERFORMANCEROUND);
	    		  } */
	    		  /*회차가 존재하지 않을경우*/
	    		  if(data.length == 0){
	    			  /* alert("없어욘"); */
	    			  var html = " <select id='selectionOf'>";
	    			  html += "<option selected='selected' disabled='disabled'>회차가 존재하지 않습니다</option>";
	    			  html += "</select>";
	    			  $("#choiceRround").html(html);
	    			  
	    			  var html2 = "<span id='beforeSelection'>관람일과 회차를 선택해 주세요.</span>";
	    			  
	    			  $("#possibleSeat").html(html2);
	    		  }
	    		  /*회차가 존재 할 경우*/
	    		  else{
	    			  var html = " <select id='selectionOf' name='selectRound'>";
		    			  html += "<option disabled='disabled' selected='selected'>회차를 선택해 주세요</option>";
	    			  for(var i=0;i<data.length;i++){
		    			  html += " <option class='round' id='"+(i+1)+"' value='"+data[i].PERFORMANCEROUND+"'>"+data[i].PERFORMANCEROUND.substring(11,16)+"</option>";	  
	    			  }
	    			 	 html += "</select>";
	    			  $("#choiceRround").html(html);	
	    			  
	    			  $("#selectionOf").change(function(){
	    					time = $(this).val();
	    					performanceNo = ${performance.performanceNo};
	    					availableSeat(time,performanceNo);
	    					
	    				}); 
	    			  
	    		  }	  
	    	  },
	    	  error: function(jqxhr){
	    		  console.log("ajax 처리 실패:"+jqxhr.status);
	    	  }
	      });

	};
	
	function availableSeat(time,performanceNo){
		console.log(time,performanceNo);
		 $.ajax({
			url:"${pageContext.request.contextPath}/performance/viewAvailableSeat",
			data:{time:time,performanceNo:performanceNo,placeCode:'${performance.placeCode}'},
			dataType: "json",
			success:function(data){
				console.log(data);
				var html = "<span id='afterSelection'> "+data.availableSeat+" 석 남았습니다.</span>";
				scheduleNo = data.scheduleNo;
			$("#possibleSeat").html(html);
		},
		error: function(jqxhr){
    		  console.log("ajax 처리 실패:"+jqxhr.status);
    		  console.log("ajax 처리 실패:"+jqxhr.textStatus);
    		  console.log("ajax 처리 실패:"+jqxhr.errorThrown);

    	}

		});
		
	}
	/*예매하기 버튼 눌렀을때*/
	function goBuyingTicket(){
		
		/*로그인 안 했을때*/
		if(${memberLoggedIn == null} ){
			alert("로그인 후에 이용해주세요ㅠ.ㅠ");
			return;
			
		} 
		/*날짜선택 안 했을때*/
		if(typeof time =="undefined"||time == null){
			alert("공연 날짜와 회차를 선택해주세요~.~");
			return;
		}
	
		console.log(performanceNo);
		console.log(time);
		console.log(scheduleNo);
	
		//예매페이지로 넘기기
		location.href = "${pageContext.request.contextPath}/ticket/seat.do?performanceNo="+performanceNo+"&time="+time+"&scheduleNo="+scheduleNo+"&selectedDate="+selectedDate;
	}
	//오늘 날짜 구하기
	var date = new Date(); 
	var tYear = date.getFullYear(); 
	var tMonth = new String(date.getMonth()+1); 
	var tDay = new String(date.getDate()); 

	// 한자리수일 경우 0을 채워준다. 
	if(tMonth.length == 1){ 
		tMonth = "0" + tMonth; 
	} 
	if(tDay.length == 1){ 
		tDay = "0" + tDay; 
	} 

	function scheduleBtn(){

		$.ajax({
			url:"${pageContext.request.contextPath}/performance/viewSchedule",
			data:{performanceNo:"${performance.performanceNo }"},
			dataType:"json",
			success:function(data){
				//console.log(data);	
				
				//오늘 날짜
				tYear = Number(tYear) ;
				tMonth = Number(tMonth);
				tDay = Number(tDay);
				
				for(var i = 0;i<data.length;i++){
					//console.log(data[i]);

					var year = data[i].substr(0,4);
					var month = data[i].substr(5,2);
					var day = data[i].substr(8,2);
					var m="";
					var d="";
					
					for(var j=1 ; j<10 ; j++){
						
						if(month === ('0'+j)){
							m = month.replace('0'+j,j);
						}
						if(day === ('0'+j)){
							d = day.replace('0'+j,j);
						}
					}
					if(m === "")
						m = month;
					if(d === "")
						d = day;
					
					//공연 날짜
					var nYear = Number(year);
					var nMonth = Number(month);
					var nDay = Number(day);
					
					//공연날짜가 지나지 않았을때만 표시
					if((nYear === tYear && nMonth === tMonth && nDay > tDay) ||
							(nYear === tYear && nMonth > tMonth)){
						//console.log("#"+year+"-"+m+"-"+d);
						//console.log($("#"+year+"-"+m+"-"+d));
						$("#"+year+"-"+m+"-"+d).css({"background":"#f39c12","color":"rgb(41, 41, 41)"});
					}
					
					}
				
			},
			error: function(jqxhr){
	    		  console.log("ajax 처리 실패:"+jqxhr.status);
	    		  console.log("ajax 처리 실패:"+jqxhr.textStatus);
	    		  console.log("ajax 처리 실패:"+jqxhr.errorThrown);

	    	}
		});
}

	
 
</script>

	<div id="line"></div>
	<div id="info-container">
		<!-- 공연 정보 헤더 div-->
		<div id="information">
			<span class="bigInfo">${performance.performanceCodeName }</span>
			<span class="bigInfo">[ ${performance.performanceTitle } ]</span>
			<div id="performanceRating"></div>
            <script>
                $('div#performanceRating').raty({
                            score: ${performance.totalRating/performance.ratingCount}
                            ,readOnly: true
                            ,path : "${pageContext.request.contextPath }/resources/images/star/"
                            ,width : 120
                });            
            </script>
			<br />
			<span class="smallInfo">${performance.performanceCodeName } | </span>
			<span class="smallInfo">${performance.runningTime }분 | </span>
			<span class="smallInfo">만 ${performance.viewingClass }세 이상 </span>
		</div>
		
		<!-- 공연 상세 정보 div  -->
		<div id="detailInfo">
			<table id="PerformanceInfo">
				<tr>
					<td rowspan="6" width="240px" height="280px">
						<img src="${pageContext.request.contextPath }/resources/upload/performance/${posterImg}"/>
					</td>
					<td width="80px" class="boldTd">장소</td>
					<td colspan="3" class="contentTd">${performance.placeName }</td>
				</tr>
				<tr>
					<td width="80px" class="boldTd">기간</td>
					<td class="contentTd">${performance.startDate }</td>
					<td class="contentTd">~</td>
					<td class="contentTd2">${performance.endDate }</td>
				</tr>
				<tr>
					<td width="80px" class="boldTd">출연</td>
					<td colspan="3" class="contentTd">${performance.casting }</td>
				</tr>
				<tr>
					<td width="80px" class="boldTd">가격정보</td>
					<td colspan="3" class="contentTd"><fmt:formatNumber value="${performance.price }" pattern="#,###"/>원</td>
					
				</tr>
				<tr>
					<td colspan="4">&nbsp;</td>
				</tr>
				<tr>
					<td colspan="4">&nbsp;</td>
				</tr>
			
			</table>
			<div id="personInfo">
				<p id="ticketingRate">예매자 정보</p>
				<!-- 성별통계 -->
				<img src="${pageContext.request.contextPath }/resources/images/genderRate.PNG" id="img-genderRate" />
				
				<!-- 구글차트(막대그래프)연령통계 -->
				<div id="chart_div" style="width: 340px; height: 200px; font-size: 9px;"></div>
				
				<div id="ticketingGenderRate">
				<!-- 성별통계 -->	
				</div>
			</div>
		</div>
		<c:set var="nowTime" value="<%= new java.util.Date()%>"/>
		<c:if test="${performance.endDate < nowTime}">
			
			<div id="scheduleInfo">
				<div id="impossibleSeat">
					<span id="beforeSelection">예매가 마감된 공연입니다.</span>
				</div>
			</div>
			
			
			
		</c:if>
		<c:if test="${performance.endDate > nowTime}">
				<!-- 예매하기(달력 등) div -->
			<div id="scheduleInfo">
			<p class="p-smallTitle">예매가능 공연일자</p>
			<!-- <button id ="showAvailableDay" onclick = "scheduleBtn();">공연일 보기</button> -->
			
			<!-- 달력 -->
			<div id="calendar"></div>
			<div id="page-body">
			    <!-- [PERIOD SELECTOR] -->
			    <div id="cal-date">
			      <select id="cal-mth" onchange="scheduleBtn();"></select>
			      <select id="cal-yr"></select>
			      <!-- <input id="cal-set" type="button" value="SET"/> -->
			    </div>
			    <!-- [CALENDAR] -->
			    <div id="cal-container" ></div>
			</div>
			
			<img src="${pageContext.request.contextPath }/resources/images/redyellow.PNG" id="redyellow" />
			
			<!-- 회차선택 -->
			<div id="choiceRround">
				<select id="selectionOf">
					<option disabled="disabled" selected="selected">회차를 선택해 주세요</option>
				</select>
			
			</div>
			<!-- 예매가능 좌석 -->
			<p class="p-smallTitle2" id="p-second">예매가능 좌석</p>
			<div id="possibleSeat">
				<span id="beforeSelection">관람일과 회차를 선택해 주세요.</span>
			</div>
				<button class="blueBtn" id="reservation-btn" onclick="goBuyingTicket();">예매하기</button>
			</div>
		</c:if>

		<%-- 아래 상세정보, 캐스팅캘린더, 관람후기, 공연장 정보, 예매유의사항 탭 div 
			 info div
		--%>
		<nav id="bottom-info">
		  <div class="nav nav-tabs" id="nav-tab" role="tablist">
		    <a class="nav-item nav-link active" id="nav-detail-tab" data-toggle="tab" href="#bottom-info-detail" role="tab" aria-controls="nav-home" aria-selected="true">상세정보</a>
		    <c:if test="${performance.performanceCodeName!='콘서트'}">
		    	<a class="nav-item nav-link" id="nav-casting-tab" data-toggle="tab" href="#bottom-info-casting" role="tab" aria-controls="nav-profile" aria-selected="false">캐스팅캘린더</a>
		    </c:if>
		    <a class="nav-item nav-link" id="nav-review-tab" data-toggle="tab" href="#bottom-info-review" role="tab" aria-controls="nav-contact" aria-selected="false">관람후기</a>
		    <a class="nav-item nav-link" id="nav-place-tab" data-toggle="tab" href="#bottom-info-place" role="tab" aria-controls="nav-contact" aria-selected="false">공연장 정보</a>
		    <a class="nav-item nav-link" id="nav-notice-tab" data-toggle="tab" href="#bottom-info-notice" role="tab" aria-controls="nav-contact" aria-selected="false">예매유의사항</a>
		  </div>
		</nav>
		<div class="tab-content" id="nav-tabContent">
		  <!-- 상세정보 탭	 -->	
		  <div class="tab-pane fade show active" id="bottom-info-detail" role="tabpanel" aria-labelledby="nav-home-tab">
		  	<img src="${pageContext.request.contextPath }/resources/upload/performance/${detailImg }" alt="상세정보 이미지" />
		  </div>
		  <!-- 캐스팅캘린더 탭 -->
		  <div class="tab-pane fade" id="bottom-info-casting" role="tabpanel" aria-labelledby="nav-profile-tab">
		  	<img src="${pageContext.request.contextPath }/resources/upload/performance/${castingImg }" alt="캐스팅 캘린더 이미지" />
		  </div>
		  <!-- 관람후기 탭 -->
		  <div class="tab-pane fade" id="bottom-info-review" role="tabpanel" aria-labelledby="nav-contact-tab">
		  <%----------------------- 댓글 입력  ----------------------%>
			<c:if test="${memberLoggedIn != null }">
				<div id="review-write">
					<span id="review-write-title">${performance.performanceTitle }</span>
					<div id="review-star-write"></div>
					<div class="input-group">
					  <textarea class="form-control" aria-label="With textarea" id="review-content"></textarea>
					</div>		  	
					<button type="button" class="btn btn-light" onclick="reviewWrite();">리뷰등록</button>
				</div>
			</c:if>
			
			
			<script>
				var reviewStarScore=1;
				<%-- 리뷰 등록 버튼 클릭 --%>
				function reviewWrite(){
					var str = $("#review-write .input-group #review-content").val();
					console.log(str);
					console.log(reviewStarScore);
					var param = {};
					param.performanceNo = '${performance.performanceNo}';
					param.memberId = '${memberLoggedIn.memberId}';
					param.reviewContent = str;
					param.reviewRating = reviewStarScore;
					
					console.log(param);
					
					$.ajax({
						url:"${pageContext.request.contextPath}/review/reviewWrite",
						data:param,
						dataType: "json",
						type:"POST",
						success:function(data){
							console.log(data);
							
							if(data.result == 0){
								<%-- 해당 공연에 후기를 한번도 남기지 않은 경우 --%>
								reviewPage(1);
								<%-- textarea 초기화 --%>
								$("#review-write .input-group #review-content").val("");								
							}
							else if(data.result == 1){
								<%-- 이미 후기가 있는 경우 --%>
								alert("이미 후기를 남기셨습니다.");			
								<%-- textarea 초기화 --%>
								$("#review-write .input-group #review-content").val("");								
							}
							else if(data.result == 2){
								<%-- 티켓 구매 후 공연시작시간 전에 리뷰를 남기려 할때,  --%>
								alert("공연 관람 후 리뷰를 작성해 주세요.");	
							}
							else if(data.result == 3){
								<%-- 티켓 구매 전 리뷰를 남기려 할때,  --%>
								alert("구매하지 않은 공연입니다.");	
							}
						},
						error: function(jqxhr){
				    		  console.log("ajax 처리 실패:"+jqxhr.status);
				    		  console.log("ajax 처리 실패:"+jqxhr.textStatus);
				    		  console.log("ajax 처리 실패:"+jqxhr.errorThrown);
				    	}

					}); 
				}
				
				
				$('div#review-star-write').raty({
					score: 0
					,path : "${pageContext.request.contextPath }/resources/images/star/"
					,width : 120
					,click: function(score, evt) {
						console.log(score);
						console.log(evt);
						reviewStarScore = score;
					}
				}); 
				
			</script>
			
			<%----------------------- 댓글 입력 끝 ---------------------%>
		  	
		   <ul class="list-group list-group-flush" id="review-table-ul">
			  <!-- <li class="list-group-item">
			  	<div class="review-div">
					<span class="review-member-id">userId</span>			  		
					<span class="review-date">2019-07-09</span>			  		
					<div class="review-star"></div>
					<br />
			  		<span class="review-content">asdassdasdasdasd</span>
			  	</div>
			  </li> -->
			</ul>
		  	
		  	<!-- <div id="star"></div>
		  	<script>
			  	$('div.review-star').raty({
	                score: 1
	                ,path : "${pageContext.request.contextPath }/resources/images/star/"
	                ,width : 120
	                ,click: function(score, evt) {
	                    console.log(score);
	                    console.log(evt);
	                }
	            });
		  	</script>  -->
		  	
		  	<div id="reviewPaging">
		  	
		  	</div>
		  	
		  	
		  	
		  	
		  </div>
		  <!-- 공연장 정보 탭 -->
		  <div class="fade" id="bottom-info-place" role="tabpanel" aria-labelledby="nav-contact-tab">
		  	<!-- 공연장 정보 입력 -->
		  	<p style="text-align: left; font-size: 18px; font-weight: bold;">공연장 정보</p>
		  	<hr/>
		  	<p style="text-align: left; font-size: 16px; margin-bottom:0;">${performance.placeName }</p>
		  	<p style="text-align: left; font-size: 14px; color: gray;">${performance.address }</p><br />
			<div id="map" style="width:800px;height:500px;margin:auto;"></div>
		  </div>
		  <!-- 예매 유의사항 탭 -->
		  <div class="tab-pane fade" id="bottom-info-notice" role="tabpanel" aria-labelledby="nav-contact-tab">
		  
			<p class="notice-title">티켓수령안내</p>
			<hr />
			<p class="notice-subTitle">&nbsp예약번호입장</p>
			<ul>
				<li>공연 당일 현장 교부처에서 예약번호 및 본인 확인 후 티켓을 수령하실 수 있습니다.</li>
				<li>상단 예매확인/취소 메뉴에서 예매내역을 프린트하여 가시면 편리합니다.</li>
			</ul>
			<p class="notice-subTitle">&nbsp티켓배송</p>
			<ul>
				<li>예매완료(결제익일) 기준 4~5일 이내에 배송됩니다. (주말, 공휴일을 제외한 영업일 기준)</li>
			</ul>
			<br /><br />
			
			<p class="notice-title">예매 취소시 유의사항</p>
			<hr />
			<ol>
				<li>예매 후 7일까지 취소 시에는 취소수수료가 없습니다.</li>
				<li>관람일 기준은 아래와 같이 취소수수료가 적용됩니다.</li>
				<span>1번과 2번 모두 해당되는 경우, 2번 기준이 우선 적용됩니다.</span>
				<ul>
					<li class="size-1">관람일 6일전~관람일 3일전까지 : 티켓금액의 20%</li>
					<li class="size-1">관람일 2일전~관람일 1일전까지 : 티켓금액의 30%</li>
					<span class="size-1">위 2번의 경우에도 예매 당일 밤 12시 이전 취소 시에는 취소수수료가 없습니다.</span><br />
					<span class="size-1">(취소기간 내에 한함)</span>
				</ul>
			</ol>
			<br /><br />
			
			<p class="notice-title">환불안내</p>
			<hr />
			<p class="notice-subTitle">&nbsp신용카드 결제의 경우</p>
			<ul>
				<li>일반적으로 당사의 취소 처리가 완료되고 4~5일 후 카드사의 취소가 확인됩니다. (체크카드 동일)</li>
				<li>예매 취소 시점과 해당 카드사의 환불 처리기준에 따라 취소금액의 환급방법과 환급일은 다소 차이가 있을 수 있으며, 예매 취소시 기존에 결제하였던 내역을 취소하며 최초 결제하셨던 동일카드로 취소 시점에 따라 취소수수료와 배송료를 재승인 합니다.</li>
			</ul>
			<br />
			<p class="notice-subTitle">&nbsp무통장 입금의 경우</p>
			<ul>
				<li>예매 취소 시에 환볼 계좌번호를 남기고, 그 계좌를 통해 취소수수료를 제외한 금액을 환불 받습니다. 취소 후 고객님의 계좌로 입금까지 대략 5~7일 정도가 소요됩니다. (주말 제외)</li>
				<li>환불은 반드시 예매자 본인 명의의 계좌로만 받으실 수 있습니다. <br />단, 예매자 본인 명의의 계좌가 없을 경우에는 직계 가족 명의의 계좌에 한하여 가능하며, 이 경우 관계를 증명할 수 있는 증빙서류를 예매자 본인이 팩스나 우편 등으로 티켓자바 본사로 보내주셔야 합니다. (예매자 본인 외 가족이 증빙서류를 보내주셨을 경우, 이로 인해 문제 발생 시 환불 접수한 가족 본인에게 모든 책임이 있습니다.)</li>
			</ul>
			<br />
			<p class="notice-subTitle">&nbsp휴대폰 결제의 경우</p>
			<ul>
				<li>취소 신청 후 바로 취소 처리가 되며 취소 수수료를 제외한 티켓 금액 및 예매수수료/핸드폰결제이용료가 취소 가능합니다.</li>
				<li>예매 취소 시 기존에 결제하셨던 내역을 취소하며 결제하셨던 동일 정보로 취소 시점에 따라 취소수수료가 재승인 합니다. (티켓이 배송된 경우는 배송료 포함하여 재승인 합니다.)</li>
			</ul>
		  </div>
		</div>
		
		
		
		
		  
		
	</div>

<script>
	var container = document.getElementById('map');
	var options = {
		center: new kakao.maps.LatLng(33.450701, 126.570667),
		level: 3
	};

	var map = new kakao.maps.Map(container, options);

	// 주소-좌표 변환 객체를 생성합니다
	var geocoder = new kakao.maps.services.Geocoder();

	// 주소로 좌표를 검색합니다
	geocoder.addressSearch('${performance.address}', function(result, status) {
		
	    // 정상적으로 검색이 완료됐으면 
	     if (status === kakao.maps.services.Status.OK) {

	        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

	        // 결과값으로 받은 위치를 마커로 표시합니다
	        var marker = new kakao.maps.Marker({
	            map: map,
	            position: coords
	        });

	        // 인포윈도우로 장소에 대한 설명을 표시합니다
	        var infowindow = new kakao.maps.InfoWindow({
	        	
	            content: '<div style="width:150px;text-align:center;padding:6px 0;">'+'${performance.placeName}'+'</div>'
	        });
	        infowindow.open(map, marker);

	        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
	        map.setCenter(coords);
	    } 
	});   
	
	$("#bottom-info-place").hide();
	$(function(){
		$("#nav-detail-tab").click(function(){
			$("#bottom-info-place").hide();
		});
		$("#nav-casting-tab").click(function(){
			$("#bottom-info-place").hide();
		});
		$("#nav-review-tab").click(function(){
			$("#bottom-info-place").hide();
			reviewPage(1);
		});
		$("#nav-place-tab").click(function(){
			$("#bottom-info-place").show();
		});
		$("#nav-notice-tab").click(function(){
			$("#bottom-info-place").hide();
		});
	});
	
	function reviewPage(cPage){
		console.log("cPage = "+cPage);
		
		
		//사용자 입력값 : js obj -> json string 서버 전송 @RequestBody
		var param = {};
		param.cPage = cPage;
		param.performanceNo = '${performance.performanceNo}';
		
		console.log(param);
		
		
		$.ajax({
			url : "${pageContext.request.contextPath}/review/reviewList",
			data : param,
			type : "GET",
			contentType : "application/json; charset=UTF-8",
			success : function(data){
				console.log(data);
				console.log(data.reviewList);
				
				var html = ""
				for(var i=0 ; i<data.reviewList.length ; i++){
					console.log(data.reviewList[i]);
					var date = new Date(data.reviewList[i].reviewDate);
					var reviewDate = date.getFullYear() + "-" + (date.getMonth()+1) + "-" + date.getDate() ;
					
					html += '<li class="list-group-item">';
					html += '<div class="review-div">';
					html += '	<span class="review-member-id">'+data.reviewList[i].memberId+'</span>';			  		
					html += '	<span class="review-date">'+reviewDate+'</span>';			  		
					html += '	<div class="review-star" id="review'+data.reviewList[i].reviewNo+'"></div>';
					html += '	<br />';
					html += '	<span class="review-content">'+data.reviewList[i].reviewContent+'</span>';
					html += '</div>';
					html += '</li>';		
					
				}
				$("#review-table-ul").html(html);
				
				for(var i=0 ; i<data.reviewList.length ; i++){
					$('div#review'+data.reviewList[i].reviewNo).raty({
		                score: data.reviewList[i].reviewRating
		                ,readOnly: true
		                ,path : "${pageContext.request.contextPath }/resources/images/star/"
		                ,width : 120
		            });
					
				}
				
				
				reviewPageBar(data.totalContents, data.cPage, data.numPerPage, "asd");
				
				
			},
			error : function(jqxhr, textStatus, errorThrown){
				console.log("ajax처리실패 : "+jqxhr.status);
				console.log(errorThrown);
			}
		});
		
	}
	
	function reviewPageBar(totalContents, cPage, numPerPage, url){
		var pageBar = "";
		//페이지바에 표시할 페이지 수
		var pageBarSize = 5;
		//총 페이지 수 구하기
		var totalPage = Number(Math.ceil(totalContents/numPerPage));
		//pageBar 순회용변수
		var pageNo = (Math.floor((cPage-1)/pageBarSize))* pageBarSize +1;
		//마지막 페이지변수
		/* var pageEnd = pageNo + pageBarSize-1; */
		var pageEnd = (Math.floor((pageNo-1)/5) +1)*pageBarSize;
		
		/* 1 2 3 4 5  -> end : 5  */
		/* 6 7 8 9 10  -> end : 10  */
		/* 11 12 13 14 15-> end : 15  */
		
		console.log("pageNo : " + pageNo);
		console.log("pageEnd : " + pageEnd);
		
		pageBar += "<ul class='pagination justify-content-center pagination-sm'>";
		//[이전]section
		if(pageNo==1) {
			pageBar +="<li class='page-item disabled'>";
			pageBar +="<a class='page-link' href='#' tabindex='-1'>이전</a>";
			pageBar +="</li>";
		}else {
			pageBar +="<li class='page-item'>";
			pageBar +="<a class='page-link' href='javascript:paging("+(pageNo-1)+")' >이전</a>";
			pageBar +="</li>";
		}
		
		//pageNo section
		if(pageNo%(pageBarSize+1)>1){
			for(var i=1 ; i<pageNo ; i++){
				pageBar +="<li class='page-item'>";
				pageBar +="<a class='page-link' href='javascript:paging("+(i)+")' >"+i+"</a>";
				pageBar +="</li>";
			}
		}
		while(!(pageNo > pageEnd || pageNo > totalPage)) {
			//현재페이지인경우
			if(pageNo == cPage) {
				pageBar +="<li class='page-item active'>";
				pageBar +="<a class='page-link'>"+pageNo+"</a>";
				pageBar +="</li>";
			}else {
				pageBar +="<li class='page-item'>";
				pageBar +="<a class='page-link' href='javascript:paging("+(pageNo)+")' >"+pageNo+"</a>";
				pageBar +="</li>";
			}
			pageNo++;
		}
		
		//[다음]section
		//다음페이지가 없는 경우
		if(pageNo > totalPage) {
			pageBar +="<li class='page-item disabled'>";
			pageBar +="<a class='page-link' href='#'>다음</a>";
			pageBar +="</li>";
		}else {
			pageBar +="<li class='page-item'>";
			pageBar +="<a class='page-link' href='javascript:paging("+(pageNo)+")' >다음</a>";
			pageBar +="</li>";
		}
		
		pageBar += "</ul>";
		
		
		
		///paging함수
		pageBar+= "<script>";
		pageBar+= "function paging(cPage){";
		pageBar+= "		reviewPage(cPage)";		
		pageBar+= "}";		
		

		$("#reviewPaging").html(pageBar);
		
		
		
	}


</script>




<jsp:include page="/WEB-INF/views/common/footer.jsp"/>