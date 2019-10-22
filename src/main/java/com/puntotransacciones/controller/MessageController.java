package com.puntotransacciones.controller;

import com.puntotransacciones.util.MailSender;
import java.io.IOException;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.core.Response;

@Path("/sendEmail")
public class MessageController
{
	@GET
	@Path("/{to}/{tipo}/{nameTo}/{transactAmount}/{transactNum}/{userNumFrom}/{userToName}/{entryPoint}")
	public Response sendMsg(@PathParam("to") String to,@PathParam("tipo") String tipo, @PathParam("nameTo") String nameTo,
                @PathParam ("transactAmount") String transactAmount, 
                @PathParam("transactNum") String transactNum,@PathParam("userNumFrom") String userNumFrom,
                @PathParam("userToName") String userToName, @PathParam("entryPoint") String entryPoint) throws IOException
	{       
                if(tipo.equals("pagoRecibido")||tipo.equals("pagorecibido")){
		String output = "Respuesta : " + 
                        MailSender.emailPagoRecibido(to, tipo, nameTo, transactAmount, transactNum, userNumFrom, userToName, entryPoint);
                return Response.status(200).entity(output).build();
                }
		//Simply return the parameter passed as message
		return Response.status(500).entity("Parametros Incorrectos").build();
	}
}
