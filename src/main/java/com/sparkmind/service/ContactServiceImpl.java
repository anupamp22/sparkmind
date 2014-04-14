package com.sparkmind.service;

import org.apache.log4j.Logger;
import com.sparkmind.model.Contact;
import com.sparkmind.response.StatusResponse;
import com.sparkmind.util.SendGridParameter;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

@Service
public class ContactServiceImpl implements ContactService {

	protected static Logger logger = Logger.getLogger("service");
	private RestTemplate restTemplate = new RestTemplate();
	
	@Value("${sendgrid.api.user}")
	private String sendgridApiUser;
	
	@Value("${sendgrid.api.key}")
	private String sendgridApiKey;
	
	@Autowired
	private MailSender mailSender;
	
	@Autowired
	private SimpleMailMessage preConfiguredMessage;
	
	@Override
	public StatusResponse send(Contact message) {
		try {
			logger.info("Entering into the SendGridEmailService::send method");
			MultiValueMap<String, Object> vars = new LinkedMultiValueMap<String, Object>();
			vars.add(SendGridParameter.API_USER, sendgridApiUser);
			vars.add(SendGridParameter.API_KEY, sendgridApiKey);
			vars.add(SendGridParameter.SENDER_NAME, message.getSenderName());
			vars.add(SendGridParameter.SENDER_EMAIL, message.getSenderEmail());
			vars.add(SendGridParameter.SUBJECT, "Hello");
			vars.add(SendGridParameter.TEXT, "");
			vars.add(SendGridParameter.HTML, message.getTextBody());
			vars.add(SendGridParameter.RECEIVER_EMAIL, "anupam.p22@gmail.com");
			vars.add(SendGridParameter.RECEIVER_NAME, "Anupam");
			
			logger.info("Exiting from SendGridEmailService::send method"+vars);
			restTemplate.postForLocation(SendGridParameter.URL, vars);
			
		} catch (Exception ex) {
			logger.error(ex);
			return new StatusResponse(false, "An error has occurred!");
		}

		return new StatusResponse(true, "Message sent");
	}
	
	@Override
	public StatusResponse sendMailUsingSpringJavaMail(String to, String subject, String body){
		try{
			SimpleMailMessage message = new SimpleMailMessage();
			message.setTo(to);
			message.setSubject(subject);
			message.setText(body);
			mailSender.send(message);			
		}
		catch(Exception ex){
			logger.error(ex);
			return new StatusResponse(false, "An error has occurred!");
		}		
		return new StatusResponse(true, "Message sent");
	}
	
	@Override
	public StatusResponse sendPreConfiguredMailMessageUsingSpringJavaMail(String to, String dear, String content){
		try{
			SimpleMailMessage preConfigMessage = new SimpleMailMessage(preConfiguredMessage);
			preConfigMessage.setTo(to);
			preConfigMessage.setText(String.format(preConfiguredMessage.getText(), dear, content));
			mailSender.send(preConfigMessage);
		}
		catch(Exception ex){
			logger.error(ex);
			return new StatusResponse(false, "An error has occurred!");
		}	
		return new StatusResponse(true, "Message sent");
	}

	
}
