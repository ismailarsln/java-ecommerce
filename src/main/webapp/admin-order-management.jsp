<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java_ecommerce.hibernate.dao.OrderItemDao"%>
<%@page import="java_ecommerce.hibernate.model.OrderItem"%>
<%@page import="java_ecommerce.hibernate.model.Order"%>
<%@page import="java_ecommerce.hibernate.dao.OrderDao"%>
<%@page import="java.util.List"%>
<%@include file="components/admin-check.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Order Management</title>
<%@include file="components/bootstrap-jquery.jsp"%>
</head>
<body>
	<%@include file="components/navbar.jsp"%>
	<%@include file="components/message.jsp"%>
	<div class="order-management-box">
		<%
			OrderDao orderDao = new OrderDao();
			OrderItemDao orderItemDao = new OrderItemDao();
			SimpleDateFormat s = new SimpleDateFormat("yyyy-MM-dd");
			
			String lowerDate = request.getParameter("low");
			String upperDate = request.getParameter("up");
			
			List<Order> orderList;
			
			if((lowerDate == null || lowerDate.isEmpty()) && (upperDate == null || upperDate.isEmpty())){
				orderList = orderDao.fetchAll();
			} else if (!(lowerDate == null || lowerDate.isEmpty()) && (upperDate == null || upperDate.isEmpty())){
				Calendar cal = Calendar.getInstance();
				orderList = orderDao.fetchAllByCreatedAt(lowerDate, s.format(cal.getTime()));
			} else if ((lowerDate == null || lowerDate.isEmpty()) && !(upperDate == null || upperDate.isEmpty())){
				Calendar cal = Calendar.getInstance();
				cal.add(Calendar.YEAR, -1000);
				orderList = orderDao.fetchAllByCreatedAt(s.format(cal.getTime()), upperDate);				
			} else {
				orderList = orderDao.fetchAllByCreatedAt(lowerDate, upperDate);
			}
			
			
		%>
		<div class="mb-4 d-flex justify-content-end align-items-center">
			<form action="admin-order-management.jsp" method="get">
			  	<label for="birthday">Başlangıç tarihi:</label>
			  	<input class="me-2" type="date" id="low" name="low">
			  	
			  	<label for="birthday">Bitiş tarihi:</label>
			  	<input class="me-2"  type="date" id="up" name="up">
			  	
			  	<input class="btn btn-success" type="submit" value="Filtrele">
			</form>
		</div>
		
		<table class="table table-striped text-center">
			<thead>
				<tr>
					<th class="col-md-1" scope="col">#</th>
					<th class="col-md-1" scope="col">Ürün Resmi</th>
					<th class="col-md-1" scope="col">Sipariş ID</th>
					<th class="col-md-1" scope="col">Ürün ID</th>
					<th class="col-md-1" scope="col">Kullanıcı ID</th>	
					<th class="col-md-2" scope="col">Kullanıcı Adı</th>				
					<th class="col-md-2" scope="col">Ürün Adı</th>
					<th class="col-md-1" scope="col">Alınan Fiyat</th>
					<th class="col-md-1" scope="col">Adet</th>
					<th class="col-md-2" scope="col">Satın Alım Tarihi</th>
				</tr>
			</thead>
			<tbody class="order-table">
				<%
					int count = 1;
					for (int i = 0; i < orderList.size(); i++) {
						List<OrderItem> orderItemList = orderItemDao.fetchAllByOrderId(orderList.get(i).getId());
						for(int j = 0; j < orderItemList.size(); j++)	{
				%>
				<tr>
					<th class="text-break" scope="row"><%=count%></th>
					<td class="text-break"><img src="img<%=orderItemList.get(j).getProduct().getImage()%>" width="100px" height="100px"></td>
					<th class="text-break" scope="row">#<%=orderList.get(i).getId()%></th>
					<th class="text-break" scope="row">#<%=orderItemList.get(j).getProduct().getId()%></th>
					<th class="text-break" scope="row">#<%=orderList.get(i).getUser().getId()%></th>					
					<td class="text-break"><%=orderList.get(i).getUser().getUsername()%></td>
					<td class="text-break"><%=orderItemList.get(j).getProduct().getName()%></td>		
					<td class="text-break"><%=orderItemList.get(j).getPrice()%> TL</td>		
					<td class="text-break">x<%=orderItemList.get(j).getQuantity()%></td>		
					<td class="text-break"><%=orderList.get(i).getCreatedAt()%></td>					
				</tr>
				<%
						count++;
					}
				}
				%>
			</tbody>
		</table>
	</div>
</body>
<style>
	.order-management-box {
		background-color: #f5f5f5;
		border-radius: 10px;
		padding: 30px;
		margin: 30px;
	}
	
	.order-table td {
	    vertical-align: middle;
	}
	.order-table th {
	    vertical-align: middle;
	}
</style>
</html>