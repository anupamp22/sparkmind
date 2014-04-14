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
	</head>

	<body>
	<jsp:include page="Header.jsp" />
	<div id="content">
		<form class="login-form" action="j_spring_security_check" method="post">
			<fieldset>
				<legend><b>Login Here</b></legend>
				<p>
					<label for="j_username"><b>Email:</b></label>
					<input id="j_username" name="j_username" size="20" maxlength="50" type="text" class="text1"/>
				</p>				
				<p>
					<label for="j_password"><b>Password:</b></label>
					<input id="j_password" name="j_password" size="20" maxlength="50" type="password" class="text1"/>				
				</p>
				<p>
					<input type="submit" value="submit"/>
				</p>			
			</fieldset>		
		</form>
		<p class="message">${message}</p>
	</div>
	<jsp:include page="Footer.jsp" />
	
	</body>
</html>