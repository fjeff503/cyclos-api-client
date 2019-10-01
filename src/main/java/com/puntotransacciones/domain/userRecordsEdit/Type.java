
package com.puntotransacciones.domain.userRecordsEdit;

import java.util.List;
import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

public class Type {

    @SerializedName("id")
    @Expose
    private String id;
    @SerializedName("name")
    @Expose
    private String name;
    @SerializedName("internalName")
    @Expose
    private String internalName;
    @SerializedName("pluralName")
    @Expose
    private String pluralName;
    @SerializedName("layout")
    @Expose
    private String layout;
    @SerializedName("useViewPage")
    @Expose
    private Boolean useViewPage;
    @SerializedName("fieldColumns")
    @Expose
    private Integer fieldColumns;
    @SerializedName("nowrapLabels")
    @Expose
    private Boolean nowrapLabels;
    @SerializedName("sections")
    @Expose
    private List<Object> sections = null;

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

    public String getPluralName() {
        return pluralName;
    }

    public void setPluralName(String pluralName) {
        this.pluralName = pluralName;
    }

    public String getLayout() {
        return layout;
    }

    public void setLayout(String layout) {
        this.layout = layout;
    }

    public Boolean getUseViewPage() {
        return useViewPage;
    }

    public void setUseViewPage(Boolean useViewPage) {
        this.useViewPage = useViewPage;
    }

    public Integer getFieldColumns() {
        return fieldColumns;
    }

    public void setFieldColumns(Integer fieldColumns) {
        this.fieldColumns = fieldColumns;
    }

    public Boolean getNowrapLabels() {
        return nowrapLabels;
    }

    public void setNowrapLabels(Boolean nowrapLabels) {
        this.nowrapLabels = nowrapLabels;
    }

    public List<Object> getSections() {
        return sections;
    }

    public void setSections(List<Object> sections) {
        this.sections = sections;
    }

}
