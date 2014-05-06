<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Connect Facebook</title>
	</head>
	<body>
		<form action="<c:url value="/connect/facebook" />" method="POST">
		    <p>You haven't created any connections with Facebook yet. Click the button to create
		       a connection between your account and your Facebook profile.
		       (You'll be redirected to Facebook where you'll be asked to authorize the connection.)</p>
		    <p><button type="submit"><img src="<c:url value="/resources/social/twitter/signin.png" />"/>
		    </button></p>
		</form>
	</body>
</html>