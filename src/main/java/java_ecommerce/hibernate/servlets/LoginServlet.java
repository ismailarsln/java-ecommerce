package java_ecommerce.hibernate.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java_ecommerce.hibernate.dao.UserDao;
import java_ecommerce.hibernate.model.User;

import java.io.IOException;
import java.io.PrintWriter;

public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;       

    public LoginServlet() {
        super();
    }
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		
		try {
			PrintWriter out = response.getWriter();
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			
			HttpSession httpSession = request.getSession();	
			
			// Validations
			
			if(username.isEmpty() || password.isEmpty()) {
				httpSession.setAttribute("red-message", "Kullanici adi ve sifre bos olmamalidir");				
				response.sendRedirect("login.jsp");
				return;
			}
			
			// Check user from db
			
			UserDao userDao = new UserDao();
			User dbUser = userDao.fetchByUsernameAndPassword(username, password);			
			
			// Redirect			
					
			if(dbUser == null) {
				httpSession.setAttribute("red-message", "Kullanici adi veya sifre hatali");				
				response.sendRedirect("login.jsp");
				return;
			} else {
				httpSession.setAttribute("current-user", dbUser);				
				response.sendRedirect("index.jsp");
				return;
			}
		} catch (Exception e) {
			response.sendRedirect("error.jsp");
		}
	}	
}
