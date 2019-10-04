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
        <link rel="icon" href="https://is4-ssl.mzstatic.com/image/thumb/Purple113/v4/b4/b0/a1/b4b0a1a8-433a-7e7d-ada3-ebe07e1f6fca/source/512x512bb.jpg">
    </head>
    <body>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.form/4.2.2/jquery.form.min.js" integrity="sha384-FzT3vTVGXqf7wRfy8k4BiyzvbNfeYjK+frTVqZeNDFl8woCbF0CYG6g2fMEFFo/i" crossorigin="anonymous"></script>
        <script>
            function addBlurListener(inp, number) {
                console.info('Entré a la funcion');
                inp.addEventListener("blur", function handler(e) {
                    console.info(($('#form' + number).serialize()) + " " + 'form' + number)
                     $.ajax({
                             type: "GET",
                             url: '${pageContext.request.contextPath}/changeoportunidad',
                            data: $('#form' + number).serialize(), 
                            success: function(data)
                            {
                                if(data == "Fallo"){
                                    $('#cantSave-container').show();
                                    $("#cantSave").text("No se ha podido guardar el contenido de la fila: "+number+". Problablemente ha terminado su sesión, intente recargar la página y volver a iniciar sesión.");
                            }
                    }
                });                   
                  e.currentTarget.removeEventListener("blur", handler); 
                });
                
            }
            
            function statusChange(inp, number) {
                if (inp.value == "logrado") {
                    $('#congratulationModal').modal('toggle');
                }
                if(inp.value=="no_logrado"){
                    $('#searchingModal').modal('toggle');
            }
            if(inp.value=="contrato"){
                    $('#contratoModal').modal('toggle');
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
                <form action="${pageContext.request.contextPath}/oportunidades" method="GET">
                    <div class="row">
                        <div class="col-4">
                            <div class="form-group">
                                <label for="empresa">Empresa</label>
                                <div class="autocomplete" style="width:300px;" >
                                    <input type="text" placeholder="${empresa!=null?empresa:"Empresa (Pendiente de agregar!)"}" class="form-control" id="myInput" name="empresa" autocomplete="off"/>
                                </div>
                            </div>
                        </div>
                        <div class="col-4">
                            <div class="form-group">
                                <label for="estatus">Estatus</label>
                                <select class="form-control" id="estatus" path="estatus" name="estatus">
                                    <option value="no_procede"${estatus=="no_procede"?"selected":""}>No Procede</option>
                                    <option value="pendiente"${estatus=="pendiente"?"selected":""}>Pendiente</option>
                                    <option value="realizado"${estatus=="realizado"?"selected":""}>Realizado</option>
                                    <option value="suspendido"${estatus=="suspendido"?"selected":""}>Suspendido</option>
                                    <option value="confirmado" ${estatus=="confirmado"?"selected":""}>Confirmado</option>
                                    <option value="prospecto"${estatus=="prospecto"?"selected":""}>1. Prospecto</option>
                                    <option value="cotizado"${estatus=="cotizado"?"selected":""}>2. Cotizado</option>
                                    <option value="aprobado"${estatus=="aprobado"?"selected":""}>3. Aprobado</option>
                                    <option value="entregado"${estatus=="entregado"?"selected":""}>4. Entregado</option>
                                    <option value="logrado"${estatus=="logrado"?"selected":""}>5. Logrado</option>
                                    <option value="no_logrado"${estatus=="no_logrado"?"selected":""}>6. No Logrado</option>
                                    <option value="contrato"${estatus=="contrato"?"selected":""}>7. Contrato</option>
                                    <option value="todos"${estatus==null?"selected":""}>Todos</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-2"><input type="reset" class="btn btn-secondary" value="Limpiar" style="margin-top:28px;"/></div>
                    </div>
                    <div class="row">
                        <div class="col-4">
                            <div class="form-group">
                                <label for="asesoras">Asesoras</label>
                                <select path="asesora" name="asesora" class="form-control">
                                    <option value="C0872" ${asesora=="C0872"?"selected":""}>Amairini Castillo</option>
                                    <option value="C0952" ${asesora=="C0952"?"selected":""}>Rosa María Cerrato</option>
                                    <option value="C0951" ${asesora=="C0951"?"selected":""}>Victoria Belloso</option>
                                    <option value="C0823" ${asesora=="C0823"?"selected":""}>Karen Cubias</option>
                                    <option value="todos" ${asesora==null || asesora == "todos"?"selected":""}>Todos</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-4">
                            <div class="form-group">
                                <label for="grupos">Grupos</label>
                                <select class="form-control" name ="grupos" id="grupos" path="grupos">
                                    <option value="empresasb2c" ${grupo=="empresasb2c"?"selected":""}>EmpresasB2C</option>
                                    <option value="empresasb2b" ${grupo=="empresasb2b"?"selected":""}>EmpresasB2B</option>
                                    <option value="sucursalesb2c" ${grupo=="sucursalesb2c"?"selected":""}>SucursalesB2C</option>
                                    <option value="empresasboc" ${grupo=="empresasboc"?"selected":""}>EmpresasBOC</option>
                                    <option value="empresas_cobros" ${grupo=="empresas_cobros"?"selected":""}>Empresas en Cobros</option>
                                    <option value="empresas_inactivas" ${grupo=="empresas_inactivas"?"selected":""}>Empresas Inactivas</option>
                                    <option value="empresas_venta" ${grupo=="empresas_venta"?"selected":""}>Empresas Solo Ventas</option>
                                    <option value="sucursalesboc" ${grupo=="sucursalesboc"?"selected":""}>Sucursales BOC</option>
                                    <option value="eduvigis" ${grupo=="eduvigis"?"selected":""}>Sucursales Eduvigis</option>
                                    <option value="todos" ${grupo==null || grupo=="todos"? "selected":""}>Todos</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-2" style="">
                            <button type="submit" class="btn btn-primary" style="margin-top:28px;">Buscar</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <!-----------Form Modal Button and Logout Button -------------->
        <div>
            <a class="btn btn-primary float-left" href="${pageContext.request.contextPath}/logout">Log out</a>
            <button type="button" class="btn btn-primary float-right" data-toggle="modal" data-target="#formModal" style="margin-bottom:0px;"><i class="fas fa-plus"></i> Agregar Oportunidad</button>
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
                            <label for="grupos">Titulo <font color="red">*</font></label>
                            <input type="text" placeholder="Titulo" class="form-control" name="titulo" required/>
                            <label for="grupos">Empresa <font color="red">*</font></label>
                            <div class="row">
                                <div class="autocomplete col-12">
                                    <input type="text" placeholder="Empresa" class="form-control" name="empresa" id="empresasForm" autocomplete="off" required/>
                                </div>
                            </div>
                            <label for="grupos">Estatus <font color="red">*</font></label>
                            <select class="form-control" id="estatus" path="estatus" name="estatus" required>
                                <option value="no_procede">No Procede</option>
                                <option value="pendiente">Pendiente</option>
                                <option value="realizado">Realizado</option>
                                <option value="suspendido">Suspendido</option>
                                <option value="confirmado">Confirmado</option>
                                <option value="prospecto" selected>1. Prospecto</option>
                                <option value="cotizado">2. Cotizado</option>
                                <option value="aprobado">3. Aprobado</option>
                                <option value="entregado">4. Entregado</option>
                                <option value="logrado">5. Logrado</option>
                                <option value="no_logrado"}>6. No Logrado</option>
                                <option value="contrato">7. Contrato</option>
                            </select>
                            <label for="vendedor">Vendedor</label>
                            <div class="row">
                                <div class="autocomplete col-12">
                                    <input type="text" placeholder="Vendedor" class="form-control" name="vendedor" id="vendedor" autocomplete="off"/>
                                </div>
                            </div>
                            <label for="vendedor2">Vendedor 2</label>
                            <div class="row">
                                <div class="autocomplete col-12">
                            <input type="text" placeholder="Vendedor2" class="form-control" name="vendedor2" id="vendedorModal2" autocomplete="off"/>
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
                <th width="8%">Fecha Creado</th>
                <th width="12%">Compra</th>
                <th width="17%">Vende</th>
                <th width="14%">Concepto</th>
                <th width="11%"">Estatus</th>
                <th width="7%">Monto</th>
                <th width="39%">Observaciones</th>
            </tr>
            <% int indice = 0; %>
            <c:forEach items="${records}" var="record" varStatus="index">
                <% indice += 1;%>
                <form method="PUT" id="form${index.index+1}" action="${pageContext.request.contextPath}/changeoportunidad">
                <tr class="clickable" data-toggle="collapse" data-target="#group-of-rows-${index.index+1}">                
                    <th>${record.creationDate}<input type="hidden" value="${record.id}" name="id" id="comprador${index.index+1}"></th>
                    <td >${record.user.display}</td> 
                    <td ><div class="autocomplete input-table"><input type="text" name="vendedor" id="vendedor${index.index+1}" value="${record.customValues.vendedor}" class="form-control" autocomplete="off" onchange="addBlurListener(this,${index.index+1})" /></div></td> 
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
                        <td></td><th>Vendedor2:</th>
                        <td><input type="text" value="${record.customValues.vendedor2}" class="form-control" id="vendedorSegundo${index.index+1}" autocomplete="off" name="vendedor2" onchange="addBlurListener(this,${index.index+1})"></td>
                        <td></td><td></td><th>Notas:</th>
                        <td><textarea rows="2" class="form-control" id="notas${index.index+1}" name="notas" onchange="addBlurListener(this,${index.index+1})">${record.customValues.notas}</textarea></td>
                    </tr>
                </form>
        </c:forEach>
            <td/><td/><td/><td/><td/><td><h5><strong>$${total}</strong></h5></td><td/>
    </table>
    <c:if test="${empty records}">
        <div class="container">
            <div class="row justify content center">
                <div class="alert alert-danger col-6 " role="alert">La busqueda no ha retornado registros. Vuelva a intentarlo cambiando los parametros</div>
            </div>
        </div>
    </c:if>
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
                    ${currentPage==0?'1':currentPage} 
                    ${currentPage==0?'<span class="sr-only">(current)</span></span>':'</a>'}
                </li>
                <c:if test="${pageCount>1}">
                    <li class="page-item ${currentPage<pageCount && currentPage!=0?'active':''}">
                        ${currentPage<pageCount && currentPage!=0?'<span class="page-link">':secondLink}
                        ${currentPage==0?'2':currentPage+1}
                        ${currentPage<pageCount && currentPage!=0?'<span class="sr-only">(current)</span></span>':'</a>'}    
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
     <!-----------Error Saving Oportunidad Modal -------->
     
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
                                currentFocus = -1;
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
                                    if (currentFocus > -1) {
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
            autocomplete(document.getElementById("myInput"), empresasSplitted);
            autocomplete(document.getElementById("empresasForm"), empresasSplitted);
            autocomplete(document.getElementById("vendedor"), empresasSplitted);
            autocomplete(document.getElementById("vendedorModal2"), empresasSplitted);
            for (i = 1; i <= 40; i++) {
                autocomplete(document.getElementById("vendedor" + i), empresasSplitted);
            }
        });



    </script>

</body>
    </html>


