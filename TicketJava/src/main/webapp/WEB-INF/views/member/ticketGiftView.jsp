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
            <td rowspan="5" colspan="2" id="posterImageTd" class="NoneBorder">
                <!-- 포스터 이미지 -->
                <img id="performancePosterImage" src="${pageContext.request.contextPath }/resources/upload/performance/${renamedFileName}"/>
            </td>
            <th colspan="2" id="purchaseNo" class="ticketView-left NoneBorder">
            	예매 번호 : ${t.purchaseNo}
            </th>
        </tr>
        <tr>
            <th colspan="2" class="ticketView-left" id="ticketTitle">
	            <c:if test="${t.performanceCode=='MU'}">뮤지컬</c:if>
	            <c:if test="${t.performanceCode=='CO'}">콘서트</c:if>
	            <c:if test="${t.performanceCode=='TH'}">연극</c:if>
	             [${t.performanceTitle}]
            </th>
        </tr>
        <tr class="ticketInfoTr BoldBorderTop">
            <th id="topTh1">장소</th>
            <td id="topTd1">${t.placeName}</td>
        </tr>
        <tr class="ticketInfoTr">
            <th>일시</th>
            <td>
            	<fmt:parseDate var="dateString" value="${p.scheduleDate}" pattern="yyyy-MM-dd HH:mm:ss" /> 
				<fmt:formatDate var="scheduleDate" value="${dateString}" pattern="yyyy-MM-dd HH:mm" />
               	${scheduleDate}
            </td>
        </tr>
        <tr class="ticketInfoTr BoldBorderBottom">
            <th>좌석</th>
            <td>
            	티켓 번호 ${t.ticketNo} : <span id="seatImpact">${t.seatRow}열 ${t.seatNo}번</span>
            </td>
        </tr>
        <!-- ------------------ -->
        <tr>
            <td colspan="4" class="NoneBorder"></td>
        </tr>
        <tr class="BoldBorderTop">
            <th>티켓금액</th>
            <td><fmt:formatNumber value="${t.price}" pattern="#,###"/>원</td>
            <th>예매자</th>
            <td>${t.memberName}</td>
        </tr>
        <tr>
            <th>수수료</th>
            <td>1,000원</td>
            <th>티켓 수령 방법</th>
            <td>${t.ticketWay=="DIRECT"?"현장 수령":"우편 배송"}</td>
        </tr>
        <tr>
            <th>배송료</th>
            <td>${t.ticketWay=="DIRECT"?"0원":"3,000원"}</td>
            <th>결제 여부</th>
            <td>${t.paymentStatus=="O"?"결제 완료":"무통장 입금 대기"}</td>
        </tr>
        <tr class="BoldBorderBottom">
           <%--  <th>할인</th>
            <td>
            	${t.couponName==null?"":"l.conponName<br />"}
            </td> --%>
            <c:if test="${t.ticketWay=='POST'}">
	            <th>주소</th>
	            <td colspan="3">
	            	<input class="addressInput" id="address1" type="text" readonly value="${t.address==NULL?'':t.address}"/>
	            	<br />
	            	<input class="addressInput" id="address2" type="text" readonly value="배송지 변경을 원하실 경우 선물하신 회원님께 요청해 주시기 바랍니다."/>
	            </td>
			</c:if>
        </tr>
        <tr>
            <td colspan="4"></td>
        </tr>
        <tr class="BoldBorderTop">
            <th colspan="4" class="ticketView-left" >
				총 결제 금액
            </th>
           <!--  <th>취소 수수료</th>
            <th>취소일</th> -->
        </tr>
        <tr>
        
            <td colspan="4" rowspan="2" class="BoldBorderBottom" id="totalPriceTd">
               <c:set var = "postFee" value = "0" />
				<c:if test="${t.ticketWay=='POST'}">
					<c:set var= "postFee" value="${postFee + 3000}"/>
				</c:if>
                <br /><fmt:formatNumber value="${t.price + 1000 + postFee}" pattern="#,###"/>원
            </td>
           <!--  <td>
                티켓 금액의 30%
            </td>
            <td>
                관람일 7일 전 ~ 1일 전까지
            </td> -->
        </tr>
        <!-- <tr class="BoldBorderBottom">
            <td>
                취소 불가능
            </td>
            <td>
                관람일 당일
            </td>
        </tr> -->
       <%--  <tr>
            <td colspan="4">
                <jsp:useBean id="today" class="java.util.Date" />
				<fmt:formatDate value="${today}" pattern="yyyy-MM-dd" var="today" />  
				<fmt:parseDate var="dateString" value="${p.scheduleDate}" pattern="yyyy-MM-dd HH:mm:ss" /> 
				<fmt:formatDate var="scheduleDate" value="${dateString}" pattern="yyyy-MM-dd" />
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
        </tr> --%>
    </table>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
