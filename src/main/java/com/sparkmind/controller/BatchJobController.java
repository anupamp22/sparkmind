package com.sparkmind.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.springframework.batch.core.Job;
import org.springframework.batch.core.JobParameter;
import org.springframework.batch.core.JobParameters;
import org.springframework.batch.core.launch.JobLauncher;
import org.springframework.batch.core.repository.JobInstanceAlreadyCompleteException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sparkmind.response.StatusResponse;

@Controller
@RequestMapping("/batch")
public class BatchJobController {
	
	@Autowired
	private JobLauncher jobLauncher;
	
	@Autowired @Qualifier("batchJob1")
	private Job job1;
	
	@RequestMapping(value="/job1")
	public @ResponseBody StatusResponse executeJob1(){
		try{
			Map<String, JobParameter> parameters = new HashMap<String, JobParameter>();
			parameters.put("date", new JobParameter(new Date()));
			
			jobLauncher.run(job1, new JobParameters(parameters));
			return new StatusResponse(true, "Job executed successfully");
		}
		catch(JobInstanceAlreadyCompleteException ex){
			return new StatusResponse(false, "This job has already completed successfully");
		}
		catch(Exception ex){
			throw new RuntimeException(ex);
		}
	}
}
