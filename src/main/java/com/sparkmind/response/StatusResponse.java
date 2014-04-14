package com.sparkmind.response;

import java.util.ArrayList;
import java.util.List;

public class StatusResponse {
	private Boolean success;
	private List<String> message;
	
	public StatusResponse(){
		this.message= new ArrayList<String>();
	}
	public StatusResponse(Boolean success){
		this.success=success;
		this.message=new ArrayList<String>();
	}
	public StatusResponse(Boolean success, String message){
		this.success=success;
		this.message=new ArrayList<String>();
		this.message.add(message);				
	}	
	public Boolean getSuccess() {
		return success;
	}
	public void setSuccess(Boolean success) {
		this.success = success;
	}
	public List<String> getMessage() {
		return message;
	}
	public void setMessage(List<String> message) {
		this.message = message;
	} 
	@Override
	public String toString(){
		StringBuilder sb= new StringBuilder();
		for(String msg:message){
			sb.append(msg);
		}
		return "StatusReponse:[success="+success+", message="+sb.toString()+"]";
	}//end of toString method
	
}//end of class
