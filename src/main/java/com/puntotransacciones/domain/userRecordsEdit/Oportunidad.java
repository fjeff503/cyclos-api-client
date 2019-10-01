
package com.puntotransacciones.domain.userRecordsEdit;

import java.util.List;
import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

public class Oportunidad {

    @SerializedName("id")
    @Expose
    private String id;
    @SerializedName("kind")
    @Expose
    private String kind;
    @SerializedName("type")
    @Expose
    private Type type;
    @SerializedName("user")
    @Expose
    private User user;
    @SerializedName("creationDate")
    @Expose
    private String creationDate;
    @SerializedName("createdBy")
    @Expose
    private CreatedBy createdBy;
    @SerializedName("lastModificationDate")
    @Expose
    private String lastModificationDate;
    @SerializedName("lastModifiedBy")
    @Expose
    private LastModifiedBy lastModifiedBy;
    @SerializedName("customValues")
    @Expose
    private List<CustomValue> customValues = null;
    @SerializedName("edit")
    @Expose
    private Boolean edit;
    @SerializedName("remove")
    @Expose
    private Boolean remove;
    @SerializedName("operations")
    @Expose
    private List<Object> operations = null;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getKind() {
        return kind;
    }

    public void setKind(String kind) {
        this.kind = kind;
    }

    public Type getType() {
        return type;
    }

    public void setType(Type type) {
        this.type = type;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
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

    public String getLastModificationDate() {
        return lastModificationDate;
    }

    public void setLastModificationDate(String lastModificationDate) {
        this.lastModificationDate = lastModificationDate;
    }

    public LastModifiedBy getLastModifiedBy() {
        return lastModifiedBy;
    }

    public void setLastModifiedBy(LastModifiedBy lastModifiedBy) {
        this.lastModifiedBy = lastModifiedBy;
    }

    public List<CustomValue> getCustomValues() {
        return customValues;
    }

    public void setCustomValues(List<CustomValue> customValues) {
        this.customValues = customValues;
    }

    public Boolean getEdit() {
        return edit;
    }

    public void setEdit(Boolean edit) {
        this.edit = edit;
    }

    public Boolean getRemove() {
        return remove;
    }

    public void setRemove(Boolean remove) {
        this.remove = remove;
    }

    public List<Object> getOperations() {
        return operations;
    }

    public void setOperations(List<Object> operations) {
        this.operations = operations;
    }

}
