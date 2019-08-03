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
        
        <h2>예매 취소</h2>
        <div id="tickeyList-script">
            - 예매를 취소하신 주문 건은 등급 산정 실적에서 제외됩니다. <br />
            - 예매 취소 후 본 상품 페이지를 통해서 예매 가능하나, 해당 좌석은 다른 고객이 먼저 예매하실 수 있습니다.
        </div>
        
       <table id="ticketListTable">
            <tr>
            	<th></th>
                <th>티켓번호</th>
                <th>상품명</th>
                <th>좌석</th>
                <th>관람일자</th>
                <th>티켓 가격</th>
                <th>결제 여부</th>
                <th>티켓 상태</th>
            </tr>
            	<c:if test="${ticketList.size() == 0}">
            		<tr>
            			<td colspan="8">취소 가능한 티켓이 없습니다.</td>
            		</tr>
            	</c:if>
            	<c:if test="${ticketList.size() != 0}">
					<c:forEach var="l" items="${ticketList}">
	                   <tr>
	                   	<td>
	                   		<c:if test="${l.ticketStatus=='USABLE'}">
	                   			<input type="checkbox" 
	                   				   class="ticketCheck" 
	                   				   name="isSend"
	                   				   ticketNo="${l.ticketNo}"/>
	                   		</c:if>
	                   	</td>
	                       <td>${l.ticketNo}</td>
	                       <td>${l.performanceTitle}</td>
	                       <td>${l.seatRow}열 ${l.seatNo}번</td>
	                       <td>${l.scheduleDate}</td>
	                       <td>${l.price}</td>
	                       <td>${l.paymentStatus=="O"?"결제 완료":"무통장 입금 대기"}</td>
	                       <td>${l.ticketStatus=="USABLE"?"취소 가능":"취소 불가능"}</td>
	                   </tr>
	               </c:forEach>
               </c:if>
        </table>
        
        <input type="hidden" id="purchaseNo" value="${ticketList[0].purchaseNo}"/>
		
        <table id="deleteTicketTable">
	    </table>
	    
        <div id="ticketSendBtnDiv">
	        <button class="ticketViewBtn" 
	        		type="button"
	        		id="ticketViewDeleteBtn"
	        		onclick="location.href = '${pageContext.request.contextPath}/member/ticketView.do?purchaseNo='+${p.purchaseNo};">
	        		뒤로
	        </button>
	        
	        <jsp:useBean id="today" class="java.util.Date" />
			<fmt:formatDate value="${today}" pattern="yyyy-MM-dd" var="today" />  
			<fmt:formatDate value="${ticketList[0].scheduleDate}" pattern="yyyy-MM-dd" var="scheduleDate"/>
           	<c:if test="${today < scheduleDate}">
		        <button class="ticketViewBtn" 
		        		type="button"
		                id="ticketViewSendBtn">
		            	티켓 취소
		        </button>
		    </c:if>    
        </div>
        
    </div>
</div>
<script>

$("input.ticketCheck").change(function(){
	var target = $(this);
	var ticketNo = target.attr("ticketNo");
	var checked = target.prop("checked");
	
	if(checked == true){
		var addTag = 
			 "<tr class=deleteTicketInfo id='"+ticketNo+"'>"+
			 "<form>"+
			 "<td><input type='hidden' value='"+ticketNo+"' name='ticketNo'/></td>"+
			 "</form>"
			 "</tr>";
			 
		$("#deleteTicketTable").append(addTag);
	}
	else{
		$("tr#"+ticketNo).remove();
	}
});

$("button#ticketViewSendBtn").click(()=>{
	var purchaseNo = $("input#purchaseNo").val();
	var check = $("input:checkbox[name=isSend]:checked").length;
	
	if(check == 0){
		alert("취소 가능한 티켓이 없습니다.")
		return
	}
	else{
		var con = confirm("정말로 예매를 취소하시겠습니까?");
		if(con == true){
			var param = {};
			param.ticketList = [];
			
			$("tr.deleteTicketInfo").each((i, elem)=>{
				var ticket = {};
				ticket.ticketNo = $(elem).find("[name=ticketNo]").val();
				param.ticketList.push(ticket);
			});
			
			var str = JSON.stringify(param);
			console.log(str);
			
			$.ajax({
				url: "${pageContext.request.contextPath}/member/deleteTicketEnd.do",
				type: "POST",
				data: str,
				contentType: "application/json; charset=UTF-8",
				success: function(data){
					alert(data.msg);
					updateMemberLoggedIn();
					location.href = '${pageContext.request.contextPath}/member/ticketDelete.do?purchaseNo='+purchaseNo;
				},
				error: function(jqxhr, textStatus, errorThrown){
					console.log("ajax 처리 실패!: "+jqxhr.status);
					console.log(errorThrown);
				}
			});
		}
	}
	
});

function updateMemberLoggedIn(){
	console.log("실행");
	var param = {
			memberId : "${memberLoggedIn.memberId}"
	};
	var str = JSON.stringify(param);
	$.ajax({
		url: "${pageContext.request.contextPath}/member/updateMemberLoggedIn.do",
		type: "get",
		data: param,
		success: function(data){
			console.log("세션 업데이트 성공!");
		},
		error: function(jqxhr, textStatus, errorThrown){
			console.log("ajax 처리 실패!: "+jqxhr.status);
			console.log(errorThrown);
		}
	});
}

</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>