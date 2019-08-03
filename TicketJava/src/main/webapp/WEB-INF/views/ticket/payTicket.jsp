<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.*,
                com.tj.ticketjava.ticket.model.vo.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/ticket/payTicket.css" />
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
    </div>
    
            
    <!-- 공연 상세 정보 div  -->
    <div id="detailInfo">
       <div id=""><ul class="title"><li  class="titleList" id="">선택좌석 가격선택</li></ul></div>
       <div class="smalltitle">정가<span><input type="text" id="price" value="${performance.price }원"/></span>
        <select name="" id="seatArr"><option value="${seatNum.size()}">${seatNum.size()}매</option></select></div>
       <div id=""><ul class="title"><li class="titleList" id="">포인트사용</li></ul></div>
       <div class="smalltitle">나의 보유 포인트
            <span id="myPoint"> ${memberLoggedIn.point }P</span>
            <input type="number"  step="500" id="selectPoint" value="0" min="0" max="${memberLoggedIn.point }" 
            onkeyPress="if ((event.keyCode<48) || (event.keyCode>57)) event.returnValue=false;"/>
            <button class="blueBtn" id="usePointBtn">사용</button>
            
            
       </div>
       <div id=""><ul class="title"><li class="titleList" id="">티켓 수령 방법</li></ul></div>
       <div class="smalltitle">
           <div>
               <input class="receiveTicket" type="radio" name="receiveOption" id="receive" value="receive" checked>
               <label for="receive">현장수령</label><br />
           </div>
           
           
           
           <%-- <jsp:useBean id="today" class="java.util.Date" />
			<fmt:formatDate value="${today}" pattern="yyyy-MM-dd" var="today" />
            <fmt:parseDate value="${today }" var="TodayDate" pattern="yyyy/MM/dd"/>
			<fmt:parseNumber value="${TodayDate.time / (1000*60*60*24)}" integerOnly="true" var="todayTime"></fmt:parseNumber>
			<c:set var="scheduleDateDay" value="${fn:substring(selectedDate,0,10)}">
			</c:set>
			
			<fmt:parseDate value="${scheduleDateDay }" var="scheduleDate" pattern="yyyy/MM/dd"/>
			<fmt:parseNumber value="${scheduleDateDay.time / (1000*60*60*24)}" integerOnly="true" var="scheduleDateTime"></fmt:parseNumber>

			<c:if test="${scheduleDateTime - todayTime >= 7}"> --%>
			<%-- 
			<jsp:useBean id="today" class="java.util.Date" />
			<fmt:formatDate value="${today}" pattern="yyyy-MM-dd" var="today" />  
           	<fmt:parseDate var="dateString" value="${selectedDate}" pattern="yyyy-MM-dd HH:mm:ss" /> 
			<fmt:formatDate var="scheduleDate" value="${dateString}" pattern="yyyy-MM-dd" />
			
			<c:if test="${today  >= scheduleDate }"> --%>
				<div>
	               <input class="receiveTicket" type="radio" name="receiveOption" id="mail" value="mail" >
	               <label for="mail">우편배송(3000원)</label><br />
	             
	             <div id="zooso">
		           	<input class="addressInput" id="address1" type="text" placeholder="주소를 검색하세요." readonly/>
						<br />
						<input class="addressInput" id="address2" type="text" placeholder="상세 주소 입력"/>
						<br />
						<button class="addressBtn" id="addressSearchBtn" onclick="execDaumPostcode();">주소 검색</button>
	             </div>  
	           </div>
           <%--  </c:if> --%>
           
				
           
       </div>
       <div id=""><ul class="title"><li class="titleList" id="">결제 방법</li></ul></div>
       <div class="smalltitle">
           <div>
               <input type="radio" name="paymentOption" id="card" value="" checked>
               <label  class="form-check-label" for="card">신용카드</label><br />
           </div>
           <div>
               <input type="radio" name="paymentOption" id="cash" value="" >
               <label  class="form-check-label" for="cash">무통장입금</label>
           </div>
        </div>
    </div>
    <!-- 예매하기(달력 등) div -->
    <div id="scheduleInfo">
        <div id="ticketPriceTitle">
            티켓금액<br />
            <span id="ticketPrice"></span>원
        </div>

        <div id=seatInfo>
        
        </div>
        
        <table id="chartTable">
        	<tr>
        		<th><span id="chartTitle1">티켓금액</span></th>
        		<td><span id="ticketPriceSpan" class="chartPrice"></span>원</td>
        	</tr>
        	<tr>
        		<th><span id="chartTitle2">수수료</span></th>
        		<td><span id="ticketChargeSpan" class="chartPrice"></span>원</td>
        	</tr>
        	<tr>
        		<th><span id="chartTitle3">배송료</span></th>
        		<td><span id="mailChargeSpan" class="chartPrice"></span>원</td>
        	</tr>
        	<tr>
        		<th><span id="chartTitle4">할인</span></th>
        		<td><span id="ticketDCSpan" class="chartPrice">0</span>원</td>
        	</tr>
        </table>
        
        <!-- <div id=chart>
            <div id="chartInfo1"><span id="chartTitle1">티켓금액</span> <span id="ticketPriceSpan" class="chartPrice"></span>원</div>
            <div id="chartInfo2"><span id="chartTitle2">수수료</span> <span id="ticketChargeSpan" class="chartPrice"></span>원</div>
            <div id="chartInfo3"><span id="chartTitle3">배송료</span> <span id="mailChargeSpan" class="chartPrice"></span>원</div>
            <div id="chartInfo4" id="bottomlineChart"><span id="chartTitle4">할인</span> <span id="ticketDCSpan" class="chartPrice">0</span>원</div>
        </div> -->
        <div id="allPrice">
            결제예정금액 <br />
             <span id="allPriceSpan"></span>원
        </div>
        <button type="button" class="blueBtn" id="reservation-btn">예매하기</button>
        <button type="button" class="blueBtn" id="cancel-btn">뒤로가기</button>
    </div>
	
	    <input type="hidden" id="seatInfo0" name=seatInfo value=""/>
	    <input type="hidden" id="seatInfo1" name=seatInfo value=""/>
	    <input type="hidden" id="seatInfo2" name=seatInfo value=""/>
	    <input type="hidden" id="seatInfo3" name=seatInfo value=""/>
	    <input type="hidden" id="seatInfo4" name=seatInfo value=""/>
	    
	<form action="${pageContext.request.contextPath}/ticket/addTicket" id="PN" method="post">
	    <input type="hidden" id="memberId" name=memberId value="${memberLoggedIn.memberId }"/>
	    <input type="hidden" id="memberName" name=memberName value="${memberLoggedIn.memberName }"/>
	    <input type="hidden" id="performanceCode" name=performanceCode value="${performance.performanceCode }"/>
	    <input type="hidden" id="placeCode" name=placeCode value="${performance.placeCode }"/>
	    <input type="hidden" id="scheduleNo" name=scheduleNo value="${scheduleNo }"/>
	    <input type="hidden" id="totalPrice" name=totalPrice value=""/>
	    <input type="hidden" id="ticketOnePrice" name=ticketOnePrice value="${performance.price }"/>
	    <input type="hidden" id="purchaseCount" name=purchaseCount value=""/>
	    <input type="hidden" id="performanceTitle" name=performanceTitle value="${performance.performanceTitle }"/>
	    <input type="hidden" id="scheduleDate" name=scheduleDate value=""/>
	    <input type="hidden" id="performancePlace" name=performancePlace value="${performance.placeName }"/>
	    <input type="hidden" id="paymentStatus" name=paymentStatus value="O"/>
	    <input type="hidden" id="ticketWay" name=ticketWay value="DIRECT"/>
	    <input type="hidden" id="performanceNo" name=performanceNo value="${performance.performanceNo }"/>
	    <input type="hidden" id="usePoint" name=usePoint value="0"/>
	    <input type="hidden" id="address" name=address value=""/>
	    <input type="hidden" id="seatR0" name=seatR value=""/>
	    <input type="hidden" id="seatR1" name=seatR value=""/>
	    <input type="hidden" id="seatR2" name=seatR value=""/>
	    <input type="hidden" id="seatR3" name=seatR value=""/>
	    <input type="hidden" id="seatR4" name=seatR value=""/>
	    <input type="hidden" id="seatN0" name=seatN value=""/>
	    <input type="hidden" id="seatN1" name=seatN value=""/>
	    <input type="hidden" id="seatN2" name=seatN value=""/>
	    <input type="hidden" id="seatN3" name=seatN value=""/>
	    <input type="hidden" id="seatN4" name=seatN value=""/>
	    <input type="hidden" id="seatInfo20" name=seatInfo2 value=""/>
	    <input type="hidden" id="seatInfo21" name=seatInfo2 value=""/>
	    <input type="hidden" id="seatInfo22" name=seatInfo2 value=""/>
	    <input type="hidden" id="seatInfo23" name=seatInfo2 value=""/>
	    <input type="hidden" id="seatInfo24" name=seatInfo2 value=""/>
	</form>
	
	<!-- 뒤로가기 -->
	<form action="${pageContext.request.contextPath}/ticket/backTicket" id="backKey" method="post">
 			<input type="hidden" value="0" id="passKey0" name="passKey"/>
 			<input type="hidden" value="0" id="passKey1" name="passKey"/>
 			<input type="hidden" value="0" id="passKey2" name="passKey"/>
 			<input type="hidden" value="0" id="passKey3" name="passKey"/>
 			<input type="hidden" value="0" id="passKey4" name="passKey"/>
	</form>    
    
    
</section>       

<script>

/* 주소 */
function execDaumPostcode(){
    new daum.Postcode({
       oncomplete: function(data) {
           // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
           //모든 데이터는 문자열이며, 값이 없을 경우 공백입니다.

           var zonecode = data.zonecode; //새 우편번호
           var address = data.address; //기본 주소 (검색 결과에서 첫줄에 나오는 주소, 검색어의 타입(지번/도로명)에 따라 달라집니다.)

           console.log("["+zonecode+"] "+address);
           $("input#address1").val("["+zonecode+"] "+address);
       }
   }).open();
}



/* 결제 */
function paygo(){
	IMP.request_pay({
	    pg : 'inicis', // version 1.1.0부터 지원.
	    pay_method : 'card',
	    merchant_uid : 'merchant_' + new Date().getTime(),
	    name : '주문명:좌석 예약',
	    amount : 1000,
	    buyer_email : 'iamport@siot.do',
	    buyer_name : '구매자이름',
	    buyer_tel : '010-1234-5678',
	    buyer_addr : '서울특별시 강남구 삼성동',
	    buyer_postcode : '123-456',
	    m_redirect_url : 'https://www.yourdomain.com/payments/complete'
	}, function(rsp) {
	    if ( rsp.success ) {
	        var msg = '결제가 완료되었습니다.';
	        msg += '결제 금액 : ' + rsp.paid_amount+"원";
	        msg += '카드 승인번호 : ' + rsp.apply_num;
		    $("#PN").submit();
	    } else {
	        var msg = '결제에 실패하였습니다.';
	        msg += '에러내용 : ' + rsp.error_msg;
	    }
	    alert(msg);
	});
}


$(document).ready(function () {
	/* 결제API */
	var IMP = window.IMP; // 생략가능
	IMP.init('imp59073806'); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
		
	
	/* 돈 계싼 */
	var seatKeyArr = ${seatNum.size()};
	var seatNum = ${seatNum};
	var ticketPrice = seatKeyArr * ${performance.price};
	var charge = 1000*${seatNum.size()};
	var mailCharge = 0;
	var DC = 0;
	var allPrice = ticketPrice + charge - DC + mailCharge;
	var userPoint = ${memberLoggedIn.point };
	
	
	/* hidden채우기 */
  	for(var i=0; i<${seatNum.size()}; i++){
		$("#seatInfo"+i).val(seatNum[i]);	
		$("#seatInfo2"+i).val(seatNum[i]);	
		$("#passKey"+i).val(seatNum[i]);	
		
	} 
  	var schedule = '${selectedDate}';

	$("#totalPrice").val(allPrice);
 	$("#scheduleDate").val(schedule);
	$("#purchaseCount").val(${seatNum.size()});
	$("#ticketPrice").html(seatKeyArr*${performance.price});
	$("#ticketPriceSpan").html(seatKeyArr*${performance.price});
	$("#ticketChargeSpan").html(charge);
	$("#mailChargeSpan").html(mailCharge);
	$("#allPriceSpan").html(allPrice);

	
	/* 예매하기 */
	for(var i=0; i<5; i++){
	   	if($("input#seatR"+i).val() == null || $("input#seatR"+i).val() == ""){
		
		$("input#seatR"+i).val(0);
		}
	   	if($("input#seatN"+i).val() == null || $("input#seatN"+i).val() == ""){
		
		$("input#seatN"+i).val(0);
		}
   	}
	$("#reservation-btn").click(function(){
		var jooso = $("#address1").val()+$("#address2").val();

		$("#address").val(jooso);
		console.log($("#address").val());
		if($("#ticketWay").val() == 'POST'){
			if($("#address").val()==null||$("#address").val()==""){
				alert("주소를 입력하세요!");
				return;
			
			}
		}
		
		if($("#paymentStatus").val()=='O'){
			paygo();
			
		}
		else{
			alert("계좌번호 : 국민은행) 111-2222-3333\n 예금주 : 티켓자바");
			$("#PN").submit();
		}   
	})
	
	
	/* 뒤로가기 */
	$("#cancel-btn").click(function(){
		$("#backKey").submit();
		
	});
	
	
	/* 포인트 사용 */
	$("#usePointBtn").click(function(){
		if($("#selectPoint").val() > ${memberLoggedIn.point }){
	    	alert("보유하신 포인트보다 입력하신 포인트가 많습니다.");
			return false;
		}


		DC = $("#selectPoint").val();
		$("#ticketDCSpan").html(DC);	
		$("#usePoint").val(DC);
		allPrice = ticketPrice + charge - DC + mailCharge;
		$("#allPriceSpan").html(allPrice);
		$("#myPoint").html(${memberLoggedIn.point }-DC+'P');
		$("#totalPrice").val(allPrice);
	});
	
	/* 수령 방법 */
	 $("[name=receiveOption]").change(function () {

		 if(mailCharge == 3000){
			 mailCharge = 0;
			 $("#ticketWay").val("DIRECT");
			 console.log( $("#ticketWay").val());
			 $("#zooso").css('display','none')
		 }
		 else{
			mailCharge = 3000; 
			 $("#ticketWay").val("POST");
			 console.log( $("#ticketWay").val());
			 $("#zooso").css('display','inline')
		 }
		 
		 $("#mailChargeSpan").html(mailCharge);
		 allPrice = ticketPrice + charge - DC + mailCharge;
		 $("#allPriceSpan").html(allPrice);
		 $("#totalPrice").val(allPrice);
	 });

	 /* 결제방법 */
	 $("[name=paymentOption]").click(function(){

		if($("#paymentStatus").val()=='O'){
			$("#paymentStatus").val("X");
		}
		else{
			$("#paymentStatus").val("O");
		}
		console.log($("#paymentStatus").val());
		
	});
	
	/* 티켓정보(좌석표시) */
 	var seatNumArr = [];
	for(var i=0; i<5; i++){
	   	if($("input#seatInfo"+i).val() == null || $("input#seatInfo"+i).val() == ""){
		
		$("input#seatInfo"+i).val(0);
		$("input#seatInfo2"+i).val(0);
	}
   		seatNumArr.push($("input#seatInfo"+i).val());
	
		
	}

    var allData = {"seatNumArr": seatNumArr };
	$.ajax({
		url: "${pageContext.request.contextPath}/ticket/ticketInfo",
		type: "POST",
		data: allData,
		dataType: "json",	
		success: function(data){
			for(var i=0; i<data.length; i++){
	 			$("div#seatInfo").append('<img src="${pageContext.request.contextPath }/resources/images/ticket/seat1.png" alt="예매가능" class="seatall" />&nbsp;'+data[i].SEAT_ROW+"열"); 
 				$("div#seatInfo").append(data[i].SEAT_NO+"번 좌석<br>"); 
	 			$("#seatR"+i).val(data[i].SEAT_ROW); 
 				$("#seatN"+i).val(data[i].SEAT_NO); 
								
			}
		},
		error: function(jqxhr, textStatus, errorThrown){
            console.log("ajax 처리 실패!: "+jqxhr.status);
            console.log(errorThrown);
        }
	
	});
	
});

	 





</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>