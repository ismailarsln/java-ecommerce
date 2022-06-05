package java_ecommerce.hibernate.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;

public class LogoutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;       

    public LogoutServlet() {
        super();
    }
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		
		try {
			PrintWriter out = response.getWriter();
			HttpSession httpSession = request.getSession();
			httpSession.removeAttribute("current-user");
			response.sendRedirect("login.jsp");			
		} catch (Exception e) {
			response.sendRedirect("error.jsp");
		}
	}	
}
