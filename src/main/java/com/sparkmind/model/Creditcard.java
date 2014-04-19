package com.sparkmind.model;

import java.io.Serializable;
import javax.persistence.*;
import java.util.Date;


/**
 * The persistent class for the creditcard database table.
 * 
 */
@Entity
public class Creditcard implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	private String creditcardid;

	private String cardnumber;

	private String cardtype;

	private int customerid;

	@Temporal(TemporalType.TIMESTAMP)
	private Date expdate;

	private String securitycode;

	public Creditcard() {
	}

	public String getCreditcardid() {
		return this.creditcardid;
	}

	public void setCreditcardid(String creditcardid) {
		this.creditcardid = creditcardid;
	}

	public String getCardnumber() {
		return this.cardnumber;
	}

	public void setCardnumber(String cardnumber) {
		this.cardnumber = cardnumber;
	}

	public String getCardtype() {
		return this.cardtype;
	}

	public void setCardtype(String cardtype) {
		this.cardtype = cardtype;
	}

	public int getCustomerid() {
		return this.customerid;
	}

	public void setCustomerid(int customerid) {
		this.customerid = customerid;
	}

	public Date getExpdate() {
		return this.expdate;
	}

	public void setExpdate(Date expdate) {
		this.expdate = expdate;
	}

	public String getSecuritycode() {
		return this.securitycode;
	}

	public void setSecuritycode(String securitycode) {
		this.securitycode = securitycode;
	}

}