
package com.puntotransacciones.domain.userRecordsEdit;

import java.util.List;
import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

public class Field {

    @SerializedName("id")
    @Expose
    private String id;
    @SerializedName("name")
    @Expose
    private String name;
    @SerializedName("internalName")
    @Expose
    private String internalName;
    @SerializedName("type")
    @Expose
    private String type;
    @SerializedName("control")
    @Expose
    private String control;
    @SerializedName("kind")
    @Expose
    private String kind;
    @SerializedName("size")
    @Expose
    private String size;
    @SerializedName("required")
    @Expose
    private Boolean required;
    @SerializedName("hasValuesList")
    @Expose
    private Boolean hasValuesList;
    @SerializedName("colspan")
    @Expose
    private Integer colspan;
    @SerializedName("defaultValue")
    @Expose
    private String defaultValue;
    @SerializedName("possibleValueCategories")
    @Expose
    private List<Object> possibleValueCategories = null;
    @SerializedName("possibleValues")
    @Expose
    private List<PossibleValue> possibleValues = null;
    @SerializedName("linkedEntityType")
    @Expose
    private String linkedEntityType;
    @SerializedName("decimalDigits")
    @Expose
    private Integer decimalDigits;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getInternalName() {
        return internalName;
    }

    public void setInternalName(String internalName) {
        this.internalName = internalName;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getControl() {
        return control;
    }

    public void setControl(String control) {
        this.control = control;
    }

    public String getKind() {
        return kind;
    }

    public void setKind(String kind) {
        this.kind = kind;
    }

    public String getSize() {
        return size;
    }

    public void setSize(String size) {
        this.size = size;
    }

    public Boolean getRequired() {
        return required;
    }

    public void setRequired(Boolean required) {
        this.required = required;
    }

    public Boolean getHasValuesList() {
        return hasValuesList;
    }

    public void setHasValuesList(Boolean hasValuesList) {
        this.hasValuesList = hasValuesList;
    }

    public Integer getColspan() {
        return colspan;
    }

    public void setColspan(Integer colspan) {
        this.colspan = colspan;
    }

    public String getDefaultValue() {
        return defaultValue;
    }

    public void setDefaultValue(String defaultValue) {
        this.defaultValue = defaultValue;
    }

    public List<Object> getPossibleValueCategories() {
        return possibleValueCategories;
    }

    public void setPossibleValueCategories(List<Object> possibleValueCategories) {
        this.possibleValueCategories = possibleValueCategories;
    }

    public List<PossibleValue> getPossibleValues() {
        return possibleValues;
    }

    public void setPossibleValues(List<PossibleValue> possibleValues) {
        this.possibleValues = possibleValues;
    }

    public String getLinkedEntityType() {
        return linkedEntityType;
    }

    public void setLinkedEntityType(String linkedEntityType) {
        this.linkedEntityType = linkedEntityType;
    }

    public Integer getDecimalDigits() {
        return decimalDigits;
    }

    public void setDecimalDigits(Integer decimalDigits) {
        this.decimalDigits = decimalDigits;
    }

}
