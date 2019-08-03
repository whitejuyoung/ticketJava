<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/member/ticketView.css" />
<div id="ticketViewDiv">
    <table id="ticketViewTable">
        <tr>
            <td rowspan="6" colspan="2" id="posterImageTd" class="NoneBorder">
                <!-- 포스터 이미지 -->
                <img id="performancePosterImage" 
                	 src="${pageContext.request.contextPath }/resources/upload/performance/${renamedFileName}"
                	 onclick="location.href='${pageContext.request.contextPath}/performance/performanceView?performanceNo=${ticketList[0].performanceNo}'"/>
            </td>
            <th colspan="2" id="purchaseNo" class="ticketView-left NoneBorder">
            	예매 번호 : ${p.purchaseNo}
            </th>
        </tr>
        <tr>
            <th colspan="2" class="ticketView-left" id="ticketTitle">
                <c:if test="${ticketList[0].performanceCode=='MU'}">뮤지컬</c:if>
	            <c:if test="${ticketList[0].performanceCode=='CO'}">콘서트</c:if>
	            <c:if test="${ticketList[0].performanceCode=='TH'}">연극</c:if> 
	            [${p.performanceTitle}]
            </th>
        </tr>
        <tr class="ticketInfoTr BoldBorderTop">
            <th id="topTh1">장소</th>
            <td id="topTd1">${ticketList[0].placeName}</td>
        </tr>
        <tr class="ticketInfoTr">
            <th>일시</th>
            <td>
            	<fmt:parseDate var="dateString" value="${p.scheduleDate}" pattern="yyyy-MM-dd HH:mm:ss" /> 
				<fmt:formatDate var="scheduleDate" value="${dateString}" pattern="yyyy-MM-dd HH:mm" />
               	${scheduleDate}
            </td>
        </tr>
        <tr class="ticketInfoTr">
        	<th>예매자</th>
            <td>${ticketList[0].memberName}</td>
        </tr>
        <tr class="ticketInfoTr BoldBorderBottom">
            <th>좌석</th>
            <td>
            	<c:forEach var="l" items="${ticketList}">
            		티켓 번호 ${l.ticketNo} : <span id="seatImpact">${l.seatRow}열 ${l.seatNo}번</span> ${l.ticketStatus=="USABLE"?"<span id='usableTicketSeat'>(사용 가능)</span>":"<span id='unusableTicketSeat'>(사용 불가능)</span>"}<br />
            	</c:forEach>
            	<c:forEach var="d" items="${deleteTicketList}">
            		티켓 번호 ${d.ticketNo} : <span id="seatImpact">${d.seatRow}열 ${d.seatNo}번</span> <span id="deleteTicketSeat">(예매 취소)</span><br />
            	</c:forEach>
            </td>
        </tr>
        <!-- ------------------ -->
        <tr>
            <td colspan="4" class="NoneBorder"></td>
        </tr>
        <tr class="BoldBorderTop">
            <th>티켓금액</th>
            <td><fmt:formatNumber value="${ticketList[0].price}" pattern="#,###"/>원</td>
            <th>사용 포인트</th>
            <td><fmt:formatNumber value="${p.usePoint}" pattern="#,###"/>p</td>
        </tr>
        <tr>
            <th>수수료</th>
            <td>
	           	<c:set var = "totalFee" value = "0" />
				<c:forEach var="t" items="${ticketList}">
					<c:set var= "totalFee" value="${totalFee + 1000}"/>
				</c:forEach>
				<fmt:formatNumber value="${totalFee}" pattern="#,###"/>원
            </td>
            <th>티켓 수령 방법</th>
            <td>${ticketList[0].ticketWay=="DIRECT"?"현장 수령":"우편 배송"}</td>
        </tr>
        <tr>
            <th>배송료</th>
            <td>${ticketList[0].ticketWay=="DIRECT"?"0원":"3,000원"}</td>
            <th>결제 여부</th>
            <td>${ticketList[0].paymentStatus=="O"?"결제 완료":"무통장 입금 대기"}</td>
        </tr>
        <tr class="BoldBorderBottom">
            <%-- <th>할인</th>
            <td>
            	<c:forEach var="l" items="${ticketList}">
            	${l.couponName==null?"":"l.conponName<br />"} 
            	</c:forEach>
            </td> --%>
			<c:if test="${ticketList[0].ticketWay=='POST'}">
	            <th>주소</th>
	            <td colspan="3">
	            	<input class="addressInput" id="address1" type="text" readonly value="${ticketList[0].address==NULL?'':ticketList[0].address}"/>
	            	<br />
	            	<input class="addressInput" id="address2" type="text" placeholder="상세 주소 입력"/>
	            	<br />
	            	<button class="addressBtn" id="addressSearchBtn" onclick="execDaumPostcode();">주소 검색</button>
	            	<button class="addressBtn" id="addressUpdateBtn" onclick="updateAddress();">주소 변경</button>
	            </td>
			</c:if>
        </tr>
        <tr>
            <td colspan="4"></td>
        </tr>
        <tr class="BoldBorderTop">
            <th colspan="2" class="ticketView-left">
				총 결제 금액
            </th>
            <th>취소 수수료</th>
            <th>취소일</th>
        </tr>
        <tr>
            <td colspan="2" rowspan="2" class="BoldBorderBottom" id="totalPriceTd">
                <%-- <c:set var="totalPrice" value="0"/>
                <c:forEach var="l" items="${ticketList}">
                	<c:set var="totalPrice" value="${totalPrice+l.price}"/>
                </c:forEach>
                
                <c:set var = "totalFee" value = "0" />
				<c:forEach var="t" items="${ticketList}">
					<c:set var= "totalFee" value="${totalFee + 1}"/>
				</c:forEach>
				
				<c:set var = "postFee" value = "0" />
				<c:if test="${ticketList[0].ticketWay=='POST'}">
					<c:set var= "postFee" value="${postFee + 3000}"/>
				</c:if>
				
                <c:out value="${totalPrice + (totalFee * 1000) + postFee}"/>원 --%>
                <fmt:formatNumber value="${p.totalPrice}" pattern="#,###"/>원
            </td>
            <td>
                티켓 금액의 30%
            </td>
            <td>
                관람일 7일 전 ~ 1일 전까지
            </td>
        </tr>
        <tr class="BoldBorderBottom">
            <td>
                취소 불가능
            </td>
            <td>
                관람일 당일
            </td>
        </tr>
        <tr>
            <td colspan="4">
                <jsp:useBean id="today" class="java.util.Date" />
				<fmt:formatDate value="${today}" pattern="yyyy-MM-dd" var="today" />  
            	<fmt:parseDate var="dateString" value="${p.scheduleDate}" pattern="yyyy-MM-dd HH:mm:ss" /> 
				<fmt:formatDate var="scheduleDate" value="${dateString}" pattern="yyyy-MM-dd" />
				<%-- <fmt:formatDate value="${p.scheduleDate}" pattern="yyyy-MM-dd" var="scheduleDate"/> --%>
            	<c:if test="${today <= scheduleDate}">
	                <button class="ticketViewBtn" 
	                		id="ticketViewSendBtn"
	                		onclick="location.href='${pageContext.request.contextPath}/member/ticketSend.do?purchaseNo='+${p.purchaseNo}">
	                		티켓 선물
	                </button>
                </c:if>
                <c:if test="${today < scheduleDate}">
                	<button class="ticketViewBtn" 
                			id="ticketViewDeleteBtn"
                			onclick="location.href='${pageContext.request.contextPath}/member/ticketDelete.do?purchaseNo='+${p.purchaseNo}">
                			티켓 취소
                	</button>
                </c:if>
                <c:if test="${today == scheduleDate}">
	                <span id="CanNotDeleteSpan">
	                		<br /><br />※ 관람일 당일에는 취소가 불가능합니다. <br /><br />
	                </span>
                </c:if>
            </td>
        </tr>
    </table>
    
    <div id="giftInfoDiv">
    	<table id="giftInfoTable">
    		<tr>
    			<th colspan="2" id="giftInfoTableTitle">선물 내역</th>
    		</tr>
    		<tr>
    			<th>좌석</th>
    			<th>선물 받은 회원</th>
    		</tr>
    		<c:forEach var="l" items="${ticketList}">
	    		<c:if test="${l.receiverId != null}">
		    		<tr>
		    			<td>${l.seatRow}열 ${l.seatNo}번</td>
		    			<td>${l.receiverId}</td>
		    		</tr>
	    		</c:if>
    		</c:forEach>
    	</table>
    	
    </div>
</div>

<script>
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
    
function updateAddress(){
	var address1= $("#address1").val();
	var address2= $("#address2").val();
	var address = address1+" "+address2;
	
	if(address1.trim().length == 0){
		alert("주소를 공란으로 둘 수 없습니다.");
		return false;
	}
	else{
		var param = {
				address : address,
				purchaseNo : "${p.purchaseNo}"
		};
		
		console.log(param);
		
		$.ajax({
			url: "${pageContext.request.contextPath}/member/updateAddress.do",
			data: param,
			type: "post",
			success: function(data){
				console.log(data);
				if(data == "O"){
					alert("주소 변경이 완료되었습니다!");
				}
				else{
					alert("주소 변경 실패: 관리자에게 문의해 주세요.");
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
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>