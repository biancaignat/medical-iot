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

            <c:if test="${!empty  SESSION_INVESTIGATION.diagnosticList}">
                <h3>Diagnostics: </h3>
            </c:if>

            <c:forEach var="diagnostic" items="${SESSION_INVESTIGATION.diagnosticList}">
                <table class="table table-bordered table-striped table-hover table-condensed" style="width: 100%;">
                    <thead>
                        <tr>
                            <th><b> ${diagnostic.description}</b> <i>by ${diagnostic.doctor.name} at ${diagnostic.timestamp}</i></th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:if test="${!empty  diagnostic.commentList}">
                            <tr>
                                <td class="text-right"><b>Comments: </b></td>
                            </tr>
                        </c:if>
                        <c:forEach var="comment" items="${diagnostic.commentList}">
                            <tr>
                                <td class="text-right">${comment.comment} <i>by ${comment.user.name} at ${comment.timestamp}</i></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <div class="row form-group">
                    <form class="form-horizontal" action="addComment" method="POST">
                        <div class="col-sm-6">
                            <textarea class="form-control" name="comment" id="comment" cols="100" rows="5"></textarea>
                        </div>
                        <input type="hidden" id="diagnosticId" name="diagnosticId" value="${diagnostic.id}"/>
                        <button type="submit" class="btn btn-success"> <i class="fa fa-save"></i> Save Comment</button>
                    </form>
                </div>
            </c:forEach>

            <c:if test="${SESSION_USER.isUserDoctor()}">
                <form class="form-horizontal" action="addDiagnostic" method="POST">
                    <div class="row form-group">
                        <label class="control-label col-sm-2">New diagnostic: </label>
                        <div class="col-sm-6">
                            <textarea class="form-control" name="diagnostic" id="diagnostic" cols="100" rows="5"></textarea>
                        </div>
                    </div>
                    <div class="alert alert-info text-center">
                        <button type="submit" class="btn btn-success"> <i class="fa fa-save"></i> Save</button>
                    </div>
                </form>
            </c:if>

            <div class="row form-group">
                <img src="./resources/images/${SESSION_INVESTIGATION.name}" alt="" border="0" />
            </div>

    </div>
</div>
<%@ include file="footer.jsp" %>
</body>
</html>