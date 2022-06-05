package java_ecommerce.hibernate.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java_ecommerce.hibernate.dao.CategoryDao;
import java_ecommerce.hibernate.model.Category;

import java.io.IOException;
import java.io.PrintWriter;

public class CategoryOperationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;       

    public CategoryOperationServlet() {
        super();
    }
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		
		try {
			PrintWriter out = response.getWriter();
			String operation = request.getParameter("operation");
			
			if(operation.trim().equals("add")) {
				String categoryName = request.getParameter("categoryName");
				
				HttpSession httpSession = request.getSession();	
				
				// Validations
				
				if(categoryName.isEmpty()) {
					httpSession.setAttribute("red-message", "Kategori adi bos olamaz");				
					response.sendRedirect("admin-category-management.jsp");
					return;
				}
				
				// Create category to db
				
				Category category = new Category(categoryName);
				CategoryDao categoryDao = new CategoryDao();
				int result = categoryDao.save(category);
				
				// Redirect
				
				if(result > -1) {					
					httpSession.setAttribute("green-message", "Kategori basariyla eklendi");
					response.sendRedirect("admin-category-management.jsp");
					return;
				} else {
					httpSession.setAttribute("red-message", "Kategori zaten var");
					response.sendRedirect("admin-category-management.jsp");
					return;
				}
			}
		} catch (Exception e) {
			response.sendRedirect("error.jsp");
		}
	}	
}
