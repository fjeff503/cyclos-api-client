/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.puntotransacciones.controller;

import com.puntotransacciones.service.UserRecordService;
import java.io.IOException;
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
    
    @RequestMapping(value = "/oportunidades", method = RequestMethod.POST)
    public void addRecord(HttpServletRequest request, HttpServletResponse response) throws IOException{
        String titulo = request.getParameter("titulo");
        String estatus = request.getParameter("estatus");
        String vendedor = request.getParameter("vendedor");
        String vendedor2 = request.getParameter("vendedor2");
        String montoT = request.getParameter("montoT");
        String notas = request.getParameter("notas");
        
        response.sendRedirect("/oportunidades");
    } 
    
}
