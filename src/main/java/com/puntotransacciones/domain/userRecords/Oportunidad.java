
package com.puntotransacciones.domain.userRecords;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;
import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
public class Oportunidad {

    @SerializedName("id")
    @Expose
    public String id;
    @SerializedName("display")
    @Expose
    public String display;
    @SerializedName("kind")
    @Expose
    public String kind;
    @SerializedName("creationDate")
    @Expose
    public String creationDate;
    @SerializedName("createdBy")
    @Expose
    public CreatedBy createdBy;
    @SerializedName("customValues")
    @Expose
    public CustomValues customValues;
    @SerializedName("user")
    @Expose
    public User user;
    @SerializedName("lastModificationDate")
   @Expose
    public String lastModificationDate;
    
    public Boolean bandera;
    
    public Integer version;
    
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

    public String getKind() {
        return kind;
    }

    public void setKind(String kind) {
        this.kind = kind;
    }

    public String getCreationDate() {
        return creationDate;
    }

    public void setCreationDate(String creationDate) {
        this.creationDate = creationDate;
    }

    public CreatedBy getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(CreatedBy createdBy) {
        this.createdBy = createdBy;
    }

    public CustomValues getCustomValues() {
        return customValues;
    }

    public void setCustomValues(CustomValues customValues) {
        this.customValues = customValues;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public void setVersion(Integer version) {
        this.version = version;
    }

    public Integer getVersion() {
        return version;
    }

    public Boolean getBandera() {
        return bandera;
    }

    public void setBandera(Boolean bandera) {
        this.bandera = bandera;
    }

    public String getLastModificationDate() {
        return lastModificationDate;
    }

    public void setLastModificationDate(String lastModificationDate) {
        this.lastModificationDate = lastModificationDate;
    }
    
    
    
}
