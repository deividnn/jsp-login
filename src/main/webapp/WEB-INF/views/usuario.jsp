<%-- 
    Document   : usuario
    Created on : 21/11/2015, 16:54:07
    Author     : DeividNn
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>    
        <title>Usuario</title>      
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="">
        <meta name="author" content="">
        <link href="<c:url value="/static/css/bootstrap.min.css"/>" rel="stylesheet">
        <link href="<c:url value="/static/css/signin.css"/>" rel="stylesheet">

    </head>

    <body>
        <div class="container">

            <div class="jumbotron">
                <div class="alert alert-success" role="alert">
                    Bem-vindo ${usuario}, voce esta na area do usuario
                </div>

                <sec:authorize access="hasRole('ADMIN')">
                <p><a class="btn btn-primary btn-lg" 
                      href="<c:url value="/admin"/>"
                      role="button">Admin</a></p>
                </sec:authorize>

                <p><a class="btn btn-danger btn-lg" 
                      href="<c:url value="/sair"/>"
                      role="button">Sair</a></p>


            </div>

        </div> 
    </body>
</html>


