/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.puntotransacciones.controller;


import com.puntotransacciones.domain.userRecords.Oportunidad;
import com.puntotransacciones.service.AuthenticationService;
import com.puntotransacciones.service.UserRecordService;
import com.puntotransacciones.service.UserService;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Map;
import java.util.logging.Logger;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author HP PC
 */
@Controller
public class MainController {
    
    public UserRecordService userRecordService = new UserRecordService();
    public UserService userService = new UserService();
    public static ArrayList<String> users;
    public AuthenticationService authService = new AuthenticationService();
    public Logger logger = Logger.getLogger("logger");
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
        ModelAndView mv = new ModelAndView();
        mv.setViewName("recordList");
         
        
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
        String estatus = (String) request.getParameter("estatus");

        logger.info( "grupo: "+grupo+" empresa: "+empresa+" asesoras: "+asesora + " Parameter map is empty: "+request.getParameterMap().get("asesora"));
        ArrayList<String> asesoras = new ArrayList();
        if(asesora != null){
            if(asesora!=""){
                if(!asesora.contains("todos")){
                    asesoras.add(asesora);
                }
            }
        }
        if("todos".equals(estatus)){
            estatus=null;
        }
        logger.info(estatus);
        ArrayList grupos = new ArrayList();
        if(grupo != null && !grupo.contains("todos")){
            grupos.add(grupo);
        }
        UserRecordService.OportunidadesResponse oportunidadesResponse = userRecordService.getOportunidades(asesoras,page,grupos, usuario, password, estatus);
        ArrayList<Oportunidad> oportunidades = oportunidadesResponse.oportunidades;
        Map<String, String> headers = oportunidadesResponse.headers;
        //Adding Java objects
        if(oportunidades != null){
            //Adds objects according to items founded -  If no items are founded then void is returned to all the objects related to the user records list
            mv.addObject("records", oportunidades);
            mv.addObject("pageCount",Integer.parseInt(headers.get("X-Page-Count")));
            mv.addObject("currentPage", Integer.parseInt(headers.get("X-Current-Page")));
            mv.addObject("totalCount", Integer.parseInt(headers.get("X-Total-Count")));   
            mv.addObject("asesora", asesora);
            mv.addObject("grupo", grupo);
            Object temp =  (empresa!=null ? mv.addObject("empresa",empresa):"");
            mv.addObject("estatus",estatus);
            String uri = "";
            Boolean amperson = false;
            if( asesora != null && asesora!=""){
                uri +="?asesora="+asesora;
                amperson = true;
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
    
    @RequestMapping(value="/logout", method=RequestMethod.GET)
        public void logout(HttpServletRequest request, HttpServletResponse response) throws IOException{
        HttpSession session = request.getSession();
        if(session.getAttribute("user")!=null && session.getAttribute("password")!=null){
                session.removeAttribute("user");
                session.removeAttribute("password");
        }
        response.sendRedirect(request.getContextPath()+"/");
    }
    
    @RequestMapping(value="/auth")
    public void authentication(HttpServletRequest request, HttpServletResponse response, @RequestParam(name="usuario") String usuario, @RequestParam(name="pass") String pass) throws IOException{
        HttpSession sesion = request.getSession();
        if(sesion.getAttribute("user")!=null && sesion.getAttribute("password")!=null){
            response.sendRedirect(request.getContextPath()+"/oportunidades");
            users = userService.getUsers((String)sesion.getAttribute("user"),(String)sesion.getAttribute("password"));
        }
        
        if(authService.authenticateUser(usuario, pass)){
            sesion.setAttribute("usuario", usuario);
             sesion.setAttribute("password", pass);
             users = userService.getUsers("uscript","1234");
            response.sendRedirect(request.getContextPath()+"/oportunidades");
        }
        else{
        
        response.sendRedirect(request.getContextPath()+"/");
        }
}
    
    @RequestMapping(value="/")
    public ModelAndView indice(HttpServletRequest request, HttpServletResponse response) throws IOException{
        
       /* if(request.getSession()!=null){
            
        }
        else{
            request.
        }*/
        HttpSession sesion = request.getSession();
        if(sesion.getAttribute("user")!=null && sesion.getAttribute("password")!=null){
            response.sendRedirect(request.getContextPath()+"/oportunidades");
        }
        
        ModelAndView mv = new ModelAndView();
        mv.setViewName("index");
        return mv;
    }
    
    
}
