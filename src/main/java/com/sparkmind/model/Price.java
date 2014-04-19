package com.sparkmind.model;

import java.io.Serializable;
import javax.persistence.*;
import java.math.BigDecimal;


/**
 * The persistent class for the price database table.
 * 
 */
@Entity
public class Price implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	private int id;

	private BigDecimal discountedprice;

	private BigDecimal listprice;

	private BigDecimal marketprice;

	private BigDecimal percentagemaxdiscount;

	private BigDecimal percentagemindiscount;

	@Column(name="product_id")
	private int productId;

	public Price() {
	}

	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public BigDecimal getDiscountedprice() {
		return this.discountedprice;
	}

	public void setDiscountedprice(BigDecimal discountedprice) {
		this.discountedprice = discountedprice;
	}

	public BigDecimal getListprice() {
		return this.listprice;
	}

	public void setListprice(BigDecimal listprice) {
		this.listprice = listprice;
	}

	public BigDecimal getMarketprice() {
		return this.marketprice;
	}

	public void setMarketprice(BigDecimal marketprice) {
		this.marketprice = marketprice;
	}

	public BigDecimal getPercentagemaxdiscount() {
		return this.percentagemaxdiscount;
	}

	public void setPercentagemaxdiscount(BigDecimal percentagemaxdiscount) {
		this.percentagemaxdiscount = percentagemaxdiscount;
	}

	public BigDecimal getPercentagemindiscount() {
		return this.percentagemindiscount;
	}

	public void setPercentagemindiscount(BigDecimal percentagemindiscount) {
		this.percentagemindiscount = percentagemindiscount;
	}

	public int getProductId() {
		return this.productId;
	}

	public void setProductId(int productId) {
		this.productId = productId;
	}

}