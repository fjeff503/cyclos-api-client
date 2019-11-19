<%-- 
    Document   : newjsp
    Created on : 11-14-2019, 11:41:45 AM
    Author     : Puntotransacciones
--%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Restaurar Contraseña - SIVA</title>
        <link rel="icon" href="<c:url value="/resources/siva-logo.jpg" />">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    </head>
    <body>
        <c:if test="${hasError}">
            <div class="container">
                <div class="row justify content center">
                    <div class="alert alert-danger col-4" role="alert">Usuario o número de DUI incorrecto</div>
                </div>
            </div>
        </c:if> 
        <c:if test="${SessionTimeout}">
            <div class="container">
                <div class="row justify content center">
                    <div class="alert alert-danger col-4" role="alert">Tiempo máximo de espera superado. Favor ingrese sus datos de nuevo</div>
                </div>
            </div>
        </c:if> 
        <div class="container center-text text-center" style="margin-top:20px;">
            <img src="<c:url value="/resources/siva-logo.jpg" />">
            <div class="row">
                <div class=" col-12">              
                    <h1 style="margin-top:15px; margin-bottom:15px"><a style="color:red">1.</a> <a style="color:#03396c">Para restaurar su contraseña ingrese sus datos</a></h1>
                    <form method="post" action="${pageContext.request.contextPath}/siva/reset">
                        <div class="form-group">
                            <label for="usuario" style="font-size: 34px">Usuario:</label>
                            <input type="text" class="form-control" id="usuario" name="usuario" placeholder="7000912" title="Ingrese un formato de usuario válido.">
                        </div>
                        <div class="form-group">
                            <label for="dui" style="font-size: 34px">DUI:</label>
                            <input type="text" pattern="[0-9]{8}-[0-9]{1}" class="form-control" id="dui" name="dui" placeholder="05300571-7" title="Ingrese un formato de DUI válido.">
                        </div>
                        <button type="submit" class="btn btn-primary text-right">Validar</button>
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>
