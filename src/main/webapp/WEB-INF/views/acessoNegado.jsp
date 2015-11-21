<%-- 
    Document   : acessoNegado
    Created on : 21/11/2015, 16:54:07
    Author     : DeividNn
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>    
        <title>Acesso Negado</title>      
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
                <div class="alert alert-danger" role="alert">
                    ${usuario}, voce nao tem autorizacao para acessar a pagina
                </div>

                <p><a class="btn btn-primary btn-lg" 
                      href="javascript:history.back();"
                      role="button">Voltar</a></p>

                <p><a class="btn btn-danger btn-lg" 
                      href="<c:url value="/sair"/>"
                      role="button">Sair</a></p>


            </div>

        </div> 
    </body>
</html>

