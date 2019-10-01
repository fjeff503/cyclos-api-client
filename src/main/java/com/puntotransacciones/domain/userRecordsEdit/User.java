
package com.puntotransacciones.domain.userRecordsEdit;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

public class User {

    @SerializedName("id")
    @Expose
    private String id;
    @SerializedName("display")
    @Expose
    private String display;
    @SerializedName("shortDisplay")
    @Expose
    private String shortDisplay;
    @SerializedName("image")
    @Expose
    private Image image;

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
