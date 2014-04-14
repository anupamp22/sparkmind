<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<c:url value="logout" var="logoutUrl"/>
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
				<p> Welcome <%=SecurityContextHolder.getContext().getAuthentication().getName()%> !</p>
				<p><a href="${logoutUrl}">Logout</a></p>
			</div>
			<jsp:include page="Footer.jsp" />
			
	</body>
</html>