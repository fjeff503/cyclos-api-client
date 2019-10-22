package com.puntotransacciones.util;


import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.Properties;
import java.util.logging.Logger;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import org.apache.commons.io.FileUtils;




/**
 *
 * @author Edwin
 */
public class MailSender {
    public static String emailPagoRecibido(String to, String concepto,String usernameTo,String transAmount, 
            String transNum, String userNumFrom, String usernameFrom, String transactionURL ) throws IOException{
        StringBuilder contentBuilder = new StringBuilder();
                        try {
                            BufferedReader in = new BufferedReader(new FileReader("puntoTransPagoRecibido.html"));
                            String str;
                            while ((str = in.readLine()) != null) {
                                if(str.contains("{0}")){str = str.replace("{0}", usernameTo);}
                                if(str.contains("{1}")){str = str.replace("{1}", transAmount);}
                                if(str.contains("{2}")){str = str.replace("{2}", transNum);}
                                if(str.contains("{3}")){str = str.replace("{3}", userNumFrom);}
                                if(str.contains("{4}")){str = str.replace("{4}", usernameFrom);}
                                if(str.contains("global.puntotransacciones.com")){str = str.replace("global.puntotransacciones.com", transactionURL);}
                                contentBuilder.append(str);
                            }
                            in.close();
                        } catch (IOException e) {
                            Logger l = Logger.getLogger("l");
                            File file = new File(".");
                                    for(String fileNames : file.list()) l.info("File: "+fileNames);
                        }                       
        String mensaje = contentBuilder.toString();
        return sendEmail(to,mensaje);
    }
    public static String sendEmail (String to, String mensaje) throws IOException{
        final String username = "soporte@puntotransacciones.com";
	final String password = "PuntoT$pta";
        String respuesta;   
        Properties props = new Properties();
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.socketFactory.port", "465");
		props.put("mail.smtp.socketFactory.class",
				"javax.net.ssl.SSLSocketFactory");
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.port", "465");

		Session session = Session.getDefaultInstance(props,
			new javax.mail.Authenticator() {
                                @Override
				protected PasswordAuthentication getPasswordAuthentication() {
					return new PasswordAuthentication(username,password);
				}
			});
                
                	try {

			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress("soporte@puntotransacciones.com"));
			message.setRecipients(Message.RecipientType.TO,
					InternetAddress.parse(to));
			message.setSubject("Pago Recibido");
                        
                        
                        
			message.setContent(mensaje,"text/html; charset=utf-8");
			Transport.send(message);

			return "Email enviado";

		} catch (MessagingException e) {
                        return "Error enviando mensaje";

		}
                
    
                }
    
}

