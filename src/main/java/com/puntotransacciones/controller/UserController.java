/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.puntotransacciones.controller;

import static com.puntotransacciones.controller.MainController.users;
import java.io.IOException;
import java.util.logging.Logger;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 *
 * @author Puntotransacciones
 */
@Controller
public class UserController {
    
    public Logger l = Logger.getLogger("logger");
    @RequestMapping(value="/usuarios")
    public void getUsuarios(HttpServletResponse response, HttpServletRequest request) throws IOException{
        
        if(users != null && !users.isEmpty()){
            response.setContentType("text/plain");
            response.setCharacterEncoding("UTF-8");
            l.info("Usuarios retornados:" + users.toString()); 
            response.getWriter().write(users.toString());
        }
        
    }
    
    
}
