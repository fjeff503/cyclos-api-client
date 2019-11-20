<%-- 
Document   : recordList
Created on : 10/09/2019, 11:48:29 AM
Author     : HP PC
--%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Oportunidades</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css" integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf" crossorigin="anonymous">
        <style>
            body{
                font-size:14px;
            }
            .autocomplete {
                /*the container must be positioned relative:*/
                position: relative;
                display: inline-block;
            }
            input {
                border: 1px solid transparent;           
                font-size: 16px;
            }
            input[type=text] {            
                width: 100%;
            }
            input[type=submit] {
                background-color: DodgerBlue;
                color: #fff;
            }
            .autocomplete-items {
                position: absolute;
                border: 1px solid #d4d4d4;
                border-bottom: none;
                border-top: none;
                z-index: 99;
                /*position the autocomplete items to be the same width as the container:*/
                top: 100%;
                left: 0;
                right: 0;
            }
            .autocomplete-items div {
                padding: 10px;
                cursor: pointer;
                background-color: #fff;
                border-bottom: 1px solid #d4d4d4;
            }
            .autocomplete-items div:hover {
                /*when hovering an item:*/
                background-color: #e9e9e9;
            }
            .autocomplete-active {
                /*when navigating through the items using the arrow keys:*/
                background-color: DodgerBlue !important;
                color: #ffffff;
            }
            textarea {
                width: 100%;
                height: 100%;
                resize: none;
                -webkit-box-sizing: border-box; /* <=iOS4, <= Android  2.3 */
                -moz-box-sizing: border-box; /* FF1+ */
                box-sizing: border-box; /* Chrome, IE8, Opera, Safari 5.1*/
            }
            .input-table{
                width: 100%;
                height: 100%;
                resize: none;
                -webkit-box-sizing: border-box; /* <=iOS4, <= Android  2.3 */
                -moz-box-sizing: border-box; /* FF1+ */
                box-sizing: border-box; /* Chrome, IE8, Opera, Safari 5.1*/
            }

        </style>
        <link rel="stylesheet" href="<c:url value="/resources/modalStyles.css" />">
        <link rel="stylesheet" href="<c:url value="/resources/main.css" />">
        <link rel="icon" href="https://is4-ssl.mzstatic.com/image/thumb/Purple113/v4/b4/b0/a1/b4b0a1a8-433a-7e7d-ada3-ebe07e1f6fca/source/512x512bb.jpg">
    </head>
    <body>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.form/4.2.2/jquery.form.min.js" integrity="sha384-FzT3vTVGXqf7wRfy8k4BiyzvbNfeYjK+frTVqZeNDFl8woCbF0CYG6g2fMEFFo/i" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@8"></script>
        <script>
                    function addBlurListener(inp, number) {
                    console.info('Entré a la funcion');
                            inp.addEventListener("blur", function handler(e) {
                            console.info(($('#form' + number).serialize()) + " " + 'form' + number)
                                    $.ajax({
                                    type: "GET",
                                            url: '${pageContext.request.contextPath}/changeoportunidad',
                                            data: $('#form' + number).serialize(),
                                            success: function (data)
                                            {
                                            if (data == "Fallo") {
                                            $('#cantSave-container').show();
                                                    $("#cantSave").text("No se ha podido guardar el contenido de la fila: " + number + ". Problablemente ha terminado su sesión, intente recargar la página y volver a iniciar sesión.");
                                                    $('#row' + number).addClass('bg-danger');
                                                    $('#row' + number).css({"color":"white", "font-weight": "bold"});
                                                    $('#group-of-rows-' + number).addClass('bg-secondary');
                                                    $('#group-of-rows-' + number).css({"color":"white", "font-weight": "bold"});
                                                    $('#deleteButton' + number).css("color", "white");
                                            }

                                            else{
                                            $('#row' + number).removeClass('font-weight-bold text-white bg-secondary');
                                            }
                                            },
                                            error: function (data) {
                                            $('#cantSave-container').show();
                                                    $("#cantSave").text("No se ha podido guardar el contenido de la fila: " + number + ". Problablemente ha terminado su sesión, intente recargar la página y volver a iniciar sesión.");
                                                    $('#row' + number).addClass('bg-danger');
                                                    $('#row' + number).css({"color":"white", "font-weight": "bold"});
                                                    $('#group-of-rows-' + number).addClass('bg-secondary');
                                                    $('#group-of-rows-' + number).css({"color":"white", "font-weight": "bold"});
                                                    $('#deleteButton' + number).css("color", "white");
                                            }
                                    });
                                    e.currentTarget.removeEventListener("blur", handler);
                            });
                    }

            function statusChange(inp, number) {
            if (inp.value == "logrado") {
            $('#congratulationModal').modal('toggle');
            }
            if (inp.value == "no_logrado") {
            $('#searchingModal').modal('toggle');
            }
            if (inp.value == "contrato") {
            $('#contratoModal').modal('toggle');
            }
            }
            function exportOportunidades() {
            $.ajax({
            type: "GET",
                    headers: {
                    'Accept': 'application/json'
                    },
                    url: '${pageContext.request.contextPath}/oportunidad/getAll',
                    data: $('#search-form').serialize() + "&" + $('#export-form').serialize(),
                    success: function (data)
                    {
                    let csvContent = "data:text/csv;charset=utf-8,";
                            let i = 0;
                            let firstRow = "Fecha de Creacion, Comprador, Vendedor, Titulo, Estatus, Monto Trans, Descripcion \r\n";
                            csvContent += firstRow;
                            for (var x in data) {
                    let row = data[i]['creationDate'];
                            if (data[i]['user']['display'] != null && data[i]['user']['display'] != "null"){
                    row += data[i]['user']['display'];
                    }

                    if (data[i]['customValues']['vendedor'] != null && data[i]['customValues']['vendedor'] != "null" && data[i]['customValues']['vendedor'] != ""){
                    row += "," + data[i]['customValues']['vendedor'];
                    }
                    else{
                    row += ",";
                    }
                    if (data[i]['customValues']['titulo'] != null && data[i]['customValues']['titulo'] != "null" && data[i]['customValues']['titulo'] != ""){
                    row += "," + data[i]['customValues']['titulo'];
                    }
                    else{
                    row += ",";
                    }
                    if (data[i]['customValues']['estatus'] != null && data[i]['customValues']['estatus'] != "null" && data[i]['customValues']['estatus'] != ""){
                    row += "," + data[i]['customValues']['estatus'];
                    }
                    else{
                    row += ",";
                    }
                    if (data[i]['customValues']['montoTrans'] != null && data[i]['customValues']['montoTrans'] != "null" && data[i]['customValues']['montoTrans'] != ""){
                    row += "," + data[i]['customValues']['montoTrans'];
                    }
                    else{
                    row += ",";
                    }
                    if (data[i]['customValues']['descripcion'] != null && data[i]['customValues']['descripcion'] != "null" && data[i]['customValues']['descripcion'] != ""){
                    row += "," + data[i]['customValues']['descripcion'];
                    }
                    else{
                    row += ",";
                    }
                    csvContent += row + "\r\n";
                            i++;
                    }
                    var encodedUri = encodeURI(csvContent);
                            var link = document.createElement("a");
                            link.setAttribute("href", encodedUri);
                            link.setAttribute("download", "oportunidades.csv");
                            document.body.appendChild(link);
                            link.click();
                    }

            })
            }
            function limpiarCampos(){
            $.noConflict();
                    jQuery('#search-form-empresa').val('');
                    jQuery('#search-form-desde').val("");
                    jQuery('#search-form-hasta').val("");
                    jQuery('#search-form-asesora').val('todos');
                    for (i = 1; i < 13; i++){
            jQuery('#search-form-box' + i).prop('checked', false);
            }
            }
            function checkSession(){
            $.ajax({
            type: "GET",
                    url: '${pageContext.request.contextPath}/checkAuth',
                    success: function (data)
                    {
                    console.info(data);
                            if (data == "Fallo"){
                    window.location.replace("https://puntotrans.herokuapp.com/");
                    }
                    },
                    error:function(data){
                    console.info("Error");
                            window.location.replace("https://puntotrans.herokuapp.com/");
                    }
            })
            }
            function deleteOportunidad(num, id){
                    var comprador = $('#compradorDisplay' + num).text();
                    var vendedor = $('#vendedor' + num).val();
                    var titulo = $('#titulo' + num).val();
                    var descripcion = $('#descripcion' + num).val();
                    console.info(id);
                    $('#deleteModal').modal('show');
                    $('#modalEliminarButton').click(function(){
                        $('#deleteModal').modal('hide');
                        $.ajax({
                        type: "DELETE",
                                url: '${pageContext.request.contextPath}/oportunidad/delete?id=' + id,
                                success: function (data)
                                {
                                    console.info(data)
                                if (data == "Fallo"){
                                        $('#cantSave-container').show();
                                        $("#cantSave").text("No se pudo eliminar el contenido de estam fila: " + num + ". Intente recargar la página y volver a intentarlo.");
                                        $('#row' + num).addClass('bg-danger');
                                        $('#row' + num).css({"color":"white", "font-weight": "bold"});
                                        $('#group-of-rows-' + num).addClass('bg-secondary');
                                        $('#group-of-rows-' + num).css({"color":"white", "font-weight": "bold"});
                                        $('#deleteButton' + num).css("color", "white");
                                }
                                if(data == "Exito"){
                                        Swal.fire(
                                                'Oportunidad borrada',
                                                '',
                                                'success'
                                                );
                                        $('#row' + num).css("display","none");
                                        $('#group-of-rows-' + num).css("display","none");
                                }
                                },
                                error:function(data){
                                $("#cantSave").text("No se pudo eliminar el contenido de estam fila: " + number + ". Intente recargar la página y volver a intentarlo.");
                                        $('#row' + num).addClass('bg-danger');
                                        $('#row' + num).css({"color":"white", "font-weight": "bold"});
                                        $('#group-of-rows-' + num).addClass('bg-secondary');
                                        $('#group-of-rows-' + num).css({"color":"white", "font-weight": "bold"});
                                        $('#deleteButton' + num).css("color", "white");
                                }
                        })
            })

                    $('#deleteModal').on('hidde.bs.modal', function(){
            $('#modalEliminarButton').off("click");
            })
                    $('#firstLineStrong').text('Comprador: ');
                    $('#secondLineStrong').text('Vendedor: ');
                    $('#thirdLineStrong').text('Titulo: ');
                    $('#innerFirstLineEliminar').text(" " + comprador);
                    $('#innerSecondLineEliminar').text(" " + vendedor);
                    if (typeof titulo != 'undefined'){
            $('#innerThirdLineEliminar').text(" " + titulo);
            }
            }
        </script>
        <c:if test="${isNull}">
            <div class="container">
                <div class="row justify content center">
                    <div class="alert alert-danger col-4" role="alert">La información ha retornado nula</div>
                </div>
            </div>
        </c:if> 
        <div class="container" style="display:none" id="cantSave-container">
            <div class="row justify content center">
                <div class="alert alert-danger col-4" id="cantSave" role="alert">No se ha podido guardar el contenido de la fila: </div>
            </div>
        </div>

        <!------------ Search Form ------------->
        <div class="container">
            <button class="btn btn-primary" data-toggle="collapse" data-target="#formulario"><i class="fas fa-arrow-down"></i></button>
            <div class="collapse" id="formulario">
                <form action="${pageContext.request.contextPath}/oportunidades" method="GET" id="search-form">
                    <div class="row">
                        <div class="col-3">
                            <div class="form-group">
                                <label for="empresa">Empresa</label>
                                <div class="autocomplete" style="width:255px;" >
                                    <input type="text" placeholder="${empresa!=null && empresa!=""?empresa:"Empresa (Pendiente de agregar!)"}" class="form-control" id="search-form-empresa" name="empresa" autocomplete="off" pattern="[E]{1}[0-9]{4}"/>
                                </div>
                            </div>
                        </div>
                        <div class="col-3">
                            <div class="form-group">
                                <label>Estatus</label>
                                <div class="dropdown">
                                    <button class="btn btn-default dropdown-toggle form-contro border" type="button" 
                                            id="dropdownMenu1" data-toggle="dropdown" 
                                            aria-haspopup="true" aria-expanded="true" style="p">
                                        Lista de Estatus
                                        <span class="caret "style="padding-left:100px;"></span>
                                    </button>
                                    <ul class="dropdown-menu checkbox-menu allow-focus" aria-labelledby="dropdownMenu1">
                                        <li class="${estatus.contains("prospecto")?"active":""}">
                                            <label>
                                                <input type="checkbox" value="prospecto"  name="option" ${estatus.contains("prospecto")?"checked":""} id="search-form-box1"> 1. Prospecto
                                            </label>
                                        </li>
                                        <li >
                                            <label>
                                                <input type="checkbox" class="${estatus.contains("cotizado")?"active":""}" value="cotizado" name="option" ${estatus.contains("cotizado")?"checked":""} id="search-form-box2"> 2. Cotizado
                                            </label>
                                        </li>
                                        <li >
                                            <label>
                                                <input type="checkbox" class="${estatus.contains("aprobado")?"active":""}" value="aprobado" name="option" ${estatus.contains("aprobado")?"checked":""} id="search-form-box3"> 3. Aprobado
                                            </label>
                                        </li>
                                        <li >
                                            <label>
                                                <input type="checkbox" class="${estatus.contains("entregado")?"active":""}" value="entregado" name="option" ${estatus.contains("entregado")?"checked":""} id="search-form-box4"> 4. Entregado
                                            </label>
                                        </li>
                                        <li >
                                            <label>
                                                <input type="checkbox" class="${estatus.contains("logrado")?"active":""}" value="logrado" name="option" ${estatus.contains("logrado")?"checked":""} id="search-form-box5"> 5. Logrado
                                            </label>
                                        </li>
                                        <li >
                                            <label>
                                                <input type="checkbox" class="${estatus.contains("no_logrado")?"active":""}" value="no_logrado" name="option" ${estatus.contains("no_logrado")?"checked":""} id="search-form-box6"> 6. No Logrado
                                            </label>
                                        </li>
                                        <li >
                                            <label>
                                                <input type="checkbox" class="${estatus.contains("contrato")?"active":""}" value="contrato" name="option" ${estatus.contains("contrato")?"checked":""} id="search-form-box7"> 7. Contrato
                                            </label>
                                        </li>
                                        <li >
                                            <label>
                                                <input type="checkbox" class="${estatus.contains("no_procede")?"active":""}" value="no_procede" name="option" ${estatus.contains("no_procede")?"checked":""} id="search-form-box8"> No Procede
                                            </label>
                                        </li>
                                        <li >
                                            <label>
                                                <input type="checkbox" class="${estatus.contains("pendiente")?"active":""}" value="pendiente" name="option" ${estatus.contains("pendiente")?"checked":""} id="search-form-box9"> Pendiente
                                            </label>
                                        </li>
                                        <li >
                                            <label>
                                                <input type="checkbox" class="${estatus.contains("realizado")?"active":""}" value="realizado" name="option" ${estatus.contains("realizado")?"checked":""} id="search-form-box10"> Realizado
                                            </label>
                                        </li>
                                        <li >
                                            <label>
                                                <input type="checkbox" class="${estatus.contains("suspendido")?"active":""} " value="suspendido" name="option" ${estatus.contains("suspendido")?"checked":""} id="search-form-box11"> Suspendido
                                            </label>
                                        </li>
                                        <li >
                                            <label>
                                                <input type="checkbox" class="${estatus.contains("confirmado")?"active":""}" value="confirmado" name="option" ${estatus.contains("confirmado")?"checked":""} id="search-form-box12"> Confirmado
                                            </label>
                                        </li>
                                    </ul>
                                </div>
                                <input type="hidden" id="search-estatus" value="" name="estatus">
                            </div>
                        </div>
                        <div class="col-3">
                            <label for="search-form-desde">Desde</label>
                            <input class="form-control" type="date" value="${desde}" id="search-form-desde" name="desde">
                        </div>
                        <div class="col-2"><button  type=button class="btn btn-secondary" value="Limpiar" style="margin-top:28px;" onclick="limpiarCampos()">Limpiar</button></div>
                    </div>
                    <div class="row">
                        <div class="col-3">
                            <div class="form-group">
                                <label for="asesoras">Asesoras</label>
                                <select path="asesora" name="asesora" class="form-control" id="search-form-asesora">
                                    <option value="C0872" ${asesora=="C0872"?"selected":""}>Amairini Castillo</option>
                                    <option value="C0952" ${asesora=="C0952"?"selected":""}>Rosa María Cerrato</option>
                                    <option value="C0951" ${asesora=="C0951"?"selected":""}>Victoria Alvarado</option>
                                    <option value="C0852" ${asesora=="C0852"?"selected":""}>Samantha Campos</option>
                                    <option value="C0823" ${asesora=="C0823"?"selected":""}>Karen Cubias</option>
                                    <option value="todos" ${asesora==null || asesora == "todos"?"selected":""}>Todos</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-3">
                            <div class="form-group">
                                <label for="grupos">Grupos</label>
                                <select class="form-control" name ="grupos" id="grupos" path="grupos">
                                    <option value="empresasb2c" ${grupo=="empresasb2c"?"selected":""}>EmpresasB2C</option>
                                    <option value="empresasb2b" ${grupo=="empresasb2b"?"selected":""}>EmpresasB2B</option>
                                    <option value="sucursalesb2c" ${grupo=="sucursalesb2c"?"selected":""}>SucursalesB2C</option>
                                    <option value="empresasboc" ${grupo=="empresasboc"?"selected":""}>EmpresasBOC</option>
                                    <option value="empresas_venta" ${grupo=="empresas_venta"?"selected":""}>Empresas Solo Ventas</option>
                                    <option value="todos" ${grupo==null || grupo=="todos"? "selected":""}>Todos</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-3">
                            <label for="form-search-hasta">Hasta</label>
                            <input class="form-control" type="date" value="${hasta}" id="search-form-hasta" name="hasta">
                        </div>
                        <div class="col-2" style="">
                            <button type="submit" class="btn btn-primary" style="margin-top:28px;">Buscar</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <!-----------Form Modal Button, Logout Button and Save Button -------------->
        <div>
            <a class="btn btn-primary float-left" href="${pageContext.request.contextPath}/logout" style="margin-left:3px; margin-bottom:1px;">Log out</a>          
            <button type="button" class="btn btn-primary float-right" data-toggle="modal" data-target="#formModal" style="margin-bottom:1px;;" onclick="checkSession()"><i class="fas fa-plus"></i> Agregar Oportunidad</button>
            <button class="btn btn-primary float-right" style="margin-right:5px; margin-bottom:1px;" data-toggle="modal" data-target="#exportModal"><i class="far fa-save"></i></button>
        </div>
        <!--------------Export Modal ------------------>
        <div id="exportModal" class="modal fade" role="dialog">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Exportar Oportunidades</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form action="${pageContext.request.contextPath}/todasLasOportundiades" method="GET" id="export-form">
                            <label for="maximoDeOportunidades">Cantidad máxima de registros a exportar:</label>
                            <input type="number" name="maximoDeOportunidades" id="maximoDeOportunidades" value="200" class="form-control">

                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                        <button type="button" class="btn btn-primary"  onclick="exportOportunidades()">Exportar Oportunidades</button>
                    </div>
                </div>
            </div>
        </div>     

        <!----------------Form Modal ------------------->
        <form action="${pageContext.request.contextPath}/addOportunidad" method="POST" id="addEmpresa">
            <div id="formModal" class="modal fade" role="dialog">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel">Crear Oportunidad</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <label for="tituloModal">Titulo <font color="red">*</font></label>
                            <input type="text" placeholder="Titulo" class="form-control" name="titulo" id="tituloModal" autocomplete="off" required/>
                            <label for="empresasForm">Empresa <font color="red">*</font></label>
                            <div class="row">
                                <div class="autocomplete col-12">
                                    <input type="text" placeholder="Empresa" class="form-control" name="empresa" id="empresasForm" autocomplete="off" pattern="[E]{1}[0-9]{4}" required title="Las sucursales no son permitidas. El formato de empresa debe comenzar con una E y debe tener 4 números después."/>
                                </div>
                            </div>
                            <label for="grupos">Estatus <font color="red">*</font></label>
                            <select class="form-control" id="estatus" path="estatus" name="estatus" required>
                                <option value="prospecto" selected>1. Prospecto</option>
                                <option value="cotizado">2. Cotizado</option>
                                <option value="aprobado">3. Aprobado</option>
                                <option value="entregado">4. Entregado</option>
                                <option value="logrado">5. Logrado</option>
                                <option value="no_logrado"}>6. No Logrado</option>
                                <option value="contrato">7. Contrato</option>
                                <option value="no_procede">No Procede</option>
                                <option value="pendiente">Pendiente</option>
                                <option value="realizado">Realizado</option>
                                <option value="suspendido">Suspendido</option>
                                <option value="confirmado">Confirmado</option>                                
                            </select>
                            <label for="vendedor">Vendedor</label>
                            <div class="row">
                                <div class="autocomplete col-12">
                                    <input type="text" placeholder="Vendedor" class="form-control" name="vendedor" id="vendedor" autocomplete="off" pattern="[E]{1}[0-9]{4}" title="Las sucursales no son permitidas. El formato de empresa debe comenzar con una E y debe tener 4 números después."/>
                                </div>
                            </div>
                            <label for="vendedor2">Vendedor 2</label>
                            <div class="row">
                                <div class="autocomplete col-12">
                                    <input type="text" placeholder="Vendedor2" class="form-control" name="vendedor2" id="vendedorModal2" autocomplete="off" pattern="[E]{1}[0-9]{4}" title="Las sucursales no son permitidas. El formato de empresa debe comenzar con una E y debe tener 4 números después."/>
                                </div>
                            </div>
                            <label for="descripcion">Descripcion</label>
                            <textarea class="form-control" placeholder="Descripcion" id="descripcion" form="addEmpresa" name="descripcion" rows="3"></textarea>
                            <label for="montoT">Monto T$</label>
                            <input type="number" placeholder="0.00" step=".01" class="form-control" id="montoT" name="montoT" />
                            <label for="notas">Notas</label>
                            <textarea class="form-control" placeholder="Notas" id="notas" form="addEmpresa" name="notas" rows="3"></textarea>
                        </div>
                        <div class="modal-footer">
                            <font color="red">* Valor requerido</font>
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                            <button type="submit" class="btn btn-primary" form="addEmpresa">Crear oportunidadad</button>
                        </div>
                    </div>
                </div>
            </div>     
        </form>
        <!---------------------------- Content's Table ------------------->
        <table class="table">
            <tr>
                <th width="2%"></th>
                <th width="8%">Fecha Creado</th>
                <th width="12%">Compra</th>
                <th width="17%">Vende</th>
                <th width="14%">Concepto</th>
                <th width="11%">Estatus</th>
                <th width="7%">Monto</th>
                <th width="37%">Observaciones</th>
            </tr>
            <% int indice = 0; %>
            <c:forEach items="${records}" var="record" varStatus="index">
                <% indice += 1;%>
                <form method="PUT" id="form${index.index+1}" action="${pageContext.request.contextPath}/changeoportunidad">
                    <tr class="clickable ${record.bandera?"font-weight-bold text-white bg-secondary":""}" data-toggle="collapse" data-target="#group-of-rows-${index.index+1}" id="row${index.index+1}">                
                        <td><!--<button type="button" style="${record.bandera?"color:black":"color:red"}" class="close" data-dismiss="modal" aria-label="Close" onclick="deleteOportunidad(${index.index+1},'${record.id}')" id="deleteButton${index.index+1}"><span aria-hidden="true">&times;</span></button>--></td>
                        <th>${record.creationDate}<input type="hidden" value="${record.id}" name="id" id="comprador${index.index+1}"></th>
                        <td ><span id="compradorDisplay${index.index+1}">${record.user.display}</span></td> 
                        <td ><div class="autocomplete input-table"><input type="text" name="vendedor" id="vendedor${index.index+1}" value="${record.customValues.vendedor}" class="form-control" autocomplete="off" onchange="addBlurListener(this,${index.index+1})" pattern="[E]{1}[0-9]{4}" title="Las sucursales no son permitidas. El formato de empresa debe comenzar con una E y debe tener 4 números después."/></div></td> 
                        <td ><input type="text"  class="form-control" value="${record.customValues.titulo}" id="titulo${index.index+1}" name="titulo" onchange="addBlurListener(this,${index.index+1})"></td>
                        <td class="select-td" > 
                            <select class="form-control" id="estatus${index.index+1}" name="estatus" onchange="addBlurListener(this,${index.index+1});
                                                statusChange(this,${index.index+1});">
                                <option value="no_procede"${record.customValues.estatus=="no_procede"?"selected":""}>No Procede</option>
                                <option value="pendiente"${record.customValues.estatus=="pendiente"?"selected":""}>Pendiente</option>
                                <option value="realizado"${record.customValues.estatus=="realizado"?"selected":""}>Realizado</option>
                                <option value="suspendido"${record.customValues.estatus=="suspendido"?"selected":""}>Suspendido</option>
                                <option value="confirmado" ${record.customValues.estatus=="confirmado"?"selected":""}>Confirmado</option>
                                <option value="prospecto"${record.customValues.estatus=="prospecto"?"selected":""}>1. Prospecto</option>
                                <option value="cotizado"${record.customValues.estatus=="cotizado"?"selected":""}>2. Cotizado</option>
                                <option value="aprobado"${record.customValues.estatus=="aprobado"?"selected":""}>3. Aprobado</option>
                                <option value="entregado"${record.customValues.estatus=="entregado"?"selected":""}>4. Entregado</option>
                                <option value="logrado"${record.customValues.estatus=="logrado"?"selected":""}>5. Logrado</option>
                                <option value="no_logrado"${record.customValues.estatus=="no_logrado"?"selected":""}>6. No Logrado</option>
                                <option value="contrato"${record.customValues.estatus=="contrato"?"selected":""}>7. Contrato</option>
                            </select>
                        </td>
                        <td ><input type="text" value="${record.customValues.montoTrans}" class="form-control" id="monto${index.index+1}" name="montoTrans" onchange="addBlurListener(this,${index.index+1})"></td>
                        <td ><textarea rows="${record.customValues.rowsDescripcion}" class="form-control" id="descripcion${index.index+1}" name="descripcion" onchange="addBlurListener(this,${index.index+1})">${record.customValues.descripcion}</textarea></td>
                    </tr>    
                    <tr id="group-of-rows-${index.index+1}" class="collapse">
                        <td></td>
                        <td></td><th>Vendedor2:</th>
                        <td><input type="text" value="${record.customValues.vendedor2}" class="form-control" id="vendedorSegundo${index.index+1}" autocomplete="off" name="vendedor2" onchange="addBlurListener(this,${index.index+1})"></td>
                        <td></td><td></td><th>Notas:</th>
                        <td><textarea rows="2" class="form-control" id="notas${index.index+1}" name="notas" onchange="addBlurListener(this,${index.index+1})">${record.customValues.notas}</textarea></td>
                    </tr>
                </form>
            </c:forEach>
            <td/><td/><td/><td/><td/><td/><td><h5><strong>$${total}</strong></h5></td><td/>
        </table>
        <c:if test="${empty records}">
            <div class="container">
                <div class="row justify content center">
                    <div class="alert alert-danger col-6 " role="alert">La busqueda no ha retornado registros. Vuelva a intentarlo cambiando los parametros</div>
                </div>
            </div>
        </c:if>

        <div><em class="float-left">Resultados devueltos: ${totalCount==null?0:totalCount} oportunidades. </em></div>
        <!------------- Pagination ------------->
        <div class="text-center center-text" style="width: 20%; margin: 0 auto;">           
            <nav aria-label="...">
                <ul class="pagination">
                    <c:if test="${currentPage>0}">
                        <li class="page-item">  
                            <a class="page-link" href="${prevPage}">Anterior</a>
                        </li>
                    </c:if>
                    <c:if test="${currentPage==0}">
                        <li class="page-item disabled">
                            <span class="page-link">Anterior</span>
                        </li>
                    </c:if>
                    <li class="page-item ${currentPage==0?'active':''}"> 
                        ${currentPage==0?'<span class="page-link">':firstLink}
                        ${currentPage==0?'1':hasNextPage==false?currentPage-1:currentPage} 
                        ${currentPage==0?'<span class="sr-only">(current)</span></span>':'</a>'}
                    </li>
                    <c:if test="${pageCount>1}">
                        <li class="page-item ${currentPage!=0 && hasNextPage==true ?'active':''}">
                            ${ currentPage!=0 && hasNextPage==true ?'<span class="page-link">':secondLink}
                            ${currentPage==0?'2':hasNextPage==false?currentPage:currentPage+1}
                            ${currentPage!=0 && hasNextPage==true ?'<span class="sr-only">(current)</span></span>':'</a>'}    
                        </li>
                    </c:if>
                    <c:if test="${pageCount>2}">
                        <li class="page-item ${currentPage==(pageCount-1)?'active':''}">
                            ${currentPage==(pageCount-1)?'<span class="page-link">':thirdLink}
                            ${currentPage==0?'3':currentPage==(pageCount-1)?currentPage+1:currentPage+1+1}
                            ${currentPage==(pageCount-1)?'<span class="sr-only">(current)</span></span>':'</a>'} 
                        </li>
                    </c:if>
                    <c:if test="${currentPage==pageCount-1 || pageCount == 0}">
                        <li class="page-item disabled">
                            <a class="page-link" >Siguiente</a>
                        </li>
                    </c:if>
                    <c:if test="${currentPage<pageCount-1}">
                        <li class="page-item">
                            <a class="page-link" href="${nextPage}">Siguiente</a>
                        </li>
                    </c:if>

                </ul>
            </nav>
        </div>
        <!----------- Confirm Delete Oportunidad Modal -------->

        <div id="deleteModal" class="modal fade" role="dialog">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="labelEliminar">Eliminar Registro</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body center-block text-center">
                        <div>Está segur@ de que quiere eliminar este registro?</div>
                        <div id="firstLineEliminar"><strong id="firstLineStrong"></strong><div id="innerFirstLineEliminar"></div></div>
                        <div id="secondLineEliminar"><strong id="secondLineStrong"></strong><div id="innerSecondLineEliminar"></div></div>
                        <div id="thirdLineEliminar"><strong id="thirdLineStrong"></strong><div id="innerThirdLineEliminar"></div></div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                        <button type="button" class="btn btn-danger"  id="modalEliminarButton">Eliminar</button>
                    </div>
                </div>
            </div>
        </div>
        <!----------- Confirm Delete Oportunidad Modal -------->

        <div id="loadingDeleteModal" class="modal fade" role="dialog">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body center-block text-center">                       
                        <div class="spinner-border text-danger" role="status">
  <span class="sr-only">Loading...</span>
</div>

                    </div>
                    <div class="modal-footer">
                    </div>
                </div>
            </div>
        </div>
        <!------------Ship Congratulation Modal ----------->
        <div class="modal fade" id="searchingModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header" class="center-text text-center">
                        <h5>No todas las oportunidades terminan como esperamos, pero la siguiente est&aacute vuelta de la esquina. <font style="color:red;">Continua buscando ${username}!</font></h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close" style="color:red;">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body" id="modalBody" style="padding-top:200px;padding-bottom:100px;">
                        <div class="seaContainer">
                            <div class="submarine__container">
                                <div class="light"></div>
                                <div class="submarine__periscope"></div>
                                <div class="submarine__periscope-glass"></div>
                                <div class="submarine__sail">
                                    <div class="submarine__sail-shadow dark1">
                                    </div>
                                    <div class="submarine__sail-shadow light1"></div>
                                    <div class="submarine__sail-shadow dark2"></div>
                                </div>
                                <div class="submarine__body">
                                    <div class="submarine__window one">

                                    </div>
                                    <div class="submarine__window two">

                                    </div>
                                    <div class="submarine__shadow-dark"></div>
                                    <div class="submarine__shadow-light"></div>
                                    <div class="submarine__shadow-arcLight"></div>
                                </div>
                                <div class="submarine__propeller">
                                    <div class="propeller__perspective">
                                        <div class="submarine__propeller-parts darkOne"></div>
                                        <div class="submarine__propeller-parts lightOne"></div>
                                    </div>        
                                </div>
                            </div>
                            <div class="bubbles__container">
                                <span class="bubbles bubble-1"></span>
                                <span class="bubbles bubble-2"></span>
                                <span class="bubbles bubble-3"></span>
                                <span class="bubbles bubble-4"></span>
                            </div>
                            <div class="ground__container">
                                <div class="ground ground1">
                                    <span class="up-1"></span>
                                    <span class="up-2"></span>
                                    <span class="up-3"></span>
                                    <span class="up-4"></span>
                                    <span class="up-5"></span>
                                    <span class="up-6"></span>
                                    <span class="up-7"></span>
                                    <span class="up-8"></span>
                                    <span class="up-9"></span>
                                    <span class="up-10"></span>
                                </div>
                                <div class="ground ground2">
                                    <span class="up-1"></span>
                                    <span class="up-2"></span>
                                    <span class="up-3"></span>
                                    <span class="up-4"></span>
                                    <span class="up-5"></span>
                                    <span class="up-6"></span>
                                    <span class="up-7"></span>
                                    <span class="up-8"></span>
                                    <span class="up-9"></span>
                                    <span class="up-10"></span>
                                    <span class="up-11"></span>
                                    <span class="up-12"></span>
                                    <span class="up-13"></span>
                                    <span class="up-14"></span>
                                    <span class="up-15"></span>
                                    <span class="up-16"></span>
                                    <span class="up-17"></span>
                                    <span class="up-18"></span>
                                    <span class="up-19"></span>
                                    <span class="up-20"></span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!------------ LOGRADO ----------->
        <div class="modal fade" id="congratulationModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header" class="center-text text-center">
                        <h5>Felicidades ${username}! Una oportunidad más a la bolsa. <font style="color:red;">Vamos por la siguiente!</font></h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close" style="color:red;">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body" id="modalBody" style="padding-top:200px;padding-bottom:100px;">
                        <section>
                            <div class='scene'>
                                <div class='scene_titanShadow'></div>
                                <div class='t_wrap'>
                                    <div class='scene_titan'>
                                        <div class='eyes'>
                                            <div class='eye eye--left'></div>
                                            <div class='eye eye--right'></div>
                                        </div>
                                    </div>
                                </div>
                                <div class='scene_saturn'>
                                    <div class='scene_saturn__face'>
                                        <div class='face_clip'>
                                            <div class='eye eye--left'></div>
                                            <div class='eye eye--right'></div>
                                            <div class='mouth'></div>
                                        </div>
                                    </div>
                                    <div class='scene_saturn__shadow'></div>
                                    <div class='scene_saturn__shadowRing'></div>
                                    <div class='scene_saturn__sparks'>
                                        <div class='spark'></div>
                                        <div class='spark'></div>
                                        <div class='spark'></div>
                                        <div class='spark'></div>
                                        <div class='spark'></div>
                                        <div class='spark'></div>
                                        <div class='spark'></div>
                                        <div class='spark'></div>
                                        <div class='spark'></div>
                                        <div class='spark'></div>
                                        <div class='spark'></div>
                                        <div class='spark'></div>
                                        <div class='spark'></div>
                                        <div class='spark'></div>
                                        <div class='spark'></div>
                                        <div class='spark'></div>
                                        <div class='spark'></div>
                                        <div class='spark'></div>
                                        <div class='spark'></div>
                                        <div class='spark'></div>
                                    </div>
                                    <div class='scene_saturn__ring'>
                                        <div class='small'>
                                            <div class='small_part'></div>
                                            <div class='small_part'></div>
                                            <div class='small_part'></div>
                                            <div class='small_part'></div>
                                            <div class='small_part'></div>
                                            <div class='small_part'></div>
                                            <div class='small_part'></div>
                                            <div class='small_part'></div>
                                            <div class='small_part'></div>
                                            <div class='small_part'></div>
                                            <div class='small_part'></div>
                                            <div class='small_part'></div>
                                            <div class='small_part'></div>
                                            <div class='small_part'></div>
                                            <div class='small_part'></div>
                                            <div class='small_part'></div>
                                            <div class='small_part'></div>
                                            <div class='small_part'></div>
                                            <div class='small_part'></div>
                                            <div class='small_part'></div>
                                            <div class='small_part'></div>
                                            <div class='small_part'></div>
                                            <div class='small_part'></div>
                                            <div class='small_part'></div>
                                            <div class='small_part'></div>
                                            <div class='small_part'></div>
                                            <div class='small_part'></div>
                                            <div class='small_part'></div>
                                            <div class='small_part'></div>
                                            <div class='small_part'></div>
                                            <div class='small_part'></div>
                                            <div class='small_part'></div>
                                            <div class='small_part'></div>
                                            <div class='small_part'></div>
                                            <div class='small_part'></div>
                                            <div class='small_part'></div>
                                            <div class='small_part'></div>
                                            <div class='small_part'></div>
                                            <div class='small_part'></div>
                                            <div class='small_part'></div>
                                        </div>
                                        <div class='layer'>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                        </div>
                                        <div class='layer'>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                        </div>
                                        <div class='layer'>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                            <div class='layer_part'></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </section>

                    </div>
                </div>
            </div>
        </div>



        <!------------ CONTRATO ----------->
        <div class="modal fade" id="contratoModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header" class="center-text text-center">
                        <h5>Una oportunidad cerrada, tras otra, tras otra... Esto es lo que significa para nosotros tener un contrato entre empresas de la red. <font style="color:red;">Felicidades ${username}!</font></h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close" style="color:red;">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body" id="modalBody" style="padding: 0px 0px 0px 0px;">

                        <div class="aquarium">
                            <div class="aquarium__table"></div>
                            <div class="aquarium__aquarium">
                                <div class="aquarium__water"></div>
                                <div class="aquarium__bubble"></div>
                                <div class="aquarium__bubble"></div>
                                <div class="aquarium__bubble"></div>
                                <div class="aquarium__bubble"></div>
                                <div class="aquarium__bubble"></div>
                                <div class="aquarium__bubble"></div>
                                <div class="aquarium__bubble"></div>
                                <div class="aquarium__bubble"></div>
                            </div>
                            <div class="aquarium__drops">
                                <div class="aquarium__drop"></div>
                                <div class="aquarium__water-column"></div>
                                <div class="aquarium__splash"></div>
                                <div class="aquarium__splash"></div>
                            </div>
                            <div class="aquarium__sponge-box">
                                <div class="aquarium__body">
                                    <div class="aquarium__body-stripe"></div>
                                    <div class="aquarium__body-hole"></div>
                                </div>
                                <div class="aquarium__face">
                                    <div class="aquarium__mouth"></div>
                                    <div class="aquarium__smile"></div>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>




        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
        <script>
                                    function autocomplete(inp, arr) {
                                    /*the autocomplete function takes two arguments,
                                     the text field element and an array of possible autocompleted values:*/
                                    var currentFocus;
                                            /*execute a function when someone writes in the text field:*/
                                            inp.addEventListener("input", function (e) {
                                            var a, b, i, val = this.value;
                                                    /*close any already open lists of autocompleted values*/
                                                    closeAllLists();
                                                    if (!val) {
                                            return false;
                                            }
                                            currentFocus = - 1;
                                                    /*create a DIV element that will contain the items (values):*/
                                                    a = document.createElement("DIV");
                                                    a.setAttribute("id", this.id + "autocomplete-list");
                                                    a.setAttribute("class", "autocomplete-items");
                                                    /*append the DIV element as a child of the autocomplete container:*/
                                                    this.parentNode.appendChild(a);
                                                    /*for each item in the array...*/
                                                    var resultados = 0;
                                                    for (i = 0; i < arr.length; i++) {
                                            if (resultados == 7) {
                                            break;
                                            }
                                            /*check if the item starts with the same letters as the text field value:*/
                                            if (arr[i].toUpperCase().includes(val.toUpperCase())) {
                                            /*create a DIV element for each matching element:*/
                                            b = document.createElement("DIV");
                                                    /*make the matching letters bold:*/
                                                    b.innerHTML = arr[i];
                                                    /*insert a input field that will hold the current array item's value:*/
                                                    b.innerHTML += "<input type='hidden' value='" + arr[i] + "'>";
                                                    /*execute a function when someone clicks on the item value (DIV element):*/
                                                    b.addEventListener("click", function (e) {
                                                    /*insert the value for the autocomplete text field:*/
                                                    inp.value = this.getElementsByTagName("input")[0].value;
                                                            /*close the list of autocompleted values,
                                                             (or any other open lists of autocompleted values:*/
                                                            closeAllLists();
                                                    });
                                                    a.appendChild(b);
                                                    resultados++;
                                            }
                                            }
                                            });
                                            /*execute a function presses a key on the keyboard:*/
                                            inp.addEventListener("keydown", function (e) {
                                            var x = document.getElementById(this.id + "autocomplete-list");
                                                    if (x)
                                                    x = x.getElementsByTagName("div");
                                                    if (e.keyCode == 40) {
                                            /*If the arrow DOWN key is pressed,
                                             increase the currentFocus variable:*/
                                            currentFocus++;
                                                    /*and and make the current item more visible:*/
                                                    addActive(x);
                                            } else if (e.keyCode == 38) { //up
                                            /*If the arrow UP key is pressed,
                                             decrease the currentFocus variable:*/
                                            currentFocus--;
                                                    /*and and make the current item more visible:*/
                                                    addActive(x);
                                            } else if (e.keyCode == 13) {
                                            /*If the ENTER key is pressed, prevent the form from being submitted,*/
                                            e.preventDefault();
                                                    if (currentFocus > - 1) {
                                            /*and simulate a click on the "active" item:*/
                                            if (x)
                                                    x[currentFocus].click();
                                            }
                                            }
                                            });
                                            function addActive(x) {
                                            /*a function to classify an item as "active":*/
                                            if (!x)
                                                    return false;
                                                    /*start by removing the "active" class on all items:*/
                                                    removeActive(x);
                                                    if (currentFocus >= x.length)
                                                    currentFocus = 0;
                                                    if (currentFocus < 0)
                                                    currentFocus = (x.length - 1);
                                                    /*add class "autocomplete-active":*/
                                                    x[currentFocus].classList.add("autocomplete-active");
                                            }
                                    function removeActive(x) {
                                    /*a function to remove the "active" class from all autocomplete items:*/
                                    for (var i = 0; i < x.length; i++) {
                                    x[i].classList.remove("autocomplete-active");
                                    }
                                    }
                                    function closeAllLists(elmnt) {
                                    /*close all autocomplete lists in the document,
                                     except the one passed as an argument:*/
                                    var x = document.getElementsByClassName("autocomplete-items");
                                            for (var i = 0; i < x.length; i++) {
                                    if (elmnt != x[i] && elmnt != inp) {
                                    x[i].parentNode.removeChild(x[i]);
                                    }
                                    }
                                    }
                                    /*execute a function when someone clicks in the document:*/
                                    document.addEventListener("click", function (e) {
                                    closeAllLists(e.target);
                                    });
                                    }
        </script>


        <script>
            var empresas = "";
                    jQuery.get('usuarios', function (data) {
                    empresas = data;
                            empresas = empresas.replace("[", "").replace("]", "");
                            var empresasSplitted = empresas.split(",");
                            for (i = 1; i < empresasSplitted.length; i++) {
                    empresasSplitted[i] = empresasSplitted[i].replace(" ", "");
                    }
                    autocomplete(document.getElementById("search-form-empresa"), empresasSplitted);
                            autocomplete(document.getElementById("empresasForm"), empresasSplitted);
                            autocomplete(document.getElementById("vendedor"), empresasSplitted);
                            autocomplete(document.getElementById("vendedorModal2"), empresasSplitted);
                            for (i = 1; i <= 40; i++) {
                    autocomplete(document.getElementById("vendedor" + i), empresasSplitted);
                    }
                    });</script>
        <script>
                    $.ajax({


                    }
                    )
        </script>
        <script>
                    $("#search-form").submit(function(){
            var arr = [];
                    $('input:checked[name="option"]').each(function(){
            arr.push($(this).val());
            });
                    $('#search-estatus').val(arr.join(','));
            });
                    $(".checkbox-menu").on("change", "input[type='checkbox']", function () {
            $(this).closest("li").toggleClass("active", this.checked);
            });
                    $(document).on('click', '.allow-focus', function (e) {
            e.stopPropagation();
            });
        </script>
    </body>
</html>


