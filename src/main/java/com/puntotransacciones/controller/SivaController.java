/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.puntotransacciones.controller;

import com.puntotransacciones.service.SivaService;
import java.io.IOException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author Puntotransacciones
 */
@Controller
public class SivaController {
    
    private SivaService sivaService = new SivaService();
    
    @RequestMapping("/siva")
    public ModelAndView passwordResetHome(HttpServletRequest request){
        ModelAndView mv = new ModelAndView();
        String error = (String) request.getSession().getAttribute("hasError");
        request.getSession().removeAttribute("hasError");
        if(error != null){
            mv.addObject("hasError",true);
        }
        
        mv.setViewName("sivaReset");
        return mv;
    }
    
    @RequestMapping(value="/siva/reset",method = RequestMethod.POST)
    public ModelAndView passwordReset(HttpServletRequest request, HttpServletResponse response, @RequestParam(name="dui") String dui, @RequestParam(name="usuario") String usuario) throws IOException{
        ModelAndView mv = new ModelAndView();
        String respuesta = sivaService.validarInformacion(usuario, dui);
        if(respuesta.equals(usuario)){
            mv.setViewName("passwordReset");
            return mv;
        }
        request.getSession().setAttribute("hasError", true);
        response.sendRedirect(request.getContextPath()+"/siva");
        return null;
    }
    
}
