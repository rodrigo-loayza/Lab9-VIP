package pe.edu.pucp.vip.Bean;

public class BPais {

    private int idPais;
    private String nombre;
    private int poblacion;
    private Double tamano;
    private BContinente continente;

    public BPais(int idPais, String nombre, int poblacion, Double tamano, BContinente continente) {
        this.idPais = idPais;
        this.nombre = nombre;
        this.poblacion = poblacion;
        this.tamano = tamano;
        this.continente = continente;
    }

    public BPais() {

    }

    public int getIdPais() {
        return idPais;
    }

    public void setIdPais(int idPais) {
        this.idPais = idPais;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public int getPoblacion() {
        return poblacion;
    }

    public void setPoblacion(int poblacion) {
        this.poblacion = poblacion;
    }

    public Double getTamano() {
        return tamano;
    }

    public void setTamano(Double tamano) {
        this.tamano = tamano;
    }

    public BContinente getContinente() {
        return continente;
    }

    public void setContinente(BContinente continente) {
        this.continente = continente;
    }
}
