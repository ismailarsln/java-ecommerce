package java_ecommerce.hibernate.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java_ecommerce.hibernate.dao.CartItemDao;
import java_ecommerce.hibernate.dao.ProductDao;
import java_ecommerce.hibernate.dao.UserDao;
import java_ecommerce.hibernate.model.CartItem;
import java_ecommerce.hibernate.model.Product;
import java_ecommerce.hibernate.model.User;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

public class CartOperationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;       

    public CartOperationServlet() {
        super();
    }
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		
		try {
			String operation = request.getParameter("operation");
			HttpSession httpSession = request.getSession();	
			ProductDao productDao = new ProductDao();
			UserDao userDao = new UserDao();
			CartItemDao cartItemDao = new CartItemDao();
			
			if(operation.trim().equals("add")) {
				int userId = Integer.parseInt(request.getParameter("userId"));
				
				if(userId < 0) {
					httpSession.setAttribute("red-message", "Sepete urun ekleyebilmek icin öncelikle giris yapmalisiniz");
					response.sendRedirect("login.jsp");
					return;
				}
				
				int productId = Integer.parseInt(request.getParameter("productId"));
				int quantity = Integer.parseInt(request.getParameter("quantity"));
				
				User user = userDao.fetchById(userId);
				
				if(user == null) {
					httpSession.setAttribute("red-message", "Gecersiz kullanici id");
					response.sendRedirect("product-detail.jsp?productid=" + productId);
					return;
				}
				
				Product product = productDao.fetchById(productId);
				
				if(product == null) {
					httpSession.setAttribute("red-message", "Gecersiz ürün id");
					response.sendRedirect("product-detail.jsp?productid=" + productId);
					return;
				}
				
				if(product.getStock() < 1) {
					httpSession.setAttribute("red-message", "Urun stokta yok");
					response.sendRedirect("product-detail.jsp?productid=" + productId);
					return;
				}
				
				List<CartItem> userCartItems = cartItemDao.fetchAllByUserId(userId);
				
				// Urun zaten sepette var mı kontrolü
				
				CartItem currentCartItem = null;
				
				for (CartItem iterationCartItem : userCartItems) {
					if(iterationCartItem.getUser().getId() == user.getId() && iterationCartItem.getProduct().getId() == product.getId()) {
						currentCartItem = iterationCartItem;
					}
				}				
				
				if(currentCartItem != null) {
					int totalQuantity = (currentCartItem.getQuantity() + quantity);
					if(totalQuantity > product.getStock()) {
						totalQuantity = product.getStock();
					}
					currentCartItem.setQuantity(totalQuantity);
					cartItemDao.update(currentCartItem);
					
					httpSession.setAttribute("green-message", "Sepetinizdeki urun miktari guncellendi");
					response.sendRedirect("product-detail.jsp?productid=" + productId);
					return;	
				} else {
					if(quantity > product.getStock()) {
						quantity = product.getStock();
					}
					CartItem cartItem = new CartItem(user, product, quantity);
					cartItemDao.save(cartItem);
					
					httpSession.setAttribute("green-message", "Urun sepete eklendi");
					response.sendRedirect("product-detail.jsp?productid=" + productId);
					return;	
				}				
				
			} else if (operation.trim().equals("delete")) {
				
			} else {
				response.sendRedirect("error.jsp");
			}
		} catch (Exception e) {
			response.sendRedirect("error.jsp");
		}
	}	
}
