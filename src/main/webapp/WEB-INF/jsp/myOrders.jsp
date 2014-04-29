<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="datatables" uri="http://github.com/dandelion/datatables" %>

<html>

<head>
	<jsp:include page="HeadFilesInclude.jsp"></jsp:include>
	<title>My Orders</title>
</head>

<body>
	<jsp:include page="Header.jsp" />
	<p>&nbsp;&nbsp;&nbsp;</p>
	<div id="content">
		<h2>My Orders</h2>
		<datatables:table id="order" data="${orderList}" cdn="true" row="order" theme="bootstrap2" cssClass="table table-striped" export="pdf">
		    <datatables:column title="Order Confirmation#">
		        <c:out value="${order.confirmationNumber}"></c:out>
		    </datatables:column>
		    <datatables:column title="Order Amount">
		        <c:out value="${order.amount}"></c:out>
		    </datatables:column>
		    <datatables:column title="Date Created">
		        <c:out value="${order.dateCreated}"></c:out>
		    </datatables:column>
		     <datatables:export type="pdf" cssClass="btn btn-small" />
		</datatables:table>
	</div>
	<jsp:include page="Footer.jsp" />
</body>
</html>