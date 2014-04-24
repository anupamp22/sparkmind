package com.sparkmind.model;

import java.io.Serializable;
import java.util.List;
import java.util.Set;

import javax.persistence.*;

import org.codehaus.jackson.annotate.JsonBackReference;
import org.codehaus.jackson.annotate.JsonIgnore;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;


/**
 * The persistent class for the product database table.
 * 
 */
@Entity
@Table (name="product", schema="test")
public class Product implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	private int id;

	@Column(name="category_id")
	private int categoryId;

	@JsonBackReference
	@ManyToOne(optional=false)
	@JoinColumn(name="category_id",referencedColumnName="id", insertable=false, updatable=false)
	private Category category;
	
	@JsonIgnore
	@ManyToMany(mappedBy="productList") 
	private Set<Order> orderList; //setting to list instead of set type errors in multiple bags can't be fetched
	
	
	private String description;

	private String imagepath;

	@Lob
	@Column(name="imgae_src")
	private byte[] imgaeSrc;

	private byte ispackage;

	private String name;

	private float price;

	private String productcode;

	private String shortname;

	   
	
	public Product() {
	}

	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getCategoryId() {
		return this.categoryId;
	}

	public void setCategoryId(int categoryId) {
		this.categoryId = categoryId;
	}

	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getImagepath() {
		return this.imagepath;
	}

	public void setImagepath(String imagepath) {
		this.imagepath = imagepath;
	}

	public byte[] getImgaeSrc() {
		return this.imgaeSrc;
	}

	public void setImgaeSrc(byte[] imgaeSrc) {
		this.imgaeSrc = imgaeSrc;
	}

	public byte getIspackage() {
		return this.ispackage;
	}

	public void setIspackage(byte ispackage) {
		this.ispackage = ispackage;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public float getPrice() {
		return this.price;
	}

	public void setPrice(float price) {
		this.price = price;
	}

	public String getProductcode() {
		return this.productcode;
	}

	public void setProductcode(String productcode) {
		this.productcode = productcode;
	}

	public String getShortname() {
		return this.shortname;
	}

	public void setShortname(String shortname) {
		this.shortname = shortname;
	}

	public Category getCategory() {
		return category;
	}

	public void setCategory(Category category) {
		this.category = category;
	}
	
	public Set<Order> getOrderList() {
		  return orderList;
	}
		   
	public void setOrderList(Set<Order> orderList) {
	  this.orderList = orderList;
	}

	@Override
	public String toString(){
		return "product category: "+this.category.getName()+
				" product name: "+this.name+
				" product code: "+this.productcode+
				" price: "+this.price+
				" category: "+this.getCategory().getName()+
				" category id: "+this.getCategory().getId();
	}
}