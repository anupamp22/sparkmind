package com.sparkmind.service;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sparkmind.model.Category;
import com.sparkmind.model.Order;
import com.sparkmind.model.Product;

@Service
public class ProductConfigServiceImpl implements ProductConfigService {

    @PersistenceContext
    EntityManager em;
	
    @Transactional
	public List<Category> getAllCategories(){
		Query q = em.createQuery("FROM Category");
		return q.getResultList();
	}
	
    @Transactional
	public List<Product> getAllProducts(){
		Query q = em.createQuery("FROM Product");
		return q.getResultList();
	}
    @Transactional
	public Category getCategoryByName(String name){
		Category p = (Category)em.createQuery("FROM Category p where p.name=:name").setParameter("name", name).getSingleResult();
		System.out.println(p);
		return p;
	}
    @Transactional
	public Product getProductByName(String name){
		Product p = (Product)em.createQuery("FROM PRODUCT p where p.name=:name").setParameter("name", name).getSingleResult();
		return p;
	}
    @Transactional
	public Category getCategoryById(int id){
		Category c = em.find(Category.class, id);
		return c;
	}
    @Transactional
	public Product getProductById(int id){
		Product p = em.find(Product.class, id);
		return p;
	}
    
    @Transactional
    public void removeCategory(int id){
    	Category c = em.find(Category.class, id);
    	if (c!=null){
    		em.remove(c);
    	}    	
    }
    @Transactional
    public void removeProduct(int id){
    	Product p = em.find(Product.class, id);
    	if (p!=null){
    		em.remove(p);
    	}
    }
    
    @Transactional
    public void saveCategory(Category c){
    	em.persist(c);
    }
    @Transactional
    public void saveProduct(Product p){
    	em.persist(p);
    }
    
    @Transactional
    public void saveOrder(Order o){
    	em.persist(o);		
    	
    }
    
    @Transactional
    public List<Order> getOrdersByUserId(Long userId){
    	Query q = em.createQuery("FROM Order o where o.userId=:userId").setParameter("userId", userId);
    	return q.getResultList();
    }
}
