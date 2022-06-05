package java_ecommerce.hibernate.dao;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.query.Query;

import java_ecommerce.hibernate.model.Order;

public class OrderDao extends DaoRepository<Order> {

	public OrderDao() {
		super(Order.class);
	}
	
	public List<Order> fetchAllByUserId(int userId){
		Session session = getSessionFactory().openSession(); 
		List<Order> returnList = new ArrayList<Order>();
		
		try {
			Query<Order> query = session.createQuery("FROM Order as o WHERE o.user.id =: id");
			query.setParameter("id", userId);
			returnList = query.list();
		} finally {
			session.close();
		}
		
		return returnList;
	}
	
	public List<Order> fetchAllGreaterThanTotal(double price){
		Session session = getSessionFactory().openSession(); 
		List<Order> returnList = new ArrayList<Order>();
		SimpleDateFormat s = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		try {
			Query<Order> query = session.createQuery("FROM Order as o WHERE o.total >=: price");
			query.setParameter("price", price);
			returnList = query.list();
		} catch(Exception e) {			
		} finally {
			session.close();
		}
		
		return returnList;
	}
	
	public List<Order> fetchAllLessThanTotal(double price){
		Session session = getSessionFactory().openSession(); 
		List<Order> returnList = new ArrayList<Order>();
		SimpleDateFormat s = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		try {
			Query<Order> query = session.createQuery("FROM Order as o WHERE o.total <=: price");
			query.setParameter("price", price);
			returnList = query.list();
		} catch(Exception e) {			
		} finally {
			session.close();
		}
		
		return returnList;
	}
	
	public List<Order> fetchAllByUserIdAndCreatedAt(int userId, Calendar lowerDate, Calendar upperDate){
		Session session = getSessionFactory().openSession(); 
		List<Order> returnList = new ArrayList<Order>();
		SimpleDateFormat s = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		try {
			Query<Order> query = session.createQuery("FROM Order as o WHERE o.user.id =: id AND "
					+ "o.createdAt >=: lowerDate AND o.createdAt <=: upperDate");
			query.setParameter("id", userId);
			query.setParameter("lowerDate", s.parse(s.format(lowerDate.getTime())));
			query.setParameter("upperDate", s.parse(s.format(upperDate.getTime())));
			returnList = query.list();
		} catch(Exception e) {			
		} finally {
			session.close();
		}
		
		return returnList;
	}
}
