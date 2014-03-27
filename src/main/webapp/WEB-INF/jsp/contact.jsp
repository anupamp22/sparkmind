<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:url value="/email/send" var="sendUrl"/>

<html>
<head>
	
	<link href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" rel="stylesheet" />
	<link href= "resources/css/global.css" rel="stylesheet" type="text/css">
	<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
	<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
	<script type="text/javascript" src="resources/js/jquery.validate.min.js"></script>	
	<script type='text/javascript' src='<c:url value="/resources/js/util.js"/>'></script>

	<title>SparkMind Contact Us</title>

	<script type='text/javascript'>
	$(function() {
		init();
	});//end of jQuery DOM loading
	
	function init() {
		$('input:button').button();
		$('#submit').button();
		
		$('#emailForm').validate({
			rules:{
				senderName:{required:true, minlength:3},
				senderEmail:{required:true,email:true},
				senderCompany:{required:true},
				senderPhone:{required:true,number:true,minlength:6}
			},
			message:{
				senderName:{required:'This field is required', minlength:'min length is 3'},
				senderEmail:{reuired:'This field is required'},
				senderCompany:{required:'This field is required'},
				senderPhone:{required:'This field is required',number:'Invalid phone no', minlength:'Min length for phone no is 6'},
				textBody:{required:'This field is required'}
			},
			success:function(label){
				label.html('ok').removeClass('error').addClass('ok');
				setTimeout(function(){
					label.fadeOut(500);
				},2000);
			}
			 
		}); //end of emailForm validate function			
	
		$('#emailForm').submit(function(event) {
				event.preventDefault();
				var $form = $(this);
				if(! $form.valid()) return false;
				$.postJSON('${sendUrl}', {
					senderName: $('#senderName').val(),
					senderEmail: $('#senderEmail').val(),
					senderCompany: $('#senderCompany').val(),
					senderPhone: $('#senderPhone').val(),
					senderMessage: $('#textBody').val(),
				},
				function(result) {
				  if (result.success == true) {
						dialog('Success', 'Email has been sent!');
					} else {
						dialog('Failure', 'Email has not been sent!');
					} 
				});
		});
		
		$('#reset').click(function() {
			clearForm();
			dialog('Success', 'Fields have been cleared!');
		});				
	}
	
	function dialog(title, text) {
		$('#msgbox').text(text);
		$('#msgbox').dialog( 
				{	title: title,
					modal: true,
					buttons: {"Ok": function()  {
						$(this).dialog("close");} 
					}
				});
	}
	
	function clearForm() {
		$('#senderName').val('');
		$('#senderEmail').val('');
		$('#senderCompany').val('');
		$('#senderPhone').val('');
		$('#subject').val('');
		$('#textBody').val('');
	}
	</script>
</head>

<body>
	<div id="masthead">
		<a href="<c:url value="/"/>" id="homelink"><img src="${pageContext.request.contextPath}/resources/image/sparkmind.gif" alt="my company image"/></a>
		<p id="today">March 6, 2014</p>
		<!-- <p id="today">Sign In</p>
		<p id="today">Sign UP</p> -->
		<ul class="navlinks">
			<li class="first"><a href="<c:url value="/"/>" id="a_home">Home</a></li>
			<li><a href="#">About us</a>
				<ul class="sub_menu">
					<li><a href="#" id="a_company">Company</a></li> 
					<li><a href="#" id="a_vision">Vision</a></li>
					<li><a href="#"id="a_mission">Mission</a></li>
				</ul>
			</li>
			<li><a href="#">Products and Services</a>
				<ul>
					<li><a href="#">Programming</a>
					<ul>
						<li><a href="#" id="a_spring">Spring and Hibernate</a></li>
						<li><a href="#" id="a_j2ee">J2EE stack</a></li>
						<li><a href="#" id="a_java">Java stack</a></li>							
					</ul>
					</li> 
					<li><a href="#">Data Mining</a>
					<ul>
						<li><a href="#" id="a_python">Python</a></li>
						<li><a href="#" id="a_R">R</a></li>
						<li><a href="#" id="a_matlab">Matlab</a></li>
					</ul>
					</li>
					<li><a href="#">System Integration</a>
					<ul>
						<li><a href="#" id="a_SOAP">SOAP webservice</a></li>
						<li><a href="#" id="a_REST">REST webservice</a></li>
					</ul>
					</li>
				</ul>
			</li>
			<li>Management Team</li>
			<li><a href="http://apriyada.blogspot.com/" id="a_blogs" target="_blank">Our blogs</a></li>
			<li><a href="${pageContext.request.contextPath}/email" id="a_contact">Contact us</a></li>
			<li><a href="#" id="a_UserLogin">User Login</a>
					<ul>
						<li><a href="#" id="a_SignUp">New User-Sign Up</a></li>
						<li><a href="#" id="a_SignIn">Existing User-Sign In</a></li>
					</ul>			
			</li>
			<li class="last"><a href="#" id="a_UserLogin">Follow Us On Social</a>
					<ul>
						<li><a href="#" id="a_Facebook">Facebook</a></li>
						<li><a href="#" id="a_Twitter">Twitter</a></li>
						<li><a href="#" id="a_LinkedIn">LinkedIn</a></li>
					</ul>			
			</li>				
		</ul>		
	</div>
	
	<h1 id='banner'>Compose Email</h1>
	
	<div id=content>
		<form id='emailForm' class="blocks">
  			<fieldset>
				<legend>New Email</legend>
				<p>
					<label for='senderName'>Name*:</label>
					<input type='text' id='senderName' name='senderName' class="text1"/>
				</p>
				<p>
					<label for='senderEmail'>Email*:</label>
					<input type='text' id='senderEmail' name='senderEmail' class="text1"/>
				</p>
				<p>
					<label for='senderCompany'>Company:</label>
					<input type='text' id='senderCompany' name='senderCompany' class="text1"/>
				</p>
				<p>
					<label for='senderPhone'>Phone:</label>
					<input type='text' id='senderPhone' name='senderPhone' class="text1" />
				</p>
				<p>
					<label for='senderMessage'>Message:</label>
					<textarea name="textBody" id="textBody" name="textBody" class="textarea">Email message here</textarea>
				</p>
				<p align="center">
					<input type='button' value='Reset' id='reset' />
					<input type='submit' value='Send' id='submit'/>
				</p>
  			</fieldset>
		</form>
	</div>	
	<div id='msgbox' title='' style='display:none'></div>
	<div id="footer">
			<i>All Rights Reserved--</i> SparkMind Inc. @ 2014		
	</div>
</body>
</html>