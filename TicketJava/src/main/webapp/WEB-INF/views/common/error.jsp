<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	//httpstatus 에러코드로 넘어온 경우 : 404,500...  등등
	//exception 내장객체가 null임.
	String status = String.valueOf(response.getStatus());
	
	String msg = exception != null?exception.getMessage():status;

%>

<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8" />
	<title>Error - spring</title>
	<style>
		#error-container{
			text-align: center;
		}
	</style>
</head>
<body>

	<div id="error-container">
		<h1>Error</h1>
		<h2 style="color:red;"><%=msg %></h2>
		<a href="${pageContext.request.contextPath }">Home</a>
	</div>
	
</body>
</html>