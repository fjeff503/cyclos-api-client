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
    public ModelAndView oportunidades(HttpServletRequest request) throws IOException{
        ModelAndView mv = new ModelAndView();
        mv.setViewName("recordList");
        ArrayList<Integer> asesoras = (ArrayList<Integer>)request.getAttribute("asesoras");
        Integer page = (Integer) request.getAttribute("page");
        ArrayList<String> grupos = (ArrayList)request.getAttribute("grupos");
        UserRecordService.OportunidadesResponse oportunidadesResponse = userRecordService.getOportunidades(asesoras,page,grupos);
        ArrayList<Oportunidad> oportunidades = oportunidadesResponse.oportunidades;
        Map<String, String> headers = oportunidadesResponse.headers;
        if(oportunidades != null){
            mv.addObject("records", oportunidades);
            mv.addObject("pageCount",headers.get("X-Page-Count"));
            mv.addObject("currentPage", headers.get("X-Current-Page"));
            mv.addObject("totalCount", headers.get("X-Total-Count"));
            Logger l = Logger.getLogger("logger");
            l.info("X-Page-Count"+" : " +headers.get("X-Page-Count"));
            l.info("X-Current-Page"+" : " +headers.get("X-Current-Page"));
            l.info("X-Total-Count"+" : " +headers.get("X-Total-Count"));           
        }
        else{
            mv.addObject("isNull",true);
        }
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
