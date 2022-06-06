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
	
	public List<Order> fetchAllByProductId(int productId){
		Session session = getSessionFactory().openSession(); 
		List<Order> returnList = new ArrayList<Order>();
		
		try {
			Query<Order> query = session.createQuery("FROM Order as o WHERE o.product.id =: id");
			query.setParameter("id", productId);
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
	
	public List<Order> fetchAllByUserIdAndCreatedAt(int userId, String lowerDate, String upperDate){
		Session session = getSessionFactory().openSession(); 
		List<Order> returnList = new ArrayList<Order>();
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		try {
			Calendar clow = Calendar.getInstance();
			clow.setTime(format.parse(lowerDate));
			clow.add(Calendar.HOUR, 23);
			clow.add(Calendar.MINUTE, 59);
			clow.add(Calendar.SECOND, 59);
			
			Calendar cup = Calendar.getInstance();
			cup.setTime(format.parse(upperDate));
			cup.add(Calendar.HOUR, 23);
			cup.add(Calendar.MINUTE, 59);
			cup.add(Calendar.SECOND, 59);
			
			SimpleDateFormat finalFormat =  new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			
			Query<Order> query = session.createQuery("FROM Order as o WHERE o.user.id =: id AND "
					+ "o.createdAt >=: lowerDate AND o.createdAt <=: upperDate");
			query.setParameter("id", userId);
			query.setParameter("lowerDate", finalFormat.parse(finalFormat.format(clow.getTime())));
			query.setParameter("upperDate", finalFormat.parse(finalFormat.format(cup.getTime())));
			returnList = query.list();
		} catch(Exception e) {			
		} finally {
			session.close();
		}
		
		return returnList;
	}
	
	public List<Order> fetchAllByCreatedAt(String lowerDate, String upperDate){		
		Session session = getSessionFactory().openSession(); 
		List<Order> returnList = new ArrayList<Order>();
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		try {
			Calendar clow = Calendar.getInstance();
			clow.setTime(format.parse(lowerDate));
			clow.add(Calendar.HOUR, 23);
			clow.add(Calendar.MINUTE, 59);
			clow.add(Calendar.SECOND, 59);
			
			Calendar cup = Calendar.getInstance();
			cup.setTime(format.parse(upperDate));
			cup.add(Calendar.HOUR, 23);
			cup.add(Calendar.MINUTE, 59);
			cup.add(Calendar.SECOND, 59);
			
			SimpleDateFormat finalFormat =  new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			
			Query<Order> query = session.createQuery("FROM Order as o WHERE o.createdAt >=: lowerDate AND o.createdAt <=: upperDate");
			query.setParameter("lowerDate", finalFormat.parse(finalFormat.format(clow.getTime())));
			query.setParameter("upperDate", finalFormat.parse(finalFormat.format(cup.getTime())));
			returnList = query.list();
		} catch(Exception e) {			
		} finally {
			session.close();
		}
		
		return returnList;
	}
}
