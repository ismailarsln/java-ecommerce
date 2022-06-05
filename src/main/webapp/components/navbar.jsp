<%@page import="java_ecommerce.hibernate.model.User"%>
<%
	User navbarUser = (User) session.getAttribute("current-user");
%>
<nav class="navbar navbar-expand-lg bg-primary mb-5">
  <div class="container">
    <a class="navbar-brand text-light" href="index.jsp">Navbar</a>
    <button class="navbar-toggler text-light" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item">
          <a class="nav-link active text-light" aria-current="page" href="index.jsp">Home</a>
        </li>
        <%
        	if(navbarUser != null && navbarUser.isAdmin()){
      			%>
	  				<li class="nav-item">
	      				<a class="nav-link active text-warning" aria-current="page" href=admin-category-management.jsp>Category Management</a>
	    			</li>
	    
	    			<li class="nav-item">
	      				<a class="nav-link text-warning" aria-current="page" href="admin-product-management.jsp">Product Management</a>
	    			</li>
	    			
	    			<li class="nav-item">
	      				<a class="nav-link text-warning" aria-current="page" href="admin-order-management.jsp">Order Management</a>
	    			</li>
	    			
	    			<li class="nav-item">
	      				<a class="nav-link text-warning" aria-current="page" href="admin-user-management.jsp">User Management</a>
	    			</li>
  				<%
        	}
        %>
      </ul>
      
      <ul class="navbar-nav ml-auto">
      
      	<%
      		if(navbarUser == null){
      			%>
      				<li class="nav-item">
          				<a class="nav-link active text-light" aria-current="page" href="login.jsp">Login</a>
        			</li>
        
        			<li class="nav-item">
          				<a class="nav-link text-light" aria-current="page" href="register.jsp">Register</a>
        			</li>
      			<%
      		} else{
      			%>
	  				<li class="nav-item">
	      				<span class="nav-link active text-light" aria-current="page"><%=navbarUser.getUsername()%></span>
	    			</li>
	    
	    			<li class="nav-item">
	      				<a class="nav-link text-light" aria-current="page" href="LogoutServlet">Logout</a>
	    			</li>
  				<%
      		}
      	%>
      
      
        
      </ul>
    </div>
  </div>
</nav>