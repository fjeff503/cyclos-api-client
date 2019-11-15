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
        <div class="container">
            <div class="row" style="margin-top:20px;">
                <div class="col-lg-4 col-md-4 col-xl-4 col-sm-2 col-2 "></div>
                <div class="col-lg-4 col-md-4 col-xl-4  col-sm-8 col-8">
                    <h2>Ingrese su nueva contraseña</h2>
                    <form method="post" action="">
                        <div class="form-group">
                            <label for="contraseña">Contraseña</label>
                            <input type="password" class="form-control" id="contraseña" name="usuario" placeholder="7000912" pattern="[A-Za-z0-9]{12}">
                        </div>
                        <div class="form-group">
                            <label for="confirmar-contraseña">Confirmar Contraseña</label>
                            <input type="password" class="form-control" id="confirmar-contraseña" name="usuario" placeholder="7000912"  pattern="[A-Za-z0-9]{12}" title="Ingrese un formato de usuario válido.">
                        </div>
                    </form>
                </div>
                <div class="col-lg-4 col-md-4 col-xl-4  col-sm-2 col-2"></div>
            </div>
        </div>
    </body>
</html>
