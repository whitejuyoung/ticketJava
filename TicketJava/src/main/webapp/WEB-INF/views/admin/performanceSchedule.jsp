<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
 
<style>
table.type11 {
    border-collapse: separate;
    border-spacing: 1px;
    text-align: center;
    line-height: 1.5;
    margin: 20px 10px;
}
table.type11 th {
    
    width: 155px;
    padding: 10px;
    font-weight: bold;
    vertical-align: top;
    color: #fff;
    background: #8a0224 ;
}
table.type11 td {
    width: 155px;
    padding: 10px;
    vertical-align: top;
    border-bottom: 1px solid #ccc;
    background: #eee;
}

</style>

<script>
function validate(){
	var performanceTitle = $("[name=performanceTitle]");
	if(performanceTitle.val().trim().length<2){
		alert("공연 제목을 입력하세요.");
		performanceTitle.focus();
		return false;
	}
	var scheduleTime = $("[name=scheduleTime]");
	var runningTime = $("[name=scheduleDate]");
	if(runningTime.val().trim().length<2&&scheduleTime.val().trim().length<2){
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


	 var startDate = $("[name=scheduleDate]");


		if(startDate.val()<today==true){
			alert("공연일정을 확인하세요");
			return false;
		}
	
	return true;
		}

function validate2(){
	var scheduleNo = $("[name=scheduleNo]");
	if(scheduleNo.val().trim().length<2){
		alert("일정 번호를 입력하세요.");
		scheduleNo.focus();
		return false;
	}
	return true;
	
}

$(function(){
	$("tr[no]").on("click",function(){
		var scheduleNo = $(this).attr("no");//사용자속성값 가져오기
		var performanceNo = ${performance.PERFORMANCE_NO};
		//console.log("bordNo="+boardNo);
		location.href = "${pageContext.request.contextPath}/admin/buyView.do?scheduleNo="+scheduleNo+"&performanceNo="+performanceNo;
	});
});



</script>

</head>
<body>


    <div style="width: 530px; height: 500px;  border-radius: 10px; background: rgb(245, 245, 245); padding: 12px;  text-align: center; overflow: scroll;" >
            <SPAN style="font-size: 20px;">현재일정</SPAN> 
            <table class="type11">
                    <thead>
                    <tr>
                        <th scope="cols">일정번호</th>
                        <th scope="cols">공연명</th>
                        <th scope="cols">공연일정</th>
                        <th scope="cols">예매오픈일</th>
                    </tr>
                    </thead>
                    <tbody>
                    
                    <c:forEach items="${Schedule}" var="m" varStatus="vs">
                      <tr no="${m.scheduleNo}">
                                <td >${m.scheduleNo}</td>
                                <td>${performance.PERFORMANCE_TITLE}</td>
                                <td><fmt:formatDate value="${m.scheduleDate}" pattern="yyyy-MM-dd HH:mm"/></td>
                                <td><fmt:formatDate value="${m.startTicketDate}" pattern="yyyy-MM-dd HH:mm"/></td>
                      </tr>
                        </c:forEach>
                        
                    </tbody>
                 
                </table>

                <hr>

            <SPAN style="font-size: 20px;">일정추가</SPAN> 
    <form action="${pageContext.request.contextPath}/admin/scheduleend.do"
    onsubmit="return validate();">
    
            <table class="type11">
                    <thead>
                    <tr>
                        <th scope="cols">공연명</th>
                        <th scope="cols">공연일</th>
                        <th scope="cols">공연시간</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                    <input type="hidden" name="performanceNo" value="${performance.PERFORMANCE_NO}"/>
                            <td><input type="text" name="performanceTitle" id="" style="width: 100px;" value="${performance.PERFORMANCE_TITLE}" readonly="readonly"></td>
                            <td><input type="date" name="scheduleDate" id="" style="width: 150px;"></td>
                         <td><input type="time" name="scheduleTime" id="" style="width: 140px;" pattern="([1]?[0-9]|2[0-3]):[0-5][0-9]"></td>
                    </tr>      
                    </tbody>
                </table>

                <button type="submit" class="btn btn-outline-danger">일정추가</button>
    </form><br /><hr />   
 <SPAN style="font-size: 20px;">일정삭제</SPAN> 
 
  <form action="${pageContext.request.contextPath}/admin/scheduledeleteend.do"
  onsubmit="return validate2();">
    <input type="hidden" name="performanceNo" value="${performance.PERFORMANCE_NO}"/>
            <table class="type11" style="margin: auto;">
                            <td><input type="number" name="scheduleNo" id="" style="width: 120px;" placeholder="일정번호 입력">
                <button type="submit" class="btn btn-outline-danger" style="margin-top: 5px;">일정삭제</button></td>
                </table>
                
    </form>
    
    
    </div>

   
</body>
</html>