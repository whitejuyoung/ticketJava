<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/member/ticketList.css" />

<div id="ticketListDivWrapper">
    <div id="ticketListDiv">
        <h2>포인트 내역</h2>
        <div id="tickeyList-script">
            - 회원님의 포인트 내역입니다. <br />
            - 포인트를 사용한 주문을 부분 취소하실 경우, 첫 번째 환불 시 사용하신 포인트도 함께 환불됩니다.
        </div>
        <table id="ticketListTable">
            <tr>
                <th>날짜</th>
                <th>포인트</th>
                <th>내용</th>
                <th>분류</th>
            </tr>
            <c:if test="${pointList.size() == 0}">
                <td colspan="4">포인트 내역이 없습니다.</td>
            </c:if>
            <c:if test="${pointList.size() != 0}">
                <c:forEach var="l" items="${pointList}">
                    <tr>
                        <td>${l.pointDate}</td>
                        <td>${l.point}</td>
                        <td>${l.pointMessage}</td>
                        <td>${l.pointStatus}</td>
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
            
            <%=com.tj.ticketjava.common.util.Utils.getPageBar(totalContents, cPage, numPerPage, "pointList.do?memberId="+memberId)%>
        </div>
        
    </div>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>