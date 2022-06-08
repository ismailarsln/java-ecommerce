<%@page import="java_ecommerce.hibernate.model.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
User navbarUser = (User) session.getAttribute("current-user");
%>
<!-- ##### Main Content Wrapper Start ##### -->
<div class="main-content-wrapper clearfix">

	<!-- Mobile Nav (max width 767px)-->
	<div class="mobile-nav">
		<!-- Navbar Brand -->
		<div class="amado-navbar-brand">
			<a href="index.jsp"><img src="img/core-img/logo.png" alt=""></a>
		</div>
		<!-- Navbar Toggler -->
		<div class="amado-navbar-toggler">
			<span></span><span></span><span></span>
		</div>
	</div>

	<!-- Header Area Start -->
	<header class="header-area clearfix">
		<!-- Close Icon -->
		<div class="nav-close">
			<i class="fa fa-close" aria-hidden="true"></i>
		</div>
		<!-- Logo -->
		<div class="logo">
			<a href="index.jsp"><img src="img/core-img/logo.png" alt=""></a>
		</div>

		<!-- Amado Nav -->
		<nav class="amado-nav">
			<ul>
				<div class="cart-fav-search mb-100">
					<li><a href="shop.jsp" class="fav-nav"><img
							src="img/core-img/favorites.png" alt=""> Alışveriş Yap</a></li>
					<li><a href="cart.jsp" class="cart-nav"><img
							src="img/core-img/cart.png" alt="" width="20px"> Sepet <span>(0)</span></a></li>
				</div>



				<%
				if (navbarUser != null && navbarUser.isAdmin()) {
				%>
				<li
					<%=request.getRequestURI().equals("/java-ecommerce/admin-category-management.jsp") ? "class='active'" : ""%>>
					<a style="color: #fbb710" aria-current="page"
					href=admin-category-management.jsp>Kategori Yönetimi</a>
				</li>

				<li
					<%=request.getRequestURI().equals("/java-ecommerce/admin-product-management.jsp") ? "class='active'" : ""%>>
					<a style="color: #fbb710" aria-current="page"
					href="admin-product-management.jsp">Ürün Yönetimi</a>
				</li>

				<li
					<%=request.getRequestURI().equals("/java-ecommerce/admin-order-management.jsp") ? "class='active'" : ""%>>
					<a style="color: #fbb710" aria-current="page"
					href="admin-order-management.jsp">Sipariş Yönetimi</a>
				</li>

				<li
					<%=request.getRequestURI().equals("/java-ecommerce/admin-user-management.jsp") ? "class='active'" : ""%>>
					<a style="color: #fbb710" aria-current="page"
					href="admin-user-management.jsp">Kullanıcı Yönetimi</a>
				</li>
				<%
				}
				%>

				<%
				if (navbarUser == null) {
				%>
				<!-- Button Group -->
				<li class="amado-btn-group mt-30"><a href="login.jsp"
					class="btn amado-btn">Giriş</a></li>
				<li class="amado-btn-group mt-15 mb-100"><a href="register.jsp"
					class="btn amado-btn mb-15">Kayıt Ol</a></li>
				<%
				} else {
				%>
				<div class="amado-btn-group mt-30 mb-100 text-center">
					<a class="btn amado-btn mb-15 logout-button" aria-current="page"
						href="LogoutServlet" style="text-transform: uppercase""> <span><%=navbarUser.getUsername()%></span>
					</a>
				</div>
				<%
				}
				%>

			</ul>
		</nav>

		<!-- Social Button -->
		<div class="social-info d-flex justify-content-between">
			<a href="#"><i class="fa fa-pinterest" aria-hidden="true"></i></a> <a
				href="#"><i class="fa fa-instagram" aria-hidden="true"></i></a> <a
				href="#"><i class="fa fa-facebook" aria-hidden="true"></i></a> <a
				href="#"><i class="fa fa-twitter" aria-hidden="true"></i></a>
		</div>
	</header>
	<!-- Header Area End -->
	<style>
.logout-button:hover span {
	display: none;
}

.logout-button:hover:before {
	content: "Çıkış Yap";
}
</style>
</div>
<!-- ##### Main Content Wrapper End ##### -->