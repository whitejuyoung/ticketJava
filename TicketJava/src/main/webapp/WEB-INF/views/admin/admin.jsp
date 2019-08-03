<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
 
 <script>


//멤버 검색 ajax
 
 function searchmember() {
	 
	 var searchKeyword = $("[name=member_searchKeyword]").val();
	 var searchType = $("[name=member_searchType] option:selected").val();
	 
	 $.ajax({
		    data : {searchKeyword : searchKeyword, searchType : searchType},
		    url : "${pageContext.request.contextPath}/admin/selectmember.do",
		    success : function(data, status, xhr) {
		    	$('#membercount').html("검색된 회원수 : ["+data[0].searchCount+"]");
		    	$( '#tableList > tbody').empty();
		    	
		    	  for(var i in data){
				  		 $("#tableList").append("<tr><td name ='mem_id'>"+data[i].MEMBER_ID+"</td><td>"+data[i].MEMBER_NAME+"</td><td>"+data[i].PHONE+"</td><td>"+data[i].EMAIL+"</td><td>"+data[i].MEMBER_GRADE+"</td><td>"+data[i].TOTAL_PRICE+"</td><td>"+data[i].POINT+"</td><td ><a href='' onclick='memdelete(this); return false;' >[삭제]</a></td></tr>");
				      }
		    	
		    },
		    error: function(jqXHR, textStatus, errorThrown) {
		      alert("error= " + errorThrown);
		    }
		
		  });
	
}
 
 
 
 function placebtn() {
		 
	 var url = "${pageContext.request.contextPath}/admin/insertplace.do";
     var name = "popup test";
     var option = "width = 700, height = 500, top = 100, left = 200"
     window.open(url, name, option);
	 
}
 
 //검색어 초기화 
 
 function resetsearch() {
	 $("[name=searchKeyword]").val('');
	 $("[name=searchType]").val('');
	 location.replace('#');
}
 

 $(function(){
		$("[name=upFile]").on("change", function(){
			/* var fileName = $(this).val();//C:\\fakepath\fileName */
			//사용자가 파일입력을 취소한 경우
	 		if($(this).prop('files')[0] === undefined) {
				$(this).next(".custom-file-label").html("zz.");	
				return;			
			}
			
			var fileName = $(this).prop('files')[0].name;
			//console.log(fileName);
			
			$(this).next(".custom-file-label").html(fileName);
			
		});
	});
 
 //공연 상세정보 확인창 
 $(function(){
		$("td[no]").on("click",function(){
			var performanceNo = $(this).attr("no");
			location.href = "${pageContext.request.contextPath}/admin/performanceupdate.do?performanceNo="+performanceNo;
		});
	});
 
 //회원 삭제기능 
 
 function memdelete(x) {
	 
	 var val = (x.closest("tr").rowIndex);

	    var memberId = $("#tableList").find("tr").eq(val).find("td").eq(0).html();

	    if(!confirm("정말 삭제하시겠습니까?"))
	         return;
				 
		 $.ajax({
			    data : {memberId : memberId},
			    url : "${pageContext.request.contextPath}/admin/memberdelete.do",
			    success : function(data, status, xhr) {
			    	
			    	if(data==1) alert("회원삭제 성공");
			    	else alert("회원삭제 실패");
			    	
			   	 searchmember();

			    },
			    error: function(jqXHR, textStatus, errorThrown) {
			      alert("error= " + errorThrown);
			    }
			
			  });

}
	
 //일정관리 팝업창 
 
 function schedulepopup(performanceno) {
	 var url = "${pageContext.request.contextPath}/admin/performanceSchedule.do?performanceNo="+performanceno;
     var name = "popup test";
     var option = "width = 600, height = 600, top = 100, left = 200"
     window.open(url, name, option);
}
 
 //온로드 유효성검사 
 
 $(function(){
	 
	 var date = new Date();
	    var year = date.getFullYear();
	    var month = date.getMonth()+1
	    var day = date.getDate();
	    if(month < 10){
	        month = "0"+month;
	    }
	    if(day < 10){
	        day = "0"+day;
	    }
	 
	    var today = year+"-"+month+"-"+day;


	 var startDate = $("[name=startDate]");
	var endDate = $("[name=endDate]");
	 
	 
	 $("[name=startDate]").on("change", function(){	
		if(startDate.val()<today==true){
			alert("유효하지 않은 시간설정입니다");
			startDate.val("");
			return ;	
		}
		});
	 
	 $("[name=endDate]").on("change", function(){	
			if(endDate.val()<today==true){
				alert("유효하지 않은 시간설정입니다");
				endDate.val("");
				return ;	
			}
				if(startDate.val()>endDate.val()==true){
					alert("유효하지 않은 시간설정입니다");
					endDate.val("");
					return;
				}
			});

 }); 
 
//유효성 검사들
 
 function validate(){
		var performanceTitle = $("[name=performanceTitle]");
		if(performanceTitle.val().trim().length<2){
			alert("공연 제목을 입력하세요.");
			performanceTitle.focus();
			return false;
		}
		var casting = $("[name=casting]");
		if(casting.val().trim().length<2){
			alert("출연진을 입력하세요.");
			casting.focus();
			return false;
		}
		
	
		var placeCode = $("[name=placeCode] option:selected");
		if(placeCode.val().trim().length<2){
			alert("공연 장소를 선택하세요.");
			placeCode.focus();
			return false;
		}
		
		
		var price = $("[name=price]");
		if(price.val().trim().length<2){
			alert("가격을 입력하세요.");
			price.focus();
			return false;
		}
		
		var viewingClass = $("[name=viewingClass] option:selected");
		if(viewingClass.val().trim().length==0){
			alert("관람등급을 선택하세요.");
			viewingClass.focus();
			return false;
		}
		
		var runningTime = $("[name=runningTime]");
		if(runningTime.val().trim().length<2){
			alert("공연 시간을 입력하세요.");
			runningTime.focus();
			return false;
		}
		
		 var date = new Date();
		    var year = date.getFullYear();
		    var month = date.getMonth()+1
		    var day = date.getDate();
		    if(month < 10){
		        month = "0"+month;
		    }
		    if(day < 10){
		        day = "0"+day;
		    }
		 
		    var today = year+"-"+month+"-"+day;


		 var startDate = $("[name=startDate]");
		var endDate = $("[name=endDate]");

			if(startDate.val()<today==true){
				alert("공연일정을 확인하세요");
				return false;
			}
			if(startDate.val()>endDate.val()==true){
				alert("유효하지 않은 시간설정입니다");
				return false;
			}
		
			if($("#Pimg").prop('files')[0] === undefined) {
				alert("대표이미지 지정하세요.");
				return false;			
			}
			if($("#Dimg").prop('files')[0] === undefined) {
				alert("상세이미지 지정하세요.");
				return false;			
			}
			if($("#Cimg").prop('files')[0] === undefined) {
				alert("캐스팅이미지 지정하세요.");
				return false;			
			}
			return true;	
 }
	
 //검색 키워드가 있을떄 
 
 $(function(){
	 <%if(!"${searchKeyword}".isEmpty() && request.getParameter("searchType") != null){ %>
		$("[name=searchKeyword]").val("${searchKeyword}");
		$("[name=searchType]").val("${searchType}").prop("selected", true);
<%
	 }
	 else{
%>
	 $("[name=searchKeyword]").val('');
	 $("[name=searchType]").val("performance_title").prop("selected", true);
	 
	 <%}%>
});
 
 

 
 </script>

 
	<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="추천메뉴" name="pageTitle"/>
</jsp:include>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin.css"/>
<br /><br />
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
  
    <div class="row">
        <div class="col-4">
          <div class="list-group" id="list-tab" role="tablist" style="width: 150px; height: 300px; position: absolute; top: 100px;">
            <a class="list-group-item list-group-item-action active" id="list-home-list" data-toggle="list" href="#list-home" role="tab" aria-controls="home">공연관리</a>
            <a class="list-group-item list-group-item-action" id="list-start-list" data-toggle="list" href="#list-start" role="tab" aria-controls="start">공연등록</a>
            <a class="list-group-item list-group-item-action" id="list-profile-list" data-toggle="list" href="#list-profile" role="tab" aria-controls="profile">회원관리</a>
            <a class="list-group-item list-group-item-action" id="list-statistics-list" data-toggle="list" href="#list-statistics" role="tab" aria-controls="statistics">회원통계</a>
          </div>
        </div>
        <div class="col-8">
          <div class="tab-content" id="nav-tabContent">
          
<!-- 공연관리 시작 -->

            <div class="tab-pane fade show active" id="list-home" role="tabpanel" aria-labelledby="list-home-list">
            
            
             <h4>공연관리</h4><hr>
                    
                    
       <form action="${pageContext.request.contextPath}/admin/admin.do" >
       <span class="input-group" style="margin-left: 140px;">
                <select name="searchType">
                <option value="performance_title" selected>공연명</option>
                <option value="place_name">공연장소</option>
                <option value="performance_name">공연분류</option>
                </select>
              <input class="text" placeholder="검색어를 입력하세요" name="searchKeyword" style="width: 300px;"/>
              <input type="submit" value="검색">
              <input type="submit" value="초기화" onclick="resetsearch();"></span>
          </form>
                    <table cellspacing='0'>
                      <tr >
                        <th>공연분류</th>
                        <th>공연장소</th>
                        <th>공연명</th>
                        <th>공연시작일</th>
                        <th>공연상태</th>
                      </tr>
  
                         <c:forEach items="${performanceList}" var="m" varStatus="vs">
                      <tr>
                                <td>${m["PERFORMANCE_NAME"]}</td>
                                <td>${m["PLACE_NAME"]}</td>
                				<td  no=${m["PERFORMANCE_NO"] }><a href="#" onclick="gaja(); return false;" >${m["PERFORMANCE_TITLE"]}</a></td>
                                <td> <fmt:formatDate value="${m[\"START_DATE\"]}" pattern="yyyy.MM.dd"/></td>
                                <td><input type="button" onclick="schedulepopup(${m["PERFORMANCE_NO"] });" value="일정관리"></td>
                      </tr>
                        </c:forEach>

                    </table>
            <%
		int totalContents = Integer.parseInt(String.valueOf(request.getAttribute("totalContents")));
		int numPerPage = Integer.parseInt(String.valueOf(request.getAttribute("numPerPage")));
		int cPage = Integer.parseInt(String.valueOf(request.getAttribute("cPage")));	
	%>
	
	<%
	String Keyword = "";
	String Type = "";
	
	if(!"${searchKeyword}".isEmpty() && request.getParameter("searchKeyword") != null){ 
		 Type = request.getParameter("searchType");
		Keyword = request.getParameter("searchKeyword");}
	%>
	

	<%= com.tj.ticketjava.common.util.adminUtils.getPageBar(totalContents, cPage, numPerPage, "admin.do?searchType="+Type+"&searchKeyword="+Keyword)%>	
            </div>
            
<!-- 공연관리 끝 -->
      
          
<!-- 공연등록 시작 -->     
          
            <div class="tab-pane fade" id="list-start" role="tabpanel" aria-labelledby="list-start-list">
                <h4>공연등록</h4>
                <hr>

   
          <form name="performanceFrm" 
		  action="${pageContext.request.contextPath}/admin/performanceinsert.do" 
		  method="post" 
		  onsubmit="return validate();"
		  enctype="multipart/form-data">


                <p id="title_span">공연제목                                 
                
                <input type="text" class="form-control" id="performanceTitle" placeholder="공연제목을 입력하세요" name="performanceTitle" required>
                
               </p>
                    
               <p id="cast_span">출연진                                 
                
                    <input type="text" class="form-control" id="formGroupExampleInput" placeholder="출연진을 입력하세요" name="casting">
                    
            </p>
             


                   <p id="image_span">대표 이미지    <br>                    
                        <span class="file_span" >
                    <input type="file" class="custom-file-input" name="upFile" id="Pimg" multiple>
		                      <label class="custom-file-label" for="upFile1" style="width: 300px;">파일을 선택하세요</label>
                        <input type="hidden" id="Ptag" name="tag">
                      </span>
                       </p>

                    <p id="category_span" class="checks" >카테고리 <br>
                                           
                        
                        <input type="radio" id="rd1" name="performanceCode" value="TH" checked="checked"> <label for="rd1" >연극</label>
                        <input type="radio" id="rd2" name="performanceCode" value="MU"> <label for="rd2" >뮤지컬</label>
                        <input type="radio" id="rd3" name="performanceCode" value="CO"> <label for="rd3" >콘서트</label>
                          
                        </p>
    

                    <p id="showstart_span">공연시작 일자                          
                
                    <input type="date" class="form-control" id="formGroupExampleInput2" placeholder="공연제목을 입력하세요" name="startDate">
                                
                     </p>

                     <p id="showend_span">공연종료 일자                                
                
                            <input type="date" class="form-control" id="formGroupExampleInput2" placeholder="공연제목을 입력하세요" name="endDate">
                                        
                    </p>

                    <p id="hall_span">공연장소                <a href="#" onclick="placebtn(); return false;"  style="font-size: 12px; color: red; margin-left: 15px;">[공연장 추가+]</a>                 
                
                            <select class="form-control" id="formGroupExampleInput2"  name="placeCode">
                            
                            <option value="" selected="selected">장소 선택</option>
                            <c:forEach items="${place}" var="m">
                            <option value="${m["PLACE_CODE"]}">${m["PLACE_NAME"]}</option>
                            
                            </c:forEach>
                            </select>
                    </p>


                    <p id="price_span">가격                                 
                
                            <input type="number" class="form-control" id="formGroupExampleInput2" placeholder="가격을 입력하세요" name="price"> 
                            
                    </p>
                    <p id="time_span">러닝타임                                 
                
                            <input type="number" class="form-control" id="formGroupExampleInput2" placeholder="러닝타임을 입력하세요" name="runningTime">
                            
                    </p>
                    <p id="grade_span">관람등급                                 
                
                            <select class="form-control" id="formGroupExampleInput2"  name="viewingClass">
                            <option value="" selected="selected">관람등급 선택</option>
                            <option value="0">전체 관람가능</option>
                            <option value="12" >12세 관람가능</option>
                            <option value="15" >15세 관람가능</option>
                            <option value="19" >19세 관람가능</option>

                            </select>
                    </p>


                    <p id="information_span">상세정보    <br>                    
                     <span class="file_span" >
                    <input type="file" class="custom-file-input" name="upFile" id="Dimg" multiple>
		                      <label class="custom-file-label" for="upFile1" style="width: 300px;">파일을 선택하세요</label>
                        <input type="hidden" id="Dtag" name="tag">
                      </span>
                       </p>

                       
                   <p id="casting_span">캐스팅 캘린더    <br>                    
                    <span class="file_span" >
                    <input type="file" class="custom-file-input" name="upFile" id="Cimg" multiple>
		                      <label class="custom-file-label" for="upFile1" style="width: 300px;">파일을 선택하세요</label>
                        <input type="hidden" id="Ctag" name="tag">
                      </span>
                       </p>

						<p id="main_span">메인 이미지    <br>                    
                    	<span class="file_span" >
                    		<input type="file" class="custom-file-input" name="upFile" id="Mimg" multiple>
		                      <label class="custom-file-label" for="upFile1" style="width: 300px;">파일을 선택하세요</label>
                        	<input type="hidden" id="Mtag" name="tag">
                      	</span>
                    </p>


                <p id="submit_span">
                    <input type="submit" class="btn btn-dark" >
                </p>
            </form>
            </div>
<!-- 공연등록 끝 -->



      
<!-- 회원관리 시작 --> 
      
            <div class="tab-pane fade" id="list-profile" role="tabpanel" aria-labelledby="list-profile-list" style="overflow-y:scroll; width: 850px;" >
             
                    <h4>회원관리 <span style="font-size: 15px">&nbsp; <sapn id="membercount"> 전체회원수 : [${ member_totalContents}] </sapn> <hr></span> </h4>
                    <br>
                    
                    <form action="${pageContext.request.contextPath}/admin/selectmember.do" >
       <span class="input-group" style="margin-left: 180px;" >
                <select name="member_searchType">
                <option value="member_id" selected>아이디</option>
                <option value="member_name">이름</option>
                <option value="member_grade">회원등급</option>
                </select>
              <input class="text" placeholder="검색어를 입력하세요" name="member_searchKeyword" style="width: 300px;"/>
              <input type="button" value="검색" onclick="searchmember();"></span>
          </form>
                    
                    <table class="type08" id="tableList" >
                            <thead>
                              <tr>
                                <th scope="col">아이디</th>
                                <th scope="col">이름</th>
                                <th scope="col">전화번호</th>
                                <th scope="col">이메일</th>
                                <th scope="col">회원등급</th>
                                <th scope="col">사용금액</th>
                                <th scope="col">포인트</th>
                                <th scope="col">회원삭제</th>
                              </tr>
                            </thead>
                            <tbody >
                            <c:forEach items="${memberList}" var="m" varStatus="vs">
                              <tr>
                                <td>${m["MEMBER_ID"]}</td>
                                <td>${m["MEMBER_NAME"]}</td>
                                <td>${m["PHONE"]}</td>
                                <td>${m["EMAIL"]}</td>
                                <td>${m["MEMBER_GRADE"]}</td>
                                <td>${m["TOTAL_PRICE"]}</td>
                                <td>${m["POINT"]}</td>
                                <td ><a href="" onclick="memdelete(this); return false;" >[삭제]</a></td>
                              </tr>
                           </c:forEach>
                            </tbody>
                          </table>
	
            </div>
            
<!-- 회원관리 끝 --> 
           
<div class="tab-pane fade" id="list-statistics" role="tabpanel" aria-labelledby="list-statistics-list" >



                    <h4>회원통계 <span style="font-size: 15px">&nbsp;</span></h4>
          	
                    <hr>
                    <br />
                   
        
          <span class="qa-widget-side qa-widget-side-top" >
                <div class="qa-activity-count" style="height: 250px; position: relative; left: 15px;">
                    <p class="qa-activity-count-item">
                        <span class="qa-activity-count-data"> ${ member_totalContents}</span>전체회원수
                    </p>
                    <p class="qa-activity-count-item">
                        <span class="qa-activity-count-data">${todaypurchaseCount }</span>금일티켓판매
                    </p>
                    <p class="qa-activity-count-item">
                        <span class="qa-activity-count-data">${performanceTotalCount }</span>전체공연수
                    </p>
                    <p class="qa-activity-count-item">
                        <span class="qa-activity-count-data">${todayScheduleCount }</span>금일공연수
                    </p>
                </div>
                
                 <br><br>
                
                        <a id="resetButton1" class="myButton" style="display: none;">RESET BAR CHART</a>
                        <a id="resetButton2" class="myButton" style="position: relative; left: 290px; text-outline: 8px;	70px;">연령대별 통계</a>
                        <a id="resetButton3" class="myButton" style="display: none;">RESET PIE CHART</a>
                    
                        <div id='dashboard' style="position: relative; left: 0px; height: 370px;">
                            
                        </div>
                        <script src="http://d3js.org/d3.v3.min.js"></script>
                        <script>
                            function dashboard(id, fData) {
                                
                                var el = document.getElementById('resetButton1');
                                el.onclick = () => {
                                    hG.update(fData.map(function(v) {
                                            return [v.State, v.total];
                                        }), barColor);
                                };
                                var el = document.getElementById('resetButton2');
                                el.onclick = () => {
                                    pC.update(tF);
                                    leg.update(tF);
                                    hG.update(fData.map(function(v) {
                                            return [v.State, v.total];
                                        }), barColor);
                                };
                                var el = document.getElementById('resetButton3');
                                el.onclick = () => {
                                    pC.update(tF);
                            leg.update(tF);
                                };
                                
                                var barColor = 'steelblue';
                    
                                function segColor(c) {
                                    return {
                                        남성: "skyblue",
                                        여성: "tomato"
                                     
                                    }[c];
                                }
                                // compute total for each state.
                                fData.forEach(function(d) {
                                    d.total = d.freq.남성 + d.freq.여성;
                                });
                                // function to handle histogram.
                                function histoGram(fD) {
                                    var hG = {},
                                        hGDim = {
                                            t: 60,
                                            r: 0,
                                            b: 30,
                                            l: 0
                                        };
                                    hGDim.w = 500 - hGDim.l - hGDim.r,
                                        hGDim.h = 300 - hGDim.t - hGDim.b;
                                    //create svg for histogram.
                                    var hGsvg = d3.select(id).append("svg")
                                        .attr("width", hGDim.w + hGDim.l + hGDim.r)
                                        .attr("height", hGDim.h + hGDim.t + hGDim.b).append("g")
                                        .attr("transform", "translate(" + hGDim.l + "," + hGDim.t + ")");
                                    // create function for x-axis mapping.
                                    var x = d3.scale.ordinal().rangeRoundBands([0, hGDim.w], 0.1)
                                        .domain(fD.map(function(d) {
                                            return d[0];
                                        }));
                                    // Add x-axis to the histogram svg.
                                    hGsvg.append("g").attr("class", "x axis")
                                        .attr("transform", "translate(0," + hGDim.h + ")")
                                        .call(d3.svg.axis().scale(x).orient("bottom"));
                                    // Create function for y-axis map.
                                    var y = d3.scale.linear().range([hGDim.h, 0])
                                        .domain([0, d3.max(fD, function(d) {
                                            return d[1];
                                        })]);
                                    // Create bars for histogram to contain rectangles and freq labels.
                                    var bars = hGsvg.selectAll(".bar").data(fD).enter()
                                        .append("g").attr("class", "bar");
                                    //create the rectangles.
                                    bars.append("rect")
                                        .attr("x", function(d) {
                                            return x(d[0]);
                                        })
                                        .attr("y", function(d) {
                                            return y(d[1]);
                                        })
                                        .attr("width", x.rangeBand())
                                        .attr("height", function(d) {
                                            return hGDim.h - y(d[1]);
                                        })
                                        .attr('fill', barColor)
                                        .on("click", mouseover) // mouseover is defined below.
                                        .on("dblclick", mouseout); // mouseout is defined below.
                                    //Create the frequency labels above the rectangles.
                                    bars.append("text").text(function(d) {
                                            return d3.format(",")(d[1])
                                        })
                                        .attr("x", function(d) {
                                            return x(d[0]) + x.rangeBand() / 2;
                                        })
                                        .attr("y", function(d) {
                                            return y(d[1]) - 5;
                                        })
                                        .attr("text-anchor", "middle");
                    
                                    function mouseover(d) { // utility function to be called on mouseover.
                                        // filter for selected state.
                                        var st = fData.filter(function(s) {
                                                return s.State == d[0];
                                            })[0],
                                            nD = d3.keys(st.freq).map(function(s) {
                                                return {
                                                    type: s,
                                                    freq: st.freq[s]
                                                };
                                            });
                                        // call update functions of pie-chart and legend.    
                                        pC.update(nD);
                                        leg.update(nD);
                                    }
                    
                                    function mouseout(d) { // utility function to be called on mouseout.
                                        // reset the pie-chart and legend.    
                                        pC.update(tF);
                                        leg.update(tF);
                                    }
                                    // create function to update the bars. This will be used by pie-chart.
                                    hG.update = function(nD, color) {
                                        // update the domain of the y-axis map to reflect change in frequencies.
                                        y.domain([0, d3.max(nD, function(d) {
                                            return d[1];
                                        })]);
                                        // Attach the new data to the bars.
                                        var bars = hGsvg.selectAll(".bar").data(nD);
                                        // transition the height and color of rectangles.
                                        bars.select("rect").transition().duration(500)
                                            .attr("y", function(d) {
                                                return y(d[1]);
                                            })
                                            .attr("height", function(d) {
                                                return hGDim.h - y(d[1]);
                                            })
                                            .attr("fill", color);
                                        // transition the frequency labels location and change value.
                                        bars.select("text").transition().duration(500)
                                            .text(function(d) {
                                                return d3.format(",")(d[1])
                                            })
                                            .attr("y", function(d) {
                                                return y(d[1]) - 5;
                                            });
                                    }
                                    return hG;
                                }
                                // function to handle pieChart.
                                function pieChart(pD) {
                                    var pC = {},
                                        pieDim = {
                                            w: 250,
                                            h: 250
                                        };
                                    pieDim.r = Math.min(pieDim.w, pieDim.h) / 2;
                                    // create svg for pie chart.
                                    var piesvg = d3.select(id).append("svg")
                                        .attr("width", pieDim.w).attr("height", pieDim.h).append("g")
                                        .attr("transform", "translate(" + pieDim.w / 2 + "," + pieDim.h / 2 + ")");
                                    // create function to draw the arcs of the pie slices.
                                    var arc = d3.svg.arc().outerRadius(pieDim.r - 10).innerRadius(0);
                                    // create a function to compute the pie slice angles.
                                    var pie = d3.layout.pie().sort(null).value(function(d) {
                                        return d.freq;
                                    });
                                    // Draw the pie slices.
                                    piesvg.selectAll("path").data(pie(pD)).enter().append("path").attr("d", arc)
                                        .each(function(d) {
                                            this._current = d;
                                        })
                                        .style("fill", function(d) {
                                            return segColor(d.data.type);
                                        })
                                        .on("click", mouseover).on("dblclick", mouseout);
                                    // create function to update pie-chart. This will be used by histogram.
                                    pC.update = function(nD) {
                                        piesvg.selectAll("path").data(pie(nD)).transition().duration(500)
                                            .attrTween("d", arcTween);
                                    }
                                    // Utility function to be called on mouseover a pie slice.
                                    function mouseover(d) {
                                        // call the update function of histogram with new data.
                                        hG.update(fData.map(function(v) {
                                            return [v.State, v.freq[d.data.type]];
                                        }), segColor(d.data.type));
                                    }
                                    //Utility function to be called on mouseout a pie slice.
                                    function mouseout(d) {
                                        // call the update function of histogram with all data.
                                        hG.update(fData.map(function(v) {
                                            return [v.State, v.total];
                                        }), barColor);
                                    }
                                    // Animating the pie-slice requiring a custom function which specifies
                                    // how the intermediate paths should be drawn.
                                    function arcTween(a) {
                                        var i = d3.interpolate(this._current, a);
                                        this._current = i(0);
                                        return function(t) {
                                            return arc(i(t));
                                        };
                                    }
                                    return pC;
                                }
                                // function to handle legend.
                                function legend(lD) {
                                    var leg = {};
                                    // create table for legend.
                                    var legend = d3.select(id).append("table").attr('class', 'legend');
                                    // create one row per segment.
                                    var tr = legend.append("tbody").selectAll("tr").data(lD).enter().append("tr");
                                    // create the first column for each segment.
                                    tr.append("td").append("svg").attr("width", '16').attr("height", '16').append("rect")
                                        .attr("width", '16').attr("height", '16')
                                        .attr("fill", function(d) {
                                            return segColor(d.type);
                                        });
                                    // create the second column for each segment.
                                    tr.append("td").text(function(d) {
                                        return d.type;
                                    });
                                    // create the third column for each segment.
                                    tr.append("td").attr("class", 'legendFreq')
                                        .text(function(d) {
                                            return d3.format(",")(d.freq);
                                        });
                                    // create the fourth column for each segment.
                                    tr.append("td").attr("class", 'legendPerc')
                                        .text(function(d) {
                                            return getLegend(d, lD);
                                        });
                                    // Utility function to be used to update the legend.
                                    leg.update = function(nD) {
                                        // update the data attached to the row elements.
                                        var l = legend.select("tbody").selectAll("tr").data(nD);
                                        // update the frequencies.
                                        l.select(".legendFreq").text(function(d) {
                                            return d3.format(",")(d.freq);
                                        });
                                        // update the percentage column.
                                        l.select(".legendPerc").text(function(d) {
                                            return getLegend(d, nD);
                                        });
                                    }
                    
                                    function getLegend(d, aD) { // Utility function to compute percentage.
                                        return d3.format("%")(d.freq / d3.sum(aD.map(function(v) {
                                            return v.freq;
                                        })));
                                    }
                                    return leg;
                                }
                                // calculate total frequency by segment for all state.
                                var tF = ['남성', '여성'].map(function(d) {
                                    return {
                                        type: d,
                                        freq: d3.sum(fData.map(function(t) {
                                            return t.freq[d];
                                        }))
                                    };
                                });
                                // calculate total frequency by state for all segment.
                                var sF = fData.map(function(d) {
                                    return [d.State, d.total];
                                });
                                var hG = histoGram(sF), // create the histogram.
                                    pC = pieChart(tF), // create the pie-chart.
                                    leg = legend(tF); // create the legend.
                            }
                        </script>
                    
                        <script>
                    	
                        var woman = new Array(0,0,0,0,0,0,0,0,0,0);
                        var man = new Array(0,0,0,0,0,0,0,0,0,0);
               
                        
<c:forEach items="${statistics}" var="s" varStatus="status">

if('${s["GENDER"]}'=='M') man[(${s["AGES"]}/10)] = ${s["AGE_NO"]};
else woman[(${s["AGES"]}/10)] = ${s["AGE_NO"]};

</c:forEach>

                        var freqData = [{
                            State: '0~9세',
                            freq: {
                                남성: Number(man[0]),
                                여성: Number(woman[0]),
                                
                            }
                        }, {
                            State: '10대',
                            freq: {
                            	  남성: Number(man[1]),
                                  여성: Number(woman[1]),
                                
                            }
                        }, {
                            State: '20대',
                            freq: {
                            	  남성: Number(man[2]),
                                  여성: Number(woman[2]),
                              
                            }
                        }, {
                            State: '30대',
                            freq: {
                            	  남성: Number(man[3]),
                                  여성: Number(woman[3]),
                                
                            }
                        }, {
                            State: '40대',
                            freq: {
                            	  남성: Number(man[4]),
                                  여성: Number(woman[4]),
                             
                            }
                        }, {
                            State: '50대',
                            freq: {
                            	  남성: Number(man[5]),
                                  여성: Number(woman[5]),
                            
                            }
                        }, {
                            State: '60대',
                            freq: {
                            	  남성: Number(man[6]),
                                  여성: Number(woman[6]),
                           
                            }
                        }, {
                            State: '70대',
                            freq: {
                            	  남성: Number(man[7]),
                                  여성: Number(woman[7]),
                           
                            }
                        }, {
                            State: '80대',
                            freq: {
                            	  남성: Number(man[8]),
                                  여성: Number(woman[8]),
                          
                            }
                        }, {
                            State: '90대',
                            freq: {
                            	  남성: Number(man[9]),
                                  여성: Number(woman[9]),
                             
                            }
                        }];
                        dashboard('#dashboard', freqData);
                    </script>



        </span>
    </div>
</div>
</body>

</html>