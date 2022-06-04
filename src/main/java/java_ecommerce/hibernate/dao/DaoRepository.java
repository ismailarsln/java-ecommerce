package java_ecommerce.hibernate.dao;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

public class DaoRepository<T> implements DaoImp<T> {

	private SessionFactory _sessionFactory;
	private Class<T> _entityClass;
	
	public DaoRepository(Class<T> entityClass) {
		_sessionFactory = new Configuration()
								.configure("hibernate.cfg.xml")
								.buildSessionFactory();
		_entityClass = entityClass;
		
	}

	@Override
	public List<T> fetchAll() {
		Session session = _sessionFactory.openSession(); 
		List<T> returnList = new ArrayList<T>();
		
		try {
		    CriteriaBuilder builder = session.getCriteriaBuilder();
		    CriteriaQuery<T> criteria = builder.createQuery(_entityClass);
		    criteria.from(_entityClass);
		    returnList = session.createQuery(criteria).getResultList();
		} finally {
			session.close();
		}
		
		return returnList;
	}

	@Override
	public T fetchById(int id) {
		Session session = _sessionFactory.openSession(); 
		T entity = null;
		try {
			entity = session.get(_entityClass, id);		
		} finally {
			session.close();
		}
		
		return entity;
	}

	@Override
	public void save(T entity) {
		Session session = _sessionFactory.openSession(); 
		
		try {
			session.beginTransaction();
			session.save(entity);
		    session.getTransaction().commit();
		} catch (Exception e) {
			session.getTransaction().rollback();
		} finally {
			session.close();
		}	
	}

	@Override
	public void update(T entity) {
		Session session = _sessionFactory.openSession(); 
		
		try {
			session.beginTransaction();
			session.update(entity);
		    session.getTransaction().commit();
		} catch (Exception e) {
			session.getTransaction().rollback();
		} finally {
			session.close();
		}	
		
	}

	@Override
	public void deleteById(int id) {
		Session session = _sessionFactory.openSession(); 
		
		try {
			session.beginTransaction();
			T category = session.get(_entityClass, id);
			session.delete(category);
		    session.getTransaction().commit();
		} catch (Exception e) {
			session.getTransaction().rollback();
		} finally {
			session.close();
		}	
		
	}

}
