package com.sparkmind.model;

public class ShoppingCartItem {
	
	private int id;
	private String name;
	private int qty;
	private float price;
	private float totalprice;
	
	public ShoppingCartItem(){		
	}
	public ShoppingCartItem(int id, String name, int qty, float price){
		this.id=id;
		this.name=name;
		this.qty=qty;
		this.price=price;
		this.totalprice=this.qty*this.price;
	}
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getQty() {
		return qty;
	}
	public void setQty(int qty) {
		this.qty = qty;
	}
	public float getPrice() {
		return price;
	}
	public void setPrice(float price) {
		this.price = price;
	}
	public float getTotalprice() {
		return totalprice;
	}
	public void setTotalprice(float totalprice) {
		this.totalprice = totalprice;
	}
	
	
	
}
