<%@page import="java_ecommerce.hibernate.dao.CategoryDao"%>
<%@page import="java_ecommerce.hibernate.model.Category"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="components/admin-check.jsp"%>
<%
	String stringCategoryId = request.getParameter("categoryid");
	if (stringCategoryId == null || stringCategoryId.isEmpty()) {
		session.setAttribute("red-message", "Kategori ID degeri yok");
		response.sendRedirect("admin-category-management.jsp");
		return;
	}
	
	int categoryId = -1;
	
	try {
		categoryId = Integer.parseInt(stringCategoryId);
	} catch (Exception e) {
		session.setAttribute("red-message", "Gecersiz kategori id");
		response.sendRedirect("admin-category-management.jsp");
		return;
	}
	
	CategoryDao categoryDao = new CategoryDao();
	Category editCategory = categoryDao.fetchById(categoryId);
	if (editCategory == null) {
		session.setAttribute("red-message", "Kategori bulunamadi");
		response.sendRedirect("admin-category-management.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Category Edit</title>
<%@include file="components/bootstrap-jquery.jsp"%>
</head>

<body>
	<%@include file="components/navbar.jsp"%>
	<div class="category-update-box">
		<%@include file="components/message.jsp"%>
		<form action="CategoryOperationServlet" method="post">
			<input type="hidden" name="operation" value="edit">
			<input type="hidden" name="categoryId" value="<%=editCategory.getId()%>">
			<div class="form-group">
				<label for="categoryName">Kategori Adı</label>
				<input type="text" class="form-control" id="categoryName" name="categoryName" value="<%=editCategory.getName()%>">
			</div>
			<input type="submit" class="btn btn-primary mt-3" value="Güncelle"/>
		</form>
	</div>
</body>
<style>
	.category-update-box {
		background-color: #f5f5f5;
		border-radius: 10px;
		padding: 30px;
		margin: 30px;
	}
</style>
</html>