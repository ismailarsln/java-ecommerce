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
<meta charset="UTF-4">
<meta name="description" content="">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<!-- The above 4 meta tags *must* come first in the head; any other head content must come *after* these tags -->

<!-- Title  -->
<title>Java-Ecommerce | Tüm Ürünler</title>

</head>

<body>
	<%
	ProductDao productDao = new ProductDao();
	List<Product> productList = null;
	String stringCategoryId = request.getParameter("categoryid");
	int totalProductCount = 0;
	int pageNo = -1;
	int categoryId = -1;
	
	if (stringCategoryId == null || stringCategoryId.isEmpty()) {
		productList = productDao.fetchAll();
		totalProductCount = productList.size();
	} else {
		try {
			categoryId = Integer.parseInt(stringCategoryId);
		} catch (Exception e) {
			session.setAttribute("red-message", "Gecersiz urun id");
			response.sendRedirect("shop.jsp");
			return;
		}

		productList = productDao.fetchAllByCategoryId(categoryId);
		totalProductCount = productList.size();
	}

	String stringPage = request.getParameter("page");
	if (stringPage != null && !stringPage.isEmpty()) {
		try {
			pageNo = Integer.parseInt(stringPage);
		} catch (Exception e) {
			session.setAttribute("red-message", "Gecersiz sayfa numarası");
			response.sendRedirect("shop.jsp");
			return;
		}		
	}
	
	if(pageNo == -1){
		int max = productList.size() > 4 ? 4 : productList.size();
		productList = productList.subList(0, max);
	} else if (pageNo > 0 && pageNo <= (productList.size() / 4) + 1) {
		int min = 4 * (pageNo - 1);
		int max = (4 * pageNo) > productList.size() ? productList.size() : (4 * pageNo);
		productList = productList.subList(min, max);
	} else {
		session.setAttribute("red-message", "Gecersiz sayfa numarası");
		response.sendRedirect("shop.jsp");
		return;
	}
	%>
	<div class="row">
		<div class="col-auto">
			<%@include file="components/navbar.jsp"%>
		</div>
		<div class="col">
			<div class="row">
				<div class="col-2" style="background-color: #f5f5f5 !important;">
					<div class="shop_sidebar_area mt-100 ml-30 mb-50">
						<!-- ##### Single Widget ##### -->
						<div class="widget catagory mb-50">
							<!-- Widget Title -->
							<h6 class="widget-title mb-15">KATEGORİLER</h6>

							<%
							CategoryDao categoryDao = new CategoryDao();
							List<Category> categoryList = categoryDao.fetchAll();
							%>

							<!--  Catagories  -->
							<div class="catagories-menu">
								<ul>
									<li
										<%=stringCategoryId != null && !stringCategoryId.isEmpty() ? "" : "class='active'"%>>
										<a href="shop.jsp">Tüm Kategoriler</a>
									</li>
									<%
									for (Category category : categoryList) {
										boolean isActive = false;
										if (stringCategoryId != null && !stringCategoryId.isEmpty()) {
											isActive = Integer.toString(category.getId()).equals(stringCategoryId);
										}
									%>
									<li <%=isActive ? "class = 'active'" : ""%>><a
										href="shop.jsp?categoryid=<%=category.getId()%>"><%=category.getName()%></a>
									</li>
									<%
									}
									%>
								</ul>
							</div>
						</div>
					</div>
				</div>
				<div class="col-10">
					<div class="amado_product_area mt-100 mr-30 mb-50">
						<div>
							<%@include file="components/message.jsp"%>
						</div>

						<div class="container-fluid">
							<div class="row">
								<div class="col-12">
									<div
										class="product-topbar d-xl-flex align-items-end justify-content-between">
										<!-- Total Products -->
										<div class="total-products">
											<p>Toplam <%=totalProductCount%> ürün bulundu</p>
										</div>
										<div class="total-products">
											<p><%=pageNo == -1 || pageNo == 1 ? 1 : (pageNo - 1) * 4 %>-<%=pageNo == -1 || pageNo == 1 ? 4 : pageNo  * 4 %> arası gösteriliyor</p>
										</div>
									</div>
								</div>
							</div>

							<div class="row">

								<%
								for (Product product : productList) {
								%>
								<!-- Single Product Area -->
								<div class="col-12 col-sm-6 col-md-12 col-xl-6">
									<div class="single-product-wrapper">
										<!-- Product Image -->
										<div class="product-img">
											<a href="product-detail.jsp?productid=<%=product.getId()%>"> <img
												src="img<%=product.getImage()%>" alt="">
											</a>
										</div>

										<!-- Product Description -->
										<div
											class="product-description d-flex align-items-center justify-content-between">
											<!-- Product Meta Data -->
											<div class="product-meta-data">
												<div class="line"></div>
												<p class="product-price"><%=product.getPrice()%>
													TL
												</p>
												<a href="product-detail.jsp?productid=<%=product.getId()%>">
													<h6><%=product.getName()%></h6>
												</a>
											</div>
											<!-- Ratings & Cart -->
											<div class="ratings-cart text-right">
												<div class="cart">
													<a href="cart.html" data-toggle="tooltip"
														data-placement="left" title="Sepete Ekle"><img
														src="img/core-img/cart.png" alt="" width="25px"><span style="font-size: 15px"> | Sepete Ekle</span></a>
												</div>
											</div>
										</div>
									</div>
								</div>
								<%
								}
								%>
							</div>

							<div class="row">
								<div class="col-12">
									<!-- Pagination -->
									<nav aria-label="navigation">
										<ul class="pagination justify-content-end mt-50">
											<%
											int count = (totalProductCount / 4) + 1;
											for (int i = 0; i < count; i++) {
											%>
											<li
												<%=pageNo == (i + 1) || pageNo * -1 == (i + 1) ? "class='page-item active ml-3'" : "class='page-item ml-3'"%>>
												<a class="page-link"
												<%=
													categoryId > 0 ? "href='shop.jsp?categoryid=" + categoryId + "&page="+ (i + 1) + "'"  : "href='shop.jsp?page="+ (i + 1) + "'"
												%>
												>
												<%= i + 1 %>
												</a>
											</li>
											<%
											}
											%>
										</ul>
									</nav>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@include file="components/footer.jsp"%>
	<%@include file="components/links-scripts.jsp"%>
</body>

</html>