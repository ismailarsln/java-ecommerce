package java_ecommerce.hibernate.dao;

import java_ecommerce.hibernate.model.OrderItem;

public class OrderItemDao extends DaoRepository<OrderItem>{

	public OrderItemDao() {
		super(OrderItem.class);
	}
}
