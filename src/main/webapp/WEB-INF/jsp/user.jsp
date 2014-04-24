<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<c:url value="logout" var="logoutUrl"/>
<html>
	<head>
			<jsp:include page="HeadFilesInclude.jsp"></jsp:include>
			<title>SparkMind Login</title>
	</head>

	<body>
			<jsp:include page="Header.jsp" />
			<div id="content">
				<p>&nbsp;&nbsp;&nbsp;</p>
				<h2>Login success </h2>
				<span class="message">Welcome ${user.firstName} ${user.lastName}</span>
				<!-- <p> Welcome <%=SecurityContextHolder.getContext().getAuthentication().getName()%> !</p> -->
				<p><a href="${logoutUrl}">Logout</a></p>
			</div>
			<jsp:include page="Footer.jsp" />
			
	</body>
</html>