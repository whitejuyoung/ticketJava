<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
 
 <script>
 

 $(function(){
	 
		$("#Pimg").on("change", function(){
			$("#Ptag").val("[P]"+$(this).prop('files')[0].name)
	});
		
		$("#Dimg").on("change", function(){
			$("#Dtag").val("[D]"+$(this).prop('files')[0].name)
	});
		
		$("#Cimg").on("change", function(){
			$("#Ctag").val("[C]"+$(this).prop('files')[0].name)
	});
	
		$("#Mimg").on("change", function(){
			$("#Mtag").val("[M]"+$(this).prop('files')[0].name)
	});
		
});
 

 
 
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
 
 
 $(function(){
	 
		 $("#Pimg").next(".custom-file-label").html("${image[0].originalFileName}");	
		
		 $("#Dimg").next(".custom-file-label").html("${image[1].originalFileName}");	
		 
		 $("#Cimg").next(".custom-file-label").html("${image[2].originalFileName}");
		 
		 $("#Mimg").next(".custom-file-label").html("${image[3].originalFileName}");
		 
		 $("#place").val("${performance.PLACE_CODE}").prop("selected", true);
		 $("#view").val("${performance.VIEWING_CLASS}").prop("selected", true);
		 $("[name=performanceCode]").val("${performance.PERFORMANCE_CODE}").prop("checked", true);
		 $("[name=startDate]").val("<fmt:formatDate value="${performance.START_DATE}" pattern="yyyy-MM-dd"/>");
		 $("[name=endDate]").val("<fmt:formatDate value="${performance.END_DATE}" pattern="yyyy-MM-dd"/>");
		 
	
	});
 
 
 $(function(){
		$("td[no]").on("click",function(){
			var performanceNo = $(this).attr("no");//사용자속성값 가져오기
			//console.log("bordNo="+boardNo);
			location.href = "${pageContext.request.contextPath}/admin/performanceupdate.do?performanceNo="+performanceNo;
		});
	});
 

 function schedulepopup() {
	 var url = "popup.jsp";
     var name = "popup test";
     var option = "width = 600, height = 600, top = 100, left = 200"
     window.open(url, name, option);
}
 
 function getFormatDate(date){ 
	 var year = date.getFullYear();	
	 var month = (1 + date.getMonth());
	 month = month >= 10 ? month : '0' + month;	
	 var day = date.getDate();	
	 day = day >= 10 ? day : '0' + day;	
	  return year + '' + month + '' + day; 
	  }

 
 
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
		
	
			return true;	
 }
	

 </script>

 
	<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="추천메뉴" name="pageTitle"/>
</jsp:include>
		

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin.css"/>


    <br />
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
  
    <div class="row">
        <div class="col-4">
          <div class="list-group" id="list-tab" role="tablist" style="width: 150px; height: 300px; position: absolute; top: 200px;">
            <a class="list-group-item list-group-item-action active" id="list-home-list" data-toggle="list" href="#list-home" role="tab" aria-controls="home">공연수정</a>
          
          </div>
        </div>
        <div class="col-8">
          <div class="tab-content" id="nav-tabContent">
          
          
<!-- 공연등록 시작 -->     
          
          
            <div class="tab-pane fade show active" id="list-home" role="tabpanel" aria-labelledby="list-home-list">
                <h4>공연수정</h4>
                <hr>

                <p id="performance_p">
                
             <form name="performanceFrm" 
		  action="${pageContext.request.contextPath}/admin/performanceupdateend.do" 
		  method="post" 
		  onsubmit="return validate();"
		  enctype="multipart/form-data">


                <p id="title_span">공연제목                                 
                <input type="hidden" name="performanceNo" value="${performanceNo}" />
                <input type="text" class="form-control" id="performanceTitle" value="${performance.PERFORMANCE_TITLE}" name="performanceTitle" required>
                
               </p>
                    
               <p id="cast_span">출연진                                 
                
                    <input type="text" class="form-control" id="formGroupExampleInput" value="${performance.CASTING}" name="casting">
                    
            </p>
             


                   <p id="image_span">대표 이미지    <br>                    
                        <span class="file_span" >
                    <input type="file" class="custom-file-input" name="upFile" id="Pimg" multiple>
		                      <label class="custom-file-label" for="upFile1" style="width: 300px;">파일을 선택하세요</label>
                        <input type="hidden" id="Ptag" name="tag" value="">
                      </span>
                       </p>

                    <p id="category_span" class="checks" >카테고리 <br>
                                           
            
                        <input type="radio" id="rd1" name="performanceCode" value="TH" checked="checked"> <label for="rd1" >연극</label>
                        <input type="radio" id="rd2" name="performanceCode" value="MU"> <label for="rd2" >뮤지컬</label>
                        <input type="radio" id="rd3" name="performanceCode" value="CO"> <label for="rd3" >콘서트</label>
                          
                        </p>
    

                    <p id="showstart_span">공연시작 일자                          
                
                    <input type="date" class="form-control" id="formGroupExampleInput2" value="${performance.START_DATE}" name="startDate">
                                
                     </p>

                     <p id="showend_span">공연종료 일자                                
                
                            <input type="date" class="form-control" id="formGroupExampleInput2" value="${performance.END_DATE}" name="endDate">
                                        
                    </p>

                  <p id="hall_span">공연장소                                 
                
                            <select class="form-control" id="place"  name="placeCode" >
                            
                            <option value="" selected="selected">장소 선택</option>
                            <c:forEach items="${place}" var="m">
                            <option value="${m["PLACE_CODE"]}">${m["PLACE_NAME"]}</option>
                            
                            </c:forEach>
                            </select>
                           </p>


                    <p id="price_span">가격                                 
                
                            <input type="number" class="form-control" id="formGroupExampleInput2" value="${performance.PRICE}"  name="price"> 
                            
                    </p>
                    <p id="time_span">러닝타임                                 
                
                            <input type="number" class="form-control" id="formGroupExampleInput2" value="${performance.RUNNING_TIME}"  name="runningTime">
                            
                    </p>
                    <p id="grade_span">관람등급                                 
                
                            <select class="form-control" id="view"  name="viewingClass">
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
                        <input type="hidden" id="Dtag" name="tag" value="">
                      </span>
                       </p>

                       
                 <p id="casting_span">캐스팅 캘린더    <br>                    
                    <span class="file_span" >
                    <input type="file" class="custom-file-input" name="upFile" id="Cimg" multiple>
		                      <label class="custom-file-label" for="upFile1" style="width: 300px;">파일을 선택하세요</label>
                        <input type="hidden" id="Ctag" name="tag" value="">
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
                    <input type="submit" class="btn btn-dark" value="수정">
                </p>
            </form>
            </div>
<!-- 공연등록 끝 -->





		</section>
		
		<footer>
		</footer>
		
	</div>
</body>

</html>