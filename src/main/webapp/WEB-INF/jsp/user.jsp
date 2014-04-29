<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<c:url value="logout" var="logoutUrl"/>
<c:url value="/myOrdersByAjax" var="myOrdersUrl"/>
<c:url value="/configurator" var="configurator"/>

<html>
	<head>
			<jsp:include page="HeadFilesInclude.jsp"></jsp:include>
			<title>SparkMind Login</title>
			<script type="text/javascript">
			$(function(){
					$('#tableOrders').find('thead').hide();
					$('#a_myorders').click(function (event) { 
					   event.preventDefault(); 
					   var url = $(this).attr('href');
					   $.get(url, function(data) {
					     	//alert(JSON.stringify(data));
					     	$('#tableOrders').find('thead').show();
					     	$('#tableOrders').find('tbody').remove();
					     	$.each(data, function(i,v){
					     		//$('#MyOrderdetails').innerHtml(data[i]);
					     		//console.log("INDEX: " + i + " VALUE: " + v.confirmationNumber);
					     		//$('#MyOrderdetails').append(data[i].confirmationNumber);
					     		var row = '<tr>';
								row+='<td>' + v.confirmationNumber + '</td>';
								row+='<td>' + v.amount + '</td>';
								row+='<td>' + v.dateCreated + '</td>';
								row+='<td>' + v.orderstatusId + '</td>';
								row+='</tr>';
								$('#tableOrders').append(row);
					     	});
					    });
					});
			});
			</script>
	</head>

		<body>
			<jsp:include page="Header.jsp" />
			<div id="content">
					<p>&nbsp;&nbsp;&nbsp;</p>
					<h2>Login success </h2>
					<!-- <span class="message">Welcome ${user.firstName} ${user.lastName}</span> -->
					<!-- <p> Welcome <%=SecurityContextHolder.getContext().getAuthentication().getName()%> !</p> -->
					<p><b>Welcome <i>${user.firstName} ${user.lastName} !</i></b></p>
					<p><a href="${myOrdersUrl}" id="a_myorders">My Orders</a></p>
					<p><a href="${configurator}">Product Configurator</a></p>
					<p><a href="${logoutUrl}">Logout</a></p>
					
				<table class="table table-bordered table-striped" id="tableOrders">
			    	 <thead>
			    	 	<tr>
			    	 		<td>Order No </td>
			    	 		<td>Order Amount</td>
			    	 		<td>Created Date</td>
			    	 		<td>Order Status </td>
			    	 	</tr>
			    	 </thead>
			     	 <tbody></tbody>
			     </table>
					
			</div>
			<div id ="MyOrderdetails">

			</div>
			<!-- <div data-role="collapsible">
			   <h3>I'm a header</h3>
			   <p>I'm the collapsible content. By default I'm closed, but you can click the header to open me.</p>
			</div> -->
			<jsp:include page="Footer.jsp" />
			
	</body>
</html>