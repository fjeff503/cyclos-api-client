/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.puntotransacciones.service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.logging.Logger;
import javax.validation.constraints.NotNull;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.HttpClientBuilder;

/**
 *
 * @author Puntotransacciones
 */
public class SivaService {
    
    final String baseUrl="https://global.puntotransacciones.com/siva/run/";
    Logger l = Logger.getLogger("siva");
    
    public String validarInformacion(@NotNull String usuario,@NotNull String dui) throws UnsupportedEncodingException, IOException{
        char character = dui.charAt(8);
        dui = dui.substring(0,8)+"-"+character;
        l.info("DUI: "+dui);
        String url = baseUrl +"autenticar-miembro?username=" +URLEncoder.encode(usuario, "UTF-8") +"&dui="+URLEncoder.encode(dui, "UTF-8");
        HttpClient client = HttpClientBuilder.create().build();
        HttpGet request = new HttpGet(url);
        HttpResponse response = client.execute(request);
        
        if(response.getStatusLine().getStatusCode()!=200){
            int responseCode = response.getStatusLine().getStatusCode();
            l.info("Codigo de ejecución: "+responseCode);
            return "Error";
        }
        BufferedReader rd = new BufferedReader(
		new InputStreamReader(response.getEntity().getContent()));
        StringBuilder result = new StringBuilder();
	String line = "";
	while ((line = rd.readLine()) != null) {
		result.append(line);
	}
        l.info("Resultado del request: " + result.toString());
        return result.toString();
    }
    
    public String restaurarContra(@NotNull String contra, @NotNull String key) throws UnsupportedEncodingException, IOException{
        String url = baseUrl +"cambiar-contra?key=" +URLEncoder.encode(key, "UTF-8") +"&newPassword="+URLEncoder.encode(contra, "UTF-8");
        HttpClient client = HttpClientBuilder.create().build();
        HttpGet request = new HttpGet(url);
        HttpResponse response = client.execute(request);
        
        if(response.getStatusLine().getStatusCode()!=200){
            int responseCode = response.getStatusLine().getStatusCode();
            l.info("Codigo de ejecución: "+responseCode);
            return "Error";
        }
        BufferedReader rd = new BufferedReader(
		new InputStreamReader(response.getEntity().getContent()));
        StringBuilder result = new StringBuilder();
	String line = "";
	while ((line = rd.readLine()) != null) {
		result.append(line);
	}
        l.info("Resultado del request de cambio de password: " + result.toString());
        l.info(url);
        return result.toString();
        
    }

    public SivaService() {
    }
    
    
    
}
