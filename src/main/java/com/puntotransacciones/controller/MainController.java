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
             sesion.setAttribute("username", userService.getUserUsername(usuario, pass));
             users = userService.getUsers("uscript","1234");
            response.sendRedirect(request.getContextPath()+"/oportunidades");
        }
        else{
        
        response.sendRedirect(request.getContextPath()+"/");
        }
}
    
    @RequestMapping(value="/checkAuth")
    public String checkAuthentication(HttpServletRequest request, HttpServletResponse response){
        HttpSession sesion = request.getSession();
        if(sesion.getAttribute("user")==null || sesion.getAttribute("password")==null){
            return "Fallo";
        }
        return "Exito";
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
