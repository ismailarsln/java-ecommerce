<%@page import="java_ecommerce.hibernate.model.Category"%>
<%@page import="java_ecommerce.hibernate.dao.CategoryDao"%>
<%@page import="java_ecommerce.hibernate.model.Product"%>
<%@page import="java_ecommerce.hibernate.dao.ProductDao"%>
<%@page import="java.util.List"%>
<%@include file="components/admin-check.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Product Management</title>
<%@include file="components/bootstrap-jquery.jsp"%>
</head>
<body>
	<%@include file="components/navbar.jsp"%>
	<%@include file="components/message.jsp" %>
	<div>
		<button type="button" class="btn btn-success" data-bs-toggle="modal"
			data-bs-target="#addProductModal">Ekle</button>

		<table class="table table-striped text-center">
			<thead>
				<tr>
					<th scope="col">#</th>
					<th scope="col">Resmi</th>
					<th scope="col">Adı</th>
					<th scope="col">Kategorisi</th>
					<th scope="col">Fiyatı</th>
					<th scope="col">Stok adedi</th>
					<th scope="col"></th>
				</tr>
			</thead>
			<tbody>
				<%
				ProductDao productDao = new ProductDao();
				List<Product> productList = productDao.fetchAll();

				for (int i = 0; i < productList.size(); i++) {
				%>
				<tr>
					<th class="text-break" scope="row"><%=i + 1%></th>
					<td class="text-break"><img src="<%=productList.get(i).getImage()%>" width="45px" height="45px"></td>
					<td class="text-break"><%=productList.get(i).getName()%></td>
					<td class="text-break"><%=productList.get(i).getCategory().getName()%></td>
					<td class="text-break"><%=productList.get(i).getPrice()%> TL</td>
					<td class="text-break"><%=productList.get(i).getStock()%></td>
					<td>
						<button class="btn btn-sm btn-primary btn-block">Düzenle</button>
						<button class="btn btn-sm btn-danger btn-block">Sil</button>
					</td>
				</tr>
				<%
				}
				%>
			</tbody>
		</table>
	</div>

	<!-- Add Category Modal -->

	<div class="modal fade" id="addProductModal" tabindex="-1"
		aria-labelledby="addProductModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="addProductModalLabel">Ürün
						Ekle</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">

					<form action="ProductOperationServlet" method="post">
						<input type="hidden" name="operation" value="add">
						<div class="mb-3">
							<input type="text" class="form-control" id="productName"
								name="productName" placeholder="Ürün adı" required>
														
							<select name="category" class="form-control" id="category">
								<%
									CategoryDao categoryDao = new CategoryDao();
									List<Category> categoryList = categoryDao.fetchAll();
									for(Category category : categoryList){
										%>
											<option value="<%=category.getId()%>"><%=category.getName()%></option>
										<%
									}
								%>								
							</select>
							
							<input type="number" class="form-control" id="productPrice"
								name="productPrice" placeholder="Ürün fiyatı" required>
								
							<input type="number" class="form-control" id="productStock"
								name="productStock" placeholder="Stok adedi" required>
								
							<label for="productImage">Ürün resmini seçiniz</label><br>
							<input type="file" accept="image/png, image/jpeg" id="productImage" name="productImage"/>
						</div>

						<div class="container text-center">
							<button type="button" class="btn btn-secondary"
								data-bs-dismiss="modal">İptal</button>
							<input type="submit" class="btn btn-primary" value="Kaydet" />
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

	<!-- Add Category Modal End -->

</body>
</html>