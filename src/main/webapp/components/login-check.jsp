<%@page import="java_ecommerce.hibernate.model.User"%>
<%
	User loginCheckUser = (User) session.getAttribute("current-user");
	if(loginCheckUser == null){
		session.setAttribute("red-message", "Oncelikle giris yapmalisiniz");
		response.sendRedirect("login.jsp");
		return;
	}
%>