package java_ecommerce.hibernate.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java_ecommerce.hibernate.dao.CartItemDao;
import java_ecommerce.hibernate.dao.OrderDao;
import java_ecommerce.hibernate.dao.OrderItemDao;
import java_ecommerce.hibernate.dao.ProductDao;
import java_ecommerce.hibernate.dao.UserDao;
import java_ecommerce.hibernate.model.CartItem;
import java_ecommerce.hibernate.model.Order;
import java_ecommerce.hibernate.model.OrderItem;
import java_ecommerce.hibernate.model.Product;
import java_ecommerce.hibernate.model.User;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

public class OrderOperationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;       

    public OrderOperationServlet() {
        super();
    }
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		
		try {
			String operation = request.getParameter("operation");
			HttpSession httpSession = request.getSession();
			UserDao userDao = new UserDao();
			CartItemDao cartItemDao = new CartItemDao();
			OrderDao orderDao = new OrderDao();
			OrderItemDao orderItemDao = new OrderItemDao();
			ProductDao productDao = new ProductDao();
			
			if(operation.trim().equals("add")) {
				int userId = Integer.parseInt(request.getParameter("userId"));
				
				if(userId < 0) {
					httpSession.setAttribute("red-message", "Siparis olusturabilmek icin öncelikle giris yapmalisiniz");
					response.sendRedirect("login.jsp");
					return;
				}
				
				User user = userDao.fetchById(userId);
				
				if(user == null) {
					httpSession.setAttribute("red-message", "Gecersiz kullanici id");
					response.sendRedirect("shop.jsp");
					return;
				}
				
				
				Order order = new Order(user, -1);				
				int orderId = orderDao.save(order);
				
				if(orderId < 0) {
					response.sendRedirect("error.jsp");
					return;
				}
				
				List<CartItem> userCartItems = cartItemDao.fetchAllByUserId(userId);
				
				if(userCartItems.size() == 0) {
					httpSession.setAttribute("red-message", "Sepetinizde urun bulunmamaktadir");
					response.sendRedirect("shop.jsp");
					return;
				}
				
				double total = 0;
				
				for (CartItem cartItem : userCartItems) {
					if(cartItem.getProduct().getStock() <= 0) {
						continue;
					}
					
					OrderItem orderItem = new OrderItem(order, cartItem.getProduct(), cartItem.getProduct().getPrice(), cartItem.getQuantity(), false);
					int orderItemId = orderItemDao.save(orderItem);
					
					if(orderItemId >= 0) {						
						cartItemDao.deleteById(cartItem.getId());
						cartItem.getProduct().setStock(cartItem.getProduct().getStock() - cartItem.getQuantity());
						productDao.update(cartItem.getProduct());
						total += cartItem.getProduct().getPrice() * cartItem.getQuantity();
					}
				}
				
				order.setTotal(total);
				orderDao.update(order);
				
				httpSession.setAttribute("green-message", "Siparisiniz basariyla olusturuldu");
				response.sendRedirect("shop.jsp");
				return;
				
			} else if(operation.trim().equals("deliver")) {
				int orderItemId = Integer.parseInt(request.getParameter("orderItemId"));
				
				if(orderItemId < 0) {
					httpSession.setAttribute("red-message", "Gecersiz siparis item Id");
					response.sendRedirect("admin-order-management.jsp");
					return;
				}
				
				OrderItem orderItem = orderItemDao.fetchById(orderItemId);
				
				if(orderItem == null) {
					httpSession.setAttribute("red-message", "Gecersiz siparis item Id");
					response.sendRedirect("admin-order-management.jsp");
					return;
				}
				
				orderItem.setDelivered(true);
				orderItemDao.update(orderItem);
				
				httpSession.setAttribute("green-message", "Siparis basarıyla teslim edildi");
				response.sendRedirect("admin-order-management.jsp");
				return;
			} else {
				response.sendRedirect("error.jsp");
			}
		} catch (Exception e) {
			response.sendRedirect("error.jsp");
		}
	}	
}
