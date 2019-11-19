/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.puntotransacciones.controller;

import com.puntotransacciones.service.SivaService;
import java.io.IOException;
import java.util.logging.Logger;
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
    Logger l = Logger.getLogger("siva");
    private SivaService sivaService = new SivaService();
    
    @RequestMapping("/siva")
    public ModelAndView passwordResetHome(HttpServletRequest request){
        ModelAndView mv = new ModelAndView();
        if(request.getSession().getAttribute("hasError") != null){
            if((boolean) request.getSession().getAttribute("hasError")){
                request.getSession().setAttribute("hasError", false);
                mv.addObject("hasError",true);
            }
        }
        if(request.getSession().getAttribute("SessionTimeout")!=null){
            if((boolean) request.getSession().getAttribute("SessionTimeout")){
                request.getSession().setAttribute("SessionTimeout",false);
                mv.addObject("SessionTimeout",true);
            }
        }
        mv.setViewName("sivaReset");
        return mv;
    }
    
    @RequestMapping(value="/siva/reset",method = RequestMethod.POST)
    public ModelAndView passwordReset(HttpServletRequest request, HttpServletResponse response, @RequestParam(name="dui") String dui, @RequestParam(name="usuario") String usuario) throws IOException{
        ModelAndView mv = new ModelAndView();
        String respuesta = sivaService.validarInformacion(usuario, dui);
        if(respuesta.equals(usuario)){
            request.getSession().setAttribute("usuario", usuario);
            mv.setViewName("passwordReset");
            return mv;
        }
        l.info("Respuesta del servidor " + respuesta);
        request.getSession().setAttribute("hasError", true);
        response.sendRedirect(request.getContextPath()+"/siva");
        return null;
    }
    
    @RequestMapping(value="/siva/attempt-reset")
    public ModelAndView attemptReset(HttpServletRequest request, HttpServletResponse response) throws IOException{
        
        String contra = (String) request.getParameter("contra");
        String contra2 = (String) request.getParameter("contra2");
        if(request.getSession().getAttribute("usuario")==null){
            response.sendRedirect(request.getContextPath()+"/siva");
            return null;
        }
        else if(contra != null && contra2 != null){
            if(!contra.equals(contra2)){
                l.info("contra: "+contra+" Contra2: "+contra2);
                ModelAndView mv = new ModelAndView();
                mv.setViewName("passwordReset");
                mv.addObject("passwordNotEqual",true);
                return mv;
            }
        }
        request.getSession().setAttribute("restaurada", true);
        request.getSession().setAttribute("contra", contra);
        response.sendRedirect(request.getContextPath()+"/siva/restaurada");
        return null;
    }
    
    @RequestMapping(value="/siva/restaurada")
    public ModelAndView successfulReset(HttpServletRequest request, HttpServletResponse response) throws IOException{
        if(request.getSession().getAttribute("restaurada")!=null){
            if((boolean) request.getSession().getAttribute("restaurada")){
                String result = sivaService.restaurarContra((String) request.getSession().getAttribute("contra"), (String) request.getSession().getAttribute("usuario"));
                if(result.contains("Session Timeout")){
                    response.sendRedirect(request.getContextPath() + "/siva");
                    request.setAttribute("SessionTimeout", true);
                }
                request.getSession().setAttribute("restaurada",false);
                request.getSession().removeAttribute("usuario");
                ModelAndView mv = new ModelAndView();
                mv.setViewName("successfulReset");
                return mv;
            }
            else{
            response.sendRedirect(request.getContextPath()+"/siva");
            return null;
        }
        }

        response.sendRedirect(request.getContextPath()+"/siva");
            return null;
    }
    
}
