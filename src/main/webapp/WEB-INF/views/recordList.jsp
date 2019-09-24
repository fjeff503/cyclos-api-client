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
        <link rel="stylesheet" href="<c:url value="../styles/Main.css" />">
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
            background-color: #f1f1f1;
            padding: 10px;
            font-size: 16px;
          }
          input[type=text] {
            background-color: #f1f1f1;
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
        </style>
        <link rel="icon" href="https://is4-ssl.mzstatic.com/image/thumb/Purple113/v4/b4/b0/a1/b4b0a1a8-433a-7e7d-ada3-ebe07e1f6fca/source/512x512bb.jpg">
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
                                    <input type="text" placeholder="${empresa!=null?empresa:"Empresa (Aún en construcción!!)"}" class="form-control" id="myInput" name="empresa" autocomplete="off"/>
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
               <!----------- Modal Button -------------->
        <div>
            <button type="button" class="btn btn-primary float-right" data-toggle="modal" data-target="#myModal" style="margin-bottom:0px;"><i class="fas fa-plus"></i> Agregar Oportunidad</button>
        </div>
                <!---------------- Modal ------------------->
                <form action="${pageContext.request.contextPath}/addOportunidad" method="POST" id="addEmpresa">
                   <div id="myModal" class="modal fade" role="dialog">
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
                            <input type="text" placeholder="Vendedor" class="form-control" name="vendedor" id="vendedor" autocomplete="off"/>
                            <label for="vendedor2">Vendedor 2</label>
                                <input type="text" placeholder="Vendedor2" class="form-control" name="vendedor2" id="vendedor2" autocomplete="off"/>
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
                <form method="PUT" id="form${index.index+1}" action="${pageContext.request.contextPath}/changeoportunidad">
                    <th contenteditable="false">${record.creationDate}<input type="hidden" value="${record.id}" name="id" name="id"></th>
                    <td contenteditable="false">${record.user.display}</td> 
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
            <c:if test="${empty records && test!=null}">
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
                <script src="http://code.jquery.com/jquery-latest.min.js"></script>
                <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
                <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
                <script>
                        function autocomplete(inp, arr) {
                         /*the autocomplete function takes two arguments,
                         the text field element and an array of possible autocompleted values:*/
                         var currentFocus;
                         /*execute a function when someone writes in the text field:*/
                         inp.addEventListener("input", function(e) {
                             var a, b, i, val = this.value;
                             /*close any already open lists of autocompleted values*/
                             closeAllLists();
                             if (!val) { return false;}
                             currentFocus = -1;
                             /*create a DIV element that will contain the items (values):*/
                             a = document.createElement("DIV");
                             a.setAttribute("id", this.id + "autocomplete-list");
                             a.setAttribute("class", "autocomplete-items");
                             /*append the DIV element as a child of the autocomplete container:*/
                             this.parentNode.appendChild(a);
                             /*for each item in the array...*/
                             for (i = 0; i < arr.length; i++) {
                               /*check if the item starts with the same letters as the text field value:*/
                               if (arr[i].substr(0, val.length).toUpperCase() == val.toUpperCase()) {
                                 /*create a DIV element for each matching element:*/
                                 b = document.createElement("DIV");
                                 /*make the matching letters bold:*/
                                 b.innerHTML = "<strong>" + arr[i].substr(0, val.length) + "</strong>";
                                 b.innerHTML += arr[i].substr(val.length);
                                 /*insert a input field that will hold the current array item's value:*/
                                 b.innerHTML += "<input type='hidden' value='" + arr[i] + "'>";
                                 /*execute a function when someone clicks on the item value (DIV element):*/
                                     b.addEventListener("click", function(e) {
                                     /*insert the value for the autocomplete text field:*/
                                     inp.value = this.getElementsByTagName("input")[0].value;
                                     /*close the list of autocompleted values,
                                     (or any other open lists of autocompleted values:*/
                                     closeAllLists();
                                 });
                                 a.appendChild(b);
                               }
                             }
                         });
                         /*execute a function presses a key on the keyboard:*/
                         inp.addEventListener("keydown", function(e) {
                             var x = document.getElementById(this.id + "autocomplete-list");
                             if (x) x = x.getElementsByTagName("div");
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
                                 if (x) x[currentFocus].click();
                               }
                             }
                         });
                         function addActive(x) {
                           /*a function to classify an item as "active":*/
                           if (!x) return false;
                           /*start by removing the "active" class on all items:*/
                           removeActive(x);
                           if (currentFocus >= x.length) currentFocus = 0;
                           if (currentFocus < 0) currentFocus = (x.length - 1);
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
                    jQuery.get('usuarios', function(data) {
                            empresas = data;
                            empresas = empresas.replace("[","").replace("]","");
                            var empresasSplitted = empresas.split(",");
                            for(i=1; i< empresasSplitted.length;i++){
                                empresasSplitted[i] = empresasSplitted[i].replace(" ","");
                            }
                            console.log(empresasSplitted);
                            autocomplete(document.getElementById("myInput"), empresasSplitted);
                            autocomplete(document.getElementById("empresasForm"), empresasSplitted);
                            autocomplete(document.getElementById("vendedor"), empresasSplitted);
                         });
                </script>
                
    </body>
</html>


