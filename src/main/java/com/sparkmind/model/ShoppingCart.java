package com.sparkmind.model;

import java.io.Serializable;
import java.util.Collection;
import java.util.Collections;
import java.util.List;

public class ShoppingCart implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private List<String> selection = Collections.emptyList();

	public List<String> getSelection() {
		return selection;
	}

	public void setSelection(List<String> selection) {
		this.selection = selection;
	}
	
	@Override
	public String toString() {
		StringBuilder sb = new StringBuilder("Selections are: ");
		for (String str : selection) {
			sb.append(str);
			sb.append(",  ");
		}
		return sb.toString();
	}

}
