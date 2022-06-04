package java_ecommerce.hibernate.dao;

import java_ecommerce.hibernate.model.User;

public class UserDao extends DaoRepository<User> {

	public UserDao() {
		super(User.class);
	}
}
