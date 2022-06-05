<%@page import="java_ecommerce.hibernate.model.Product"%>
<%@page import="java_ecommerce.hibernate.dao.ProductDao"%>
<%@page import="java_ecommerce.hibernate.model.Category"%>
<%@page import="java.util.List"%>
<%@page import="java_ecommerce.hibernate.dao.CategoryDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Home</title>
<%@include file="components/bootstrap-jquery.jsp"%>
</head>
<body>
	<%@include file="components/navbar.jsp"%>
	<div class="row ms-3 me-3">
		<div class="col-6">
			<h1>Kategoriler</h1>
			<%
				CategoryDao categoryDao = new CategoryDao();
				List<Category> categoryList = categoryDao.fetchAll();
				for(Category category : categoryList){
					%>
						<h6><%=category.getName()%></h6>
					<%
				}
			%>
		</div>
		<div class="col-6">
			<h1>Ürünler</h1>
			<%
				ProductDao productDao = new ProductDao();
				List<Product> productList = productDao.fetchAll();
				for(Product product : productList){
					%>
						<h6><%=product.getName()%></h6>
					<%
				}
			%>
		</div>
	</div>
</body>
</html>