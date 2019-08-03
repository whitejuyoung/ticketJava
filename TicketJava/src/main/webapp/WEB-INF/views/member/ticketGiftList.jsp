<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/member/ticketList.css" />
<style>
#ticketListDiv button#giftListTapBtn{
    /* 현재 선택된 탭 */
    /* purchaseListTapBtn
    giftListTapBtn */
    border-color: rgb(52, 152, 219);
}
</style>
<div id="ticketListDivWrapper">
    <div id="ticketListDiv">
        <button class="ticketListTapBtn" 
                id="purchaseListTapBtn"
                onclick="location.href='${pageContext.request.contextPath}/member/ticketList.do?memberId=${memberLoggedIn.memberId}'">
                주문 내역
        </button> 
        <button class="ticketListTapBtn" id="giftListTapBtn"
        		onclick="location.href='${pageContext.request.contextPath}/member/ticketGiftList.do?memberId=${memberLoggedIn.memberId}'">
        		선물함
        </button>
        <hr id="ticketListDivHr" />
        <br />
        <h2>선물 받은 티켓함</h2>
        <div id="tickeyList-script">
            - 선물 받으신 티켓은 등급 실적에 반영되지 않습니다. <br />
            - 선물 받으신 티켓은 다시 선물하실 수 없습니다. <br />
            - 선물 받으신 티켓을 취소할 경우, 선물한 회원님께 환불이 진행됩니다. <br />
            - 선물한 후에는 선물하기를 취소하실 수 없습니다. <br />
            - 우편 수령일 경우, 티켓을 선물 받으신 회원님은 배송지를 변경하실 수 없습니다. 
        </div>
        <table id="ticketListTable">
            <tr>
         		<th>선물한 회원</th>
                <th>상품명</th>
                <th>관람일자</th>
                <th>좌석</th>
                <th>티켓 금액</th>
            </tr>
            <!-- <tr>
                <td>1</td>
                <td>2019-07-02</td>
                <td>헤드윅</td>
                <td>2019-10-10</td>
                <td>120000</td>
            </tr> -->
            <c:if test="${giftList.size() == 0}">
                <td colspan="5">선물 받으신 티켓이 없습니다.</td>
            </c:if>
            <c:if test="${giftList.size() != 0}">
                <c:forEach var="l" items="${giftList}">
                	<%-- ticketList는 purchase객체, ticketGiftList는 ticket객체 --%>
                    <tr ticketNo="${l.ticketNo}" purchaseNo="${l.purchaseNo}">
                    	<td>${l.memberId}</td>
                        <td>${l.performanceTitle}</td>
                        <td>
                        	<c:forEach var="p" items="${giftPurchaseList}">
                        		<c:if test="${l.purchaseNo == p.purchaseNo}">
                        			<fmt:parseDate var="dateString" value="${p.scheduleDate}" pattern="yyyy-MM-dd HH:mm:ss" /> 
									<fmt:formatDate var="scheduleDate" value="${dateString}" pattern="yyyy-MM-dd HH:mm" />
		                        	${scheduleDate}
                        		</c:if>
                        	</c:forEach>
                        </td>
                        <td>${l.seatRow}열 ${l.seatNo}번</td>
                        <td>${l.price}</td>
                    </tr>
                </c:forEach>
            </c:if>
        </table>
        
        <div id="ticketListPageBarDiv">
            <%
             int totalContents = Integer.parseInt(String.valueOf(request.getAttribute("totalContents")));
             int numPerPage = Integer.parseInt(String.valueOf(request.getAttribute("numPerPage")));
             int cPage = Integer.parseInt(String.valueOf(request.getAttribute("cPage")));
             String memberId = String.valueOf(request.getAttribute("memberId"));
            %>
            
            <%=com.tj.ticketjava.common.util.Utils.getPageBar(totalContents, cPage, numPerPage, "ticketGiftList.do?memberId="+memberId)%>
        </div>
        
    </div>
</div>
<script>
$(function(){
    $("tr[ticketNo]").on("click", function(){
        var ticketNo = $(this).attr("ticketNo"); //사용자 속성값 가져오기
        var purchaseNo = $(this).attr("purchaseNo"); //사용자 속성값 가져오기
        location.href = "${pageContext.request.contextPath}/member/ticketGiftView.do?ticketNo="+ticketNo+"&purchaseNo="+purchaseNo;
    });
});
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>