<%-- 
    Document   : succesfulReset
    Created on : 11-14-2019, 02:28:01 PM
    Author     : Puntotransacciones
--%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Restablecimiento Exitoso - SIVA</title>
        <link rel="icon" href="<c:url value="/resources/siva-logo.jpg" />">
              <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    </head>
    <body>
        <div class="container">
            <div class="row" style="margin-top:20px;">
                <div>
                    <h2 style="margin-top:10px;">Contraseña Restablecida</h2>
                    <h4>Ya puede ingresar a su cuenta de <a style="color:blue">SIVA</a> con su nueva contraseña.</h4>
                </div>
            </div>
            
            <div class="row" style="margin-top: 30px; margin-bottom: 40px;">
                <img src="<c:url value="/resources/siva-logo.jpg" />">
            </div>
        </div>
    </body>
</html>
