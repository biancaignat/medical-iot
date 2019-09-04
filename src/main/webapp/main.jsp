<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <%@ include file="js_css.jsp" %>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Medical IoT Platform</title>
</head>
<body>
<%@ include file="header.jsp" %>

<div class="row">
    <div class="col-md-10 col-md-offset-1">
        <h3>Hi, <c:if test="${SESSION_USER.isUserDoctor()}">doctor</c:if> ${SESSION_USER.name}!</h3>
        <c:if test="${!empty  SESSION_USER.investigationList}">
            <table class="table table-bordered table-striped table-hover table-condensed" style="width: 100%;">
                <thead>
                <tr>
                    <td>Patient information</td>
                    <td>Investigation Type</td>
                    <td>Investigation Time</td>
                    <td>Investigation Result</td>
                    <td>Investigation Diagnostics</td>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="investigation" items="${SESSION_USER.investigationList}">
                    <tr>
                        <td>${investigation.patient.name}, age: ${investigation.patient.age}</td>
                        <td>${investigation.getType()}</td>
                        <td>${investigation.timestamp}</td>
                        <td><a href="./resources/images/${investigation.name}"  target="_blank"><img src="./resources/images/${investigation.name}" alt="" border="0" height="120px"/></a></td>
                        <td>${investigation.getDiagnostics()}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </c:if>
        <c:if test="${SESSION_USER.isUserDoctor()}">
            <table class="table table-bordered table-striped table-hover table-condensed" style="width: 100%;">
                <thead>
                <tr>
                    <td>Patient unique ID</td>
                    <td>Investigation Type</td>
                    <td>Investigation Time</td>
                    <td>Investigation Result</td>
                    <td>Investigation Diagnostics</td>
                    <td>Add Diagnostic</td>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="investigation" items="${SESSION_INVESTIGATIONS}">
                    <tr>
                        <td>${investigation.patient.uniqueId}</td>
                        <td>${investigation.getType()}</td>
                        <td>${investigation.timestamp}</td>
                        <td><img src="./resources/images/${investigation.name}" alt="" border="0" height="120px"/></td>
                        <td>${investigation.getDiagnostics()}</td>
                        <td>
                            <c:if test="${SESSION_USER.isUserDoctor()}">
                                <a class="btn btn-info" href="./addDiagnostic?id=${investigation.getId()}"><i
                                        class="fa fa-plus"></i></a>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </c:if>

    </div>
</div>
<%@ include file="footer.jsp" %>
</body>
<script type="text/javascript">
    $(document).ready(function () {
        var table = $('table').DataTable({
            "dom": 'frtip',
            "saveState": true
        });
    });
</script>
</html>