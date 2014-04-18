<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:url value="/email/send" var="sendUrl"/>

<html>
<head>
	<link rel="shortcut icon" href="resources/image/favicon.ico" type="image/x-icon" /> 
	<title>SparkMind Contact Us</title>
	<link href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" rel="stylesheet" />
	<link href= "resources/css/global.css" rel="stylesheet" type="text/css">
	<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
	<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
	<script type="text/javascript" src="resources/js/jquery.validate.min.js"></script>
	<script type="text/javascript" src="resources/js/script.js"></script>
	<script type='text/javascript' src='<c:url value="/resources/js/util.js"/>'></script>
	
	<script type='text/javascript'>
	$(function() {
		init();
	});//end of jQuery DOM loading
	
	function init() {
		$('input:button').button();
		$('#submit').button();
		
		$('#emailForm').validate({
			rules:{
				senderName:{required:true, minlength:3},
				senderEmail:{required:true,email:true},
				senderCompany:{required:true},
				senderPhone:{required:true,number:true,minlength:6}
			},
			message:{
				senderName:{required:'This field is required', minlength:'min length is 3'},
				senderEmail:{reuired:'This field is required'},
				senderCompany:{required:'This field is required'},
				senderPhone:{required:'This field is required',number:'Invalid phone no', minlength:'Min length for phone no is 6'},
				textBody:{required:'This field is required'}
			},
			success:function(label){
				label.html('ok').removeClass('error').addClass('ok');
				setTimeout(function(){
					label.fadeOut(500);
				},2000);
			}
			 
		}); //end of emailForm validate function			
	
		$('#emailForm').submit(function(event) {
				event.preventDefault();
				var $form = $(this);
				if(! $form.valid()) return false;
				$.postJSON('${sendUrl}', {
					senderName: $('#senderName').val(),
					senderEmail: $('#senderEmail').val(),
					senderCompany: $('#senderCompany').val(),
					senderPhone: $('#senderPhone').val(),
					textBody: $('#textBody').val(),
				},
				function(result) {
				  if (result.success == true) {
						dialog('Success', 'Email has been sent!');
					} else {
						dialog('Failure', 'Email has not been sent!');
					} 
				});
		});
		
		$('#reset').click(function() {
			clearForm();
			dialog('Success', 'Fields have been cleared!');
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
	
	function clearForm() {
		$('#senderName').val('');
		$('#senderEmail').val('');
		$('#senderCompany').val('');
		$('#senderPhone').val('');
		$('#subject').val('');
		$('#textBody').val('');
	}
	</script>
</head>

<body>
	<jsp:include page="Header.jsp" />
	<!-- <h1 id='banner'>Compose Email</h1> -->
	
	<div id=content>
		<form:form id="emailForm" class="blocks" commandName="message">
  			<fieldset>
				<legend>Compose Email</legend>
				<p>
					<form:label path='senderName'>Name*:</form:label>
					<form:input path="senderName" type='text' class="text1"/>
				</p>
				<p>
					<form:label path='senderEmail'>Email*:</form:label>
					<form:input path="senderEmail" type='text' id='senderEmail' name='senderEmail' class="text1"/>
				</p>
				<p>
					<form:label path='senderCompany'>Company:</form:label>
					<form:input path="senderCompany" type='text' class="text1"/>
				</p>
				<p>
					<form:label path='senderPhone'>Phone:</form:label>
					<form:input path="senderPhone" type='text' class="text1" />
				</p>
				<p>
					<form:label path='textBody'>Message:</form:label>
					<form:textarea path="textBody" class="textarea"></form:textarea>
				</p>
				<p align="center">
					<input type='button' value='Reset' id='reset' />
					<input type='submit' value='Send' id='submit'/>
				</p>
  			</fieldset>
		</form:form>
		 <p class="message">${mesg}</p>	
	</div>	
	<div id='msgbox' title='' style='display:none'></div>
	<jsp:include page="Footer.jsp" />
	
</body>
</html>