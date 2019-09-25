/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.puntotransacciones.service;

import com.puntotransacciones.util.Encoder;
import java.io.IOException;
import java.util.logging.Logger;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.HttpClientBuilder;

/**
 *
 * @author HP PC
 */
public class AuthenticationService {
    public String targetWP = "https://global.puntotransacciones.com/api";
    public Encoder encoder;
    public Logger logger = Logger.getLogger("logger");
    
    public boolean authenticateUser(String usuario, String pass) throws IOException{
        targetWP+="/auth";
        HttpClient client = HttpClientBuilder.create().build();
        HttpGet request = new HttpGet(targetWP);
        String encodedCred = encoder.encode64(usuario,pass);
        request.addHeader("Authorization", encodedCred);
        request.addHeader("Accept", "application/json");
       targetWP="https://global.puntotransacciones.com/api";
        HttpResponse response = client.execute(request);
        if(response.getStatusLine().getStatusCode()==200){
            return true;
        }
        else{
            return false;
        }
    }
    
}
