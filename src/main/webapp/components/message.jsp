<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<%
	String greenMessage = (String)session.getAttribute("green-message");
	String redMessage = (String)session.getAttribute("red-message");
	if(greenMessage != null){
		
		%>
			<div class="alert alert-success" role="alert">
  				<%=greenMessage%>
			</div>
		<%
		
		session.removeAttribute("green-message");
	} else if( redMessage != null){		
		%>
			<div class="alert alert-danger" role="alert">
  				<%=redMessage%>
			</div>
		<%
		
		session.removeAttribute("red-message");
	}
%>