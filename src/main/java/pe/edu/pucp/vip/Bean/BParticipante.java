package pe.edu.pucp.vip.Bean;

public class BParticipante {

    private int idParticipante;
    private String nombre;
    private String apellido;
    private int edad;
    private String genero;
    private BPais pais;

    public BParticipante(int idParticipante, String nombre, String apellido, int edad, String genero, BPais pais) {
        this.idParticipante = idParticipante;
        this.nombre = nombre;
        this.apellido = apellido;
        this.edad = edad;
        this.genero = genero;
        this.pais = pais;
    }

    public BParticipante(int idParticipante, String nombre, String apellido, int edad) {
        this.idParticipante = idParticipante;
        this.nombre = nombre;
        this.apellido = apellido;
        this.edad = edad;
    }

    public BParticipante(int idParticipante, String nombre, String apellido) {
        this.idParticipante = idParticipante;
        this.nombre = nombre;
        this.apellido = apellido;
    }

    public BParticipante(int idParticipante) {
        this.idParticipante = idParticipante;
    }

    public BParticipante() {

    }

    public int getIdParticipante() {
        return idParticipante;
    }

    public void setIdParticipante(int idParticipante) {
        this.idParticipante = idParticipante;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getApellido() {
        return apellido;
    }

    public void setApellido(String apellido) {
        this.apellido = apellido;
    }

    public int getEdad() {
        return edad;
    }

    public void setEdad(int edad) {
        this.edad = edad;
    }

    public String getGenero() {
        return genero;
    }

    public void setGenero(String genero) {
        this.genero = genero;
    }

    public BPais getPais() {
        return pais;
    }

    public void setPais(BPais pais) {
        this.pais = pais;
    }
}
