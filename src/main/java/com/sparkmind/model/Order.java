package com.sparkmind.model;

import java.io.Serializable;
import javax.persistence.*;
import java.sql.Timestamp;
import java.util.List;


/**
 * The persistent class for the order database table.
 * 
 */
@Entity
public class Order implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	private int id;

	private double amount;

	@Column(name="date_created")
	private Timestamp dateCreated;

	@Column(name="orderstatus_id")
	private int orderstatusId;

	@Column(name="user_id")
	private int userId;

	//bi-directional many-to-one association to OrderHasProduct
	@OneToMany(mappedBy="order")
	private List<OrderHasProduct> orderHasProducts;

	public Order() {
	}

	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public double getAmount() {
		return this.amount;
	}

	public void setAmount(double amount) {
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

	public int getUserId() {
		return this.userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public List<OrderHasProduct> getOrderHasProducts() {
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
	}

}