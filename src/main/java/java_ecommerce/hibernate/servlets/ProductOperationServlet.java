package java_ecommerce.hibernate.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java_ecommerce.hibernate.dao.CategoryDao;
import java_ecommerce.hibernate.dao.ProductDao;
import java_ecommerce.hibernate.model.Category;
import java_ecommerce.hibernate.model.Product;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;

@MultipartConfig(fileSizeThreshold = 1024 * 1024,
maxFileSize = 1024 * 1024 * 10, 	// 10 MB
maxRequestSize = 1024 * 1024 * 10)	// 10 MB
public class ProductOperationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;       

    public ProductOperationServlet() {
        super();
    }
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		
		try {
			String operation = request.getParameter("operation");
			HttpSession httpSession = request.getSession();			
			CategoryDao categoryDao = new CategoryDao();
			ProductDao productDao = new ProductDao();
			
			if(operation.trim().equals("add")) {
				String productName = request.getParameter("productName");
				int categoryId = Integer.parseInt(request.getParameter("category"));
				double productPrice = Double.parseDouble(request.getParameter("productPrice"));
				int productStock = Integer.parseInt(request.getParameter("productStock"));
				Part productImagePart = request.getPart("productImage");	
				
				// Validations
				
				validateProduct(response, httpSession, productName, categoryId, productPrice, productStock, productImagePart);
				
				
				// Create product to db
				Category category = categoryDao.fetchById(categoryId);
				
				String uploadPath = File.separator + "product" + File.separator + "default.png";
				
				// Upload Image
				if(productImagePart.getSize() != 0 && productImagePart.getSubmittedFileName() != "") {
					uploadPath = uploadImage(request, productImagePart);
				}
				
				Product product = new Product(category, productName, productPrice, productStock, uploadPath);
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
			} else if(operation.trim().equals("edit")) {
				int productId = Integer.parseInt(request.getParameter("productId"));
				String productName = request.getParameter("productName");
				int categoryId = Integer.parseInt(request.getParameter("category"));
				double productPrice = Double.parseDouble(request.getParameter("productPrice"));
				int productStock = Integer.parseInt(request.getParameter("productStock"));
				Part productImagePart = request.getPart("productImage");
				
				// Validations
				
				validateProduct(response, httpSession, productName, categoryId, productPrice, productStock, productImagePart);
				
				// Update product in db
				
				Product updatedProduct = productDao.fetchById(productId);
				
				if(updatedProduct == null) {
					httpSession.setAttribute("red-message", "Gecersiz urun id");
					response.sendRedirect("admin-product-management.jsp");
					return;
				}
				
				Category category = categoryDao.fetchById(categoryId);
				
				if(category == null) {
					httpSession.setAttribute("red-message", "Gecersiz kategori id");
					response.sendRedirect("admin-product-management.jsp");
					return;
				}
				
				updatedProduct.setCategory(category);
				updatedProduct.setName(productName);
				updatedProduct.setPrice(productPrice);
				updatedProduct.setStock(productStock);
				
				String imagePath = updatedProduct.getImage();
				
				// Upload Image
				if(productImagePart.getSize() != 0 && productImagePart.getSubmittedFileName() != "") {
					imagePath = uploadImage(request, productImagePart);
					if(updatedProduct.getImage() != "\\product\\default.png") {
						String oldImageFullPath = request.getRealPath("img") + updatedProduct.getImage();
						deleteImage(oldImageFullPath);
					}					
				}
				
				updatedProduct.setImage(imagePath);
				
				productDao.update(updatedProduct);
				
				httpSession.setAttribute("green-message", "Urun basariyla guncellendi");
				response.sendRedirect("admin-product-management.jsp");
				return;
			} else if(operation.trim().equals("delete")) {
				int productId = Integer.parseInt(request.getParameter("productId"));
				
				// Delete product in db
				
				productDao.deleteById(productId);
				
				httpSession.setAttribute("green-message", "Urun basariyla silindi");
				response.sendRedirect("admin-product-management.jsp");
				return;
				
			} else {
				response.sendRedirect("error.jsp");
			}
			
		} catch (Exception e) {
			response.sendRedirect("error.jsp");
		}
	}

	private void validateProduct(HttpServletResponse response, HttpSession httpSession, String productName,
			int categoryId, double productPrice, int productStock, Part productImagePart) throws IOException {
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
		
		if(productImagePart.getSize() > 10485760) {
			httpSession.setAttribute("red-message", "Resim boyutu en fazla 10 MB olabilir");				
			response.sendRedirect("admin-product-management.jsp");
			return;
		}
	}

	private String uploadImage(HttpServletRequest request, Part productImagePart)
			throws FileNotFoundException, IOException {		
		String appPath = request.getRealPath("img");
		String uploadPath = File.separator + "product" + File.separator + java.util.UUID.randomUUID();
		String fullPath = appPath + uploadPath;
		
		FileOutputStream fos = new FileOutputStream(fullPath);
		
		InputStream is = productImagePart.getInputStream();	
				
		byte[] data = new byte[is.available()];
		
		is.read(data);
		fos.write(data);
		fos.close();
		
		return uploadPath;
	}
	
	private void deleteImage(String imagePath) {
		File file = new File(imagePath);
		file.delete();
	}
}
