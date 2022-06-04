package java_ecommerce.hibernate.dao;

import java_ecommerce.hibernate.model.Product;

public class ProductDao extends DaoRepository<Product> {

	public ProductDao() {
		super(Product.class);
	}
}
