package com.sparkmind.model;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the order_has_product database table.
 * 
 */
@Entity
@Table(name="order_has_product")
public class OrderHasProduct implements Serializable {
	private static final long serialVersionUID = 1L;

	@EmbeddedId
	private OrderHasProductPK id;

	//bi-directional many-to-one association to Order
	@ManyToOne
	@JoinColumn(name="order_id",referencedColumnName="id", insertable=false, updatable=false)
	private Order order;

	public OrderHasProduct() {
	}

	public OrderHasProductPK getId() {
		return this.id;
	}

	public void setId(OrderHasProductPK id) {
		this.id = id;
	}

	public Order getOrder() {
		return this.order;
	}

	public void setOrder(Order order) {
		this.order = order;
	}

}