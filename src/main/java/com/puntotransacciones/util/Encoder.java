/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.puntotransacciones.util;

import java.util.Base64;

/**
 *
 * @author HP PC
 */
public class Encoder {

    public Encoder() {
    }
    
    
    
    //Encoder for user credentials
    public static String encode64(String usuario, String contra){
    String originalInput = usuario +":"+contra;
    String encodedString = Base64.getEncoder().encodeToString(originalInput.getBytes());
    String headerAuth = "Basic "+encodedString;
    return headerAuth;   
    }
}
