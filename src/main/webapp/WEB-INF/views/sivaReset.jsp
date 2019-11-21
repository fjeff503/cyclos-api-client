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
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
        <div class="container text-center" style="margin-top:20px;">
            <div class="row">
                <div class="col-12">
                    <img src="<c:url value="/resources/siva-logo.jpg" />">
                </div>
            </div>
            <div class="row" style="margin-bottom: 150px;">
                <div class="col-12">
                    <div>              
                        <h2 style="margin-top:15px; margin-bottom:25px"><a style="color:red">1.</a> <a style="color:#03396c">Para restaurar su contraseña ingrese sus datos</a></h2>
                        <form method="post" action="${pageContext.request.contextPath}/siva/reset">
                            <div class="form-group">
                                <label for="usuario" style="font-size: 34px">Usuario:</label>
                                <input type="text" class="form-control" id="usuario" name="usuario" placeholder="7000912" title="Ingrese un formato de usuario válido." autocomplete="off">
                            </div>
                            <div class="form-group">
                                <label for="dui" style="font-size: 34px">DUI:</label>
                                <input type="text" pattern="[0-9]{9}" class="form-control" id="dui" name="dui" placeholder="059482019" title="Ingrese un formato de DUI válido." autocomplete="off">
                                <a style="font-style: italic">Ingrese los números de su DUI, sin guíon (-).</a>
                            </div>
                            <button type="submit" class="btn btn-primary text-right" style="margin-top:15px;">Validar</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </body>

    <!--
    <script>
        var value = document.getElementById('dui').getAttribute('value');
        var currentKey = 0;
        document.getElementById('dui').addEventListener('keydown', function (e) {
            e.preventDefault();
            if (e.keyCode >= 48 && e.keyCode <= 57) {
                if (currentKey === 10) {
                    return;
                }
                if (currentKey === 8) {
                    currentKey = 9
                }
                value = value.substr(0, currentKey) + String.fromCharCode(e.keyCode) + value.substr(currentKey + 1, value.length - (currentKey + 1));
                document.getElementById('dui').setAttribute('value', value);
                currentKey++;
                //setFocusOn(currentKey)

            }
            else if (e.keyCode === 8) {
                if (currentKey === 9) {
                    currentKey = 8
                }
                if (currentKey === 0) {
                    return
                }
                value = value.substr(0, currentKey - 1) + "0" + value.substr(currentKey, value.length - (currentKey));
                document.getElementById('dui').setAttribute('value', value);
                currentKey--;
                //setFocusOn(currentKey,element)
            }
        });

        function setFocusOn(keyFocus, element) {



        }

        document.getElementById('dui').addEventListener('focus', function (e) {
            var elem = document.getElementById('dui');
            elem.setSelectionRange(currentKey, currentKey);
            elem.focus();
        })

        document.getElementById('dui').addEventListener('onclick', function (e) {
            var elem = document.getElementById('dui');
            elem.focus();
            elem.setSelectionRange(currentKey, currentKey);
        })

    </script>
    -->
</html>
