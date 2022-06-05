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

public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;       

    public RegisterServlet() {
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
				response.sendRedirect("register.jsp");
				return;
			}
			
			// Create user to db
			
			User user = new User(username, password, false);
			UserDao userDao = new UserDao();
			int result = userDao.save(user);
			
			// Redirect
					
			if(result > -1) {
				
				// Get user from db
				
				User dbUser = userDao.fetchByUsernameAndPassword(username, password);
				
				if(dbUser != null && dbUser.getId() == result) {		
					httpSession.setAttribute("current-user", dbUser);				
					response.sendRedirect("index.jsp");
					return;
				} else {
					response.sendRedirect("error.jsp");
				}
			} else {
				httpSession.setAttribute("red-message", "Kullanici zaten mevcut");				
				response.sendRedirect("register.jsp");
				return;
			}
		} catch (Exception e) {
			response.sendRedirect("error.jsp");
		}
	}	
}
