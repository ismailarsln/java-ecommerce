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



<html lang="en">
  <head>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <!-- Favicon  -->
    <link rel="icon" href="img/core-img/favicon.ico">

    <!-- Core Style CSS -->
    <link rel="stylesheet" href="css/core-style.css">
    <link rel="stylesheet" href="style.css">

    
   

    
    <!-- Custom styles for this template -->
    <link href="costum.css" rel="stylesheet">
  </head>
  <body>
  <%@include file="components/navbar.jsp"%>
  

<div class="container">

	<section id="content">
		<form action="LoginServlet" method="post">
		
			<h1>Login Form</h1>
			<%@include file="components/message.jsp"%>
			
			<div>
				<input type="text" placeholder="Username"  id="username" name="username" required />
			</div>
			<div>
				<input type="password" placeholder="Password"  id="password" name="password" required />
			</div>
			<div>
				<input type="submit" value="Log in" />
				<a href="#">Lost your password?</a>
				<a href="register.jsp">Register</a>
			</div>
		</form><!-- form -->
		<div class="button">
		
		</div><!-- button -->
	</section><!-- content -->
</div><!-- container -->


    
  </body>
  <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.7/dist/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
</html>

