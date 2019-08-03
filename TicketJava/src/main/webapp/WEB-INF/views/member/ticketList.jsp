<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/member/ticketList.css" />
<style>
#ticketListDiv button#purchaseListTapBtn{
    /* 현재 선택된 탭 */
    /* purchaseListTapBtn
    giftListTapBtn
    deleteTicketListTapBtn*/
    border-color: rgb(52, 152, 219);
}
</style>
<div id="ticketListDivWrapper">
    <div id="ticketListDiv">
        <button class="ticketListTapBtn" 
                id="purchaseListTapBtn"
                >
                주문 내역
        </button> 
        <button class="ticketListTapBtn" 
        		id="giftListTapBtn"
        		onclick="location.href='${pageContext.request.contextPath}/member/ticketGiftList.do?memberId=${memberLoggedIn.memberId}'">
        	선물함
        </button>
        <hr id="ticketListDivHr" />
        <br />
        <h2>구매 실적 상세 보기</h2>
        <div id="tickeyList-script">
            - 고객님의 구매 확정 티켓 주문 내역입니다. <br />
            - 구매 확정 이후 주문 취소하시는 경우 취소 신청 일자로 차감하여 실적 반영됩니다. <br />
            - 동일한 주문 번호는 1건으로 산정됩니다.
        </div>
        <table id="ticketListTable">
            <tr>
                <th>주문번호</th>
                <th>구매일자</th>
                <th>상품명</th>
                <th>관람일자</th>
                <th>티켓 수</th>
                <th>상태</th>
            </tr>
            <!-- <tr>
                <td>1</td>
                <td>2019-07-02</td>
                <td>헤드윅</td>
                <td>2019-10-10</td>
                <td>120000</td>
            </tr> -->
            <c:if test="${purchaseList.size() == 0}">
                <td colspan="6">결제하신 티켓이 없습니다.</td>
            </c:if>
            <c:if test="${purchaseList.size() != 0}">
                <c:forEach var="l" items="${purchaseList}">
                    <tr purchaseNo="${l.purchaseNo}">
                        <td>${l.purchaseNo}</td>
                        <td>${l.purchaseDate}</td>
                        <td>${l.performanceTitle}</td>
                        <td>
	                        <fmt:parseDate var="dateString" value="${l.scheduleDate}" pattern="yyyy-MM-dd HH:mm:ss" /> 
							<fmt:formatDate var="scheduleDate" value="${dateString}" pattern="yyyy-MM-dd HH:mm" />
                        	${scheduleDate}
                        </td>
                        <td>
                        	<c:set var="usableTicketCnt" value="0"/>
                        	<c:forEach var="u" items="${usableList}">
                        		<c:if test="${u.purchaseNo == l.purchaseNo}">
                        			<c:set var="usableTicketCnt" value="${usableTicketCnt + u.usableTicket}"/>
                        		</c:if>
                        	</c:forEach>
                        	<c:out value="${usableTicketCnt}"/>&nbsp;/&nbsp;${l.purchaseCount}
                        </td>
                        <td>
	                        <c:set var = "deleteTotal" value = "0" />
                        	<c:if test="${deleteList.size() != 0}">
								<c:forEach var="d" items="${deleteList}">
									<c:if test="${l.purchaseNo == d.purchaseNo}">
										<c:set var= "deleteTotal" value="${deleteTotal + 1}"/>
									</c:if>
								</c:forEach>
                        	</c:if>
                        	
							<c:set var = "ticketTotal" value = "0" />
							<c:forEach var="t" items="${ticketList}">
								<c:if test="${l.purchaseNo == t.purchaseNo}">
									<c:set var= "ticketTotal" value="${ticketTotal + 1}"/>
								</c:if>
							</c:forEach>
							
							<%-- <c:out value="${deleteTotal}"/>
							<c:out value="${ticketTotal}"/> --%>
							
							<c:choose>
								<c:when test="${deleteTotal > 0 && ticketTotal >0}">
										부분 취소
								</c:when>
								<c:when test="${deleteTotal > 0 && ticketTotal ==0}">
										취소
								</c:when>
								<c:otherwise>
									예매
								</c:otherwise>
							</c:choose>
                        </td>
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
            
            <%=com.tj.ticketjava.common.util.Utils.getPageBar(totalContents, cPage, numPerPage, "ticketList.do?memberId="+memberId)%>
        </div>
        
    </div>
</div>
<script>
$(function(){
    $("tr[purchaseNo]").on("click", function(){
        var purchaseNo = $(this).attr("purchaseNo"); //사용자 속성값 가져오기
        location.href = "${pageContext.request.contextPath}/member/ticketView.do?purchaseNo="+purchaseNo;
    });
    
   /*  var param = {};
    var check = ${totalContents};
    console.log(check);
   for(i=0; i<check; i++){
	   param.purchaseNo = $("");
	    $.ajax({
			url: "${pageContext.request.contextPath}/ticket/checkTicketStatus.do",
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
    
   } */
   
   
});


</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>