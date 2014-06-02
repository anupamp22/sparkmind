package com.sparkmind.batch;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.batch.item.file.mapping.FieldSetMapper;
import org.springframework.batch.item.file.transform.FieldSet;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.validation.BindException;

import com.sparkmind.model.Role;
import com.sparkmind.model.User;

public class RoleFieldSetMapper implements FieldSetMapper<Role>{
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	public static final String SELECT_QUERY = "select id, " +
												"firstName, " +
												"lastName, " +
												"password, " +
												"email " +
												"from user where email = ?";

	@Override
	public Role mapFieldSet(FieldSet fs) throws BindException {
			if(fs == null){
				return null;
			}
			
			Role role = new Role();
			
			Object[] params = new Object[1];
			params[0] = fs.readString("email");
			
			role.setUser(jdbcTemplate.queryForObject(SELECT_QUERY, params, new RowMapper<User>() {
				@Override
				public User mapRow(ResultSet rs, int rowNum) throws SQLException {
					User user  = new User();
					user.setId(rs.getLong("id"));
					user.setFirstName(rs.getString("firstName"));
					user.setLastName(rs.getString("lastName"));
					user.setEmail(rs.getString("email"));
					user.setPassword(rs.getString("password"));
					return user;
				}
			}));
			role.setRole(fs.readInt("role"));
			return role;
	}

}
