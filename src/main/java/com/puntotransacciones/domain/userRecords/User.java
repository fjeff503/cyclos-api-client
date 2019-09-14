
package com.puntotransacciones.domain.userRecords;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

public class User {

    @SerializedName("id")
    @Expose
    public String id;
    @SerializedName("display")
    @Expose
    public String display;
    @SerializedName("shortDisplay")
    @Expose
    public String shortDisplay;
    @SerializedName("image")
    @Expose
    private Image image;

    public User(String id, String display, String shortDisplay, Image image) {
        this.id = id;
        this.display = display;
        this.shortDisplay = shortDisplay;
        this.image = image;
    }

    
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getDisplay() {
        return display;
    }

    public void setDisplay(String display) {
        this.display = display;
    }

    public String getShortDisplay() {
        return shortDisplay;
    }

    public void setShortDisplay(String shortDisplay) {
        this.shortDisplay = shortDisplay;
    }

    public Image getImage() {
        return image;
    }

    public void setImage(Image image) {
        this.image = image;
    }

}
