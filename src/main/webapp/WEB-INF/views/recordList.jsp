<%-- 
    Document   : recordList
    Created on : 10/09/2019, 11:48:29 AM
    Author     : HP PC
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Oportunidades</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link rel="stylesheet" href="../styles/Main.css">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css" integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf" crossorigin="anonymous">
        <style>
            body{
                font-size:14px;
            }
        </style>
    </head>
    <body>
        <c:if test="${isNull}">
            <div class="container">
                <div class="row justify content center">
                    <div class="alert alert-danger col-4" role="alert">La información ha retornado nula</div>
                </div>
            </div>
        </c:if> 
        <c:if test="${cantSave}">
            <div class="container">
                <div class="row justify content center">
                    <div class="alert alert-danger col-4" role="alert">No se ha podido guardar el contenido de la fila: </div>
                </div>
            </div>
        </c:if> 
        <div class="container">
            <button class="btn btn-primary" data-toggle="collapse" data-target="#formulario"><i class="fas fa-arrow-down"></i></button>
            <div class="collapse" id="formulario">
                <form>
                    <div class="row">
                        <div class="col-4"
                             <div class="form-group">
                                <label for="asesoras">Asesoras</label>
                                <select class="form-control" id="asesoras">
                                    <option value="1043">Amairini Castillo</option>
                                    <option value=10365">Rosa María Cerrato</option>
                                    <option value="10936">Victoria Belloso</option>
                                    <option value="10087">Karen Cubias</option>
                                    <option value="todos" selected>Todos</option>
                                </select>
                            </div>
                            <div class="col-4">
                                <div class="form-group">
                                    <label for="grupos">Grupos</label>
                                    <select class="form-control" id="grupos">
                                        <option value="empresasb2c">EmpresasB2C</option>
                                        <option value=empresasb2b">EmpresasB2B</option>
                                        <option value="sucursalesb2c">SucursalesB2C</option>
                                        <option value="empresasboc">EmpresasBOC</option>
                                        <option value="empresas_cobros">Empresas en Cobros</option>
                                        <option value="empresas_inactivas">Empresas Inactivas</option>
                                        <option value="empresas_venta">Empresas Solo Ventas</option>
                                        <option value="sucursalesboc">Sucursales BOC</option>
                                        <option value="eduvigis">Sucursales Eduvigis</option>
                                        <option value="todos" selected>Todos</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                </form>
            </div>
        </div>
        <table class="table">
            <tr>
                <th>Index</th>
                <th>Compra</th>
                <th>Vende</th>
                <th>Concepto</th>
                <th style="padding-right: 90px;">Estatus</th>
                <th>Monto</th>
                <th>Observaciones</th>
            </tr>
            <% int indice = 0; %>
            <c:forEach items="${records}" var="record" varStatus="index">
                <% indice += 1;%>
                <tr>
                    <form>
                    <th contenteditable="true"><%=indice%></th>
                    <td contenteditable="true">${record.user.display}</td>
                    <td contenteditable="true">${record.customValues.vendedor}</td>
                    <td contenteditable="true">${record.customValues.titulo}</td>
                    <td class="select-td" > 
                        <select class="form-control" id="estatus">
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
                    <td contenteditable="true">${record.customValues.montoTrans}</td>
                    <td contenteditable="true">${record.customValues.descripcion}</td>
                    </form>
                </tr>
            </c:forEach>
        </table>

            <div class="text-center center-text" style="width: 20%; margin: 0 auto;">
                <nav aria-label="...">
                    <ul class="pagination">
                        <c:if test="${currentPage>0}">
                            <li class="page-item">
                                <span class="page-link">Anterior</span>
                            </li>
                        </c:if>
                        <c:if test="${currentPage==0}">
                            <li class="page-item disabled">
                                <span class="page-link">Anterior</span>
                            </li>
                        </c:if>
                        <li class="page-item ${currentPage==0?'active':''}"> 
                            ${currentPage==0?'<span class="page-link">':'<a class="page-link" href="#">'}
                                ${currentPage==0?'1':currentPage} 
                            ${currentPage==0?'<span class="sr-only">(current)</span></span>':'</a>'}
                        </li>
                        <c:if test="${pageCount>1}">
                        <li class="page-item ${currentPage<pageCount && currentPage!=0?'active':''}">
                                ${currentPage<pageCount && currentPage!=0?'<span class="page-link">':'<a class="page-link" href="#">'}
                                    ${currentPage==0?'2':currentPage+1}
                                ${currentPage<pageCount && currentPage!=0?'<span class="sr-only">(current)</span></span>':'</a>'}    
                        </li>
                        </c:if>
                        <c:if test="${pageCount>2}">
                        <li class="page-item ${currentPage==(pageCount-1)?'active':''}">
                            ${currentPage==(pageCount-1)?'<span class="page-link">':'<a class="page-link" href="#">'}
                                ${currentPage==0?'3':currentPage==(pageCount-1)?currentPage+1:currentPage+1+1}
                            ${currentPage==(pageCount-1)?'<span class="sr-only">(current)</span></span>':'</a>'} 
                        </li>
                        </c:if>
                            <c:if test="${currentPage==pageCount}">
                            <li class="page-item disabled">
                                <a class="page-link" href="#">Siguiente</a>
                            </li>
                        </c:if>
                        <c:if test="${currentPage<pageCount}">
                            <li class="page-item">
                                <a class="page-link" href="#">Siguiente</a>
                            </li>
                        </c:if>

                    </ul>
                </nav>
            </div>
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>

    </body>
</html>


