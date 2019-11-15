package com.puntotransacciones.controller;

import com.puntotransacciones.util.MailSender;
import java.io.IOException;
import java.util.logging.Logger;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class MessageController
{
        /*@RequestMapping(value="sendEmail", method=RequestMethod.GET)
        public void sendMsg(){
            Logger l = Logger.getLogger("l");
            l.info("Entré al controller");
            
        }*/
        
	@RequestMapping(value="sendEmail" , method= RequestMethod.GET)
        @ResponseBody
	public String sendMsg(@RequestParam("to") String to,@RequestParam("tipo") String tipo, 
                @RequestParam("nameTo") String nameTo,
                @RequestParam ("transactAmount") String transactAmount, 
                @RequestParam("transactNum") String transactNum,@RequestParam("userNumFrom") String userNumFrom,
                @RequestParam("userToName") String userToName, @RequestParam("entryPoint") String entryPoint) throws IOException
	{
            Logger l = Logger.getLogger("l");
            l.info("Entré al controller");
                if(tipo.equals("pagoRecibido")||tipo.equals("pagorecibido")){
		String output = "Respuesta : " + 
                        MailSender.emailPagoRecibido(to, tipo, nameTo, transactAmount, transactNum, userNumFrom, userToName, entryPoint);
                return "Success";
                }
		//Simply return the parameter passed as message
		return "Fail";
	}
}
