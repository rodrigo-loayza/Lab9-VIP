package pe.edu.pucp.vip.Bean;

public class BAlumno extends BParticipante {

    private String codigo;
    private Double promedio;
    private boolean condicion;
    private BUniversidad universidad;

    public BAlumno(int idParticipante, String nombre, String apellido, int edad, String genero, BPais pais, String codigo, Double promedio, boolean condicion, BUniversidad universidad) {
        super(idParticipante, nombre, apellido, edad, genero, pais);
        this.codigo = codigo;
        this.promedio = promedio;
        this.condicion = condicion;
        this.universidad = universidad;
    }

    public BAlumno(String codigo, Double promedio, boolean condicion, BUniversidad universidad) {
        this.codigo = codigo;
        this.promedio = promedio;
        this.condicion = condicion;
        this.universidad = universidad;
    }

    public BAlumno() {

    }

    public String getCodigo() {
        return codigo;
    }

    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }

    public Double getPromedio() {
        return promedio;
    }

    public void setPromedio(Double promedio) {
        this.promedio = promedio;
    }

    public boolean isCondicion() {
        return condicion;
    }

    public void setCondicion(boolean condicion) {
        this.condicion = condicion;
    }

    public BUniversidad getUniversidad() {
        return universidad;
    }

    public void setUniversidad(BUniversidad universidad) {
        this.universidad = universidad;
    }
}
