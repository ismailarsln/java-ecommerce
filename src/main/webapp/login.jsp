<%@page import="java_ecommerce.hibernate.model.User"%>
<%
if ((User) session.getAttribute("current-user") != null) {
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
<link href="css/login-register-custom.css" rel="stylesheet">
</head>
<body>


	<div class="row">
		<div class="col-auto">
			<%@include file="components/navbar.jsp"%>
		</div>
		<div class="col">
			<div class="container">

				<section id="content">
					<form action="LoginServlet" method="post">

						<h1>Giriş Yap</h1>
						<%@include file="components/message.jsp"%>

						<div>
							<input type="text" placeholder="Kullanıcı Adı" id="username"
								name="username" required />
						</div>
						<div>
							<input type="password" placeholder="Parola" id="password"
								name="password" required />
						</div>
						<div>
							<input type="submit" value="Giriş Yap" /> <a href="register.jsp">Kayıt
								Ol</a>
						</div>
					</form>
					<!-- form -->
					<div class="button"></div>
					<!-- button -->
				</section>
				<!-- content -->
			</div>
			<!-- container -->
		</div>
	</div>
	<%@include file="components/footer.jsp"%>
	<%@include file="components/links-scripts.jsp"%>
</body>
</html>

