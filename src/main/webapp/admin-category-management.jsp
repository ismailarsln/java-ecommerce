<%@page import="java_ecommerce.hibernate.model.Category"%>
<%@page import="java.util.List"%>
<%@page import="java_ecommerce.hibernate.dao.CategoryDao"%>
<%@include file="components/admin-check.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Category Management</title>
<%@include file="components/bootstrap-jquery.jsp"%>
</head>

<body>
	<%@include file="components/navbar.jsp"%>
	<%@include file="components/message.jsp"%>
	<div class="category-management-box">
		<%
			CategoryDao categoryDao = new CategoryDao();
			List<Category> categoryList = categoryDao.fetchAll();
		%>
		<div class="mb-5">
			<h5>Toplam kategori sayısı: <%=categoryList.size()%></h5>			
		</div>
		<button type="button" class="btn btn-success" data-bs-toggle="modal"
			data-bs-target="#addCategoryModal">Ekle</button>

		<table class="table table-striped text-center">
			<thead>
				<tr>
					<th class="col-md-1"  scope="col">#</th>
					<th class="col-md-1"  scope="col">Kategori ID</th>
					<th class="col-md-9" scope="col">Kategori Adı</th>
					<th class="col-md-1"  scope="col"></th>
				</tr>
			</thead>
			<tbody class="category-table">
				<%
					for (int i = 0; i < categoryList.size(); i++) {
				%>
				<tr>
					<th class="text-break" scope="row"><%=i + 1%></th>
					<th class="text-break" scope="row">#<%=categoryList.get(i).getId()%></th>
					<td class="text-break"><%=categoryList.get(i).getName()%></td>
					<td>
						<div class="d-flex justify-content-end">
							<form action="admin-category-edit.jsp" method="get">
							    <input type="hidden" value="<%=categoryList.get(i).getId()%>" name="categoryid" /> 
							    <input class="btn btn-sm btn-primary btn-block" id="editSubmit" type="submit" value="Düzenle"/>
							</form>
							<form id="deleteForm<%=i+1%>" action="CategoryOperationServlet" method="post">
								<input type="hidden" name="operation" value="delete">
								<input type="hidden" name="categoryId" value="<%=categoryList.get(i).getId()%>">
							</form>
							<button class="btn btn-sm btn-danger btn-block ms-2" onclick="deleteCategory(<%=i + 1%>)">Sil</button>
						</div>						
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
		aria-labelledby="addCategoryModalLabel" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
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
	
	<script>
		function deleteCategory(count){
			var result = confirm(count + " numaralı kategori silenecek. Onaylıyor musunuz?");
			if(result){
				var deleteForm = document.getElementById("deleteForm" + count);
				deleteForm.submit();
			}		
		}
	</script>
</body>
<style>
	.category-management-box {
		background-color: #f5f5f5;
		border-radius: 10px;
		padding: 30px;
		margin: 30px;
	}
	
	.category-table td {
	    vertical-align: middle;
	}
	.category-table th {
	    vertical-align: middle;
	}
</style>
</html>