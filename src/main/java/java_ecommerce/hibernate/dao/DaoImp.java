package java_ecommerce.hibernate.dao;

import java.util.List;

public interface DaoImp<T> {
	public List<T> fetchAll();
	public T fetchById(int id);
	public int save(T entity);
	public void update(T entity);
	public void deleteById(int id);
}
