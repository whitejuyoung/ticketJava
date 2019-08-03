<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
						class="seatall" id="${vs.index }" onclick="go(1, 1, 'BL', 1, ${vs.index}, 'ing')"  />
					</c:forEach>
					&nbsp;
		
				</div>
				<div id="line2">
					<c:forEach begin="1" end="30" varStatus="vs">
						<c:if test="${vs.index eq 11}">2</c:if>
						<c:if test="${vs.index eq 21}">2</c:if>
						<img src="${pageContext.request.contextPath }/resources/images/ticket/seat1.png" alt="예매가능" class="seatall" id="${vs.index }" />
					</c:forEach>
				</div>
				<div id="line3">
					<c:forEach begin="1" end="30" varStatus="vs">
						<c:if test="${vs.index eq 11}">3</c:if>
						<c:if test="${vs.index eq 21}">3</c:if>
						<img src="${pageContext.request.contextPath }/resources/images/ticket/seat1.png" alt="예매가능" class="seatall" id="${vs.index }" />
					</c:forEach>
				</div>
				<div id="line4">
					<c:forEach begin="1" end="30" varStatus="vs">
						<c:if test="${vs.index eq 11}">4</c:if>
						<c:if test="${vs.index eq 21}">4</c:if>
						<img src="${pageContext.request.contextPath }/resources/images/ticket/seat1.png" alt="예매가능" class="seatall" id="${vs.index }" />
					</c:forEach>
				</div>
				<div id="line5">
					<c:forEach begin="1" end="30" varStatus="vs">
						<c:if test="${vs.index eq 11}">5</c:if>
						<c:if test="${vs.index eq 21}">5</c:if>
						<img src="${pageContext.request.contextPath }/resources/images/ticket/seat1.png" alt="예매가능" class="seatall" id="${vs.index }" />
					</c:forEach>
				</div>
				<div id="line6">
					<c:forEach begin="1" end="30" varStatus="vs">
						<c:if test="${vs.index eq 11}">6</c:if>
						<c:if test="${vs.index eq 21}">6</c:if>
						<img src="${pageContext.request.contextPath }/resources/images/ticket/seat1.png" alt="예매가능" class="seatall" id="${vs.index }" />
					</c:forEach>
				</div>
				<div id="line7">
					<c:forEach begin="1" end="30" varStatus="vs">
						<c:if test="${vs.index eq 11}">7</c:if>
						<c:if test="${vs.index eq 21}">7</c:if>
						<img src="${pageContext.request.contextPath }/resources/images/ticket/seat1.png" alt="예매가능" class="seatall" id="${vs.index }" />
					</c:forEach>
				</div>
				<div id="line8">
					<c:forEach begin="1" end="30" varStatus="vs">
						<c:if test="${vs.index eq 11}">8</c:if>
						<c:if test="${vs.index eq 21}">8</c:if>
						<img src="${pageContext.request.contextPath }/resources/images/ticket/seat1.png" alt="예매가능" class="seatall" id="${vs.index }" />
					</c:forEach>
				</div>
				<div id="line9">
					<c:forEach begin="1" end="30" varStatus="vs">
						<c:if test="${vs.index eq 11}">9</c:if>
						<c:if test="${vs.index eq 21}">9</c:if>
						<img src="${pageContext.request.contextPath }/resources/images/ticket/seat1.png" alt="예매가능" class="seatall" id="${vs.index }" />
					</c:forEach>
				</div>
				<div id="line10">
					<c:forEach begin="1" end="30" varStatus="vs">
						<c:if test="${vs.index eq 11}">10</c:if>
						<c:if test="${vs.index eq 21}">10</c:if>
						<img src="${pageContext.request.contextPath }/resources/images/ticket/seat1.png" alt="예매가능" class="seatall" id="${vs.index }" />
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
			<div></div>
			<br />
			<br />
		<form id="iSeat">
			<div id="cseat">선택하신 좌석</div>
			<div id="selectSeat"></div>
			<br />
			<br />
		<button class="blueBtn" id="reservation-btn" onclick="reserve()">예매하기</button>
		</form>
		</div>
	</div>
	


</section>

<script>
/* 결제 API */
/* var IMP = window.IMP; // 생략가능
IMP.init('imp59073806'); 

IMP.request_pay({
    pg : 'html5_inicis',
    pay_method : 'card',
    merchant_uid : 'merchant_' + new Date().getTime(),
    name : '주문명:결제테스트',
    amount : 14000,
    buyer_name : '구매자이름',
}, function(rsp) {
    if ( rsp.success ) {
        var msg = '결제가 완료되었습니다.';
        msg += '결제 금액 : ' + rsp.paid_amount;
        msg += '결제 금액 : ' + rsp.buyer_name;
    } else {
        var msg = '결제에 실패하였습니다.';
        msg += '에러내용 : ' + rsp.error_msg;
    }

    alert(msg);
}); */




$(document).ready(function () {
	
	
	
	$('.seat').on('click','.seatall', function(){//버블링
	    $(this).attr('src','${pageContext.request.contextPath }/resources/images/ticket/seat2.png');
		$(this).attr('class', 'select');
		id = $(this).attr('id');
/* 		console.log(id); */

		
	})
	
	$('.seat').on('click', ".select", function(){
		$(this).prop('src','${pageContext.request.contextPath }/resources/images/ticket/seat1.png');
		$(this).prop('class', 'seatall');
		var no = $(this).attr('id');
		
		$("tr#seat"+no).remove();
	})

	
});

function reserve(){
	var data = $('form').serialize(); 

	var param = {"list":[{"seat_row":"#iSeat [name=seat_row]".val()},{"seat_no":"#iSeat [name=seat_no]".val()},
						 {"schedule_no":"#iSeat [name=schedule_no]".val()},{"performance_no":"#iSeat [name=performance_no]".val()},
						 {"place_code":"#iSeat [name=place_code]".val()},{"seat_status":"#iSeat [name=seat_status]".val()}]};
/* 	param.seat_row = $("#iSeat [name=seat_row]").val();
	param.seat_no = $("#iSeat [name=seat_no]").val();
	param.schedule_no = $("#iSeat [name=schedule_no]").val();
	param.performance_no = $("#iSeat [name=performance_no]").val();
	param.place_code = $("#iSeat [name=place_code]").val();
	param.seat_status = $("#iSeat [name=seat_status]").val();
 */	
	var str = JSON.stringify(param);
	$.ajax({

		url: "${pageContext.request.contextPath}/ticket/insertTicket.do",
		type: "POST",
		data: str,
		contentType: "application/json; charset=UTF-8",
		success: function(data){
			//console.log(data);
			alert(data.msg);
			
		},
		error: function(jqxhr, textStatus, errorThrown){
			console.log("ajax 처리 실패!: "+jqxhr.status);
			console.log(errorThrown);
		}
	});
}

function go(schedule, performance, place, row, no, status){


	var addTag = "<tr id=seat"+no+">"+
				 "<td><input type='text' value='"+row+"' id='row' readonly='readonly' name='seat_row'/><span>열 </span></td>"+
				 "<td><input type='text' value='"+no+"' id='no' readonly='readonly' name='seat_no'/></td>"+
				 "<td><input type='hidden' value='"+schedule+"' id='schedule' name='schedule_no' /></td>"+
				 "<td><input type='hidden' value='"+performance+"' id='performance' name='performance_no'/></td>"+
				 "<td><input type='hidden' value='"+place+"' id='place' name='place_code'/></td>"+
				 "<td><input type='hidden' value='"+status+"' id='status' name='seat_status'/></td>"+
				 "</tr>";
	
	$("#selectSeat").append(addTag);

	
}



</script>

	


<jsp:include page="/WEB-INF/views/common/footer.jsp"/>