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
							row+='<td>' + this.price + '</td>';
							row += '<td><input type="checkbox" name="selection" id="selectedProduct" value="'+this.id+'"></td>';
							row+='</tr>';
							$('#tableProducts').append(row);
							$("#RoatatingWheel").fadeOut('slow');
						});
						
					});
				});	
				
				//$('#productForm').submit(function(event){
				$('#addToCartBtn').click(function(event){
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
						$('#shoppingCartTable').find('tbody').remove();
						$.each(data, function(i,v){
							var row = '<tr>';
							row +='<td>' + this.name + '</td>';
							row +='<td>' + this.price + '</td>'
							row += '<td><input type="textbox" name="quantity" id="quantity_' + i + '" class="quantity" value="'+this.qty+'"></td>';
							row +='<td>' + this.totalprice + '</td>'
							row +='<td><input type="hidden" name="productInCart" id="productIdforCart" value="'+this.id+'"></td>';
							row += '<td><input type="checkbox" name="selection" id="selectedProduct" value="'+this.id+'"></td>';
							row+='</tr>';
							$('#shoppingCartTable').append(row);
							$("#RoatatingWheel").fadeOut('slow');
						});
					});
				});
				
				
				$('#updateCartBtn').click(function(event){
				//$('#shoppingCartForm').submit(function(event){
					event.preventDefault();
					$('#RoatatingWheel').fadeIn();
					
					var formData = $('#shoppingCartForm').serializeJSON();
					//alert(JSON.stringify(formData));
					
					//var shoppingCartItems=[];
					var shoppingCartItemList = {
							userId:'anupam.p22@gmail.com',
							deliveryinstructions: 'standard shipping',
							shoppingCartItems:[],
					};
					
					$('input:hidden').each(function(i,v){
						shoppingCartItemList.shoppingCartItems.push({
							id:$(this).val(),
							qty:$('#quantity_' + $(this).val()).val(),
							//qty:$(this).closest('form').find('#quantity').val(),
							//qty:$('input:text[name=quantity]').val(),
							//qty:$(this).parent().find('input[type=text]').val(),
							//qty:$('#shoppingCartForm > input:checkbox').val(),
						});
					});
					//alert(JSON.stringify(shoppingCartItemList));
					
					$.postJSON('${pageContext.request.contextPath}/updateCart',shoppingCartItemList,
							function(data){
								//alert(JSON.stringify(data));
								$('#shoppingCartTable').find('tbody').remove();
								$.each(data, function(i,v){
									var row = '<tr>';
									row +='<td>' + this.name + '</td>';
									row +='<td>' + this.price + '</td>'
									row += '<td><input type="textbox" name="quantity" id="quantity_' + i + '" class="quantity" value="'+this.qty+'"></td>';
									row +='<td>' + this.totalprice + '</td>'
									row +='<td><input type="hidden" name="productInCart" id="productIdforCart" value="'+this.id+'"></td>';
									row += '<td><input type="checkbox" name="selection" id="selectedProduct" value="'+this.id+'"></td>';
									row+='</tr>';
									$('#shoppingCartTable').append(row);
									$("#RoatatingWheel").fadeOut('slow');
								});
								
					});//end of POST
				});//end of update function
				
				$('#checkoutCartBtn').click(function(event){
						event.preventDefault();
						$('#RoatatingWheel').fadeIn();
						
						//var shoppingCartItems=[];
						var shoppingCartItemList = {
								userId:'anupam.p22@gmail.com',
								deliveryinstructions: 'standard shipping',
								shoppingCartItems:[],
						};
						
						$('input:hidden').each(function(i,v){
							shoppingCartItemList.shoppingCartItems.push({
								id:$(this).val(),
								qty:$('#quantity_' + $(this).val()).val(),
								//qty:$(this).closest('form').find('#quantity').val(),
								//qty:$('input:text[name=quantity]').val(),
								//qty:$(this).parent().find('input[type=text]').val(),
								//qty:$('#shoppingCartForm > input:checkbox').val(),
							});
						});
						//alert(JSON.stringify(shoppingCartItemList));
						
						$.postJSON('${pageContext.request.contextPath}/checkoutCart',shoppingCartItemList,
								function(data){
									//alert(JSON.stringify(data));
									$('#checkoutTable').find('tbody').remove();
									$.each(data, function(i,v){
										var row = '<tr>';
										row +='<td>' + this.name + '</td>';
										row += '<td><input type="textbox" disabled="true" name="quantity" id="quantity_' + i + '" class="quantity" value="'+this.qty+'"></td>';
										row +='<td class="price">' + this.totalprice + '</td>';
										row +='<td><input type="hidden" name="productInCart" id="productIdforCart" value="'+this.id+'"></td>';
										row+='</tr>';
										$('#checkoutTable').append(row);
										$("#RoatatingWheel").fadeOut('slow');
									});
									var rowTotal='</tr>';
									$('#checkoutTable').append('<tr><td colspan="2">Order Total</td> <td id="total"></td></tr>');
									getTotal();
						});
				});//end of checkoutcart function
				
				$('#confirmOrderBtn').click(function(event){
					event.preventDefault();
					$('#RoatatingWheel').fadeIn();
					//alert("anupam is printing before postjson success");
					$.postJSON('${pageContext.request.contextPath}/confirmOrder',{}, function(data){
						//alert(JSON.stringify(data));
						if (data.success==true){
							$.each(data.message, function(i,v){
								$('#orderConfirmationSpan').text(v);
							});
							$("#RoatatingWheel").fadeOut('slow');
						}//end of if
					});
					
				});//end of confirm order function
				
			}); //end of DOM load
			
			function getTotal(){
			    var total = 0;
			    $('.price').each(function(){
			        total += parseFloat(this.innerHTML);
			    });
			    //$('#total').text(total);
			    $("#total").text('$' + parseFloat(total, 10).toFixed(2).replace(/(\d)(?=(\d{3})+\.)/g, "$1,").toString());
			}
		</script>
		
	</head>
	
	<body>
		<jsp:include page="Header.jsp"></jsp:include>
		<%
			session.getAttribute("shoppingCartItemMap");
		%>		
		<div id="content">
			<p>&nbsp;&nbsp;&nbsp;</p>
			<span class="message">Welcome ${user.firstName} ${user.lastName}</span>
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
			 	 <!--<form:form commandName="shoppingCart" id="productForm" action="addToCart" method="post"> -->
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
					<input class="command" type="submit" name="action" value="Add to Cart" accesskey="A" id="addToCartBtn"/>
				<!-- </form:form> -->
			</div>
			
			<div id="shoppingCartDiv">
				<h2> My Cart </h2>
					<form:form commandName="shoppingCartItemList" id="shoppingCartForm">
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
									<c:forEach items="${shoppingCartItemMap.values()}" var="item">
									 <tr>
										<td>${item.name}</td>
										<td>${item.price} </td>
										<td>${item.qty}</td>
										<td>${item.totalprice}</td>
										<td> </td>
									</tr>
									</c:forEach>
							</tbody>
					     </table>
					<input class="command" type="submit" name="action" value="Proceed to checkout" accesskey="A" id="checkoutCartBtn" />
					<input class="command" type="submit" name="action" value="Update Cart" accesskey="A" id="updateCartBtn" />
				</form:form>
			</div>
			
			<div id="checkoutDiv">
				<h2> My Order </h2>
					<!--<form:form commandName="shoppingCartItemList" id="shoppingCartForm">-->
					   <table class="table table-bordered table-striped" id="checkoutTable">
							<thead>
								<tr>
									<th> Product Name</th>
									<th> Quantity</th>
									<th> Total Price</th>
								<tr>
							</thead>
							<tbody>
							</tbody>
					     </table>
					 
					<input class="command" type="submit" name="action" value="confirm order" accesskey="A" id="confirmOrderBtn" />
					<p>&nbsp;&nbsp;&nbsp;</p>
					<span class="message" id="orderConfirmationSpan"></span>
				<!--</form:form> -->
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