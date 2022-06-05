package java_ecommerce.hibernate.dao;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.query.Query;

import java_ecommerce.hibernate.model.Product;

public class ProductDao extends DaoRepository<Product> {

	public ProductDao() {
		super(Product.class);
	}
	
	public List<Product> fetchAllByCategoryId(int categoryId){
		Session session = getSessionFactory().openSession(); 
		List<Product> returnList = new ArrayList<Product>();
		
		try {
			Query<Product> query = session.createQuery("FROM Product as p WHERE p.category.id =: id");
			query.setParameter("id", categoryId);
			returnList = query.list();
		} finally {
			session.close();
		}
		
		return returnList;
	}
	
	public List<Product> fetchAllGreaterThanPrice(double price){
		Session session = getSessionFactory().openSession(); 
		List<Product> returnList = new ArrayList<Product>();
		
		try {
			Query<Product> query = session.createQuery("FROM Product as p WHERE p.price >=: price");
			query.setParameter("price", price);
			returnList = query.list();
		} finally {
			session.close();
		}
		
		return returnList;
	}
	
	public List<Product> fetchAllLessThanPrice(double price){
		Session session = getSessionFactory().openSession(); 
		List<Product> returnList = new ArrayList<Product>();
		
		try {
			Query<Product> query = session.createQuery("FROM Product as p WHERE p.price <=: price");
			query.setParameter("price", price);
			returnList = query.list();
		} finally {
			session.close();
		}
		
		return returnList;
	}
	
	public List<Product> fetchAllInStock(){
		Session session = getSessionFactory().openSession(); 
		List<Product> returnList = new ArrayList<Product>();
		
		try {
			Query<Product> query = session.createQuery("FROM Product as p WHERE p.stock > 0");
			returnList = query.list();
		} finally {
			session.close();
		}
		
		return returnList;
	}
}
