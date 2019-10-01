
package com.puntotransacciones.domain.userRecordsEdit;

import java.util.List;
import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

public class Oportunidad {

    @SerializedName("kind")
    @Expose
    private String kind;
    @SerializedName("type")
    @Expose
    private Type type;
    @SerializedName("fields")
    @Expose
    private List<Field> fields = null;
    @SerializedName("user")
    @Expose
    private User user;
    @SerializedName("edit")
    @Expose
    private Boolean edit;
    @SerializedName("remove")
    @Expose
    private Boolean remove;
    @SerializedName("editableFields")
    @Expose
    private List<String> editableFields = null;
    @SerializedName("record")
    @Expose
    private Record record;
    @SerializedName("binaryValues")
    @Expose
    private BinaryValues binaryValues;

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

    public List<Field> getFields() {
        return fields;
    }

    public void setFields(List<Field> fields) {
        this.fields = fields;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
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

    public List<String> getEditableFields() {
        return editableFields;
    }

    public void setEditableFields(List<String> editableFields) {
        this.editableFields = editableFields;
    }

    public Record getRecord() {
        return record;
    }

    public void setRecord(Record record) {
        this.record = record;
    }

    public BinaryValues getBinaryValues() {
        return binaryValues;
    }

    public void setBinaryValues(BinaryValues binaryValues) {
        this.binaryValues = binaryValues;
    }

}
