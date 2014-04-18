package com.sparkmind.model;

import java.io.Serializable;

public class Contact implements Serializable {
	private String senderName;
	private String senderCompany;
	private String senderEmail;
	private String senderPhone;
	private String textBody;
	
	public Contact(){
		super();
	}
	
	public Contact(String senderName, String senderCompany, 
					String senderEmail, String senderPhone, 
					String textBody){
		super();
		this.senderName=senderName;
		this.senderCompany=senderCompany;
		this.senderEmail=senderEmail;
		this.senderPhone=senderPhone;
		this.textBody=textBody;
	}
	
	
	public String getSenderName() {
		return senderName;
	}
	public void setSenderName(String senderName) {
		this.senderName = senderName;
	}
	public String getSenderCompany() {
		return senderCompany;
	}
	public void setSenderCompany(String senderCompany) {
		this.senderCompany = senderCompany;
	}
	public String getSenderEmail() {
		return senderEmail;
	}
	public void setSenderEmail(String senderEmail) {
		this.senderEmail = senderEmail;
	}
	public String getSenderPhone() {
		return senderPhone;
	}
	public void setSenderPhone(String senderPhone) {
		this.senderPhone = senderPhone;
	}
	public String getTextBody() {
		return textBody;
	}
	public void setTextBody(String textBody) {
		this.textBody = textBody;
	}	
}
