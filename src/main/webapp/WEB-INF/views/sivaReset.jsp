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
        <div class="container center-text text-center">
            <div class="row" style="margin-top:20px;">
                <div class="col-lg-4 col-md-4 col-xl-4 col-sm-1 col-2 "></div>
                <div class="col-lg-4 col-md-4 col-xl-4  col-sm-10 col-8">
                
                    <h4>Para restaurar su contraseña ingrese sus datos:</h4>
                    <form method="post" action="${pageContext.request.contextPath}/siva/reset">
                        <div class="form-group">
                            <label for="usuario">Usuario</label>
                            <input type="text" class="form-control" id="usuario" name="usuario" placeholder="7000912" title="Ingrese un formato de usuario válido.">
                        </div>
                        <div class="form-group">
                            <label for="dui">DUI</label>
                            <input type="text" pattern="[0-9]{8}-[0-9]{1}" class="form-control" id="dui" name="dui" placeholder="11111111-1" title="Ingrese un formato de DUI válido.">
                        </div>
                        <button type="submit" class="btn btn-primary text-right">Validar</button>
                    </form>
                </div>
                <div class="col-lg-4 col-md-4 col-xl-4  col-sm-1 col-2"></div>
            </div>
        </div>
    </body>
</html>
