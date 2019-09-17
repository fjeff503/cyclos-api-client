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
import java.net.URLEncoder;
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
    public Logger l = Logger.getLogger("logger");
    public UserRecordService() {
    }
    
    public class OportunidadesResponse{
        public ArrayList<Oportunidad> oportunidades;
        public HashMap<String,String> headers;
        public OportunidadesResponse(){
        }
    }
    
    //UsernameAsesora debe ser el username!! (Ej. c0872 [Amairini])
     public OportunidadesResponse  getOportunidades(ArrayList<String> usernameAsesoras, Integer page, ArrayList<String> grupos, String usr, String pword) throws IOException{
        targetWP += "/general-records/oportunidades";
        Boolean amperson = false;
        if(page!=null){
            targetWP+="?page="+page;
            amperson = true;
        }
        if(usernameAsesoras!=null){
            if(!usernameAsesoras.isEmpty()){
                if(amperson){
                    targetWP+="&brokers=";
                }
                else{
                    targetWP+="?brokers=";
                    amperson=true;
                }

                for(int i=0; i<usernameAsesoras.size();i++){
                        if(i==0){
                            if(usernameAsesoras.get(0)==null){
                                targetWP+=null;
                            }
                            else{
                                targetWP+=usernameAsesoras.get(0);
                            }
                        }
                        else{
                            targetWP+="%2C"+usernameAsesoras.get(i) ;
                        }
                  }
            }
        }
        if(grupos!=null){
            if(!grupos.isEmpty()){
                if(amperson){
                    targetWP+="&groups=";
                }
                else{
                    targetWP+="?groups=";
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
        }
        
        HttpClient client = HttpClientBuilder.create().build();
        HttpGet request = new HttpGet(targetWP);
        String encodedCred = encoder.encode64(usr,pword);
        request.addHeader("Authorization", encodedCred);
        request.addHeader("Accept", "application/json");
        Logger logger = Logger.getLogger("logger");
                 logger.info( targetWP);
        HttpResponse response = client.execute(request);
        
        if(response.getStatusLine().getStatusCode()!=200){
            int responseCode = response.getStatusLine().getStatusCode();
            l.info("Codigo de ejecución: "+responseCode);
            l.info(targetWP);
            targetWP = "https://global.puntotransacciones.com/api";
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
            if(oportunidad.getCustomValues().getVendedor()!=null){
                if(oportunidad.getCustomValues().getVendedor().contains("E")){
                    String[] vendedor = oportunidad.getCustomValues().getVendedor().split("E", 2);
                    if(vendedor.length>1){
                        oportunidad.customValues.setVendedor("E"+vendedor[1]);
                    }
                
                }
                else if(oportunidad.getCustomValues().getVendedor().contains("C")){
                    String[] vendedor = oportunidad.getCustomValues().getVendedor().split("C", 2);
                    if(vendedor.length>1){
                        oportunidad.customValues.setVendedor("C"+vendedor[1]);
                        oportunidad.customValues.setVendedor(oportunidad.customValues.getVendedor().replace("Ã", "í"));
                    }
                    
                }
            }
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
        
       
        
    public String  estatusInterpreter(String id){
        if(id.equals("no_procede")){
            return "No Procede";
        }
        
        if(id.equals("pendiente")){
            return "Pendiente";
        }
        if(id.equals("realizado")){
            return "Realizado";
        }
        if(id.equals("suspendido")){
            return "Suspendido";
        }
        if(id.equals("confirmado")){
            return "Confirmado";
        }
        if(id.equals("prospecto")){
            return "1. Prospecto";
        }
        if(id.equals("cotizado")){
            return "2. Cotizado";
        }
        if(id.equals("aprobado")){
            return "3. Aprobado";
        }
        if(id.equals("entregado")){
            return "4. Entregado";
        }
        if(id.equals("logrado")){
            return "5. Logrado";
        }
        if(id.equals("no_logrado")){
            return "6. No Logrado";
        }
        if(id.equals("contrato")){
            return "7. Contrato";
        }
        return id;
    }
    
    
}
