/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.puntotransacciones.service;

import com.google.gson.Gson;
import com.puntotransacciones.util.Encoder;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.logging.Logger;
import org.apache.http.Header;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.web.client.HttpClientErrorException;
import com.puntotransacciones.domain.userRecords.Oportunidad;
import java.net.ProtocolException;
import java.nio.charset.StandardCharsets;
import java.time.LocalDate;
import java.time.Period;
import java.time.temporal.ChronoUnit;
import org.apache.http.client.methods.HttpDelete;
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

        public OportunidadesResponse(ArrayList<Oportunidad> oportunidades, HashMap<String, String> headers) {
            this.oportunidades = oportunidades;
            this.headers = headers;
        }
        
    }
    
    //UsernameAsesora debe ser el username!! (Ej. c0872 [Amairini])
     public OportunidadesResponse  getOportunidades(ArrayList<String> usernameAsesoras, Integer page, ArrayList<String> grupos, String username, String password, String estatus, String desde, String hasta) throws IOException{
        String targetGetOportunidades = targetWP+ "/general-records/oportunidades";
        Boolean amperson = false;
        if(page!=null){
            targetGetOportunidades+="?page="+page;
            amperson = true;
        }
        if(usernameAsesoras!=null){
            if(!usernameAsesoras.isEmpty()){
                if(amperson){
                    targetGetOportunidades+="&brokers=";
                }
                else{
                    targetGetOportunidades+="?brokers=";
                    amperson=true;
                }

                for(int i=0; i<usernameAsesoras.size();i++){
                        if(i==0){
                            if(usernameAsesoras.get(0)==null){
                                targetGetOportunidades+=null;
                            }
                            else{
                                targetGetOportunidades+=usernameAsesoras.get(0);
                            }
                        }
                        else{
                            targetGetOportunidades+="%2C"+usernameAsesoras.get(i) ;
                        }
                  }
            }
        }
        if(grupos!=null){
            if(!grupos.isEmpty()){
                if(amperson){
                    targetGetOportunidades+="&groups=";
                }
                else{
                    targetGetOportunidades+="?groups=";
                    amperson = true;
                }
                for(int i=0; i<grupos.size();i++){
                        if(i==0){
                        targetGetOportunidades+=grupos.get(0);}
                        else{
                            targetGetOportunidades+="%2C"+grupos.get(i);
                        }
                    }
            }
        }
        if(estatus!=null){
            if(amperson){
                targetGetOportunidades+="&customFields=reg_estatus:"+estatus;
            }
            else{
                targetGetOportunidades+="?customFields=reg_estatus:"+estatus;
                amperson = true;
            }
        }
        if(desde!=null && hasta!=null && desde!="" && hasta!=""){
            if(amperson){
                targetGetOportunidades+="&creationPeriod="+desde+"T00%3A00%3A01%2C"+hasta+"T23%3A59%3A59";
            }
            else{
                targetGetOportunidades+="?creationPeriod="+desde+"T00%3A00%3A01%2C"+hasta+"T23%3A59%3A59";
            }
        }
        l.info(targetGetOportunidades);
        HttpClient client = HttpClientBuilder.create().build();
        HttpGet request = new HttpGet(targetGetOportunidades);
        String encodedCred = encoder.encode64(username,password);
        request.addHeader("Authorization", encodedCred);
        request.addHeader("Accept", "application/json");
        HttpResponse response = client.execute(request);
        
        if(response.getStatusLine().getStatusCode()!=200){
            int responseCode = response.getStatusLine().getStatusCode();
            l.info("Codigo de ejecución: "+responseCode);
            l.info(targetGetOportunidades);
            return new OportunidadesResponse(null,null);
        }
        BufferedReader rd = new BufferedReader(
		new InputStreamReader(response.getEntity().getContent(), StandardCharsets.UTF_8));
        StringBuilder result = new StringBuilder();
	String line = "";
	while ((line = rd.readLine()) != null) {
		result.append(line);
	}
        
        JSONArray responseArray = new JSONArray(result.toString());
        
        int size = responseArray.length();
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
            //Agregamos las filas que tomará las oportunidades para desplegarlas en el front end
            oportunidad.customValues.rowsDescripcion = 2;
            if(oportunidad.customValues.getDescripcion()!=null){
                if(oportunidad.customValues.getDescripcion()!=""){
                    oportunidad.customValues.rowsDescripcion = (oportunidad.customValues.getDescripcion().length()>100?3:2);
                }
            }
            //Limpiamos la asesora para que quede solo su inicial
            if(oportunidad.user.display != null){
                oportunidad.user.display += "("+ oportunidad.createdBy.getDisplay().substring(0, 1).toUpperCase()+ ")";
            }
            //Normalizamos el formato de la fecha
            if(oportunidad.getCreationDate()!=null){
                String[] tempVector = oportunidad.getCreationDate().split("T");
                String[] tempVector2 = tempVector[0].split("-");
                oportunidad.setCreationDate(tempVector2[2]+"-"+tempVector2[1]+"-"+tempVector2[0]);
                String estadoTexto = "contrato logrado no_logrado";
                //filtro de los 3 estados(contrato, logrado, no_logrado)
                 	if (oportunidad.lastModificationDate != null) {                   
                 		String[] tempVector3 = oportunidad.lastModificationDate.split("T");
                 		LocalDate localDate = LocalDate.now();
                 		LocalDate fecha_creacion = localDate.parse(tempVector[0]);
                 		LocalDate fecha_modificacion = localDate.parse(tempVector3[0]); 
                		
                	
                
                	 if (ChronoUnit.DAYS.between(fecha_modificacion, localDate) > 2 && ChronoUnit.DAYS.between(fecha_creacion, localDate)  < 60 && !(estadoTexto.contains(oportunidad.customValues.getEstatus()) )) {                   
                   		oportunidad.bandera = true; 
                	 } 
                         else {
                 		oportunidad.bandera = false;
                	 } 
                 }
                        else{
                                    LocalDate fecha_creacion = LocalDate.parse(tempVector[0]);
                 		LocalDate localDate = LocalDate.now();
                            if(!(estadoTexto.contains(oportunidad.customValues.getEstatus())) && (ChronoUnit.DAYS.between(fecha_creacion, localDate) > 2)){
                                oportunidad.bandera=true;
                            }
                            else{
                            oportunidad.bandera=false;
                            }
                        }
                        
            }
            oportunidad.customValues.setDescripcion(oportunidad.customValues.getDescripcion());
            oportunidades.add(oportunidad);
        }
        
        //Conseguimos los headers del resultado
        HashMap<String,String> headersMap = new HashMap();
        Header[] headers = response.getAllHeaders();
        for(Header header:headers){
             if("X-Page-Count".equals(header.getName()) || "X-Current-Page".equals(header.getName()) || "X-Total-Count".equals(header.getName())  || "X-Has-Next-Page".equals(header.getName()) ){
                 headersMap.put(header.getName(), header.getValue());
             }
        }
        
        //Creamos una respuesta con los headers incluidos
        OportunidadesResponse respuesta = new OportunidadesResponse();
        respuesta.headers=headersMap;
        respuesta.oportunidades=oportunidades;
        return respuesta;
    }
     
     public ArrayList<Oportunidad> getAllOportunidades(String username, String password, ArrayList<String> usernameAsesoras, ArrayList<String> grupos, String estatus, String desde, String hasta, String maximoOportunidades) throws IOException{
         if(maximoOportunidades == null || maximoOportunidades == "0"){
             maximoOportunidades = "200";
         }
         
         targetWP+="/general-records/oportunidades?pageSize="+maximoOportunidades;
         targetWP+="&"+"fields=customValues.reg_estatus%2CcustomValues.descripcion%2CcustomValues.vendedor%2CcustomValues.montotrans%2CcustomValues.notas%2Cuser.display%2CcreationDate%2CcustomValues.vendedor2";
        if(usernameAsesoras!=null){
            if(!usernameAsesoras.isEmpty()){
                    targetWP+="&brokers=";
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
                    targetWP+="&groups=";
                for(int i=0; i<grupos.size();i++){
                        if(i==0){
                        targetWP+=grupos.get(0);}
                        else{
                            targetWP+="%2C"+grupos.get(i);
                        }
                    }
            }
        }
        if(estatus!=null){
                targetWP+="&customFields=reg_estatus:"+estatus;            
        }
        if(desde!=null && hasta!=null && !desde.equals("") && !hasta.equals("")){
                targetWP+="&creationPeriod="+desde+"T00%3A00%3A01%2C"+hasta+"T23%3A59%3A59";
        }
          l.info(targetWP);
        HttpClient client = HttpClientBuilder.create().build();
        HttpGet request = new HttpGet(targetWP);
        String encodedCred = encoder.encode64(username,password);
        request.addHeader("Authorization", encodedCred);
        request.addHeader("Accept", "application/json");
        HttpResponse response = client.execute(request);
        
        if(response.getStatusLine().getStatusCode()!=200){
            int responseCode = response.getStatusLine().getStatusCode();
            l.info("Codigo de ejecución: "+responseCode + " Estatus:"+response.getStatusLine().getReasonPhrase());
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
            //Agregamos las filas que tomará las oportunidades para desplegarlas en el front end
            oportunidad.customValues.rowsDescripcion = 2;
            if(oportunidad.customValues.getDescripcion()!=null){
                if(oportunidad.customValues.getDescripcion()!=""){
                    oportunidad.customValues.rowsDescripcion = (oportunidad.customValues.getDescripcion().length()>100?3:2);
                }
            }
            //Normalizamos el formato de la fecha
            if(oportunidad.getCreationDate()!=null){
                String[] tempVector = oportunidad.getCreationDate().split("T");
                String[] tempVector2 = tempVector[0].split("-");
                oportunidad.setCreationDate(tempVector2[2]+"-"+tempVector2[1]+"-"+tempVector2[0]);                
            }
            oportunidades.add(oportunidad);
        }
        
        return oportunidades;
     }
     
     public Integer getOportunidadVersion(String username, String pass, String id) throws IOException{
         String getOportunidadWP = targetWP+"/records/"+id+"/data-for-edit";
         HttpClient client = HttpClientBuilder.create().build();
        HttpGet request = new HttpGet(getOportunidadWP);
        String encodedCred = encoder.encode64(username,pass);
        request.addHeader("Authorization", encodedCred);
        request.addHeader("Accept", "application/json");
        HttpResponse httpResponse = client.execute(request);
        l.info(httpResponse.getStatusLine().getStatusCode() + " : "+httpResponse.getStatusLine().getReasonPhrase());
          BufferedReader rd = new BufferedReader(new InputStreamReader(httpResponse.getEntity().getContent()));
        StringBuilder result = new StringBuilder();
        String line = "";
	while ((line = rd.readLine()) != null) {
		result.append(line);
	}
        JSONObject jsonResponse = new JSONObject(result.toString());
        
        int version = 0;
        Gson gson = new Gson();
        com.puntotransacciones.domain.userRecordsEdit.Oportunidad oportunidad = gson.fromJson(jsonResponse.toString(), com.puntotransacciones.domain.userRecordsEdit.Oportunidad.class);
        version = oportunidad.getRecord().getVersion();
         return version;
     }
     public String putOportunidad(String username, String pass, String id, String titulo, String estatus, String vendedor, String vendedor2, String descripcion, String montoT, String notas ) throws MalformedURLException, IOException{ 
        Integer version = getOportunidadVersion(username, pass, id);      
        
        String encodedCred = encoder.encode64(username,pass);
         String oportunidadWP = targetWP+"/records/"+id;
         String record = oportunidadPutJSONConstructor(titulo, estatus, cleanUserCode(vendedor), vendedor2, descripcion, montoT, notas, version);
           URL url = new URL (oportunidadWP);
           try{
           HttpURLConnection con = (HttpURLConnection)url.openConnection();
           con.setRequestMethod("PUT");
           con.setRequestProperty("Content-Type", "application/json; utf-8");
           con.setRequestProperty("Accept", "application/json");
           con.setRequestProperty("Authorization", encodedCred);
           con.setDoOutput(true);
           try(OutputStream os = con.getOutputStream()) {
                byte[] input = record.getBytes("utf-8");
                os.write(input, 0, input.length);           
            }
           catch(Exception e){
               l.info(e.getMessage());
           }
           try(BufferedReader br = new BufferedReader(
            new InputStreamReader(con.getInputStream(), "utf-8"))) {
              StringBuilder response = new StringBuilder();
              String responseLine = null;
              while ((responseLine = br.readLine()) != null) {
                  response.append(responseLine.trim());
              }
              
          }
           l.info("Respuesta del cambio: " + con.getResponseCode() );
           }
           catch(IOException e){
               l.info(e.getMessage());
               return "Fallo";
           }
           
         return "Exito";
     }
      
     public String deleteOportunidad(String username, String pass, String id) throws MalformedURLException, ProtocolException, IOException{
         String deleteWP = targetWP+"/records/"+id;
           HttpClient client = HttpClientBuilder.create().build();
         HttpDelete request = new HttpDelete(targetWP);
        String encodedCred = encoder.encode64(username,pass);
        URL url = new URL(deleteWP);
        HttpURLConnection httpCon = (HttpURLConnection) url.openConnection();
        httpCon.setDoOutput(true);
        httpCon.setRequestProperty(
        "Authorization", encodedCred );
        httpCon.setRequestProperty( "Accept", "application/json" );
        httpCon.setRequestMethod("DELETE");
        httpCon.connect();      
         if(httpCon.getResponseCode()!=204){
            int responseCode = httpCon.getResponseCode();
            l.info("Codigo de ejecución: "+responseCode );
            l.info(deleteWP);
            targetWP = "https://global.puntotransacciones.com/api";
            return "Fallo";
        }
         return "Exito";
     }
       public String addOportunidad(String username, String pass, String user, String titulo, String estatus, String vendedor, String vendedor2, String descripcion, String montoT, String notas) throws UnsupportedEncodingException, IOException{
           String record =  oportunidadJSONConstructor(titulo, estatus, vendedor, vendedor2, descripcion, montoT, notas);
           l.info(record);
           String oportunidadWP= targetWP+"/"+user+"/records/oportunidades";
           l.info(oportunidadWP);
           String encodedCred = encoder.encode64(username,pass);
           URL url = new URL (oportunidadWP);
           HttpURLConnection con = (HttpURLConnection)url.openConnection();
           con.setRequestMethod("POST");
           con.setRequestProperty("Content-Type", "application/json; utf-8");
           con.setRequestProperty("Accept", "application/json");
           con.setRequestProperty("Authorization", encodedCred);
           con.setDoOutput(true);
           try(OutputStream os = con.getOutputStream()) {
                byte[] input = record.getBytes("utf-8");
                os.write(input, 0, input.length);           
            }
           try(BufferedReader br = new BufferedReader(
            new InputStreamReader(con.getInputStream(), "utf-8"))) {
              StringBuilder response = new StringBuilder();
              String responseLine = null;
              while ((responseLine = br.readLine()) != null) {
                  response.append(responseLine.trim());
              }
              l.info(response.toString());
          }
          
           return "Exito";
       }
       
       
       
      public String cleanUserCode(String user){
          if(user.contains(" - ")){
              String[] userVector = user.split(" - ");
              return userVector[0];
          }
          return user;
      } 
       
       public Double sumaDeOportunidades(ArrayList<Oportunidad> oportunidades){
           Double suma = 0.0;
           for(Oportunidad oportunidad: oportunidades){
               try{
               suma+= Double.parseDouble(oportunidad.customValues.getMontoTrans());
               }
               catch(Exception e){
                   
               }
           }
           
           return suma;
       }
          public String oportunidadJSONConstructor(String titulo, String estatus, String vendedor, String vendedor2, String descripcion, String montoT, String notas){
            String oportunidadJSON = "";
            oportunidadJSON+="{\"customValues\":{";
            Boolean coma = false;
            if(titulo!=null && titulo!=""){
                oportunidadJSON+="\"titulo\":\""+titulo+"\"";
                coma=true;
            }
            if(estatus!=null && estatus!=""){
                if(coma){
                    oportunidadJSON+=",";
                }
                oportunidadJSON+="\"reg_estatus\":\""+estatus+"\"";
            }
            if(vendedor!=null && vendedor!=""){
                if(coma){
                    oportunidadJSON+=",";
                }
                oportunidadJSON+="\"vendedor\":\""+vendedor+"\"";
            }
            if(vendedor2!=null && vendedor2!=""){
                if(coma){
                    oportunidadJSON+=",";
                }
                oportunidadJSON+="\"vendedor2\":\""+vendedor2+"\"";
            }
            if(descripcion!=null && descripcion!=""){
                if(coma){
                    oportunidadJSON+=",";
                }
                oportunidadJSON+="\"descripcion\":\""+descripcion+"\"";
            }
            if(montoT!=null && montoT!=""){
                if(coma){
                    oportunidadJSON+=",";
                }
                oportunidadJSON+="\"montotrans\":"+montoT;
            }
            if(notas!=null && notas!=""){
                if(coma){
                    oportunidadJSON+=",";
                }
                oportunidadJSON+="\"notas\":\""+notas+"\"";
            }
            String version = null;
            if(version!=null){
                oportunidadJSON+="},\"version\":"+version+"}";
               
            }
            else{
                 oportunidadJSON+="}}";
            }
            oportunidadJSON = oportunidadJSON.replaceAll(System.getProperty("line.separator"), "\\\\n");
            l.info("Has (newLine): "+oportunidadJSON.contains("newLine"));
            l.info(oportunidadJSON);
        return oportunidadJSON;
        }
          
     public String oportunidadPutJSONConstructor(String titulo, String estatus, String vendedor, String vendedor2, String descripcion, String montoT, String notas, Integer version){
            if(titulo == null){titulo="";}
            if(estatus == null){estatus="1.prospecto";}
            if(vendedor== null){vendedor="";}
            if(vendedor2 == null){vendedor2="";}
            if(descripcion == null){descripcion="";}
            if(montoT.equals("")){montoT=null;}
            if(notas == null){notas="";}
            String oportunidadJSON = "";
            oportunidadJSON+="{\"customValues\":{";
            Boolean coma = false;
            oportunidadJSON+="\"titulo\":\""+titulo+"\"";
            oportunidadJSON+=",";
           oportunidadJSON+="\"reg_estatus\":\""+estatus+"\"";
           oportunidadJSON+=",";
           oportunidadJSON+="\"vendedor\":\""+vendedor+"\"";
           oportunidadJSON+=",";
           oportunidadJSON+="\"vendedor2\":\""+vendedor2+"\"";
           oportunidadJSON+=",";
           oportunidadJSON+="\"descripcion\":\""+descripcion+"\"";
           oportunidadJSON+=",";
           oportunidadJSON+="\"montotrans\":"+montoT;
           oportunidadJSON+=",";
           oportunidadJSON+="\"notas\":\""+notas+"\"";
           oportunidadJSON+="},\"version\":"+version+"}";
           oportunidadJSON = oportunidadJSON.replaceAll(System.getProperty("line.separator"), "\\\\n");
            l.info(oportunidadJSON);
            return oportunidadJSON;
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
