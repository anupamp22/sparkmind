<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>

<c:url value="admin" var="adminUrl"/>
<c:url value="logout" var="logoutUrl"/>
<c:url value="configurator" var="configuratorUrl"/>
<c:url value="myOrders" var="myordersUrl"/>
<c:url value="user" var="myProfileUrl"/>
<c:url value="myangular" var="myangularUrl"/>

<div id="masthead">
		<a href="<c:url value="/"/>" id="homelink"><img src="${pageContext.request.contextPath}/resources/image/sparkmind.gif" alt="my company image"/></a>
		<p id="today">today</p>
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
			<li><a href="#" id="a_ManagementTeam">Management Team</a></li>
			<li><a href="http://apriyada.blogspot.com/" id="a_blogs" target="myIframe">Our blogs</a></li>
			<li><a href="${pageContext.request.contextPath}/email" id="a_contact">Contact us</a></li>
			<li><a href="#" id="a_UserLogin">User Login</a>
					<ul>
						<sec:authorize var="loggedIn" access="isAuthenticated()">
							<c:choose>
								<c:when test="${loggedIn}">
									<li><a href="${myProfileUrl}">My Profile</a></li>
									<li><a href="${myordersUrl}">My Orders</a></li>
									<li><a href="${configuratorUrl}">Product Configurator</a></li>
									<li><a href="${myangularUrl}">Angular way</a></li>
									<sec:authorize access="hasRole('ROLE_ADMIN')">
										<li><a href="${adminUrl}">Admin</a></li>
									</sec:authorize>
									<li><a href="${logoutUrl}">Logout</a></li>
								</c:when>
								<c:otherwise>
								</c:otherwise>
							</c:choose>
						</sec:authorize>
						<c:if test="<%=SecurityContextHolder.getContext().getAuthentication() == null %>">
 										<li><a href="${pageContext.request.contextPath}/login" id="a_SignIn">Sign In</a></li>
								<li><a href="${pageContext.request.contextPath}/signup" id="a_SignUp">Sign Up</a></li>
						</c:if>
						<sec:authorize access="isAnonymous()">
								<li><a href="${pageContext.request.contextPath}/login" id="a_SignIn">Sign In</a></li>
								<li><a href="${pageContext.request.contextPath}/signup" id="a_SignUp">Sign Up</a></li>
						</sec:authorize>
					</ul>			
			</li>
			<li class="last"><a href="#" id="a_UserLogin">Follow Us On Social</a>
					<ul>
						<li><a href="${pageContext.request.contextPath}/facebook" id="a_Facebook">Facebook</a></li>
						<li><a href="#" id="a_Twitter">Twitter</a></li>
						<li><a href="#" id="a_LinkedIn">LinkedIn</a></li>
					</ul>			
			</li>				
		</ul>		
	</div>
<!-- <span id="menu-username"><%=SecurityContextHolder.getContext().getAuthentication().getName()%></span> -->
