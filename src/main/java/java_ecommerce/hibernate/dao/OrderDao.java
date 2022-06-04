package java_ecommerce.hibernate.dao;

import java_ecommerce.hibernate.model.Order;

public class OrderDao extends DaoRepository<Order> {

	public OrderDao() {
		super(Order.class);
	}
}
