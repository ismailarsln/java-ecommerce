<%@page import="java_ecommerce.hibernate.model.Category"%>
<%@page import="java.util.List"%>
<%@page import="java_ecommerce.hibernate.dao.CategoryDao"%>
<%@page import="java_ecommerce.hibernate.dao.ProductDao"%>
<%@page import="java_ecommerce.hibernate.model.Product"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="components/admin-check.jsp"%>
<%
	String stringProductId = request.getParameter("productid");
	if (stringProductId == null || stringProductId.isEmpty()) {
		session.setAttribute("red-message", "Urun ID degeri yok");
		response.sendRedirect("admin-product-management.jsp");
		return;
	}
	
	int productId = -1;
	
	try {
		productId = Integer.parseInt(stringProductId);
	} catch (Exception e) {
		session.setAttribute("red-message", "Gecersiz urun id");
		response.sendRedirect("admin-product-management.jsp");
		return;
	}
	
	ProductDao productDao = new ProductDao();
	Product editProduct = productDao.fetchById(productId);
	if (editProduct == null) {
		session.setAttribute("red-message", "Urun bulunamadi");
		response.sendRedirect("admin-product-management.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Product Edit</title>
<%@include file="components/bootstrap-jquery.jsp"%>
</head>

<body>
	<%@include file="components/navbar.jsp"%>
	<div class="product-update-box">
		<%@include file="components/message.jsp"%>
		<div class="row">
			<div class="col-3 text-center">
				<img src="img<%=editProduct.getImage()%>" width="350px" height="350px" style="border: 2px solid"><br>
			</div>
			
			<div class="col-9">
				<form action="ProductOperationServlet" method="post" enctype="multipart/form-data">
					<input type="hidden" name="operation" value="edit">
					<input type="hidden" name="productId" value="<%=editProduct.getId()%>">
					<div class="form-group">
										
						<label for="productName" class="mt-3">Ürün adı(*)</label>				
						<input type="text" class="form-control mb-3" id="productName"
										name="productName" value="<%=editProduct.getName()%>" required>
						
						<label for="category">Kategorisi(*)</label>										
						<select name="category" class="form-control mb-3" id="category" required>
							<%
								CategoryDao categoryDao = new CategoryDao();
								List<Category> categoryList = categoryDao.fetchAll();
								for(Category category : categoryList){
									%>
										<option value="<%=category.getId()%>" <%=editProduct.getCategory().getId() == category.getId() ? "selected" : ""%>><%=category.getName()%></option>
									<%
								}
							%>								
						</select>
						
						<label for="productPrice">Fiyatı(*)</label>
						<input type="number" class="form-control mb-3" id="productPrice"
							name="productPrice" value="<%=editProduct.getPrice()%>" required>
							
						<label for="productStock">Stok adedi(*)</label>
						<input type="number" class="form-control mb-3" id="productStock"
							name="productStock" value="<%=editProduct.getStock()%>" required>
							
						<label for="productImage">Ürün resmini seçiniz</label><br>
						<input type="file" accept="image/png, image/jpeg" id="productImage" name="productImage"/>
					</div>
					<input type="submit" class="btn btn-primary mt-3" value="Güncelle"/>
				</form>
			</div>
		</div>				
	</div>
</body>
<style>
	.product-update-box {
		background-color: #f5f5f5;
		border-radius: 10px;
		padding: 30px;
		margin: 30px;
	}
</style>
</html>