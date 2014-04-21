package com.sparkmind.service;

import java.util.List;

import com.sparkmind.model.Category;
import com.sparkmind.model.Product;

public interface ProductConfigService {
	
	List<Category> getAllCategories();
	List<Product> getAllProducts();
	Category getCategoryByName(String name);
	Product getProductByName(String name);
	Category getCategoryById(int id);
	Product getProductById(int id);
	void removeCategory(int id);
	void removeProduct(int id);
	void saveCategory(Category c);
	void saveProduct(Product p);
}
