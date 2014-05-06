<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="datatables" uri="http://github.com/dandelion/datatables" %>

<html>

<head>
	<jsp:include page="common/HeadFilesInclude.jsp"></jsp:include>
	<title>My Orders</title>
	<script type="text/javascript">
		$(function(){
			$('.a_orderUrlClass').click(function(event){
					event.preventDefault();
					var url = $(this).attr('href');
					$.get(url, function(data){
						$('#orderProductTable').find('tbody').remove();
						//alert(JSON.stringify(data));
						$.each(data, function(i,v){
							var row = '<tr>';
							row +='<td>' + v.id+ '</td>';
							row +='<td>' + v.name + '</td>';
							row +='<td>' + v.price + '</td>';
							row +='<td>' + v.productcode + '</td>';
							row+='</tr>';
							$('#orderProductTable').append(row);
						});
						showPopup();
					});
			});
		}); //end of DOM load
		function showPopup() {
			$('body').css('overflow', 'hidden');
			$('#popup').fadeIn('fast');
			$('#mask').fadeIn('fast');
		}
		function closePopup() {
			$('#popup').fadeOut('fast');
			$('#mask').fadeOut('fast');
			$('body').css('overflow', 'auto');
		}
	</script>
</head>
<body>
	<jsp:include page="common/Header.jsp" />
	<div id="content">
		<h2>My Orders</h2>
		<datatables:table id="order" data="${orderList}" cdn="true" row="order" theme="bootstrap2" cssClass="table table-striped" export="pdf">
		    <datatables:column title="Order Confirmation#">
		    	 <spring:url value="myOrders/{orderId}" var="orderUrl">
            			<spring:param name="orderId" value="${order.id}"/>
        		</spring:url>
        		<a href="${orderUrl}" class="a_orderUrlClass"><c:out value="${order.confirmationNumber}" /></a>
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
	
	<div id="mask" style="display: none;"></div>
	<div id="popup" style="display: none;">
		<div class="content">
				<table class="table table-bordered table-striped" id="orderProductTable">
							<thead>
								<tr>
									<th> Id </th>
									<th> Product Name</th>
									<th> Price</th>
									<th> Product Code</th>
								<tr>
							</thead>
							<tbody>
							</tbody>
				</table>
				<p><a href="#" onclick="closePopup();">Close</a></p>
		</div>
	</div>	
	<jsp:include page="common/Footer.jsp" />
</body>
</html>