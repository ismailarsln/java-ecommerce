<%@page import="java_ecommerce.hibernate.model.Category"%>
<%@page import="java.util.List"%>
<%@page import="java_ecommerce.hibernate.dao.CategoryDao"%>
<%@include file="../../components/admin-check.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Category Management</title>
<%@include file="../../components/bootstrap-jquery.jsp"%>
</head>
<body>
	<%@include file="../../components/navbar.jsp"%>
	<%@include file="../../components/message.jsp" %>
	<div>
		<button type="button" class="btn btn-success" data-bs-toggle="modal"
			data-bs-target="#addCategoryModal">Ekle</button>

		<table class="table table-striped text-center">
			<thead>
				<tr>
					<th scope="col">#</th>
					<th scope="col">Adı</th>
					<th scope="col"></th>
				</tr>
			</thead>
			<tbody class="category-table">
				<%
				CategoryDao categoryDao = new CategoryDao();
				List<Category> categoryList = categoryDao.fetchAll();

				for (int i = 0; i < categoryList.size(); i++) {
				%>
				<tr>
					<th class="text-break" scope="row"><%=i + 1%></th>
					<td class="text-break"><%=categoryList.get(i).getName()%></td>
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

	<div class="modal fade" id="addCategoryModal" tabindex="-1"
		aria-labelledby="addCategoryModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="addCategoryModalLabel">Kategori
						Ekle</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">

					<form action="CategoryOperationServlet" method="post">
						<input type="hidden" name="operation" value="add">
						<div class="mb-3">
							<input type="text" class="form-control" id="categoryName"
								name="categoryName" placeholder="Kategori adı" required>
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