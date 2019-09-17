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
import java.util.Map;
import java.util.logging.Logger;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author HP PC
 */
@Controller
public class MainController {
    
    public UserRecordService userRecordService = new UserRecordService();
    
    @RequestMapping(value = "/oportunidades")
    public ModelAndView oportunidades(HttpServletRequest request, HttpServletResponse response) throws IOException{
        
        ModelAndView mv = new ModelAndView();
        mv.setViewName("recordList");
         Logger logger = Logger.getLogger("logger");
        
        String[] asesoraVector = request.getParameterMap().get("asesora");
        String asesora = (String)request.getAttribute("asesora");
        if(asesoraVector !=null){
        if(asesoraVector.length>=1){
            asesora =  asesoraVector[0];
        }}
        String[] empresaVector = request.getParameterMap().get("empresa");
        String empresa = (String)request.getAttribute("empresa");
        if(empresaVector !=null){
            if(empresaVector.length>=1){
                if(empresaVector[0]!=null){
                    empresa = empresaVector[0];
                }
            }
        }
        String[] grupoVector = request.getParameterMap().get("grupos");
        Integer page = (Integer) request.getAttribute("page");
        String grupo = (String)request.getAttribute("grupos");
        if(grupoVector !=null){
            if(grupoVector.length>=1){
                if(grupoVector[0]!=null){
                        grupo = grupoVector[0];
            }
         }
        }
        logger.info( "grupo: "+grupo+" empresa: "+empresa+" asesoras: "+asesora + " Parameter map is empty: "+request.getParameterMap().get("asesora"));
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
        UserRecordService.OportunidadesResponse oportunidadesResponse = userRecordService.getOportunidades(asesoras,page,grupos, "uscript", "1234");
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
            mv.addObject("empresa",empresa);
        }
        else{
            mv.addObject("isNull",true);
        }
        //Adding JS objects
        
        return mv;
    }
    
    @RequestMapping(value="/")
    public ModelAndView indice(HttpServletRequest request){
        
       /* if(request.getSession()!=null){
            
        }
        else{
            request.
        }*/
        ModelAndView mv = new ModelAndView();
        mv.setViewName("index");
        return mv;
    }
    
    @RequestMapping(value="/getOportunidades")
    public void getOportunidades(HttpServletRequest request ){
          ArrayList<Integer> asesoras = (ArrayList<Integer>)request.getAttribute("asesoras");
          Integer page = (Integer) request.getAttribute("page");
          ArrayList<String> grupos = (ArrayList)request.getAttribute("grupos");
                      
}
    
}
