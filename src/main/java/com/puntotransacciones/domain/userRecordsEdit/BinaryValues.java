
package com.puntotransacciones.domain.userRecordsEdit;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

public class BinaryValues {

    @SerializedName("fileValues")
    @Expose
    private FileValues fileValues;
    @SerializedName("imageValues")
    @Expose
    private ImageValues imageValues;

    public FileValues getFileValues() {
        return fileValues;
    }

    public void setFileValues(FileValues fileValues) {
        this.fileValues = fileValues;
    }

    public ImageValues getImageValues() {
        return imageValues;
    }

    public void setImageValues(ImageValues imageValues) {
        this.imageValues = imageValues;
    }

}
