<%-- 
    Document   : passwordReset
    Created on : 11-14-2019, 01:52:39 PM
    Author     : Puntotransacciones
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Restaurar Contraseña - SIVA</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    </head>
    <body>
        <div class="container center-text text-center">
            <div class="row" style="margin-top:20px;">
                <div class="col-lg-4 col-md-4 col-xl-4 col-sm-2 col-2 "></div>
                <div class="col-lg-4 col-md-4 col-xl-4  col-sm-8 col-8">
                    <h4><a style="color:red">2.</a> Ingrese su nueva contraseña</h4>
                    <form method="post" action="${pageContext.request.contextPath}/siva/attempt-reset">
                        <div class="form-group">
                            <label for="contraseña">Contraseña</label>
                            <input type="password" class="form-control" id="contraseña" name="contra" placeholder="&#9679;&#9679;&#9679;&#9679;&#9679;&#9679;&#9679;&#9679;&#9679;" pattern="[A-Za-z0-9]{3,12}" title="La contraseña debe llevar de 3-12 digitos, sin utilizar simbolos.">
                        </div>
                        <div class="form-group">
                            <label for="confirmar-contraseña">Confirmar Contraseña</label>
                            <input type="password" class="form-control" id="confirmar-contraseña" name="contra2" placeholder="&#9679;&#9679;&#9679;&#9679;&#9679;&#9679;&#9679;&#9679;&#9679;"  pattern="[A-Za-z0-9]{3,12}" title="La contraseña debe llevar de 3-12 digitos, sin utilizar simbolos.">                                                     
                        </div>
                        <button type="submit" class="btn btn-primary text-right">Validar</button>
                    </form>
                </div>
                <div class="col-lg-4 col-md-4 col-xl-4  col-sm-2 col-2"></div>
            </div>
        </div>
    </body>
</html>
