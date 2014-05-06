<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<html>
	<head>
		<jsp:include page="common/HeadFilesInclude.jsp"></jsp:include>
		<title>SparkMind Login</title>
	</head>

	<body>
	<jsp:include page="common/Header.jsp" />
	<div id="content">
		<p>&nbsp;&nbsp;&nbsp;</p>
		<h2>Sign In</h2>
		<form class="login-form" action="j_spring_security_check" method="post">
			<fieldset>
				<!-- <legend><b>Login Here</b></legend> -->
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
	<jsp:include page="common/Footer.jsp" />
	
	</body>
</html>