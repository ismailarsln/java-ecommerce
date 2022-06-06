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
			String operation = request.getParameter("operation");
			HttpSession httpSession = request.getSession();
			CategoryDao categoryDao = new CategoryDao();
			
			if(operation.trim().equals("add")) {
				String categoryName = request.getParameter("categoryName");
				
				// Validations
				
				if(categoryName.isEmpty()) {
					httpSession.setAttribute("red-message", "Kategori adi bos olamaz");				
					response.sendRedirect("admin-category-management.jsp");
					return;
				}
				
				// Create category to db
				
				Category category = new Category(categoryName);
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
			} else if (operation.trim().equals("edit")) {
				String categoryName = request.getParameter("categoryName");
				int categoryId = Integer.parseInt(request.getParameter("categoryId"));
				
				// Validations
				
				if(categoryName.isEmpty()) {
					httpSession.setAttribute("red-message", "Kategori adi bos olamaz");				
					response.sendRedirect("admin-category-edit.jsp?categoryid=" + categoryId);
					return;
				}
				
				// Update category in db
				
				Category category = categoryDao.fetchById(categoryId);
				
				if(category == null) {
					httpSession.setAttribute("red-message", "Gecersiz kategori id");				
					response.sendRedirect("admin-category-edit.jsp?categoryid=" + categoryId);
					return;
				}
				
				category.setName(categoryName);				
				categoryDao.update(category);
				
				httpSession.setAttribute("green-message", "Kategori basariyla guncellendi");
				response.sendRedirect("admin-category-management.jsp");
				return;
				
			} else if (operation.trim().equals("delete")) {
				int categoryId = Integer.parseInt(request.getParameter("categoryId"));
				
				// Delete category in db
				
				categoryDao.deleteById(categoryId);
				
				httpSession.setAttribute("green-message", "Kategori basariyla silindi");
				response.sendRedirect("admin-category-management.jsp");
				return;
				
			} else {
				response.sendRedirect("error.jsp");
			}
		} catch (Exception e) {
			response.sendRedirect("error.jsp");
		}
	}	
}
