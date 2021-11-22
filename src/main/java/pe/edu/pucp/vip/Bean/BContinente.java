package pe.edu.pucp.vip.Bean;

public class BContinente {

    private int idContinente;
    private String nombre;

    public BContinente(int idContinente, String nombre) {
        this.idContinente = idContinente;
        this.nombre = nombre;
    }

    public BContinente() {

    }

    public int getIdContinente() {
        return idContinente;
    }

    public void setIdContinente(int idContinente) {
        this.idContinente = idContinente;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
}
