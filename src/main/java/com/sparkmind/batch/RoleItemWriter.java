package com.sparkmind.batch;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.batch.item.ItemWriter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import com.sparkmind.model.Role;
import com.sparkmind.model.User;

public class RoleItemWriter implements ItemWriter<Role>{
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	public static final String SELECT_QUERY = "select id," +
												"firstName, " +
												"lastName, " +
												"password, " +
												"email " +
												"from user where email = ?";
 
	public static final String INSERT_QUERY = "insert into role(role, " +
											"user_id) " +
											"values(?,?);";

	@Override
	public void write(List<? extends Role> roles) throws Exception {
		for(Role role:roles){
			Object[] params = new Object[1];
			params[0] = role.getUser().getEmail();
			
			User user = jdbcTemplate.queryForObject(SELECT_QUERY, params, new RowMapper<User>() {
						@Override
						public User mapRow(ResultSet rs, int rowNum) throws SQLException {
								User user = new User();
								user.setId(rs.getLong("id"));
								user.setFirstName(rs.getString("firstName"));
								user.setLastName(rs.getString("lastName"));
								user.setEmail(rs.getString("email"));
								user.setPassword(rs.getString("password"));
								return user;
						}
				});
			jdbcTemplate.update(INSERT_QUERY, role.getRole(), user.getId());
		} //end of for loop
	}//end of write method
}
