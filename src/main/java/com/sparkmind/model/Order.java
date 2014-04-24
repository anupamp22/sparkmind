package com.sparkmind.model;

import java.io.Serializable;
import javax.persistence.*;

import org.codehaus.jackson.annotate.JsonIgnore;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

import java.sql.Timestamp;
import java.util.List;
import java.util.Set;


/**
 * The persistent class for the order database table.
 * 
 */
@Entity
@Table(name="order", schema="test")
public class Order implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	private int id;

	private float amount;

	@Column(name="date_created")
	private Timestamp dateCreated;

	@Column(name="orderstatus_id")
	private int orderstatusId;

	@Column(name="user_id")
	private Long userId;
	
	@Column(name="confirmation_number")
	private int confirmationNumber;

	//bi-directional many-to-one association to OrderHasProduct
	//@OneToMany(mappedBy="order")
	//private List<OrderHasProduct> orderHasProducts;
	
	@JsonIgnore
	@ManyToMany
    @JoinTable(name="order_has_product",joinColumns=@JoinColumn(name="order_id", referencedColumnName="id"),
			   inverseJoinColumns= @JoinColumn(name="product_id", referencedColumnName="id"))
	private Set<Product> productList; ////setting to list instead of set type errors in multiple bags can't be fetched
	

	public Order() {
	}

	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public float getAmount() {
		return this.amount;
	}

	public void setAmount(float amount) {
		this.amount = amount;
	}

	public Timestamp getDateCreated() {
		return this.dateCreated;
	}

	public void setDateCreated(Timestamp dateCreated) {
		this.dateCreated = dateCreated;
	}

	public int getOrderstatusId() {
		return this.orderstatusId;
	}

	public void setOrderstatusId(int orderstatusId) {
		this.orderstatusId = orderstatusId;
	}

	public Long getUserId() {
		return this.userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

	public Set<Product> getProductList() {
		return productList;
	}
	
	public void setProductList(Set<Product> productList) {
		this.productList = productList;
	}

	public int getConfirmationNumber() {
		return confirmationNumber;
	}

	public void setConfirmationNumber(int confirmationNumber) {
		this.confirmationNumber = confirmationNumber;
	}
	
	
	/*public List<OrderHasProduct> getOrderHasProducts() {
		return this.orderHasProducts;
	}

	public void setOrderHasProducts(List<OrderHasProduct> orderHasProducts) {
		this.orderHasProducts = orderHasProducts;
	}

	public OrderHasProduct addOrderHasProduct(OrderHasProduct orderHasProduct) {
		getOrderHasProducts().add(orderHasProduct);
		orderHasProduct.setOrder(this);

		return orderHasProduct;
	}

	public OrderHasProduct removeOrderHasProduct(OrderHasProduct orderHasProduct) {
		getOrderHasProducts().remove(orderHasProduct);
		orderHasProduct.setOrder(null);

		return orderHasProduct;
	}*/

}