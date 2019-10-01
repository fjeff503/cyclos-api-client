
package com.puntotransacciones.domain.userRecordsEdit;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

public class Record {

    @SerializedName("customValues")
    @Expose
    private CustomValues customValues;
    @SerializedName("version")
    @Expose
    private Integer version;

    public CustomValues getCustomValues() {
        return customValues;
    }

    public void setCustomValues(CustomValues customValues) {
        this.customValues = customValues;
    }

    public Integer getVersion() {
        return version;
    }

    public void setVersion(Integer version) {
        this.version = version;
    }

}
