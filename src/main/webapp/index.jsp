<%@page import="java_ecommerce.hibernate.model.Product"%>
<%@page import="java_ecommerce.hibernate.dao.ProductDao"%>
<%@page import="java_ecommerce.hibernate.model.Category"%>
<%@page import="java.util.List"%>
<%@page import="java_ecommerce.hibernate.dao.CategoryDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="description" content="">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<!-- The above 4 meta tags *must* come first in the head; any other head content must come *after* these tags -->

<!-- Title  -->
<title>Java-Ecommerce | Ana Sayfa</title>
</head>

<body>
	<div class="row">
		<div class="col-auto">
			<%@include file="components/navbar.jsp"%>
		</div>
		<div class="col">
			<!-- Product Catagories Area Start -->
			<div class="products-catagories-area clearfix">
				<div class="amado-pro-catagory clearfix">

					<%
					ProductDao productDao = new ProductDao();
					List<Product> productList = productDao.fetchAll();
					for (Product product : productList) {
					%>
					<div class="single-products-catagory clearfix">
						<a href="product-detail.jsp?productid=<%=product.getId()%>"> <img src="img<%=product.getImage()%>" alt="">
							<!-- Hover Content -->
							<div class="hover-content">
								<div class="line"></div>
								<p>
									Fiyat:
									<%=product.getPrice()%>
									TL
								</p>
								<h4 class="text-truncate" style="max-width: 400px;"><%=product.getName()%></h4>
							</div>
						</a>
					</div>
					<%
					}
					%>
				</div>
			</div>
			<!-- Product Catagories Area End -->
		</div>
		<!-- ##### Main Content Wrapper End ##### -->
	</div>
	<%@include file="components/footer.jsp"%>
	<%@include file="components/links-scripts.jsp"%>
</body>

</html>