<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<html>
	<head>
		<jsp:include page="HeadFilesInclude.jsp"></jsp:include>
		<title>Product Configurator</title>
		<script type="text/javascript">
			$(function(){
				$('#RoatatingWheel').hide();
				$('#selectedCategory').change(function(){
					$('#RoatatingWheel').fadeIn();
					$.getJSON('${pageContext.request.contextPath}/getProducts',{
						categoryId:$(this).val(),
					}, function(data){
						//alert(JSON.stringify(data));
						$('#tableProducts').find('tbody').remove();
						$.each(data, function(){
							var row = '<tr>';
							row+='<td>' + this.name + '</td>';
							row+='<td>' + this.description + '</td>';
							row+='<td>' + this.price + '</td>'
							row += '<td><input type="checkbox" name="selection" id="selectedProduct" value="'+this.id+'"></td>';
							row+='</tr>';
							$('#tableProducts').append(row);
							 $("#RoatatingWheel").fadeOut('slow');
						});
						
					});
				});	
				
				$('#shoppingCartForm').submit(function(event){
					event.preventDefault();
					$('#RoatatingWheel').fadeIn();
					var selectedProducts=[];
					$('input:checked').each(function(){
						selectedProducts.push($(this).val());
					});
					
					//alert($('#selectedProduct').val());
					//alert(selectedProducts);
					$.postJSON('${pageContext.request.contextPath}/addToCart',selectedProducts,
					function(data){						
						//alert(JSON.stringify(data));
						//$('#shoppingCartTable').find('tbody').remove();
						$.each(data, function(){
							var row = '<tr>';
							row+='<td>' + this.name + '</td>';
							row+='<td>' + this.price + '</td>'
							row += '<td><input type="textox" name="quantity" id="quantity" value="1"></td>';
							row += '<td> </td>';
							row += '<td><input type="checkbox" name="selection" id="selectedProduct" value="'+this.id+'"></td>';
							row+='</tr>';
							$('#shoppingCartTable').append(row);
							$("#RoatatingWheel").fadeOut('slow');
						});
					});
				});
			});
		</script>
		
	</head>
	
	<body>
		<jsp:include page="Header.jsp"></jsp:include>
		<div id="content">
			<p>&nbsp;&nbsp;&nbsp;</p>
			<h2> Product Configurator </h2>
			<div id="categoryDiv">
				<label>Select Product Category</label>
				<select id="selectedCategory">
					<option value="">Select Category</option>
					<c:forEach items="${categoryList}" var="category">
						<option value="${category.id}">${category.name}</option>
					</c:forEach>
				</select>
			</div>
			<div id="RoatatingWheel" align="center"><img src="${pageContext.request.contextPath}/resources/image/ajax-loader.gif" alt="Saving User Record Image"></div>
			<div id="productDiv">
			  <form:form commandName="shoppingCart" id="shoppingCartForm" action="addToCart" method="post">
					<table class="table table-bordered table-striped" id="tableProducts">
					<thead>
						<tr>
							<th> Product Name</th>
							<th> Product Description</th>
							<th> Price</th>	
							<th> Select Product</th>	
						<tr>
					</thead>
					<tbody>
						
					</tbody>
					</table>
					<input class="command" type="submit" name="action" value="Add to Cart" accesskey="A" />
				</form:form>
			</div>
			
			<div id="shoppingCart">
				<h2> my cart </h2>
				<table class="table table-bordered table-striped" id="shoppingCartTable">
					<thead>
						<tr>
							<th> Product Name</th>
							<th> Price</th>
							<th> Quantity</th>
							<th> Total Price</th>
							<th> Delete?</th>	
						<tr>
					</thead>
					<tbody>
						
					</tbody>
					
			</table>
			<input class="command" type="submit" name="action" value="Proceed to checkout" accesskey="A" />
			<input class="command" type="submit" name="action" value="Update Cart" accesskey="A" />
			</div>
				
				
			<!--
			<c:forEach items="${category.productList}" var="product">
				<input name="${product.name}" type="checkbox" VALUE="${product.id}">${product.name} ${product.productcode} ${product.price}<br>
			</c:forEach>			

			<label>Available product for selected category</label>
				<label for="${category.name}">${category.name}
					<input type="radio" name="${category.name}" value="${category.name}"/>
				</label>-->
		</div>
			
		<jsp:include page="Footer.jsp"></jsp:include>			
	</body>
</html>