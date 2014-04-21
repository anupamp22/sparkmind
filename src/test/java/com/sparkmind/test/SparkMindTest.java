package com.sparkmind.test;

import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;

import org.junit.Test;
import org.junit.runner.RunWith;
import static org.junit.Assert.assertNull;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.sparkmind.model.Category;
import com.sparkmind.model.Product;
import com.sparkmind.service.ProductConfigService;


@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
@RunWith(SpringJUnit4ClassRunner.class)
public class SparkMindTest {

	@Autowired
	private ProductConfigService productConfigService;
	
	protected static Logger logger = Logger.getLogger(SparkMindTest.class);
	
	@Test
	@Transactional
	public void executeTest(){
		List<Category> categoryList = productConfigService.getAllCategories();
		List<Product> productList = productConfigService.getAllProducts();
		System.out.println(categoryList.size()+"::"+productList.size());
		
		
		//Product product = em.find(Product.class, 1);
		//Adding a new category
		Category newCategory = new Category();
		newCategory.setName("Test");
		newCategory.setTags("Test");
		//em.persist(newCategory);
		productConfigService.saveCategory(newCategory);
		
		//Adding a new product to the category
		Product newProduct = new Product();
		newProduct.setCategory(newCategory);
		newProduct.setName("test");
		newProduct.setPrice(699);
		newProduct.setCategoryId(newCategory.getId());
		//em.persist(newProduct);
		productConfigService.saveProduct(newProduct);
		
		//Attaching the product to the category
		List<Product> newProdList = new ArrayList<Product>();
		newProdList.add(newProduct);		
		newCategory.setProductList(newProdList);
		
		//Retrieving all the entities after added
		categoryList = productConfigService.getAllCategories();
		productList = productConfigService.getAllProducts();
		System.out.println(categoryList.size()+"::"+productList.size());
		
		//Category category = em.find(Category.class, 2);
		Category category = productConfigService.getCategoryByName("Test");
		System.out.println(category);
		
		List<Product> prods = category.getProductList();
		System.out.println(prods.size());
		
		for (Product p:prods){
			System.out.println(p);
		}
		
		//Deleting an entitiy after finding it
		productConfigService.removeCategory(newCategory.getId());
		
		//System.out.println("Anupam is testing with junit in sparkmindtest class::"+product.getCategory().getName());
		//assertNull(product.getCategory());
	}
	
	
}//end of test class
