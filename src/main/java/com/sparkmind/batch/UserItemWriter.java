package com.sparkmind.batch;

import java.util.List;

import org.springframework.batch.item.ItemWriter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;

import com.sparkmind.model.User;

public class UserItemWriter implements ItemWriter<User> {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	public static final String INSERT_QUERY = "insert into user(firstName, " +
												"lastName, " +
												"password, " +
												"email) " +
												"values(?,?,?,?);";
	@Override
	public void write(List<? extends User> users) throws Exception {
		for(User u:users){
			jdbcTemplate.update(INSERT_QUERY,u.getFirstName(),u.getLastName(),u.getPassword(),u.getEmail());
		}
	}
}
