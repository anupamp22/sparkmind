package com.sparkmind.repository;

import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import com.sparkmind.model.Story;

@Repository
public interface StoryRepository extends MongoRepository<Story,String>{
	
	Story findByEmail(String email);

}
