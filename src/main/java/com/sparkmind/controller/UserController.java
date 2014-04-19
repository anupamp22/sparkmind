package com.sparkmind.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.persistence.NoResultException;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.codehaus.jackson.annotate.JsonIgnore;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sparkmind.model.Role;
import com.sparkmind.model.User;
import com.sparkmind.response.StatusResponse;
import com.sparkmind.service.ContactService;
import com.sparkmind.service.UserService;

@Controller
@RequestMapping
public class UserController {
	
	protected static Logger logger = Logger.getLogger("service");
	
	@Autowired
	private UserService accessService;
	
	@Autowired
	private ContactService emailService;
	
	@Value("${localhost.baseURL}")
	private String localbaseURL;
	
	@Value("${sparkmindonspring.herokuapp.baseURL}")
	private String herokuAppURL;
	
	@RequestMapping("/login")
	public String login(Model model, @RequestParam(required=false) String message){
		
		model.addAttribute("message", message);
		return "login";
	}
	
	@RequestMapping(value = "/denied")
	public String denied(){
		
		return "denied";
	}
	
	@RequestMapping(value = "/login/failure")
	public String loginFailure(){
		String message="Login Failure!";
		return "redirect:/login?message="+message;
	}
	
	@RequestMapping(value = "/logout/success")
	public String logoutSuccess(){
		String message="Logout Success";
		return "redirect:/login?message="+message;
	}
	
	@RequestMapping(value = "/user")
	public String getUserPage(){
		return "user";
	}
	
	@RequestMapping(value = "/admin")
	public String getAdminPage(Map<String, Object> map){
		map.put("userList", accessService.getAllUsers());
		map.put("user", new User());
		return "admin";
	}
	
    @RequestMapping(value = "/signup", method = RequestMethod.GET)
    public String getSignUp(Map<String, Object> map, @RequestParam(required=false) String message) {
    	map.put("user", new User());
    	map.put("message", message);
    	return "signup";
    }
	
    @RequestMapping(value = "/register", method = RequestMethod.POST)
    public String addUser(@ModelAttribute("User") User user, BindingResult result,HttpServletRequest req) {
    	
    	String guid = UUID.randomUUID().toString();
    	user.setGuid(guid);
			
    		Role role = new Role();
			role.setRole(2);
			role.setUser(user);
			
			user.setRole(role);
			String message=req.getRequestURL().toString()+"/userConfirmation?guid="+guid;
    	
		try{
    		User u = accessService.findByUsername(user.getEmail());
    		return "redirect:/signup/error";
    	}
    	catch(NoResultException e){
    		accessService.addUser(user);
    		emailService.sendPreConfiguredMailMessageUsingSpringJavaMail("anupam.p22@gmail.com",user.getFirstName(),message);
    		return "redirect:/signup/success";
    	}
    }
    
    @RequestMapping(value = "/registerByAjax", method = RequestMethod.POST)
    public @ResponseBody StatusResponse addUserByAjax(@RequestBody User user, /*@ModelAttribute("User") User user,*/ HttpServletRequest req) {
    	//System.out.println("Anupam is printing the ##$###############33333333333"+user.getFirstName());
    	String guid = UUID.randomUUID().toString();
    	user.setGuid(guid);
			
    		Role role = new Role();
			role.setRole(2);
			role.setUser(user);
			
			user.setRole(role);
			String message=req.getRequestURL().toString()+"/userConfirmation?guid="+guid;
    	
		try{
    		User u = accessService.findByUsername(user.getEmail());
    		return new StatusResponse(false, "User already exists");
    	}
    	catch(NoResultException e){
    		accessService.addUser(user);
    		emailService.sendPreConfiguredMailMessageUsingSpringJavaMail("anupam.p22@gmail.com",user.getFirstName(),message);
    		return new StatusResponse(true, "User created successfully");
    	}
    }
    
    @RequestMapping(value = "/signup/success", method = RequestMethod.GET)
    public String singupSuccess(){
    	String message="You are registered now! Soon, you will be getting a mail to confirm your credentials. Please do so.";
    	return "redirect:/signup?message="+message;
    }
    @RequestMapping(value = "/signup/error", method = RequestMethod.GET)
    public String singupError(){
    	String message="User already exists";
    	return "redirect:/signup?message="+message;
    }
    
    @RequestMapping(value = "/register/userConfirmation", method = RequestMethod.GET)
    public String userConfirmation(Map<String, Object> map, @RequestParam(required=true) String guid) {
    	map.put("user", new User());
    	map.put("guid", guid);
    	try{
    		User u = accessService.findByGuid(guid);
    		u.setUserConfirmation("Confirmed");
    		accessService.addUser(u);    	
    	}
    	catch(NoResultException ex){    		
    	}
    	
    	return "userConfirmation";
    }

    @RequestMapping(value = "/registerByAjax/userConfirmation", method = RequestMethod.GET)
    public String userConfirmationByAjax(Map<String, Object> map, @RequestParam(required=true) String guid) {
    	map.put("user", new User());
    	map.put("guid", guid);
    	try{
    		User u = accessService.findByGuid(guid);
    		u.setUserConfirmation("Confirmed");
    		accessService.addUser(u);
    	}
    	catch(NoResultException ex){
    	}
    	
    	return "userConfirmation";
    }
    
    //form submission - url refresh
    @RequestMapping("/deleteUser/{userId}")
    public String deleteUser(@PathVariable("userId") Long userId){
    	accessService.deleteUser(userId);
    	return "redirect:/admin";
    }
    
    @RequestMapping(value="/deleteUserByAjax/{userId}", method = RequestMethod.GET)
    public @ResponseBody StatusResponse deleteUserByAjaxByAjax(@PathVariable("userId") Long userId){
    	accessService.deleteUser(userId);
    	return new StatusResponse(true, "User deleted");
    }
    
    //ajax json get
    @RequestMapping(value="/editUser/{userId}", method = RequestMethod.GET)
    public @ResponseBody User editUser(@PathVariable("userId") Long userId, Model model){
        //model.addAttribute("user",accessService.getUserById(userId));
    	model.addAttribute("user", accessService.getUserById(userId));
    	return accessService.getUserById(userId);
    }
    
  //ajax json put
    @RequestMapping(value="/saveUser/{userId}", method = RequestMethod.POST)
    public @ResponseBody User saveUser(@RequestBody User user){
    	logger.debug("Anupam is printing in the saveUser method::"+user.getFirstName()+user.getId());
    	
    	//return new StatusResponse(true, "User record updated");
    	return accessService.updateUser(user);
    }

    @RequestMapping(value="/loadUsers")
    public @ResponseBody List<User> loadUser(){
    	return accessService.getAllUsers();
    }
    
    @RequestMapping(value="/loadUsersInAMap")
    public @ResponseBody Map<String, Object> loadUserThroughMap(){
    	Map<String, Object> map = new HashMap<String, Object>();
    	map.put("user", accessService.getAllUsers());
    	return map;
    }
}