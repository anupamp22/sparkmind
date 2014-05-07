package com.sparkmind.service;

import java.util.Collection;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sparkmind.model.Category;
import com.sparkmind.model.Order;
import com.sparkmind.model.Product;

@Service
public class ProductConfigServiceImpl implements ProductConfigService {

    @PersistenceContext
    EntityManager em;
	
    @Override
    @Transactional(readOnly = true)
	public List<Category> getAllCategories(){
		Query q = em.createQuery("FROM Category");
		return q.getResultList();
	}
	
    @Override
    @Transactional(readOnly = true)
	public List<Product> getAllProducts(){
		Query q = em.createQuery("FROM Product");
		return q.getResultList();
	}
    @Override
    @Transactional(readOnly = true)
	public Category getCategoryByName(String name){
		Category p = (Category)em.createQuery("FROM Category p where p.name=:name").setParameter("name", name).getSingleResult();
		System.out.println(p);
		return p;
	}
    @Override
    @Transactional(readOnly = true)
	public Product getProductByName(String name){
		Product p = (Product)em.createQuery("FROM PRODUCT p where p.name=:name").setParameter("name", name).getSingleResult();
		return p;
	}
    @Override
    @Transactional(readOnly = true)
	public Category getCategoryById(int id){
		Category c = em.find(Category.class, id);
		return c;
	}
    @Override
    @Transactional(readOnly = true)
	public Product getProductById(int id){
		Product p = em.find(Product.class, id);
		return p;
	}
    @Override
    @Transactional
    public void removeCategory(int id){
    	Category c = em.find(Category.class, id);
    	if (c!=null){
    		em.remove(c);
    	}    	
    }
    @Override
    @Transactional
    public void removeProduct(int id){
    	Product p = em.find(Product.class, id);
    	if (p!=null){
    		em.remove(p);
    	}
    }
    @Override
    @Transactional
    public void saveCategory(Category c){
    	em.persist(c);
    }
    @Override
    @Transactional
    public void saveProduct(Product p){
    	em.persist(p);
    }
    @Override
    @Transactional
    public void saveOrder(Order o){
    	em.persist(o);		
    	
    }
    @Override
    @Transactional(readOnly = true)
    @Cacheable(value = "orders")
    public List<Order> getOrdersByUserId(Long userId){
    	Query q = em.createQuery("FROM Order o where o.userId=:userId").setParameter("userId", userId);
    	return q.getResultList();
    }
    @Override
    @Transactional(readOnly = true)
    public Order getProductsForOrder(int orderId){
    	Query q = em.createQuery("SELECT distinct o FROM Order o LEFT JOIN FETCH o.productList where o.id=:orderId");
    	q.setParameter("orderId", orderId);
    	return (Order) q.getSingleResult();
    }
}
