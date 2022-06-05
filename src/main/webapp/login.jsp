<%@page import="java_ecommerce.hibernate.model.User"%>
<%
	if((User) session.getAttribute("current-user") != null){
		session.removeAttribute("red-message");	
		session.removeAttribute("green-message");	
		response.sendRedirect("index.jsp");
		return;
	}
%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
<%@include file="../components/bootstrap-jquery.jsp"%>
</head>
<body>
	<%@include file="../components/navbar.jsp"%>
	<%@include file="../components/message.jsp" %>
	<form action="LoginServlet" method="post">
		<input type="text" id="username" name="username" placeholder="Enter username" required>
		<input type="password" id="password" name="password" placeholder="Enter password" required>
		<button>Login</button>
		<a href="register.jsp">Don't have an account?</a>
	</form>
</body>
</html>