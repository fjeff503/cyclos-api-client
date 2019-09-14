
package com.puntotransacciones.domain.userRecords;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

public class CustomValues {

    @SerializedName("reg_estatus")
    @Expose
    private String regEstatus;
    @SerializedName("fecha")
    @Expose
    private String fecha;
    @SerializedName("vendedor")
    @Expose
    private String vendedor;
    @SerializedName("titulo")
    @Expose
    private String titulo;

    public CustomValues(String regEstatus, String fecha, String vendedor, String titulo) {
        this.regEstatus = regEstatus;
        this.fecha = fecha;
        this.vendedor = vendedor;
        this.titulo = titulo;
    }

    
    public String getRegEstatus() {
        return regEstatus;
    }

    public void setRegEstatus(String regEstatus) {
        this.regEstatus = regEstatus;
    }

    public String getFecha() {
        return fecha;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }

    public String getVendedor() {
        return vendedor;
    }

    public void setVendedor(String vendedor) {
        this.vendedor = vendedor;
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

}
