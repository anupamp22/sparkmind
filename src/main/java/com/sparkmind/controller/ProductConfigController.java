package com.sparkmind.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.Set;
import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.googlecode.charts4j.Color;
import com.googlecode.charts4j.GCharts;
import com.googlecode.charts4j.PieChart;
import com.googlecode.charts4j.Slice;
import com.sparkmind.model.Category;
import com.sparkmind.model.Order;
import com.sparkmind.model.Product;
import com.sparkmind.model.ShoppingCart;
import com.sparkmind.model.ShoppingCartItem;
import com.sparkmind.model.ShoppingCartItemList;
import com.sparkmind.model.User;
import com.sparkmind.response.StatusResponse;
import com.sparkmind.service.ProductConfigService;

@Controller
public class ProductConfigController {

	protected static Logger logger = Logger.getLogger(ProductConfigController.class);
	
	@Autowired
	private ProductConfigService productConfigService;
	
	//static Map<Integer, Category> categoryMap = new HashMap<Integer, Category>();
	//static Map<Integer, Product> productMap = new HashMap<Integer, Product>();
	//static Map<Integer, ShoppingCartItem> shoppingCartItemMap = new HashMap<Integer, ShoppingCartItem>();
	
	private Map<Integer, Category> categoryMap;
	private Map<Integer, Product> productMap;
	private Map<Integer, ShoppingCartItem> shoppingCartItemMap;//=new HashMap<Integer, ShoppingCartItem>();
	
	private List<Category> categoryList;
	
	private Map<Integer, Set<Product>> orderMap;
	
	public void initialize(){
		categoryMap = new HashMap<Integer, Category>();
		productMap = new HashMap<Integer, Product>();
		//if (shoppingCartItemMap.size()<=0 && shoppingCartItemMap==null){
		shoppingCartItemMap = new HashMap<Integer, ShoppingCartItem>();
		//}
		categoryList = new ArrayList<Category>();
		
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
		
		ShoppingCartItemList shoppingCartItemList = new ShoppingCartItemList();
		model.addAttribute("shoppingCartItemList",shoppingCartItemList);
		return "configurator";
	}
	
	@RequestMapping(value="/getProducts",method=RequestMethod.GET)
	public @ResponseBody List<Product> configurator(@RequestParam(required=true) int categoryId){
		/*for(Product p:categoryMap.get(categoryId).getProductList()){
			System.out.println("Anupam is printing:::"+p);
		}
		//return productConfigService.getCategoryById(categoryId).getProductList();
		*/
		return (List<Product>)categoryMap.get(categoryId).getProductList();
		
	}
	
	@RequestMapping(value = "/addToCart", method = RequestMethod.POST)
	public @ResponseBody Map<Integer, ShoppingCartItem> addToCart(@RequestBody String[] productIDs) {
		/*List<Product> prodList = new ArrayList<Product>();
		for(String id:productIDs){
			//System.out.println("#@#@%$#%@#@#3333333333333333333333"+Integer.valueOf(id));
			prodList.add(productMap.get(Integer.valueOf(id)));
		}*/
		//OrderForm orderForm = createOrderForm(userSelections.getSelection());
		//List<ShoppingCartItem> shoppingCartItemList = new ArrayList<ShoppingCartItem>();
		for(String id:productIDs){
			if (productMap.containsKey(Integer.valueOf(id))){
				Product p = productMap.get(Integer.valueOf(id));
				ShoppingCartItem s=null;
				if (!shoppingCartItemMap.containsKey(Integer.valueOf(id))){
					s = new ShoppingCartItem(p.getId(),p.getName(), 1, p.getPrice());					
				}
				else{
					s = shoppingCartItemMap.get(Integer.valueOf(id));
					s.setQty(s.getQty()+1);
					s.setTotalprice(s.getQty()*s.getPrice());
				}
				shoppingCartItemMap.put(Integer.valueOf(id), s);				
			}
		}		
		//return prodList;
		return shoppingCartItemMap;
	}
	
	@RequestMapping(value = "/updateCart", method = RequestMethod.POST)
	public @ResponseBody Map<Integer, ShoppingCartItem> updateCart(@RequestBody ShoppingCartItemList shoppingCartItemList, HttpServletRequest request) {
		for(ShoppingCartItem s:shoppingCartItemList.getShoppingCartItems()){
			
			if (shoppingCartItemMap.containsKey(s.getId())){
				ShoppingCartItem shoppingCartItem = shoppingCartItemMap.get(s.getId());
				shoppingCartItem.setQty(s.getQty());
				shoppingCartItem.setTotalprice(shoppingCartItem.getPrice()*s.getQty());
				if (s.getQty()==0){
					shoppingCartItemMap.remove(s.getId());
				}
				
				//shoppingCartItemMap.put(s.getId(), shoppingCartItem);
			}
		}
		/*for(Integer id:shoppingCartItemMap.keySet()){
			ShoppingCartItem shoppingCartItem = shoppingCartItemMap.get(id);
			if (shoppingCartItem.getTotalprice()==0){
				shoppingCartItemMap.remove(id);
			}
		}*/
		HttpSession session = request.getSession(false);
		session.setAttribute("shoppingCartItemMap", shoppingCartItemMap);
		return shoppingCartItemMap;
	}
	
	@RequestMapping(value = "/checkoutCart", method = RequestMethod.POST)
	public @ResponseBody Map<Integer, ShoppingCartItem> checkoutCart(@RequestBody ShoppingCartItemList shoppingCartItemList, HttpServletRequest request) {
		for(ShoppingCartItem s:shoppingCartItemList.getShoppingCartItems()){
			if (shoppingCartItemMap.containsKey(s.getId())){
				ShoppingCartItem shoppingCartItem = shoppingCartItemMap.get(s.getId());
				shoppingCartItem.setQty(s.getQty());
				shoppingCartItem.setTotalprice(shoppingCartItem.getPrice()*s.getQty());
				if (s.getQty()==0){
					shoppingCartItemMap.remove(s.getId());
				}
			}
		}
		HttpSession session = request.getSession(false);
		session.setAttribute("shoppingCartItemMap", shoppingCartItemMap);
		
		return shoppingCartItemMap;
	}
	
	
	@RequestMapping(value = "/confirmOrder", method = RequestMethod.POST)
	public @ResponseBody StatusResponse confirmOrder(HttpServletRequest request){
		
		Order order = new Order();
		
		HttpSession session = request.getSession(false);
		User user = (User)session.getAttribute("user");
		order.setUserId(user.getId());
		//order.setUserId(new Long(1));
		
		Set<Product> productSet = new HashSet<Product>();
		float orderAmount=0;
		
		for(int id:shoppingCartItemMap.keySet()){
			ShoppingCartItem s =shoppingCartItemMap.get(id);
			Product p = new Product();
			p.setId(s.getId());
			productSet.add(p);
			orderAmount+=s.getTotalprice();
		}
		order.setProductList(productSet);
		order.setAmount(orderAmount);
		
		Random random = new Random();
		int i = random.nextInt(999999999);
		order.setConfirmationNumber(i);
		
		java.util.Date date= new java.util.Date();
		order.setDateCreated(new Timestamp(date.getTime()));
		
		productConfigService.saveOrder(order);
		
		String userMessage="Order created successfully! Your Order No is:"+i;
		System.out.println("Anupam is printing userMessage in product controller"+userMessage);
		return new StatusResponse(true, userMessage);
		//return i;
	}
	
	
	@RequestMapping(value = "/drawCharts", method = RequestMethod.GET)
	public String drawCharts(Model model){
		Slice s1 = Slice.newSlice(15, Color.newColor("CACACA"), "Mac", "Mac");
		Slice s2 = Slice.newSlice(15, Color.newColor("DF7417"), "Windows", "Windows");
		Slice s3 = Slice.newSlice(15, Color.newColor("951800"), "Linux", "Linux");
		Slice s4 = Slice.newSlice(15, Color.newColor("01A1DB"), "Others", "Others");
		
		PieChart pieChart = GCharts.newPieChart(s1,s2,s3,s4);
		pieChart.setTitle("Google Pie Chart", Color.BLACK,15);
		pieChart.setSize(720, 360);
		pieChart.setThreeD(true);
		
		model.addAttribute("pieChart", pieChart.toURLString());
		
		return "charts/chart";
	}
	
	@RequestMapping(value = "/myOrdersByAjax", method = RequestMethod.GET)
	public @ResponseBody List<Order> getMyOrdersThroughAjax(HttpServletRequest request){
		
		HttpSession session = request.getSession(false);
		User user = (User)session.getAttribute("user");
		
		return productConfigService.getOrdersByUserId(user.getId());		
	}
	
	@RequestMapping(value = "/myOrders", method = RequestMethod.GET)
	public String getMyOrders(HttpServletRequest request, Model model){
		
		HttpSession session = request.getSession(false);
		User user = (User)session.getAttribute("user");
		List<Order> orderList = productConfigService.getOrdersByUserId(user.getId());
		model.addAttribute("orderList", orderList);
		
		orderMap = new HashMap<Integer, Set<Product>> ();
		for (Order o:orderList){
			orderMap.put(o.getConfirmationNumber(), o.getProductList());
		}
		//System.out.println("Printing OrderMap in getMyOrders function"+orderMap);
		return "myOrders";
	}
	
	@RequestMapping(value = "/myOrders/{orderId}", method = RequestMethod.GET)
	public @ResponseBody Set<Product> getMyOrders(@PathVariable("orderId") Integer orderId /*@RequestParam Integer OrderId*/){
		Order o = productConfigService.getProductsForOrder(orderId);
		return o.getProductList();
	}
}
