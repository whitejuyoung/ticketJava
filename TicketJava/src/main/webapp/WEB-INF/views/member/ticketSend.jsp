<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/member/ticketSend.css" />
<style>
#ticketListDiv button#purchaseListTapBtn{
    /* 현재 선택된 탭 */
    /* purchaseListTapBtn
    giftListTapBtn */
    border-color: rgb(52, 152, 219);
}
</style>
<div id="ticketListDivWrapper">
    <div id="ticketListDiv">
        
        <h2>티켓 선물하기</h2>
        <div id="tickeyList-script">
            - 선물하신 티켓도 등급 산정 실적에 포함됩니다. <br />
            - 선물하기 이후 선물하기를 취소하실 수 없습니다.
        </div>
        
       <table id="ticketListTable">
            <tr>
            	<th></th>
                <th>주문번호</th>
                <th>상품명</th>
                <th>좌석</th>
                <th>관람일자</th>
                <th>티켓 가격</th>
                <th>결제 여부</th>
                <th>티켓 상태</th>
            </tr>
            	<c:if test="${ticketList.size() == 0}">
            		<tr>
            			<td colspan="8">선물 가능한 티켓이 없습니다.</td>
            		</tr>
            	</c:if>
            	<c:if test="${ticketList.size() != 0}">
					<c:forEach var="l" items="${ticketList}">
	                   <tr>
	                   	<td>
	                   		<c:if test="${l.ticketStatus=='USABLE'}">
	                   			<input type="radio" name="isSend" onchange="giftTicketCheck('${l.ticketNo}', '${l.seatRow}', '${l.seatNo}');"/>
	                   		</c:if>
	                   	</td>
	                       <td>${l.purchaseNo}</td>
	                       <td>${l.performanceTitle}</td>
	                       <td>${l.seatRow}열 ${l.seatNo}번</td>
	                       <td>${l.scheduleDate}</td>
	                       <td>${l.price}</td>
	                       <td>${l.paymentStatus=="O"?"결제 완료":"무통장 입금 대기"}</td>
	                       <td>${l.ticketStatus=="USABLE"?"선물 가능":"선물 불가능"}</td>
	                   </tr>
	               </c:forEach>
               </c:if>
        </table>
		<form action="${pageContext.request.contextPath}/member/ticketSendEnd.do"
			  method="post"
			  onsubmit="return submitInvalid();"
			  id="sendTicketForm">
	        <div id="ticketSendInfoDiv">
        		<input type="text" id="receiverId" placeholder="선물 받으실 회원님의 아이디"/>
           		<input type="hidden" id="memberLoggedId" name="memberLoggedId" value="${memberLoggedIn.memberId}"/>
           		<input type="hidden" name="receiverId" />
           		<input type="hidden" name="ticketNo"/>
           		<input type="hidden" name="purchaseNo" value="${ticketList[0].purchaseNo}"/>
           		<button type="button" onclick="checkReceiverId();">확인</button>
           		<br /><br /><br />
	        	<span class="giftTicketInfoSpan" id="receiverIdSpan" ></span>님에게
	        	<span class="giftTicketInfoSpan" id="giftTicketPerformanceTitle">${ticketList[0].performanceTitle}</span>
	        	<span class="giftTicketInfoSpan" id="giftTicketSeatRow"></span>열
	        	<span class="giftTicketInfoSpan" id="giftTicketSeatNo"></span>번
	        	좌석을 선물합니다.
	        </div>
	        
	        <div id="ticketSendBtnDiv">
		        <button class="ticketViewBtn" 
		        		type="button"
		        		id="ticketViewDeleteBtn"
		        		onclick="location.href = '${pageContext.request.contextPath}/member/ticketView.do?purchaseNo='+${p.purchaseNo};">
		        		취소
		        </button>
		        <button class="ticketViewBtn" 
		        		type="button"
		                id="ticketViewSendBtn"
		                onclick="submitSendTicketForm();">
		            	티켓 선물
		        </button>
	        </div>
        </form>
        
    </div>
</div>
<script>
function giftTicketCheck(ticketNo, seatRow, seatNo){
		$("span#giftTicketSeatRow").html(seatRow);
		$("span#giftTicketSeatNo").html(seatNo);
		$("input[name='ticketNo']").val(ticketNo);
}
function submitSendTicketForm(){
	var con = confirm("정말로 선물하시겠습니까?");
	console.log(con);
	if(con == false){
		location.href = "${pageContext.request.contextPath}/member/ticketSend.do?purchaseNo="+${ticketList[0].purchaseNo};
	}
	if(con == true){
		$("form#sendTicketForm").submit();
	}
}
function checkReceiverId(){
	var receiverId = $("input#receiverId").val();
	var memberLoggedId = $("input#memberLoggedId").val();
	console.log(receiverId);
	console.log(memberLoggedId);
	if(receiverId==memberLoggedId){
		alert("본인에게 티켓을 선물할 수 없습니다.");
	}
	else if(receiverId.trim().length == 0){
		alert("선물 받으실 분의 아이디를 정확히 입력해 주세요.");
	}
	else{
		var param = {
	    		memberId : receiverId.trim()	
	    }
		
		$.ajax({
			url: "${pageContext.request.contextPath}/member/checkIdDuplicate.do",
			data: param,
			type: "get",
			success: function(data){
				if(data == "true"){
					alert("존재하지 않는 아이디입니다!");
				}
				else{
					alert("아이디가 확인되었습니다!");
					$("span#receiverIdSpan").html(receiverId);
					$("input[name='receiverId']").val(receiverId.trim());
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
}

function submitInvalid(){
	if($("input[name='receiverId']").val().trim() == 0){
		alert("받으시는 분의 아이디를 다시 확인해 주세요!");
		return false;
	}
	if($("input[name='ticketNo']").val().trim() == 0){
		alert("선물하실 티켓을 다시 선택해 주세요!");
		return false;
	}
	
	return true;
}

</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>