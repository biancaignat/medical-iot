<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<spring:url value="/resources/app/main.css" var="appCss" />
<spring:url value="/resources/app/main.js" var="appJs" />
<spring:url value="/resources/jquery/jquery-2.2.3.min.js" var="jqueryJs" />

<spring:url value="/resources/bootstrap/js/bootstrap-3.3.4.min.js" var="bootstrapJs"  />
<spring:url value="/resources/bootstrap/css/bootstrap.min.css" var="bootstrapCss" />

<spring:url value="/resources/datatable/datatables-1.10.12.min.js" var="datatableJs" />
<spring:url value="/resources/datatable/datatables-1.10.12.min.css" var="datatableCss" />

<spring:url value="/resources/font-awesome/css/font-awesome.min.css" var="faCss" />


<!-- css files -->
<link href="${bootstrapCss}" rel="stylesheet" />
<link href="${datatableCss}" rel="stylesheet" />
<link href="${appCss}" rel="stylesheet" />
<link href="${faCss}" rel="stylesheet" />
<link href="${loadingCss}" rel="stylesheet" />

<!-- js files -->
<script src="${jqueryJs}"></script>
<script src="${bootstrapJs}"></script>
<script src="${datatableJs}"></script>

<script src="${appJs}"></script>
	
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">	
