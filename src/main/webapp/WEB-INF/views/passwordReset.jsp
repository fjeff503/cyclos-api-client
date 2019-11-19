<%-- 
    Document   : passwordReset
    Created on : 11-14-2019, 01:52:39 PM
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
        <c:if test="${passwordNotEqual}">
            <div class="container">
                <div class="row justify content center">
                    <div class="alert alert-danger col-4" role="alert">Las contraseñas ingresadas no coinciden</div>
                </div>
            </div>
        </c:if> 
        <div class="container center-text text-center">
            <div class="row" style="margin-top:20px;">
                <div class="col-1 "></div>
                <div class="col-10">
                    <h2><a style="color:red">2.</a> Ingrese su nueva contraseña</h2>
                    <form method="post" action="${pageContext.request.contextPath}/siva/attempt-reset" id="resetForm">
                        <div class="form-group">
                            <label for="contraseña">Contraseña</label>
                            <input type="password" class="form-control" id="contraseña" name="contra" placeholder="&#9679;&#9679;&#9679;&#9679;&#9679;&#9679;&#9679;&#9679;&#9679;" pattern="[A-Za-z0-9]{3,12}" title="La contraseña debe llevar de 3-12 digitos, sin utilizar simbolos.">
                        </div>
                        <div class="form-group" id="confirmar-contra-group">
                            <label for="confirmar-contraseña">Confirmar Contraseña</label>
                            <input type="password" class="form-control" id="confirmar-contraseña" name="contra2" placeholder="&#9679;&#9679;&#9679;&#9679;&#9679;&#9679;&#9679;&#9679;&#9679;"  pattern="[A-Za-z0-9]{3,12}" title="La contraseña debe llevar de 3-12 digitos, sin utilizar simbolos.">
                            <div class="invalid-feedback">Las contraseñas no son iguales.</div>
                        </div>
                        <button type="submit" class="btn btn-primary text-right">Validar</button>
                    </form>
                </div>
                <div class="col-1"></div>
            </div>
        </div>
        <script>
            document.getElementById('resetForm').addEventListener("submit", function (e) {
                password = document.getElementById('contraseña');
                confirm_password = document.getElementById('confirmar-contraseña');

                if (password.value !== confirm_password.value) {
                    confirm_password.className += " is-invalid";
                    e.preventDefault();
                }
            })
            document.getElementById('confirmar-contraseña').addEventListener("change", function(e){
                document.getElementById('confirmar-contraseña').classList.remove("is-invalid");
            })

        </script>

    </body>
</html>
