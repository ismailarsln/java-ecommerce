package java_ecommerce.hibernate.dao;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.query.Query;

import java_ecommerce.hibernate.model.Order;
import java_ecommerce.hibernate.model.OrderItem;

public class OrderItemDao extends DaoRepository<OrderItem>{

	public OrderItemDao() {
		super(OrderItem.class);
	}
	
	public List<OrderItem> fetchAllByOrderId(int orderId){
		Session session = getSessionFactory().openSession(); 
		List<OrderItem> returnList = new ArrayList<OrderItem>();
		
		try {
			Query<OrderItem> query = session.createQuery("FROM OrderItem as o WHERE o.order.id =: id");
			query.setParameter("id", orderId);
			returnList = query.list();
		} finally {
			session.close();
		}
		
		return returnList;
	}
}
