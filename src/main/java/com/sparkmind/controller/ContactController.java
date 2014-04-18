package com.sparkmind.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sparkmind.model.Contact;
import com.sparkmind.model.User;
import com.sparkmind.response.StatusResponse;
import com.sparkmind.service.ContactService;

@Controller
public class ContactController {
	
	@Autowired
	private ContactService emailService;
	
	@RequestMapping(value="/email",method=RequestMethod.GET)
	public String emailForm(Map<String, Object> map, @RequestParam(required=false) String mesg){
    	map.put("message", new Contact());
    	map.put("mesg", mesg);
		return "contact";
	}
	
	@RequestMapping(value="/email/success",method=RequestMethod.GET)
	public String emailSuccess(){
		String mesg ="email sent!";
		return "redirect:/email?mesg="+mesg;
	}

	@RequestMapping(value="/email/failure",method=RequestMethod.GET)
	public String emailFailure(){
		String mesg ="email failure!";
		return "redirect:/email?mesg="+mesg;
	}
	//sending it through normal form post and spring form data binding
	@RequestMapping(value="/email", method=RequestMethod.POST)
	public String send(@ModelAttribute("message") Contact  message, BindingResult result){
		System.out.println("Anupam is printing the values:"+message.getSenderPhone()+message.getSenderName()+message.getTextBody());
		StatusResponse rs = emailService.sendMailUsingSpringJavaMail("anupam.p22@gmail.com", "Test message", message.getTextBody());
		if (!rs.getSuccess()){
			return "redirect:email/failure";
		}
		return "redirect:email/success";
	}
	
	//sending it through ajax jquery and json -elegant and preferable method
	@RequestMapping(value="/email/send", method=RequestMethod.POST)
	public @ResponseBody StatusResponse sendByJson(@RequestBody Contact message){
		String to = "anupam.p22@gmail.com";
		String subject = "Subject: Message from "+message.getSenderName();
		String messageTobeSent = "This is the message from "+message.getSenderName()+" Phone: "+message.getSenderPhone()+" Email: "+message.getSenderEmail()+"\n"+" Message: "+message.getTextBody();
		
		StatusResponse rs = emailService.sendMailUsingSpringJavaMail(to, subject, messageTobeSent);
		return rs;
	}
}
