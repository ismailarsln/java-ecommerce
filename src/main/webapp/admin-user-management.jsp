<%@page import="java_ecommerce.hibernate.dao.UserDao"%>
<%@page import="java.util.List"%>
<%@include file="components/admin-check.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Java-Ecommerce | Kullanıcı Yönetimi</title>
</head>
<body>

	<div class="row">
		<div class="col-auto">
			<%@include file="components/navbar.jsp"%>
		</div>
		<div class="col">
			<div class="user-management-box">
				<%@include file="components/message.jsp"%>
				<%
				UserDao userDao = new UserDao();
				List<User> userList = userDao.fetchAll();
				%>
				<div class="mb-5">
					<h5>
						Toplam kullanıcı sayısı:
						<%=userList.size()%></h5>
				</div>
				<table class="table table-striped text-center">
					<thead>
						<tr>
							<th class="col-md-1" scope="col">#</th>
							<th class="col-md-7" scope="col">Kullanıcı adı</th>
							<th class="col-md-2" scope="col">Rolü</th>
							<th class="col-md-2" scope="col"></th>
						</tr>
					</thead>
					<tbody class="user-table">
						<%
						for (int i = 0; i < userList.size(); i++) {
						%>
						<tr>
							<th class="text-break" scope="row"><%=i + 1%></th>
							<td class="text-break"><%=userList.get(i).getUsername()%></td>
							<td class="text-break"><%=userList.get(i).isAdmin() ? "ADMIN" : "KULLANICI"%></td>
							<td>
								<div class="d-flex justify-content-end">
									<form id="changeRoleForm<%=i + 1%>" action="UserOperationServlet"
										method="post">
										<input type="hidden" name="operation" value="changeRole">
										<input type="hidden" value="<%=userList.get(i).getId()%>"
											name="userId" />
									</form>
									<button class="btn btn-sm btn-primary btn-block ml-2"
										onclick="changeRole(<%=i + 1%>)">
										Rolünü
										<%=!userList.get(i).isAdmin() ? "ADMIN" : "KULLANICI"%>
										Yap
									</button>
									<form id="deleteForm<%=i + 1%>" action="UserOperationServlet"
										method="post">
										<input type="hidden" name="operation" value="delete">
										<input type="hidden" name="userId"
											value="<%=userList.get(i).getId()%>">
									</form>
									<button class="btn btn-sm btn-danger btn-block ml-2"
										onclick="deleteUser(<%=i + 1%>)">Sil</button>
								</div>
							</td>
						</tr>
						<%
						}
						%>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<%@include file="components/footer.jsp"%>
	<%@include file="components/links-scripts.jsp"%>

	<script>
		function deleteUser(count){
			var result = confirm(count + " numaralı kullanıcı silenecek. Onaylıyor musunuz?");
			if(result){
				var deleteForm = document.getElementById("deleteForm" + count);
				deleteForm.submit();
			}		
		}
		
		function changeRole(count){
			var result = confirm(count + " numaralı kullanıcının rolü güncellenecek. Onaylıyor musunuz?");
			if(result){
				var deleteForm = document.getElementById("changeRoleForm" + count);
				deleteForm.submit();
			}	
		}
	</script>
</body>
<style>
.user-management-box {
	background-color: #f5f5f5;
	border-radius: 10px;
	padding: 30px;
	margin: 30px;
}

.user-table td {
	vertical-align: middle;
}

.user-table th {
	vertical-align: middle;
}
</style>
</html>