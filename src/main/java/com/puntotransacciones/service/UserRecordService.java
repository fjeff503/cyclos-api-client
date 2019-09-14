/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.puntotransacciones.service;

import com.google.gson.Gson;
import com.puntotransacciones.domain.userRecords.CustomValues;
import com.puntotransacciones.domain.userRecords.Oportunidad;
import com.puntotransacciones.domain.userRecords.User;
import com.puntotransacciones.util.Encoder;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.Base64;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Logger;
import javax.ws.rs.client.Client;
import javax.ws.rs.client.ClientBuilder;
import javax.ws.rs.client.Invocation;
import javax.ws.rs.client.WebTarget;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import org.apache.http.Header;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.json.JSONArray;
import org.json.JSONObject;

/**
 *
 * @author HP PC
 */
public class UserRecordService {
    
    public String targetWP = "https://global.puntotransacciones.com/api";
    public Encoder encoder;

    public UserRecordService() {
    }
    
    public class OportunidadesResponse{
        public ArrayList<Oportunidad> oportunidades;
        public HashMap<String,String> headers;
        public OportunidadesResponse(){
        }
    }
    
    //UsernameAsesora debe ser el username!! (Ej. c0872 [Amairini])
     public OportunidadesResponse  getOportunidades(ArrayList<Integer> usernameAsesoras, Integer page, ArrayList<String> grupos) throws IOException{
        targetWP += "/general-records/oportunidades";
        Boolean amperson = false;
        if(page!=null){
            targetWP+="?page="+page;
            amperson = true;
        }
        if(usernameAsesoras!=null){
            if(amperson){
                targetWP+="&brokers=";
            }
            else{
                targetWP+="?brokers=";
                amperson=true;
            }
            for(int i=0; i<usernameAsesoras.size();i++){
                    if(i==0){
                    targetWP+=usernameAsesoras.get(0);}
                    else{
                        targetWP+="%2C"+usernameAsesoras.get(i);
                    }
                }
        }
        if(grupos!=null){
            if(amperson){
                targetWP+="&groups=";
            }
            else{
                targetWP="?brokers=";
                amperson = true;
            }
            for(int i=0; i<grupos.size();i++){
                    if(i==0){
                    targetWP+=grupos.get(0);}
                    else{
                        targetWP+="%2C"+grupos.get(i);
                    }
                }            
        }
        
        HttpClient client = HttpClientBuilder.create().build();
        HttpGet request = new HttpGet(targetWP);
        String encodedCred = encoder.encode64("uscript","1234");
        request.addHeader("Authorization", encodedCred);
        request.addHeader("Accept", "application/json");
        
        HttpResponse response = client.execute(request);
        
        if(response.getStatusLine().getStatusCode()!=200){
            Logger l = Logger.getLogger("logger");
            int responseCode = response.getStatusLine().getStatusCode();
            l.info("Codigo de ejecución: "+responseCode);
            l.info(targetWP);
            return null;
        }
        BufferedReader rd = new BufferedReader(
		new InputStreamReader(response.getEntity().getContent()));
        StringBuilder result = new StringBuilder();
	String line = "";
	while ((line = rd.readLine()) != null) {
		result.append(line);
	}
        
        JSONArray responseArray = new JSONArray(result.toString());
        
        int size = responseArray.length();
        targetWP = "https://global.puntotransacciones.com/api";
        ArrayList<Oportunidad> oportunidades = new ArrayList();
        for(int i=0;i<size;i++){
            JSONObject oportunidadJson = responseArray.getJSONObject(i);
            Gson gson = new Gson();
            Oportunidad oportunidad = gson.fromJson(oportunidadJson.toString(), Oportunidad.class);
            oportunidades.add(oportunidad);
        }
        HashMap<String,String> headersMap = new HashMap();
        Header[] headers = response.getAllHeaders();
        for(Header header:headers){
             if("X-Page-Count".equals(header.getName()) || "X-Current-Page".equals(header.getName()) || "X-Total-Count".equals(header.getName()) ){
                 headersMap.put(header.getName(), header.getValue());
             }
        }
        OportunidadesResponse respuesta = new OportunidadesResponse();
        respuesta.headers=headersMap;
        respuesta.oportunidades=oportunidades;
        return respuesta;
    }  
        
       
        
    
    
    
}
