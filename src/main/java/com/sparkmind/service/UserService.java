package com.sparkmind.service;

import java.util.List;

import com.sparkmind.model.User;

public interface UserService {
	User findByUsername(String username);
	List<User> getAllUsers();
	User getUserById(Long id);
	void addUser(User user);
	User findByGuid(String guid);
	void deleteUser(Long userId);
	User updateUser(User user);
}
