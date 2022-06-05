package java_ecommerce.hibernate.dao;

import org.hibernate.Session;
import org.hibernate.query.Query;

import java_ecommerce.hibernate.model.User;

public class UserDao extends DaoRepository<User> {

	public UserDao() {
		super(User.class);
	}
	
	public User fetchByUsernameAndPassword(String username, String password){
		Session session = getSessionFactory().openSession(); 
		User user = null;
		
		try {
			Query<User> query = session.createQuery("FROM User as u WHERE u.username =: username AND u.password =: password");
			query.setParameter("username", username);
			query.setParameter("password", password);
			user = query.uniqueResult();
		} finally {
			session.close();
		}
		
		return user;
	}
}
