<%@page import="java_ecommerce.hibernate.model.CartItem"%>
<%@page import="java.util.List"%>
<%@include file="components/login-check.jsp"%>
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
<title>Java-Ecommerce | Sepet</title>

</head>

<body>
	<div class="row">
		<div class="col-auto">
			<%@include file="components/navbar.jsp"%>
		</div>
		<div class="col">
			<%
			CartItemDao cartItemDao = new CartItemDao();
			List<CartItem> cartItemList = cartItemDao.fetchAllByUserId(navbarUser.getId());
			double cartAmount = 0;
			%>
			<!-- ##### Main Content Wrapper Start ##### -->
			<div class="main-content-wrapper d-flex clearfix">
				<div class="cart-table-area section-padding-100">
					<div class="container-fluid">
						<div class="row">
							<div class="col-12 col-lg-8">
								<div class="cart-title mt-50">
									<h2>Sepetim - <%=cartItemList.size()%> ürün</h2>
								</div>

								<div class="cart-table clearfix">
									<table class="table table-responsive">
										<thead>
											<tr>
												<th></th>
												<th>Ürün Adı</th>
												<th>Fiyatı</th>
												<th>Adet</th>
											</tr>
										</thead>
										<tbody>
											<%for(CartItem cartItem : cartItemList) {
												cartAmount += cartItem.getProduct().getPrice() * cartItem.getQuantity();
											%>
											<tr>
												<td class="cart_product_img"><a href="product-detail.jsp?productid=<%=cartItem.getProduct().getId()%>">
													<img src="img<%=cartItem.getProduct().getImage()%>" alt="Product"></a>
												</td>
												<td class="cart_product_desc">
													<h5><%=cartItem.getProduct().getName()%></h5>
												</td>
												<td class="price"><span><%=cartItem.getProduct().getPrice()%> TL</span></td>
												<td>
													<div class="row">
														<div class="col">
															<span><%=cartItem.getQuantity()%></span>
														</div>
														<div class="col">
															<form action="CartOperationServlet" method="post">
																<input type="hidden" name="operation" value="delete">
																<input type="hidden" name="cartItemId" value="<%=cartItem.getId()%>">
																<input type="hidden" name="userId" value="<%=navbarUser == null ? -1 : navbarUser.getId()%>">
																<button type="submit" name="createOrder" class="btn btn-danger">Sil</button>
															</form>														
														</div>
													</div>
													
												</td>
											</tr>
											<%}%>
										</tbody>
									</table>
								</div>
							</div>
							<div class="col-12 col-lg-4">
								<div class="cart-summary">
									<h5>Sepet Tutarı</h5>
									<ul class="summary-table">
										<li><span>Ürün Tutarı:</span> <span><%=cartAmount%> TL</span></li>
										<li><span>Kargo:</span> <span>ÜCRETSİZ</span></li>
										<li><span>Toplam:</span> <span><%=cartAmount%> TL</span></li>
									</ul>
									<div class="cart-btn mt-100">
										<form action="OrderOperationServlet" method="post">
											<input type="hidden" name="operation" value="add">
											<input type="hidden" name="userId" value="<%=navbarUser == null ? -1 : navbarUser.getId()%>">
											<button type="submit" name="createOrder" class="btn amado-btn btn-block"<%= cartItemList.size() > 0 ? "" : "disabled"%>>Siparişi Oluştur</button>
										</form>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- ##### Main Content Wrapper End ##### -->
		</div>
	</div>
	<%@include file="components/footer.jsp"%>
	<%@include file="components/links-scripts.jsp"%>
</body>

</html>