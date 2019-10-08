/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.puntotransacciones.controller;

import com.puntotransacciones.domain.userRecords.Oportunidad;
import com.puntotransacciones.service.UserRecordService;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author Puntotransacciones
 */
@Controller
public class RecordController {
    
    public UserRecordService userRecordService = new UserRecordService();
    public Logger l = Logger.getLogger("logger");
    
    @RequestMapping(value = "/oportunidades")
    public ModelAndView oportunidades(HttpServletRequest request, HttpServletResponse response) throws IOException{
        HttpSession sesion = request.getSession();
        String usuario = "";
        String password = "";
        if(sesion.getAttribute("usuario")==null || sesion.getAttribute("password")==null){
            response.sendRedirect(request.getContextPath()+"/");
        }
        else{
            usuario = (String) sesion.getAttribute("usuario");
            password = (String) sesion.getAttribute("password");
            
        }
        sesion.setMaxInactiveInterval(60*60*4);
        ModelAndView mv = new ModelAndView();
        mv.setViewName("recordList");
         
        String desde = (String)request.getParameter("desde");
        String hasta = (String)request.getParameter("hasta");
        String asesora = (String)request.getParameter("asesora");
        String empresa = (String)request.getParameter("empresa");
        String empresaCodigo = "";
        if(empresa != null){
            if(empresa.contains(" - ")){
                String[] empresaVector = empresa.split(" - ");
                empresa = empresaCodigo;
            }
        }
        Integer page = (request.getParameter("page")!=null?Integer.parseInt(request.getParameter("page")):null);
        String grupo = (String)request.getParameter("grupos");
        //String estatus = (String) request.getParameter("estatus");
        String estatus = (String) request.getParameter("estatus");
        l.info("Estatus: "+estatus);
         if("todos".equals(estatus)){
            estatus=null;
        }
        if(estatus!=null){
            if(estatus.contains("%2C")){
                estatus = estatus.replace("%2C", "%7C");
            }
            if(estatus.contains(",")){
                estatus = estatus.replace(",", "%7C");
            }
        }
        l.info( "grupo: "+grupo+" empresa: "+empresa+" asesoras: "+asesora + " Parameter map is empty: "+request.getParameterMap().get("asesora"));
        ArrayList<String> asesoras = new ArrayList();
        if(asesora != null){
            if(asesora!=""){
                if(!asesora.contains("todos")){
                    asesoras.add(asesora);
                }
            }
        }
        ArrayList grupos = new ArrayList();
        if(grupo != null && !grupo.contains("todos")){
            grupos.add(grupo);
        }
        UserRecordService.OportunidadesResponse oportunidadesResponse = userRecordService.getOportunidades(asesoras,page,grupos, usuario, password, estatus, desde, hasta);
        ArrayList<Oportunidad> oportunidades = oportunidadesResponse.oportunidades;
        Map<String, String> headers = oportunidadesResponse.headers;
        
        if(estatus!=null){
            if(estatus.contains("%7C")){
                estatus = estatus.replace("%7C", ",");
            }
        }
        //Adding Java objects
        if(oportunidades != null){
            //Adds objects according to items founded -  If no items are founded then void is returned to all the objects related to the user records list
            mv.addObject("records", oportunidades);
            mv.addObject("pageCount",Integer.parseInt(headers.get("X-Page-Count")));
            mv.addObject("currentPage", Integer.parseInt(headers.get("X-Current-Page")));
            mv.addObject("totalCount", Integer.parseInt(headers.get("X-Total-Count")));   
            mv.addObject("asesora", asesora);
            mv.addObject("grupo", grupo);
            mv.addObject("total", userRecordService.sumaDeOportunidades(oportunidades));
            mv.addObject("username",sesion.getAttribute("username"));
            Object temp =  (empresa!=null ? mv.addObject("empresa",empresa):"");
            mv.addObject("estatus",estatus);
            mv.addObject("desde",desde);
            mv.addObject("hasta",hasta);
            String uri = "";
            Boolean amperson = false;
            if(desde !=null && desde !="" && hasta!=null && hasta!=null){
                uri +="?desde="+desde+"&hasta="+hasta;
                amperson = true;
            }
            if( asesora != null && asesora!=""){
                if(amperson){
                    
                }
                else{
                uri +="?asesora="+asesora;
                amperson = true;}
            }
            if( grupo != null && grupo !=""){
                if(amperson){
                    uri+="&grupo="+grupo;
                }
                else{
                    uri+="?grupo="+grupo;
                }
            }
            if(empresa != null && empresa !=""){
                if(amperson){
                    empresa+="&empresa="+empresa;
                }
                else{
                    uri+="?empresa="+empresa;
                }
            }
            if(estatus!=null && estatus!="logrado"){
                if(amperson){
                    uri+="&estatus="+estatus;
                }
                else{
                    uri+="?estatus="+estatus;
                }
            }
            //Check the page and add links to the pagination buttons acordingly
            String htmlLink = "<a class=\"page-link\" href=\""+request.getContextPath()+"/oportunidades"+uri;
            if(Integer.parseInt(headers.get("X-Current-Page")) != 0){
                if(amperson){
                    if(Integer.parseInt(headers.get("X-Current-Page"))==Integer.parseInt(headers.get("X-Page-Count"))){
                           mv.addObject("firstLink", htmlLink+"&page="+(Integer.parseInt(headers.get("X-Current-Page"))-2)+"\">"); 
                           mv.addObject("secondLink", htmlLink+"&page="+(Integer.parseInt(headers.get("X-Current-Page"))-1)+"\">"); 
                           mv.addObject("thirdLink", htmlLink+"&page="+(Integer.parseInt(headers.get("X-Current-Page"))-0)+"\">"); 

                    }
                    else{
                        mv.addObject("firstLink", htmlLink+"&page="+(Integer.parseInt(headers.get("X-Current-Page"))-1)+"\">"); 
                        mv.addObject("secondLink", htmlLink+"&page="+(Integer.parseInt(headers.get("X-Current-Page"))-0)+"\">"); 
                        mv.addObject("thirdLink", htmlLink+"&page="+(Integer.parseInt(headers.get("X-Current-Page"))+1)+"\">"); 
                    }
                }
                else{
                    if(Integer.parseInt(headers.get("X-Current-Page"))==Integer.parseInt(headers.get("X-Page-Count"))){
                           mv.addObject("firstLink", htmlLink+"?page="+(Integer.parseInt(headers.get("X-Current-Page"))-2)+"\">"); 
                           mv.addObject("secondLink", htmlLink+"?page="+(Integer.parseInt(headers.get("X-Current-Page"))-1)+"\">"); 
                           mv.addObject("thirdLink", htmlLink+"?page="+(Integer.parseInt(headers.get("X-Current-Page"))-0)+"\">"); 
                }
                    else{
                        mv.addObject("firstLink", htmlLink+"?page="+(Integer.parseInt(headers.get("X-Current-Page"))-1)+"\">"); 
                        mv.addObject("secondLink", htmlLink+"?page="+(Integer.parseInt(headers.get("X-Current-Page"))-0)+"\">"); 
                        mv.addObject("thirdLink", htmlLink+"?page="+(Integer.parseInt(headers.get("X-Current-Page"))+1)+"\">"); 
                    }
                }
            }
             else{
                if(amperson){
                    mv.addObject("firstLink", htmlLink+"&page="+(Integer.parseInt(headers.get("X-Current-Page"))-0)+"\">"); 
                    mv.addObject("secondLink", htmlLink+"&page="+(Integer.parseInt(headers.get("X-Current-Page"))+1)+"\">"); 
                    mv.addObject("thirdLink", htmlLink+"&page="+(Integer.parseInt(headers.get("X-Current-Page"))+2)+"\">"); 
                }
                else{
                    mv.addObject("firstLink", htmlLink+"?page="+(Integer.parseInt(headers.get("X-Current-Page"))-0)+"\">"); 
                    mv.addObject("secondLink", htmlLink+"?page="+(Integer.parseInt(headers.get("X-Current-Page"))+1)+"\">"); 
                    mv.addObject("thirdLink", htmlLink+"?page="+(Integer.parseInt(headers.get("X-Current-Page"))+2)+"\">"); 
                }
            }
            if(amperson){
                mv.addObject("nextPage", request.getContextPath()+"/oportunidades"+uri+"&page="+(Integer.parseInt(headers.get("X-Current-Page"))+1));
                mv.addObject("prevPage",request.getContextPath()+"/oportunidades"+uri+"&page="+(Integer.parseInt(headers.get("X-Current-Page"))-1));
            }
            else{
                mv.addObject("nextPage",request.getContextPath()+"/oportunidades"+uri+"?page="+(Integer.parseInt(headers.get("X-Current-Page"))+1));
                mv.addObject("prevPage",request.getContextPath()+"/oportunidades"+uri+"?page="+(Integer.parseInt(headers.get("X-Current-Page"))-1));
            }
        }
        else{
            mv.addObject("isNull",true);
        }
        return mv;
    }
    @RequestMapping(value = "/addOportunidad", method = RequestMethod.POST)
    public void addRecord(HttpServletRequest request, HttpServletResponse response) throws IOException{
        HttpSession sesion = request.getSession();
        String usuario = (String) sesion.getAttribute("usuario");
        String password = (String) sesion.getAttribute("password");
        if(usuario==null || password==null){
            response.sendRedirect(request.getContextPath()+"/");
        }
        String titulo = request.getParameter("titulo");
        String empresa = request.getParameter("empresa");
        String vendedor = request.getParameter("vendedor");
        if(empresa.contains(" - ")){
            String[] empresaVector = empresa.split(" - ");
            empresa = empresaVector[0];
        }
        if(vendedor.contains(" - ")){
            String[] vendedorVector = vendedor.split(" - ");
            vendedor = vendedorVector[0];
        }
        String estatus = request.getParameter("estatus");

        String vendedor2 = request.getParameter("vendedor2");
        String descripcion = request.getParameter("descripcion");
        String montoT = request.getParameter("montoT");
        String notas = request.getParameter("notas");
        userRecordService.addOportunidad(usuario, password, empresa, titulo, estatus, vendedor, vendedor2, descripcion, montoT, notas);
        
        
        response.sendRedirect(request.getContextPath()+"/oportunidades");
    }
    
    @RequestMapping(value="/changeoportunidad", method=RequestMethod.GET)
    public void changeRecord(HttpServletRequest request, HttpServletResponse response) throws IOException{
        HttpSession sesion = request.getSession();
        if(sesion.getAttribute("usuario")==null || sesion.getAttribute("password")==null){
            response.sendRedirect(request.getContextPath()+"/");
        }
        else{
        String respuesta = userRecordService.putOportunidad((String)sesion.getAttribute("usuario"),(String) sesion.getAttribute("password"),(String) request.getParameter("id"),(String) request.getParameter("titulo"),(String) request.getParameter("estatus"),(String) request.getParameter("vendedor"),(String) request.getParameter("vendedor2"),(String) request.getParameter("descripcion"),(String) request.getParameter("montoTrans"),(String) request.getParameter("notas"));
        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(respuesta);
        }
    }
    
    @ResponseBody
    @RequestMapping(value="/oportunidad/getAll", method=RequestMethod.GET, produces=MediaType.APPLICATION_JSON_VALUE)
    public List<Oportunidad> getAllOportunidades(HttpServletRequest request, HttpServletResponse response) throws IOException{
        HttpSession sesion = request.getSession();
        if(sesion.getAttribute("usuario")==null || sesion.getAttribute("password")==null){
            response.sendRedirect(request.getContextPath());
        }
        ArrayList<String> asesoras = new ArrayList();
        String asesora = (String)request.getParameter("asesora");
        if(asesora != null){
            if(asesora!=""){
                if(!asesora.contains("todos")){
                    asesoras.add(asesora);
                }
            }
        }
        
        ArrayList<String> grupos = new ArrayList();
        String grupo = (String)request.getParameter("grupos");
        if(grupo != null && !grupo.contains("todos")){
            grupos.add(grupo);
        }
        String estatus = (String) request.getParameter("estatus");
        if("todos".equals(estatus)){
            estatus=null;
        }
        return userRecordService.getAllOportunidades((String)sesion.getAttribute("usuario"), (String) sesion.getAttribute("password"), asesoras, grupos,estatus , (String)request.getParameter("desde"), (String)request.getParameter("hasta"), (String)request.getParameter("maximoDeOportunidades"));
    }
    
}
