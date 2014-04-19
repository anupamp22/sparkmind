package com.sparkmind.model;

import java.io.Serializable;
import javax.persistence.*;

/**
 * The primary key class for the order_has_product database table.
 * 
 */
@Embeddable
public class OrderHasProductPK implements Serializable {
	//default serial version id, required for serializable classes.
	private static final long serialVersionUID = 1L;

	@Column(name="order_id")
	private int orderId;

	@Column(name="product_id")
	private int productId;

	public OrderHasProductPK() {
	}
	public int getOrderId() {
		return this.orderId;
	}
	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}
	public int getProductId() {
		return this.productId;
	}
	public void setProductId(int productId) {
		this.productId = productId;
	}

	public boolean equals(Object other) {
		if (this == other) {
			return true;
		}
		if (!(other instanceof OrderHasProductPK)) {
			return false;
		}
		OrderHasProductPK castOther = (OrderHasProductPK)other;
		return 
			(this.orderId == castOther.orderId)
			&& (this.productId == castOther.productId);
	}

	public int hashCode() {
		final int prime = 31;
		int hash = 17;
		hash = hash * prime + this.orderId;
		hash = hash * prime + this.productId;
		
		return hash;
	}
}