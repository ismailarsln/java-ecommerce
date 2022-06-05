<%@page import="java_ecommerce.hibernate.model.User"%>
<%
	User adminCheckUser = (User) session.getAttribute("current-user");
	if(adminCheckUser == null){
		session.setAttribute("red-message", "Oncelikle giris yapmalisiniz");
		response.sendRedirect("login.jsp");
		return;
	} else {
		if(!adminCheckUser.isAdmin()){
			session.setAttribute("red-message", "Bu sayfaya erisebilmek icin yetkiniz yok");
			response.sendRedirect("login.jsp");
			return;
		}
	}
%>