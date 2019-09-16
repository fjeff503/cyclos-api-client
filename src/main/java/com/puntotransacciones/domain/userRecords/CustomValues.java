
package com.puntotransacciones.domain.userRecords;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

public class CustomValues {

    @SerializedName("reg_estatus")
    @Expose
    private String estatus;
    @SerializedName("fecha")
    @Expose
    private String fecha;
    @SerializedName("vendedor")
    @Expose
    private String vendedor;
    @SerializedName("titulo")
    @Expose
    private String titulo;
    @SerializedName("montotrans")
    @Expose
    private Double montoTrans;
    @SerializedName("descripcion")
    @Expose
    private String descripcion;

    public CustomValues(String fecha, String vendedor, String titulo) {
        this.fecha = fecha;
        this.vendedor = vendedor;
        this.titulo = titulo;
    }

    public CustomValues() {
    }

    public String getEstatus() {
        return estatus;
    }

    public void setEstatus(String estatus) {
        this.estatus = estatus;
    }
    

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    
    public Double getMontoTrans() {
        return montoTrans;
    }

    public void setMontoTrans(Double montoTrans) {
        this.montoTrans = montoTrans;
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
