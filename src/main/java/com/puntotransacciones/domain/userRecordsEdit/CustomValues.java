
package com.puntotransacciones.domain.userRecordsEdit;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

public class CustomValues {

    @SerializedName("reg_estatus")
    @Expose
    private String regEstatus;
    @SerializedName("montousd")
    @Expose
    private String montousd;
    @SerializedName("descripcion")
    @Expose
    private String descripcion;
    @SerializedName("fecha")
    @Expose
    private String fecha;
    @SerializedName("vendedor")
    @Expose
    private String vendedor;
    @SerializedName("reg_para")
    @Expose
    private String regPara;
    @SerializedName("montotrans")
    @Expose
    private String montotrans;
    @SerializedName("notas")
    @Expose
    private String notas;
    @SerializedName("apoyode")
    @Expose
    private String apoyode;
    @SerializedName("vendedor2")
    @Expose
    private String vendedor2;
    @SerializedName("titulo")
    @Expose
    private String titulo;

    public String getRegEstatus() {
        return regEstatus;
    }

    public void setRegEstatus(String regEstatus) {
        this.regEstatus = regEstatus;
    }

    public String getMontousd() {
        return montousd;
    }

    public void setMontousd(String montousd) {
        this.montousd = montousd;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
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

    public String getRegPara() {
        return regPara;
    }

    public void setRegPara(String regPara) {
        this.regPara = regPara;
    }

    public String getMontotrans() {
        return montotrans;
    }

    public void setMontotrans(String montotrans) {
        this.montotrans = montotrans;
    }

    public String getNotas() {
        return notas;
    }

    public void setNotas(String notas) {
        this.notas = notas;
    }

    public String getApoyode() {
        return apoyode;
    }

    public void setApoyode(String apoyode) {
        this.apoyode = apoyode;
    }

    public String getVendedor2() {
        return vendedor2;
    }

    public void setVendedor2(String vendedor2) {
        this.vendedor2 = vendedor2;
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

}
