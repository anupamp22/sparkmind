package com.sparkmind.batch;

import org.springframework.batch.item.file.mapping.FieldSetMapper;
import org.springframework.batch.item.file.transform.FieldSet;
import org.springframework.validation.BindException;

import com.sparkmind.model.User;

public class UserFieldSetMapper implements FieldSetMapper<User>{

	@Override
	public User mapFieldSet(FieldSet fs) throws BindException {
		if (fs==null){
			return null;
		}
		User user = new User();
		user.setFirstName(fs.readString("firstName"));
		user.setLastName(fs.readString("lastName"));
		user.setEmail(fs.readString("email"));
		user.setPassword(fs.readString("password"));
		return user;
	}

}
