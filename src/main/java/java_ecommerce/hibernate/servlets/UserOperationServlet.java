package java_ecommerce.hibernate.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java_ecommerce.hibernate.dao.UserDao;
import java_ecommerce.hibernate.model.User;

import java.io.IOException;

public class UserOperationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;       

    public UserOperationServlet() {
        super();
    }
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		
		try {
			String operation = request.getParameter("operation");
			HttpSession httpSession = request.getSession();
			UserDao userDao = new UserDao();
			
			if(operation.trim().equals("changeRole")) {
				int userId = Integer.parseInt(request.getParameter("userId"));
				
				// Update user in db
				
				User user = userDao.fetchById(userId);
				
				if(user == null) {
					httpSession.setAttribute("red-message", "Gecersiz kullanici id");
					response.sendRedirect("admin-user-management.jsp");
					return;
				}
				
				user.setAdmin(!user.isAdmin());
				userDao.update(user);
				
				httpSession.setAttribute("green-message", "Kullanici rolu basariyla guncellendi!");
				response.sendRedirect("admin-user-management.jsp");
				return;
				
				
			} else if (operation.trim().equals("delete")) {
				int userId = Integer.parseInt(request.getParameter("userId"));
				
				// Delete user in db
				
				userDao.deleteById(userId);
				
				httpSession.setAttribute("green-message", "Kullanici basariyla silindi");
				response.sendRedirect("admin-user-management.jsp");
				return;
				
			} else {
				response.sendRedirect("error.jsp");
			}
		} catch (Exception e) {
			response.sendRedirect("error.jsp");
		}
	}	
}
