/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.puntotransacciones.controller;

import com.puntotransacciones.service.UserRecordService;
import java.io.IOException;
import java.util.logging.Logger;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author Puntotransacciones
 */
@Controller
public class RecordController {
    
    public UserRecordService userRecordService = new UserRecordService();
    public Logger l = Logger.getLogger("logger");
    
    
    @RequestMapping(value = "/addOportunidad", method = RequestMethod.POST)
    public void addRecord(HttpServletRequest request, HttpServletResponse response) throws IOException{
        String titulo = request.getParameter("titulo");
        String empresa = request.getParameter("empresa");
        if(empresa.contains(" - ")){
            String[] empresaVector = empresa.split(" - ");
            empresa = empresaVector[0];
        }
        String estatus = request.getParameter("estatus");
        String vendedor = request.getParameter("vendedor");
        String vendedor2 = request.getParameter("vendedor2");
        String descripcion = request.getParameter("descripcion");
        String montoT = request.getParameter("montoT");
        String notas = request.getParameter("notas");
        
        userRecordService.addOportunidad("uscript", "1234", empresa, titulo, estatus, vendedor, vendedor2, descripcion, montoT, notas);
        
        
        response.sendRedirect(request.getContextPath()+"/oportunidades");
    }
    
    @RequestMapping(value="/changeoportunidad", method=RequestMethod.PUT)
    public void changeRecord(HttpServletRequest request, HttpServletResponse response){
        l.info("comprado: "+request.getParameter("comprador")+" vendedor: "+request.getParameter("vendedor")+" titulo:" + request.getParameter("titulo")+" estatus:" + request.getParameter("estatus") + "montoTrans: "+ request.getParameter("montoTrans")+" descripcion: "+request.getParameter("descripcion"));
        
    }  
}
