<%@page import="java_ecommerce.hibernate.dao.UserDao"%>
<%@page import="java.util.List"%>
<%@include file="components/admin-check.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Management</title>
<%@include file="components/bootstrap-jquery.jsp"%>
</head>
<body>
	<%@include file="components/navbar.jsp"%>
	<%@include file="components/message.jsp"%>
	<div>

		<table class="table table-striped text-center">
			<thead>
				<tr>
					<th scope="col">#</th>
					<th scope="col">Kullanıcı adı</th>
					<th scope="col">Rolü</th>
					<th scope="col"></th>
				</tr>
			</thead>
			<tbody class="category-table">
				<%
				UserDao userDao = new UserDao();
				List<User> userList = userDao.fetchAll();

				for (int i = 0; i < userList.size(); i++) {
				%>
				<tr>
					<th class="text-break" scope="row"><%=i + 1%></th>
					<td class="text-break"><%=userList.get(i).getUsername()%></td>
					<td class="text-break"><%=userList.get(i).isAdmin() ? "ADMIN" : "USER"%></td>
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

</body>
</html>