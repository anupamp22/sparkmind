<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<spring:url value="/webjars/bootstrap/2.3.2/css/bootstrap.min.css" var="bootstrapCss"/>
<link href="${bootstrapCss}" rel="stylesheet"/>


 <spring:url value="/webjars/jquery/1.9.0/jquery.js" var="jQuery"/>
 <script src="${jQuery}"></script>

 <spring:url value="/webjars/jquery-ui/1.9.2/js/jquery-ui-1.9.2.custom.js" var="jQueryUi"/>
 <script src="${jQueryUi}"></script>

 <!--<spring:url value="/webjars/jquery-ui/1.9.2/css/smoothness/jquery-ui-1.9.2.custom.css" var="jQueryUiCss"/>
 <link href="${jQueryUiCss}" rel="stylesheet"></link>

<spring:url value="/webjars/jquery/2.1.1/jquery.js" var="jQuery"/>
<script src="${jQuery}"></script>

<spring:url value="/webjars/jquery-ui/1.10.4/js/jquery-ui-1.10.4.custom.js" var="jQueryUi"/>
<script src="${jQueryUi}"></script>

<spring:url value="/webjars/jquery-ui/1.10.4/css/smoothness/jquery-ui-1.10.4.custom.css" var="jQueryUiCss"/>
<link href="${jQueryUiCss}" rel="stylesheet"></link>

<spring:url value="/resources/css/petclinic.css" var="petclinicCss"/>
<link href="${petclinicCss}" rel="stylesheet"/>
<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.2/jquery.mobile-1.4.2.min.css" />
<script src="http://code.jquery.com/mobile/1.4.2/jquery.mobile-1.4.2.min.js"></script>-->


<script src="${pageContext.request.contextPath}/resources/js/myangular/angular-1.0.0rc6.js"></script>
<link href= "${pageContext.request.contextPath}/resources/css/global.css" rel="stylesheet" type="text/css">
<!-- <script src="${pageContext.request.contextPath}/resources/js/script.js"></script>-->
<script src="${pageContext.request.contextPath}/resources/js/myangular/myangular.js"></script>
