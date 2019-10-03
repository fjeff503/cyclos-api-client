/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.puntotransacciones.service;

import com.puntotransacciones.util.Encoder;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.HttpClientBuilder;

/**
 *
 * @author Puntotransacciones
 */
public class UserService {
     public String targetWP = "https://global.puntotransacciones.com/api";
     public Encoder encoder;
    public Logger l = Logger.getLogger("logger");

    public UserService() {
    }
    
    public String getUserUsername(String user, String pass) throws IOException{
        String httpRequestTargetWP = targetWP+"/users/self?fields=name";
         HttpClient client = HttpClientBuilder.create().build();
        HttpGet request = new HttpGet(httpRequestTargetWP);
        String encodedCred = encoder.encode64(user,pass);
        request.addHeader("Authorization", encodedCred);
        request.addHeader("Accept", "application/json");
         HttpResponse response = client.execute(request);
        BufferedReader rd = new BufferedReader(
		new InputStreamReader(response.getEntity().getContent()));
        StringBuilder result = new StringBuilder();
	String line = "";
	while ((line = rd.readLine()) != null) {
		result.append(line);
	}
        String stringResult = result.toString();
        String[] resultVector = stringResult.split("\"name\":\"");
        String[] resultVector2 = resultVector[1].split("\"");
        String[] resultVector3 = resultVector2[0].split(" ");
        return resultVector3[0];
    }
    
    public ArrayList<String> getUsers(String user, String pass) throws IOException{
        ArrayList<String> usuarios = new ArrayList();
        targetWP+="/users?fields=display&groups=empresas%2C%20sucursales&pageSize=999";
         HttpClient client = HttpClientBuilder.create().build();
        HttpGet request = new HttpGet(targetWP);
        String encodedCred = encoder.encode64(user,pass);
        request.addHeader("Authorization", encodedCred);
        request.addHeader("Accept", "application/json");
         HttpResponse response = client.execute(request);
        BufferedReader rd = new BufferedReader(
		new InputStreamReader(response.getEntity().getContent()));
        StringBuilder result = new StringBuilder();
	String line = "";
	while ((line = rd.readLine()) != null) {
		result.append(line);
	}
        String stringResult = result.toString();
        String[] firstVector = stringResult.split("\"display\":");
        for(int i=1;i<firstVector.length;i++){
            String empresa = firstVector[i].replace("\"", "");
            empresa = empresa.replace("},{", "");
            //empresa = new String(empresa.getBytes("ISO-8859-1"),"UTF-8");
            if(empresa.contains("E0772")){
                l.info(empresa);
            }
            usuarios.add(empresa);
        }
        targetWP = "https://global.puntotransacciones.com/api";
        return usuarios;
    }
}
