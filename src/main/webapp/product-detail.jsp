<%@page import="java_ecommerce.hibernate.model.Product"%>
<%@page import="java_ecommerce.hibernate.dao.ProductDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String stringProductId = request.getParameter("productid");
if (stringProductId == null || stringProductId.isEmpty()) {
	response.sendRedirect("shop.jsp");
	return;
}

int productId = -1;

try {
	productId = Integer.parseInt(stringProductId);
} catch (Exception e) {
	response.sendRedirect("shop.jsp");
	return;
}

ProductDao productDao = new ProductDao();
Product product = productDao.fetchById(productId);
if (product == null) {
	response.sendRedirect("shop.jsp");
	return;
}
%>
	
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
<title>Java-Ecommerce | Ürün Detayları</title>

<!-- Favicon  -->
<link rel="icon" href="img/core-img/favicon.ico">
</head>

<body>
	<div class="row">
		<div class="col-auto">
			<%@include file="components/navbar.jsp"%>
		</div>
		<div class="col">
			<!-- ##### Main Content Wrapper Start ##### -->
			<div class="main-content-wrapper clearfix">
				<!-- Product Details Area Start -->
				<div class="single-product-area section-padding-100 clearfix">
					<%@include file="components/message.jsp"%>
					<div class="container-fluid">

						<div class="row">
							<div class="col-12">
								<nav aria-label="breadcrumb">
									<ol class="breadcrumb mt-50">
										<li class="breadcrumb-item"><a href="shop.jsp?categoryid=<%=product.getCategory().getId()%>"><%=product.getCategory().getName()%></a></li>
										<li class="breadcrumb-item active" style="text-decoration: underline;" aria-current="page"><%=product.getName()%></li>
									</ol>
								</nav>
							</div>
						</div>

						<div class="row">
							<div class="col-12 col-lg-5">
								<div class="single_product_thumb">
									<img src="img<%=product.getImage()%>" style="width: 100%;">
								</div>
							</div>
							<div class="col-12 col-lg-7">
								<div class="single_product_desc">
									<!-- Product Meta Data -->
									<div class="product-meta-data">
										<div class="line"></div>
										<p class="product-price"><%=product.getPrice()%> TL</p>
										<a href="product-details.html">
											<h6><%=product.getName()%></h6>
										</a>
										<!-- Ratings & Review -->
										<div
											class="ratings-review mb-15 d-flex align-items-center justify-content-between">
											<div class="ratings">
												<i class="fa fa-star" aria-hidden="true"></i> <i
													class="fa fa-star" aria-hidden="true"></i> <i
													class="fa fa-star" aria-hidden="true"></i> <i
													class="fa fa-star" aria-hidden="true"></i> <i
													class="fa fa-star" aria-hidden="true"></i>
											</div>
										</div>
										<!-- Avaiable -->
										<p class="avaibility">
											<%
												if(product.getStock() > 0){
													%>
													<i class="fa fa-circle available"></i> Stokta <%=product.getStock()%> adet var
													<%
												} else {
													%>
													<i class="fa fa-circle not-available"></i> Stokta yok
													<%
												}
											%>											
										</p>
									</div>

									<div class="short_overview my-5">
										<p>Lorem ipsum dolor sit amet, consectetur adipisicing
											elit. Aliquid quae eveniet culpa officia quidem mollitia
											impedit iste asperiores nisi reprehenderit consequatur,
											autem?</p>
									</div>

									<!-- Add to Cart Form -->
									<form class="cart clearfix" action="CartOperationServlet" method="post">
										<input type="hidden" name="operation" value="add">
										<input type="hidden" name="userId" value="<%=navbarUser == null ? -1 : navbarUser.getId()%>">
										<input type="hidden" name="productId" value="<%=product.getId()%>">
										<div class="cart-btn d-flex mb-50">
											<p>Adet</p>
											<div class="quantity">
												<span class="qty-minus"
													onclick="var effect = document.getElementById('qty'); var qty = effect.value; if( !isNaN( qty ) &amp;&amp; qty &gt; 1 ) effect.value--;return false;"><i
													class="fa fa-caret-down" aria-hidden="true"></i></span> <input
													type="number" class="qty-text" id="qty" step="1" min="1"
													max="300" name="quantity" value="1"> <span
													class="qty-plus"
													onclick="var effect = document.getElementById('qty'); var qty = effect.value; if( !isNaN( qty )) effect.value++;return false;"><i
													class="fa fa-caret-up" aria-hidden="true"></i></span>
											</div>
										</div>
										<button type="submit" name="addtocart" class="btn amado-btn" <%= product.getStock() > 0 ? "" : "disabled"%>>Sepete Ekle</button>
									</form>

								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- Product Details Area End -->
			</div>
			<!-- ##### Main Content Wrapper End ##### -->
		</div>
	</div>
	<%@include file="components/footer.jsp"%>
	<%@include file="components/links-scripts.jsp"%>
</body>

</html>