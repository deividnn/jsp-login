<%-- 
    Document   : acesso
    Created on : 21/11/2015, 16:54:07
    Author     : DeividNn
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>    
        <title>Acesso</title>      
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
            <c:url var="acessoURL" value="/acesso" />
            <form class="form-signin" method="post" action="${acessoUrl}">

                <c:if test="${param.error != null}">
                    <div class="alert alert-danger" role="alert">
                        <p style="color: red">usuario/senha incorretos.</p>
                    </div>
                </c:if>

                <c:if test="${param.sair != null}">
                    <div class="alert alert-info" role="alert">
                        <p style="color: blue">voce saiu do sistema.</p>
                    </div>
                </c:if>


                <h2 class="form-signin-heading">Acesso</h2>

                <label for="usuario" class="sr-only">Usuario</label>
                <input type="text"
                       id="usuario"
                       name="usuario"
                       class="form-control" 
                       placeholder="Digite o usuario" 
                       required autofocus>
                <br/>
                <label for="senha" class="sr-only">Senha</label>
                <input type="password" 
                       id="senha"
                       name="senha"
                       class="form-control" 
                       placeholder="Digite a senha" 
                       required>

                <input type="hidden"
                       name="${_csrf.parameterName}"
                       value="${_csrf.token}" />

                <button class="btn btn-lg btn-danger btn-block" 
                        type="submit">Acessar</button>
                <br/>
                <a class="btn btn-lg btn-primary btn-block" 
                   href="<c:url value="/inicio"/>"
                   role="button">Inicio</a>

            </form>

        </div> 
    </body>
</html>
