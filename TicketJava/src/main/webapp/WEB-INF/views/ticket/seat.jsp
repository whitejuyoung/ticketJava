<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.*,
				com.tj.ticketjava.ticket.model.vo.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/ticket/seat.css" />
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic&display=swap" rel="stylesheet">
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<section>
    <div id="line"></div>
    
    <div id="info-container">
        <!-- 공연 정보 헤더 div-->
        <div id="information">
			<span class="bigInfo">${performance.performanceCodeName }</span>
			<span class="bigInfo">[ ${performance.performanceTitle } ]</span>
			<br />
			<span class="smallInfo">${performance.performanceCodeName } | </span>
			<span class="smallInfo">${performance.runningTime }분 | </span>
			<span class="smallInfo">만 ${performance.viewingClass }세 이상 </span>
		</div>
        
        <!-- 공연 상세 정보 div  -->
        <div id="detailInfo">
            <div id="stage">
                <div>STAGE</div>
            </div>
            <div class="seat">
                <br />
                <div id="line1">
                    &nbsp;
                    <c:forEach begin="1" end="28" varStatus="vs">
                        <c:if test="${vs.index eq 10}">1</c:if>
                        <c:if test="${vs.index eq 20}">1</c:if>
                        <img src="${pageContext.request.contextPath }/resources/images/ticket/seat1.png" alt="예매가능" 
                        class="seatall" row="1" id="a${vs.index }" onclick="go(${param.scheduleNo}, ${performance.performanceNo },  '${performance.placeCode }', 1, 'a${vs.index}', 'ing'); go2(1,${vs.index },${performance.performanceNo });"  />
                        <!-- scheduleNo, performanceNo, placeCode, row, no, status -->
                    </c:forEach>
                    &nbsp;
        
                </div>
                <div id="line2">
                    <c:forEach begin="1" end="30" varStatus="vs">
                        <c:if test="${vs.index eq 11}">2</c:if>
                        <c:if test="${vs.index eq 21}">2</c:if>
                        <img src="${pageContext.request.contextPath }/resources/images/ticket/seat1.png" alt="예매가능" 
                        class="seatall" row="2" id="b${vs.index }" onclick="go(${param.scheduleNo}, ${performance.performanceNo },  '${performance.placeCode }', 2, 'b${vs.index}', 'ing'); go2(2,${vs.index },${performance.performanceNo });"/>
                    </c:forEach>
                </div>
                <div id="line3">
                    <c:forEach begin="1" end="30" varStatus="vs">
                        <c:if test="${vs.index eq 11}">3</c:if>
                        <c:if test="${vs.index eq 21}">3</c:if>
                        <img src="${pageContext.request.contextPath }/resources/images/ticket/seat1.png" alt="예매가능" 
                        class="seatall" row="3" id="c${vs.index }" onclick="go(${param.scheduleNo}, ${performance.performanceNo },  '${performance.placeCode }', 3, 'c${vs.index}', 'ing'); go2(3,${vs.index },${performance.performanceNo });"/>
                    </c:forEach>
                </div>
                <div id="line4">
                    <c:forEach begin="1" end="30" varStatus="vs">
                        <c:if test="${vs.index eq 11}">4</c:if>
                        <c:if test="${vs.index eq 21}">4</c:if>
                        <img src="${pageContext.request.contextPath }/resources/images/ticket/seat1.png" alt="예매가능" 
                        class="seatall" row="4" id="d${vs.index }" onclick="go(${param.scheduleNo}, ${performance.performanceNo },  '${performance.placeCode }', 4, 'd${vs.index}', 'ing'); go2(4,${vs.index },${performance.performanceNo });"/>
                    </c:forEach>
                </div>
                <div id="line5">
                    <c:forEach begin="1" end="30" varStatus="vs">
                        <c:if test="${vs.index eq 11}">5</c:if>
                        <c:if test="${vs.index eq 21}">5</c:if>
                        <img src="${pageContext.request.contextPath }/resources/images/ticket/seat1.png" alt="예매가능" 
                        class="seatall" row="5" id="e${vs.index }" onclick="go(${param.scheduleNo}, ${performance.performanceNo },  '${performance.placeCode }', 5, 'e${vs.index}', 'ing'); go2(5,${vs.index },${performance.performanceNo });"/>
                    </c:forEach>
                </div>
                <div id="line6">
                    <c:forEach begin="1" end="30" varStatus="vs">
                        <c:if test="${vs.index eq 11}">6</c:if>
                        <c:if test="${vs.index eq 21}">6</c:if>
                        <img src="${pageContext.request.contextPath }/resources/images/ticket/seat1.png" alt="예매가능" 
                        class="seatall" row="6" id="f${vs.index }" onclick="go(${param.scheduleNo}, ${performance.performanceNo },  '${performance.placeCode }', 6, 'f${vs.index}', 'ing'); go2(6,${vs.index },${performance.performanceNo });"/>
                    </c:forEach>
                </div>
                <div id="line7">
                    <c:forEach begin="1" end="30" varStatus="vs">
                        <c:if test="${vs.index eq 11}">7</c:if>
                        <c:if test="${vs.index eq 21}">7</c:if>
                        <img src="${pageContext.request.contextPath }/resources/images/ticket/seat1.png" alt="예매가능" 
                        class="seatall" row="7" id="g${vs.index }" onclick="go(${param.scheduleNo}, ${performance.performanceNo },  '${performance.placeCode }', 7, 'g${vs.index}', 'ing'); go2(7,${vs.index },${performance.performanceNo });"/>
                    </c:forEach>
                </div>
                <div id="line8">
                    <c:forEach begin="1" end="30" varStatus="vs">
                        <c:if test="${vs.index eq 11}">8</c:if>
                        <c:if test="${vs.index eq 21}">8</c:if>
                        <img src="${pageContext.request.contextPath }/resources/images/ticket/seat1.png" alt="예매가능" 
                        class="seatall" row="8" id="h${vs.index }" onclick="go(${param.scheduleNo}, ${performance.performanceNo },  '${performance.placeCode }', 8, 'h${vs.index}', 'ing'); go2(8,${vs.index },${performance.performanceNo });"/>
                    </c:forEach>
                </div>
                <div id="line9">
                    <c:forEach begin="1" end="30" varStatus="vs">
                        <c:if test="${vs.index eq 11}">9</c:if>
                        <c:if test="${vs.index eq 21}">9</c:if>
                        <img src="${pageContext.request.contextPath }/resources/images/ticket/seat1.png" alt="예매가능" 
                        class="seatall" row="9" id="i${vs.index }" onclick="go(${param.scheduleNo}, ${performance.performanceNo },  '${performance.placeCode }', 9, 'i${vs.index}', 'ing'); go2(9,${vs.index },${performance.performanceNo });"/>
                    </c:forEach>
                </div>
                <div id="line10">
                    <c:forEach begin="1" end="30" varStatus="vs">
                        <c:if test="${vs.index eq 11}">10</c:if>
                        <c:if test="${vs.index eq 21}">10</c:if>
                        <img src="${pageContext.request.contextPath }/resources/images/ticket/seat1.png" alt="예매가능" 
                        class="seatall" row="10" id="j${vs.index }" onclick="go(${param.scheduleNo}, ${performance.performanceNo },  '${performance.placeCode }', 10, 'j${vs.index}', 'ing'); go2(10,${vs.index },${performance.performanceNo });"/>
                    </c:forEach>
                </div>
                <br />
                <span id="floor">&nbsp;1F&nbsp;</span>
                <br />
                <br />
                
                
                
            
            </div>
        </div>
        
        <!-- 예매하기(달력 등) div -->
        <div id="scheduleInfo">
            <div id="rseat">잔여석</div>
            <div id="possibleSeat"></div>
            <br />
            <br />
        <form>
            <div id="cseat">선택하신 좌석</div>
            <div id="selectSeat">
            <table id="tbl-seat"></table>
            </div>
            <br />
            <br />
        <button type="button" class="blueBtn" id="reservation-btn">예매하기</button>
        
        

        </form>
        </div>
    </div>
		<form action="${pageContext.request.contextPath}/ticket/payTicket.do" id="PN" method="post">
	        <input type="hidden" value="${performance.performanceNo}" name="performanceNo"/> 
 			<input type="hidden" value="0" id="passKey0" name="passKey"/>
 			<input type="hidden" value="0" id="passKey1" name="passKey"/>
 			<input type="hidden" value="0" id="passKey2" name="passKey"/>
 			<input type="hidden" value="0" id="passKey3" name="passKey"/>
 			<input type="hidden" value="0" id="passKey4" name="passKey"/>
 			<input type="hidden" value="${param.time }" id="selectedDate" name="selectedDate"/>
 			<input type="hidden" value="${param.scheduleNo}" id="scheduleNo" name="scheduleNo"/>
 			
		</form>

		<input type="hidden" value="ing" id="ing"/>
</section>
<script>
var seatCnt = null;
	
/* 좌석 선택 시 이미지 변경 */
$(document).ready(function () {
		
    $('.seat').on('click','.seatall', function(){//버블링
        $(this).attr('src','${pageContext.request.contextPath }/resources/images/ticket/seat2.png');
        $(this).attr('class', 'select');
        var id = $(this).attr('id');
        console.log(id);
        seatCnt++;
        console.log(seatCnt);
         if(seatCnt == 5){
    		alert("한번에 5장까지만 결제가능");
    		
    		$('.seatall').prop('disabled',true);
    	} 
    	

        
    })
    
    $('.seat').on('click', ".select", function(){
        $(this).prop('src','${pageContext.request.contextPath }/resources/images/ticket/seat1.png');
        $(this).prop('class', 'seatall');
        no = $(this).attr('id');
        row = $(this).attr('row');
        seatCnt--;
        console.log(seatCnt);
         if(seatCnt < 5){
        	console.log("zzzzzzz");
			$('.seatall').prop('disabled',false);
    	} 
        $("tr#seat"+row+no).remove();
        
    })
    
});

$(function(){
	var time = '${param.time}';
	var performanceNo = ${param.performanceNo};
	var scheduleNo = ${param.scheduleNo};
	var placeCode = '${param.placeCode}';
	var selectedDate = '${param.selectedDate}';
	
	function availableSeat(time,performanceNo,scheduleNo){
		var time = time;
		var performanceNo = performanceNo;

		console.log(time,performanceNo);
		
		 $.ajax({
			url:"${pageContext.request.contextPath}/performance/viewAvailableSeat",
			data:{time:time,performanceNo:performanceNo,placeCode:'${performance.placeCode}' },
			dataType: "json",
			success:function(data){
				
		
				/*판매된 티켓 표시하기*/
				showSoldTicket(time, performanceNo, scheduleNo);
				
				
				console.log(data);
				var html = "<span id='afterSelection'> "+data.availableSeat+" 석 남았습니다.</span>";
				
			$("#possibleSeat").html(html);
		},
		error: function(jqxhr){
    		  console.log("ajax 처리 실패:"+jqxhr.status);
    		  console.log("ajax 처리 실패:"+jqxhr.textStatus);
    		  console.log("ajax 처리 실패:"+jqxhr.errorThrown);

    	}

		});
		
	}
	
	availableSeat(time, performanceNo, scheduleNo);
	
});


/*판매된 티켓 표시하기*/
function showSoldTicket(time, performanceNo,scheduleNo){
	$.ajax({
		url: "${pageContext.request.contextPath}/ticket/checkSeat.do",
        type: "POST",
        data:{time:time,performanceNo:performanceNo},
		dataType: "json",
        success: function(data){
        	for(var i=0; i<data.length; i++){

        	 	if(data[i].performanceNo == performanceNo && data[i].scheduleNo == scheduleNo){
         	 		var z = "";

        	 		if(data[i].seatRow == 1)
        	 			z = "#a";
        	 		if(data[i].seatRow == 2)
        	 			z = "#b";
       	 			if(data[i].seatRow == 3)
      	 				z = "#c";
   	 				if(data[i].seatRow == 4)
   	 					z = "#d";
 					if(data[i].seatRow == 5)
 						z = "#e";
					if(data[i].seatRow == 6)
						z = "#f";
					if(data[i].seatRow == 7)
						z = "#g";
					if(data[i].seatRow == 8)
						z = "#h";
					if(data[i].seatRow == 9)
						z = "#i";
					if(data[i].seatRow == 10)
						z = "#j";	       	 	 
        	 		
		        	$(z+data[i].seatNo).attr('class','noSeat');
		        	$(z+data[i].seatNo).attr('src','${pageContext.request.contextPath }/resources/images/ticket/seat3.png');
		        	$(z+data[i].seatNo).attr('onclick','');

		        	
        	 	}
        	}
        },
        error: function(jqxhr, textStatus, errorThrown){
            console.log("ajax 처리 실패!: "+jqxhr.status);
            console.log(errorThrown);
        }
	})
}

/* 여러 좌석 선택 */
function go(schedule, performance, place, row, no, status){
    if(seatCnt >= 5){
    	return;
    }
	if(no.length==2){
		seatNo = no.substring(1,2);   	
    }
	else if(no.length==3){
		seatNo = no.substring(1,3);
	}
	else{
		seatNo = no.substring(1,4);
	}
    var addTag = 
                 "<tr class=seatInfo id=seat"+row+no+">"+
                 "<form>"+
                 "<td><input type='text' value='"+row+"' id='row' readonly='readonly' name='seatRow'/><span>열 </span></td>"+
                 "<td><input type='text' value='"+seatNo+"' id='no' readonly='readonly' name='seatNo'/>번</td>"+
                 "<td><input type='hidden' value='"+schedule+"' id='schedule' name='scheduleNo' /></td>"+
                 "<td><input type='hidden' value='"+performance+"' id='performance' name='performanceNo'/></td>"+
                 "<td><input type='hidden' value='"+place+"' id='place' name='placeCode'/></td>"+
                 "<td><input type='hidden' value='"+status+"' id='status' name='seatStatus'/></td>"+
                 "</form>"
                 "</tr>";
                 

                 
   
   
    $("#tbl-seat").append(addTag);
    

}

/* 이선좌 */
function go2(row, no, performanceNo){
	console.log(row);
	console.log(no);
	
	var scheduleNo = ${param.scheduleNo};
    $.ajax({
        url: "${pageContext.request.contextPath}/ticket/esunjoa",
        type: "POST",
        data: {row:row, no:no, scheduleNo:scheduleNo, performanceNo:performanceNo},
        success: function(data){
			 if(data>0){
				alert("이선좌");
				alert("다른 좌석을 선택해주세요!");
				location.reload();
			}else{
			} 
        	
			
        },
        error: function(jqxhr, textStatus, errorThrown){
            console.log("ajax 처리 실패!: "+jqxhr.status);
            console.log(errorThrown);
        }
    });
}

/* 선택된 좌석 controller로 보내기 */
$("#reservation-btn").click(()=>{
	//사용자입력값: js obj -> json string 서버 전송 @RequestBody
    var param = {};
    param.seatList = [];
    
    $("tr.seatInfo").each((i, elem)=>{
        var seat = {};
        seat.seatRow = $(elem).find("[name=seatRow]").val();
        seat.seatNo = $(elem).find("[name=seatNo]").val();
        seat.scheduleNo = $(elem).find("[name=scheduleNo]").val();
        seat.performanceNo = $(elem).find("[name=performanceNo]").val();
        seat.placeCode = $(elem).find("[name=placeCode]").val();
        seat.seatStatus = $(elem).find("[name=seatStatus]").val();
        param.seatList.push(seat);
    });
    
    var str = JSON.stringify(param);
    $.ajax({
        url: "${pageContext.request.contextPath}/ticket/insertTicket.do",
        type: "POST",
        data: str,
        contentType: "application/json; charset=UTF-8",
        success: function(data){
        	
 		 	for(var i=0 ; i<data.sList.length; i++){
				$("#passKey"+i).val(data.sList[i].seatKey);							

			} 
 		 	if(seatCnt<1){
				alert("좌석을 선택해수제요");
				location.reload();
 		 	}
 		 	else{
				$("#PN").submit();
 		 	}
			
        },
        error: function(jqxhr, textStatus, errorThrown){
            console.log("ajax 처리 실패!: "+jqxhr.status);
            console.log(errorThrown);
        }
    });

    

})

</script>
    
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>