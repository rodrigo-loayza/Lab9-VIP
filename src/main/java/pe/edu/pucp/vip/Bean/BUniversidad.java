package pe.edu.pucp.vip.Bean;

public class BUniversidad {

    private int idUniversidad;
    private String nombre;
    private int ranking;
    private int numAlumnos;
    private String urlFoto;
    private BPais pais;

    public BUniversidad(int idUniversidad, String nombre, int ranking, int numAlumnos, String urlFoto, BPais pais) {
        this.idUniversidad = idUniversidad;
        this.nombre = nombre;
        this.ranking = ranking;
        this.numAlumnos = numAlumnos;
        this.urlFoto = urlFoto;
        this.pais = pais;
    }

    public BUniversidad() {

    }

    public int getIdUniversidad() {
        return idUniversidad;
    }

    public void setIdUniversidad(int idUniversidad) {
        this.idUniversidad = idUniversidad;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public int getRanking() {
        return ranking;
    }

    public void setRanking(int ranking) {
        this.ranking = ranking;
    }

    public int getNumAlumnos() {
        return numAlumnos;
    }

    public void setNumAlumnos(int numAlumnos) {
        this.numAlumnos = numAlumnos;
    }

    public String getUrlFoto() {
        return urlFoto;
    }

    public void setUrlFoto(String urlFoto) {
        this.urlFoto = urlFoto;
    }

    public BPais getPais() {
        return pais;
    }

    public void setPais(BPais pais) {
        this.pais = pais;
    }
}
