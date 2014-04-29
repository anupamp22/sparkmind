<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<%@ taglib prefix="datatables" uri="http://github.com/dandelion/datatables" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Facebook Connection successful</title>
	<jsp:include page="../HeadFilesInclude.jsp"></jsp:include>
</head>


<body>
	<jsp:include page="../Header.jsp"></jsp:include>
	<!-- <p> Welcome to your facebook page <i><%=SecurityContextHolder.getContext().getAuthentication().getName()%> ! </i></p> -->
	<!-- <p> Welcome ${pageContext.request.userPrincipal.name} !</p>  -->
	<!--<p> Welcome ${user.id} ${user.firstName} ${user.lastName} ${user.email}!</p>-->
	<!-- <p>${profileInfo}</p>  -->
	
	<div id="content">
		<div class="pic">
				<img src="http://graph.facebook.com/${profileInfo.id}/picture" alt="profile image"/>
				<span>${profileInfo.name}</span><br>
				<!-- <span>${profileLink}</span><br> -->
				<!-- <span class="message">${profileInfo.id}</span> -->
				<!--<c:forEach items="${friendList}" var="friend">
					<c:out value="${friend.name}"/><br>
				</c:forEach>-->
				
				<datatables:table id="friend" data="${friendList}" cdn="true" row="friend" theme="bootstrap2" cssClass="table table-striped" export="pdf">
				    <datatables:column title="Id">
				        <c:out value="${friend.id}"></c:out>
				    </datatables:column>
				    <datatables:column title="Name">
				        <c:out value="${friend.name}"></c:out>
				    </datatables:column>
				     <datatables:export type="pdf" cssClass="btn btn-small" />
		</datatables:table>
		</div>
	</div>
	<jsp:include page="../Footer.jsp"></jsp:include>
</body>
</html>