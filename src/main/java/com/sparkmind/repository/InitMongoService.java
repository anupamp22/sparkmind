package com.sparkmind.repository;

import java.util.Date;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;

import com.sparkmind.model.Story;



public class InitMongoService {
	
	@Autowired
	private MongoTemplate mongoTemplate;
	
	public void init(){
		mongoTemplate.dropCollection("story");
		
		Story story = new Story();
		story.setId(UUID.randomUUID().toString());
		story.setEmail("anupam.p22@gmail.com");
		story.setTimestamp(new Date());
		story.setDescription("this is first story");
		
		mongoTemplate.insert(story, "story");
	} //end of init
	
}//end of class
