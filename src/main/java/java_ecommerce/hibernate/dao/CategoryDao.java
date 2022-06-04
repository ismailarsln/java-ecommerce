package java_ecommerce.hibernate.dao;

import java_ecommerce.hibernate.model.Category;

public class CategoryDao extends DaoRepository<Category> {

	public CategoryDao() {
		super(Category.class);
	}
}
