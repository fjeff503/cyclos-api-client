
package com.puntotransacciones.domain.userRecordsEdit;

import java.util.List;
import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

public class CustomValue {

    @SerializedName("id")
    @Expose
    private String id;
    @SerializedName("stringValue")
    @Expose
    private String stringValue;
    @SerializedName("field")
    @Expose
    private Field field;
    @SerializedName("enumeratedValues")
    @Expose
    private List<EnumeratedValue> enumeratedValues = null;
    @SerializedName("linkedEntityValue")
    @Expose
    private LinkedEntityValue linkedEntityValue;
    @SerializedName("userValue")
    @Expose
    private UserValue userValue;
    @SerializedName("decimalValue")
    @Expose
    private String decimalValue;
    @SerializedName("dateValue")
    @Expose
    private String dateValue;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getStringValue() {
        return stringValue;
    }

    public void setStringValue(String stringValue) {
        this.stringValue = stringValue;
    }

    public Field getField() {
        return field;
    }

    public void setField(Field field) {
        this.field = field;
    }

    public List<EnumeratedValue> getEnumeratedValues() {
        return enumeratedValues;
    }

    public void setEnumeratedValues(List<EnumeratedValue> enumeratedValues) {
        this.enumeratedValues = enumeratedValues;
    }

    public LinkedEntityValue getLinkedEntityValue() {
        return linkedEntityValue;
    }

    public void setLinkedEntityValue(LinkedEntityValue linkedEntityValue) {
        this.linkedEntityValue = linkedEntityValue;
    }

    public UserValue getUserValue() {
        return userValue;
    }

    public void setUserValue(UserValue userValue) {
        this.userValue = userValue;
    }

    public String getDecimalValue() {
        return decimalValue;
    }

    public void setDecimalValue(String decimalValue) {
        this.decimalValue = decimalValue;
    }

    public String getDateValue() {
        return dateValue;
    }

    public void setDateValue(String dateValue) {
        this.dateValue = dateValue;
    }

}
