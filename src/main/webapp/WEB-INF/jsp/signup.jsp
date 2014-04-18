<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="shortcut icon" href="resources/image/favicon.ico" type="image/x-icon" /> 
		<title>SparkMind Login</title>
		<link href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" rel="stylesheet" />
		<link href= "resources/css/global.css" rel="stylesheet" type="text/css">
		<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
		<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
		<script type="text/javascript" src="resources/js/jquery.validate.min.js"></script>	
		<script type="text/javascript" src="resources/js/script.js"></script>
		<script type='text/javascript' src='<c:url value="/resources/js/util.js"/>'></script>
		<script type='text/javascript'>
			$(function(){
				$('#signupform').validate({
					rules:{
						firstName:{required:true, minlength:3},
						lastName:{required:true, minlength:3},
						email:{required:true,email:true},
						password:{required:true},						
					},
					message:{
						firstName:{required:'This field is required', minlength:'min length is 3'},
						lastName:{required:'This field is required', minlength:'min length is 3'},
						email:{required:'This field is required'},
						password:{required:'This field is required'}
					},
					success:function(label){
						label.html('ok').removeClass('error').addClass('ok');
						setTimeout(function(){
							label.fadeOut(500);
						},2000);
					}
				});
			});
		
		</script>
	</head>

	<body>
	<jsp:include page="Header.jsp" />
	<div id="content">
		     <form:form method="post" action="register" commandName="user" id="signupform" class="blocks">
			     <fieldset>
				     	<legend>Register User</legend>
		                <p><form:label path="firstName">First Name</form:label>
		                <form:input path="firstName" class="text1" /> </p>
		                <p><form:label path="lastName">Last Name</form:label>
		                <form:input path="lastName" class="text1" /></p>
		                <p><form:label path="email">email</form:label>
		                <form:input path="email" class="text1" /></p>
		                <p><form:label path="password">Password</form:label>
		                <form:input path="password" class="text1" type="password"/></p>
		                <p><form:hidden path="userConfirmation" class="text1" /></p>
		                <p align="center"><input type="submit" value="Register" class="btn"/></p>
	               </fieldset>
            </form:form>                     	
	</div>
	<div id="rightMessageContent" class="blocks">
	 	<p class="message">${message}</p>
	 </div>
	<jsp:include page="Footer.jsp" />
	
	</body>
</html>