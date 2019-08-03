<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

</td>
	</tr>
	<tr>
		<td class="memberMyPageIndex" 
			id="memberUpdateIndex"
			onclick="location.href='${pageContext.request.contextPath}/member/memberInfoUpdatePasswordCheck.do'">
			회원정보 수정
		</td>
	</tr>
	<tr>
		<td class="memberMyPageIndex" 
			id="memberPasswordUpdateIndex"
			onclick="location.href='${pageContext.request.contextPath}/member/memberPasswordUpdatePasswordCheck.do'">
			비밀번호 변경
		</td>
	</tr>
	<tr>
		<td class="memberMyPageIndex" 
			id="memberSnsIndex"
			onclick="location.href='${pageContext.request.contextPath}/member/memberSNS.do'">
			SNS 연결 설정
		</td>
	</tr>
	<tr>
		<td class="memberMyPageIndex" 
			id="memberDeleteIndex"
			onclick="location.href='${pageContext.request.contextPath}/member/memberDeletePasswordCheck.do'">
			회원 탈퇴
		</td>
	</tr>
	</table>

</div>