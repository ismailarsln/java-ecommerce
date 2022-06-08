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
  

    
   

    
    <!-- Custom styles for this template -->
    <link href="costum.css" rel="stylesheet">
        <!-- Favicon  -->
    <link rel="icon" href="img/core-img/favicon.ico">

    <!-- Core Style CSS -->
    <link rel="stylesheet" href="css/core-style.css">
    <link rel="stylesheet" href="style.css">
  </head>
  <body>
    <%@include file="components/navbar.jsp"%>
  

<div class="container">
	<section id="content">
		<form action="RegisterServlet" method="post">
			<h1>Register Form</h1>
			<div>
				<input type="text" placeholder="Username"  id="username" name="username" required />
			</div>
			<div>
				<input type="password" placeholder="Password"  id="password" name="password" required />
			</div>
			<div>
				<input type="submit" value="Register" />
				<a href="login.jsp">Login</a>
			</div>
		</form><!-- form -->
		<div class="button">
		
		</div><!-- button -->
	</section><!-- content -->
</div><!-- container -->


    
  </body>
</html>

