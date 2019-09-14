/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.puntotransacciones.domain.user;

/**
 *
 * @author HP PC
 */


public class EntityUser {
    public String id;
    public String shortDisplay;
    public String username;

    public EntityUser(String id, String shortDisplay, String username) {
        this.id = id;
        this.shortDisplay = shortDisplay;
        this.username = username;
    }

    public EntityUser() {
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getShortDisplay() {
        return shortDisplay;
    }

    public void setShortDisplay(String shortDisplay) {
        this.shortDisplay = shortDisplay;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }
    
    
    
    
}
