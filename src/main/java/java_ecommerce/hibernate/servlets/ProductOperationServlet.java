package java_ecommerce.hibernate.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java_ecommerce.hibernate.dao.CategoryDao;
import java_ecommerce.hibernate.dao.ProductDao;
import java_ecommerce.hibernate.model.Category;
import java_ecommerce.hibernate.model.Product;

import java.io.IOException;
import java.io.PrintWriter;

public class ProductOperationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;       

    public ProductOperationServlet() {
        super();
    }
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		
		try {
			PrintWriter out = response.getWriter();
			String operation = request.getParameter("operation");
			
			if(operation.trim().equals("add")) {
				String productName = request.getParameter("productName");
				int categoryId = Integer.parseInt(request.getParameter("category"));
				double productPrice = Double.parseDouble(request.getParameter("productPrice"));
				int productStock = Integer.parseInt(request.getParameter("productStock"));
				// Part productImagePart = request.getPart("productImage");
				
				HttpSession httpSession = request.getSession();	
				
				// Validations
				
				if(productName.isEmpty()) {
					httpSession.setAttribute("red-message", "Ürün adi bos olamaz");				
					response.sendRedirect("admin-product-management.jsp");
					return;
				}
				
				if(categoryId < 0) {
					httpSession.setAttribute("red-message", "Gecersiz kategori");				
					response.sendRedirect("admin-product-management.jsp");
					return;
				}
				
				if(productPrice < 0) {
					httpSession.setAttribute("red-message", "Urun fiyati en az 0 olabilir");				
					response.sendRedirect("admin-product-management.jsp");
					return;
				}
				
				if(productStock < 0) {
					httpSession.setAttribute("red-message", "Urun stogu en az 0 olabilir");				
					response.sendRedirect("admin-product-management.jsp");
					return;
				}
				/*
				if(productImagePart.getSize() > 10485760) {
					httpSession.setAttribute("red-message", "Resim boyutu en fazla 10 MB olabilir");				
					response.sendRedirect("admin-product-management.jsp");
					return;
				}
				*/
				
				// Create product to db
				
				CategoryDao categoryDao = new CategoryDao();
				Category category = categoryDao.fetchById(categoryId);
				
				Product product = new Product(category, productName, productPrice, productStock, "default.jpg");
				ProductDao productDao = new ProductDao();
				int result = productDao.save(product);
				
				// Redirect
				
				if(result > -1) {					
					httpSession.setAttribute("green-message", "Urun basariyla eklendi");
					response.sendRedirect("admin-product-management.jsp");
					return;
				} else {
					httpSession.setAttribute("red-message", "Urun eklenirken bir sorun olustu");
					response.sendRedirect("admin-product-management.jsp");
					return;
				}
			}
		} catch (Exception e) {
			response.sendRedirect("error.jsp");
		}
	}	
}
