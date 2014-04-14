package com.sparkmind.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.sparkmind.model.User;

public interface UserRepository extends JpaRepository<User, Long> {
	User findByEmail(String email);
}
