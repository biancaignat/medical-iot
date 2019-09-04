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
        <form class="form-horizontal" action="addDiagnostic" method="POST">
            <div class="alert alert-info text-center">
                <a href="./home" class="btn btn-danger btn-back"><i class="fa fa-arrow-left"></i> Back</a>
                <button type="submit" class="btn btn-success"> <i class="fa fa-save"></i> Save</button>
            </div>

            <div class="row form-group">
                <label class="control-label col-sm-2">Patient name : </label>
                <div class="col-sm-3">
                    <input class="form-control" type="text" name="description" value="${SESSION_INVESTIGATION.patient.name}" disabled/>
                </div>

                <label class="control-label col-sm-2">Patient age : </label>
                <div class="col-sm-3">
                    <input class="form-control" type="text" name="code" value="${SESSION_INVESTIGATION.patient.age}" disabled />
                </div>
            </div>

            <div class="row form-group">
                <label class="control-label col-sm-2">Diagnostic: </label>
                <div class="col-sm-6">
                    <textarea class="form-control" name="diagnostic" id="diagnostic" cols="100" rows="5"></textarea>
                </div>
            </div>

            <div class="row form-group">
                <img src="./resources/images/${SESSION_INVESTIGATION.name}" alt="" border="0" />
            </div>
        </form>

    </div>
</div>
<%@ include file="footer.jsp" %>
</body>
</html>