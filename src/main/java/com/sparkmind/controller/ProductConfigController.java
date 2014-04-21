package com.sparkmind.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sparkmind.model.Category;
import com.sparkmind.model.Product;
import com.sparkmind.model.ShoppingCart;
import com.sparkmind.service.ProductConfigService;

@Controller
public class ProductConfigController {

	protected static Logger logger = Logger.getLogger(ProductConfigController.class);
	
	@Autowired
	private ProductConfigService productConfigService;
	
	static Map<Integer, Category> categoryMap = new HashMap<Integer, Category>();
	static Map<Integer, Product> productMap = new HashMap<Integer, Product>();
	
	static List<Category> categoryList = new ArrayList<Category>();
	
	public void initialize(){
		categoryList = productConfigService.getAllCategories();
		for(Category c:categoryList){
			categoryMap.put(Integer.valueOf(c.getId()), c);
			for(Product p:c.getProductList()){
				productMap.put(p.getId(), p);
			}
		}
	}
	
	@RequestMapping(value="/configurator",method=RequestMethod.GET)
	public String configurator(Model model, @RequestParam(required=false) String message){
		initialize();
		model.addAttribute("message", message);
		model.addAttribute("categoryList",categoryList);
		
		ShoppingCart shoppingCart = new ShoppingCart();
		model.addAttribute("shoppingCart",shoppingCart);
		return "configurator";
	}
	
	@RequestMapping(value="/getProducts",method=RequestMethod.GET)
	public @ResponseBody List<Product> configurator(@RequestParam(required=true) int categoryId){
		/*for(Product p:categoryMap.get(categoryId).getProductList()){
			System.out.println("Anupam is printing:::"+p);
		}*/
		return (List<Product>)categoryMap.get(categoryId).getProductList();
		//return productConfigService.getCategoryById(categoryId).getProductList();
	}
	
	@RequestMapping(value = "/addToCart", method = RequestMethod.POST)
	public @ResponseBody List<Product> addToCart(@RequestBody String[] productIDs) {
		List<Product> prodList = new ArrayList<Product>();
		for(String id:productIDs){
			//System.out.println("#@#@%$#%@#@#3333333333333333333333"+Integer.valueOf(id));
			prodList.add(productMap.get(Integer.valueOf(id)));
		}
		//OrderForm orderForm = createOrderForm(userSelections.getSelection());
		return prodList;
	}
	
}
