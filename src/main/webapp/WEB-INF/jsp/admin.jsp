<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>


<html>
	<head>
		<jsp:include page="HeadFilesInclude.jsp"></jsp:include>
		<title>SparkMind Admin Page</title>
		
		<script type="text/javascript">
			$(function(){
					loadUsers();
					$('#userEditDiv').hide();
					$('#RoatatingWheel').hide();
					
					//$('.editUserBtn').click(function(event){
					$(document).on("click",'.editUserBtn', function(event){
						event.preventDefault();
						var userId = $(this).parent().find('#userId').val();
						var editUrl = '${pageContext.request.contextPath}/editUser/'+userId;
						$.getJSON(editUrl,function(result){
								$('#id').val(result.id);
								$('#firstName').val(result.firstName);
								$('#lastName').val(result.lastName);
								$('#email').val(result.email);
								$('#password').val(result.password);
								$('#role').val(result.role.role);
								$('#userConfirmation').val(result.userConfirmation);
								$('#guid').val(result.guid);
						});
						$('#userEditDiv').show();
					});					
					
					$(document).on("click",'.deleteUsrBtn', function(event){
						event.preventDefault();
						$('#RoatatingWheel').fadeIn(); //show when submitting
						var userId = $(this).parent().find('#userId').val();
						var deleteUrl = '${pageContext.request.contextPath}/deleteUserByAjax/'+userId;
						//alert(deleteUrl);
						$.getJSON(deleteUrl, function(data){
							//alert(JSON.stringify(data));
							/*if (data.success==true){
								alert("User deleted");								
							}*/
							loadUsers();
							 $("#RoatatingWheel").fadeOut('slow');
						});			
						
					});
					
					
					$('#saveUserRecordForm').submit(function(event){
						event.preventDefault();
						$('#RoatatingWheel').fadeIn(); //show when submitting
						
						var $form = $(this);
						var $inputs = $form.find("input");
						//var serializedData = $form.serialize();
						var serializedData = $form.serializeJSON();
						
						//$inputs.prop("disabled",true);
						//alert(serializedData);
						//var parsedData = JSON.stringify($form.serializeJSON());
						//alert(parsedData);
						
						var saveUrl='${pageContext.request.contextPath}/saveUser/'+$('#id').val();
						
						var role = {
								role:$('#role').val(),
								user:user,
						};
						var user={
								id:$('#id').val(),
								firstName:$('#firstName').val(),
								lastName:$('#lastName').val(),
								email:$('#email').val(),
								guid:$('#guid').val(),
								password:$('#password').val(),
								userConfirmation:$('#userConfirmation').val(),
								role:role,
						};
						//alert(JSON.stringify(user));
						$.postJSON(saveUrl, user, function(result){
							//alert(result);
							/*if (result.success==true){
								dialog("Success", "Record Saved");
							}*/
							loadUsers();
							 $("#RoatatingWheel").fadeOut('slow');
						});
					});
					
					
					$('#signupForm').submit(function(event){
						event.preventDefault();
						$('#RoatatingWheel').fadeIn(); //show when submitting
						var $form = $(this);
						var serializedData = $form.serializeJSON();
						//alert(JSON.stringify($form.serializeJSON()));
						
						/*var user={
								firstName:$('#newfirstName').val(),
								lastName:$('#newlastName').val(),
								email:$('#newemail').val(),
								password:$('#newpassword').val(),
						};*/
						
						//alert(JSON.stringify(user));
						var registerUrl='${pageContext.request.contextPath}/registerByAjax';
						$.postJSON(registerUrl, serializedData, function(result){
							//alert(JSON.stringify(result));
							loadUsers();
							$("#RoatatingWheel").fadeOut('slow');
						});						
					});
					
					//btn btn-danger btn-mini
					function loadUsers(){
						$.getJSON('${pageContext.request.contextPath}/loadUsersInAMap', function(data){
							//alert(JSON.stringify(data));
							$('#tableUsers').find('tbody').remove();
							$.each(data.user, function(){
								//$.each(this, function(name,value){
									var row = '<tr>';
									row+='<td>' + this.firstName + '</td>';
									row+='<td>' + this.lastName + '</td>';
									row+='<td>' + this.email + '</td>';
									row+='<td>' + this.role.role + '</td>';
									row+='<td>' + this.userConfirmation + '</td>';
									row+='<td>' + this.guid + '</td>';
									row+='<td><input type="hidden" id="userId" value="'+this.id+'"/><input type="button" id ="editUserBtn" class="editUserBtn" value="edit"/> </td>';
									/*row+='<td><form action="deleteUser/'+this.id+'" method="post"><input type="submit" class="btn btn-danger btn-mini" value="Delete"/></form></td>';
									*/
									row+='<td><input type="hidden" id="userId" value="'+this.id+'"/><input type="submit" class="deleteUsrBtn" value="Delete"/></td>';
									
									row+='</tr>';
									$('#tableUsers').append(row);
									//console.log(this.firstName + this.lastName + this.role.role);	
								//});
							});
						});
					}
					function dialog(title, text) {
						$('#msgbox').text(text);
						$('#msgbox').dialog( 
								{	title: title,
									modal: true,
									buttons: {"Ok": function()  {
										$(this).dialog("close");} 
									}
								});
					}
					
					
			});			
		</script>
	</head>
	<body>
		<jsp:include page="Header.jsp"></jsp:include>
		<div id="content">
			<p>&nbsp;&nbsp;&nbsp;</p>
			<h2>All user data</h2>
			
			<table class="table table-bordered table-striped" id="tableUsers">
				<thead>
					<tr>
						<th>First name</th>
						<th>Last name</th>
						<th>Email</th>
						<th>Role</th>
						<th>userConfirmation</th>
						<th>Guid</th>
						<th>&nbsp;</th>
					</tr>
				</thead>
				<!--<c:forEach items="${userList}" var="user">
						<tr>
							<td>${user.firstName}</td>
							<td>${user.lastName}</td>
							<td>${user.email}</td>
							<td>${user.role.role}</td>
							<td>${user.userConfirmation}</td>
							<td>${user.guid}</td>
							<td>
								<input type="hidden" id="userId" value="${user.id}" />
								<input type="submit" id = "editUserBtn" class="editUserBtn" value="edit"/>
							</td>	
							<td>
								<form action="deleteUser/${user.id}" method="post"><input type="submit" class="btn btn-danger btn-mini" value="Delete"/></form>
							</td>										
						</tr>		
				</c:forEach>-->
			</table>
			
			<div id="RoatatingWheel" align="center"><img src="${pageContext.request.contextPath}/resources/image/ajax-loader.gif" alt="Saving User Record Image"></div>
		
			<div id="userEditDiv">
				     <form:form commandName="user" id="saveUserRecordForm" class="blocks">
					     <fieldset>
						     	<legend>Edit user record</legend>
						     	<p><form:label path="id">Id</form:label>
				                <form:input path="id" class="text1" /> </p>
				                <p><form:label path="firstName">First Name</form:label>
				                <form:input path="firstName" class="text1" /> </p>
				                <p><form:label path="lastName">Last Name</form:label>
				                <form:input path="lastName" class="text1" /></p>
				                <p><form:label path="email">email</form:label>
				                <form:input path="email" class="text1" /></p>
				                 <p><form:label path="guid">guid</form:label>
				                <form:input path="guid" class="text1" /></p>
				                <p><form:label path="password">Password</form:label>
				                <form:input path="password" class="text1" type="password"/></p>
				                <p><form:label path="userConfirmation">User Confirmation </form:label>
				                <form:input path="userConfirmation" class="text1" /></p>
				                <p><form:label path="role">Role</form:label>
				                <form:input path="role" class="text1" /></p>
				                <p align="center"><input type="submit" value="save user record" class="btn" id="saveUserRecordBtn"/></p>
			               </fieldset>
	            </form:form> 
			</div>
			
			<div id="signupDiv">
			     <form id="signupForm" class="blocks">
				     <fieldset>
					     	<legend>Create a new user</legend>
			                <p><label for="newfirstName">First Name</label>
			                <input type="text" name="firstName" id="newfirstName" class="text1" /> </p>
			                <p><label for="newlastName">Last Name</label>
			                <input type="text" name="lastName" id="newlastName" class="text1" /></p>
			                <p><label for="newemail">email</label>
			                <input type="text" id="newemail" name="email" class="text1" /></p>
			                <p><label for="newpassword">Password</label>
			                <input id="newpassword" class="text1" name="password" type="password"/></p>
			                <p align="center"><input type="submit" value="Register" class="btn"/></p>
		               </fieldset>
	            </form>                     	
			</div>			
			
		</div>
			
		<jsp:include page="Footer.jsp"></jsp:include>
	</body>
</html>