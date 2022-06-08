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
<title>Java-Ecommerce | Kategori Düzenle</title>
</head>

<body>

	<div class="row">
		<div class="col-auto">
			<%@include file="components/navbar.jsp"%>
		</div>
		<div class="col">
			<div class="category-update-box">
				<%@include file="components/message.jsp"%>
				<form action="CategoryOperationServlet" method="post">
					<input type="hidden" name="operation" value="edit"> <input
						type="hidden" name="categoryId" value="<%=editCategory.getId()%>">
					<div class="form-group">
						<label for="categoryName">Kategori Adı</label> <input type="text"
							class="form-control" id="categoryName" name="categoryName"
							value="<%=editCategory.getName()%>">
					</div>
					<div class="row">
						<div class="col d-flex justify-content-end">
							<input type="submit" class="btn btn-primary mt-3" value="Güncelle" />
						</div>
					</div>					
				</form>
			</div>
		</div>		
	</div>
	<%@include file="components/footer.jsp"%>
	<%@include file="components/links-scripts.jsp"%>

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