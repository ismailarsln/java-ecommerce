<%@page import="java_ecommerce.hibernate.model.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	User navbarUser = (User) session.getAttribute("current-user");
%>
 <!-- Search Wrapper Area Start -->
    <div class="search-wrapper section-padding-100">
        <div class="search-close">
            <i class="fa fa-close" aria-hidden="true"></i>
        </div>
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <div class="search-content">
                        <form action="#" method="get">
                            <input type="search" name="search" id="search" placeholder="Type your keyword...">
                            <button type="submit"><img src="img/core-img/search.png" alt=""></button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Search Wrapper Area End -->

    <!-- ##### Main Content Wrapper Start ##### -->
    <div class="main-content-wrapper d-flex clearfix">

        <!-- Mobile Nav (max width 767px)-->
        <div class="mobile-nav">
            <!-- Navbar Brand -->
            <div class="amado-navbar-brand">
                <a href="index.jsp"><img src="img/core-img/logo.png" alt=""></a>
            </div>
            <!-- Navbar Toggler -->
            <div class="amado-navbar-toggler">
                <span></span><span></span><span></span>
            </div>
        </div>

        <!-- Header Area Start -->
        <header class="header-area clearfix">
            <!-- Close Icon -->
            <div class="nav-close">
                <i class="fa fa-close" aria-hidden="true"></i>
            </div>
            <!-- Logo -->
            <div class="logo">
                <a href="index.jsp"><img src="img/core-img/logo.png" alt=""></a>
            </div>
            
             <%
      		if(navbarUser == null){
      			%>
      				<!-- Button Group -->
            <div class="amado-btn-group mt-30 mb-100">
                <a href="login.jsp" class="btn amado-btn mb-15">Giriş</a>
                <a href="register.jsp" class="btn amado-btn mb-15">Kayıt Ol</a>
            </div>
      			<%
      		} else{
      			%>
	  				 <div class="amado-btn-group mt-30 mb-100">
	      				<span style="font-size:27px; text-transform: uppercase"  aria-current="page"><%=navbarUser.getUsername()%></span>
	      				<br>
	      				
	      				<a class="btn amado-btn mb-15" aria-current="page" href="LogoutServlet">Logout</a>
	    			            </div>
  				<%
      		}
      	%>
      	
      
             <!-- Amado Nav -->
            <nav class="amado-nav">
                <ul>
               
	      				<div class="cart-fav-search mb-100">
                <li > <a href="cart.html" class="cart-nav"><img src="img/core-img/cart.png" alt=""> Sepet <span>(0)</span></a></li>
                 <li ><a href="#" class="fav-nav"><img src="img/core-img/favorites.png" alt=""> Tüm Ürünler</a></li>
                 <li ><a href="#" class="search-nav"><img src="img/core-img/search.png" alt=""> Arama</a></li>
                
            </div>
	    			
                
                    
                    <%
        	if(navbarUser != null && navbarUser.isAdmin()){
      			%>
	  				<li >
	      				<a aria-current="page" href=admin-category-management.jsp>Category Management</a>
	    			</li>
	    
	    			<li >
	      				<a  aria-current="page" href="admin-product-management.jsp">Product Management</a>
	    			</li>
	    			
	    			<li >
	      				<a  aria-current="page" href="admin-order-management.jsp">Order Management</a>
	    			</li>
	    			
	    			<li >
	      				<a  aria-current="page" href="admin-user-management.jsp">User Management</a>
	    			</li>
  				<%
        	}
        %>
                    
                  
                    
                </ul>
            </nav>
            
           
             
           
           
           
            <!-- Social Button -->
            <div class="social-info d-flex justify-content-between">
                <a href="#"><i class="fa fa-pinterest" aria-hidden="true"></i></a>
                <a href="#"><i class="fa fa-instagram" aria-hidden="true"></i></a>
                <a href="#"><i class="fa fa-facebook" aria-hidden="true"></i></a>
                <a href="#"><i class="fa fa-twitter" aria-hidden="true"></i></a>
            </div>
               <!-- ##### jQuery (Necessary for All JavaScript Plugins) ##### -->
    <script src="js/jquery/jquery-2.2.4.min.js"></script>
    <!-- Popper js -->
    <script src="js/popper.min.js"></script>
    <!-- Bootstrap js -->
    <script src="js/bootstrap.min.js"></script>
    <!-- Plugins js -->
    <script src="js/plugins.js"></script>
    <!-- Active js -->
    <script src="js/active.js"></script>
        </header>
        <!-- Header Area End -->