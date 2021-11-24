package pe.edu.pucp.vip.Bean;

public class BAlumno extends BParticipante {

    private String codigo;
    private double promedio;
    private boolean condicionEliminado;
    private BUniversidad universidad;

    public BAlumno(int idParticipante, String nombre, String apellido, int edad, String codigo, double promedio, boolean condicionEliminado, BUniversidad universidad) {
        super(idParticipante, nombre, apellido, edad);
        this.codigo = codigo;
        this.promedio = promedio;
        this.condicionEliminado = condicionEliminado;
        this.universidad = universidad;
    }

    public BAlumno(int idParticipante, String nombre, String apellido, String codigo, double promedio, BUniversidad universidad) {
        super(idParticipante, nombre, apellido);
        this.codigo = codigo;
        this.promedio = promedio;
        this.universidad = universidad;
    }

    public BAlumno(int idParticipante, String codigo, double promedio, BUniversidad universidad) {
        super(idParticipante);
        this.codigo = codigo;
        this.promedio = promedio;
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

    public double getPromedio() {
        return promedio;
    }

    public void setPromedio(double promedio) {
        this.promedio = promedio;
    }

    public boolean getCondicionEliminado() {
        return condicionEliminado;
    }

    public void setCondicionEliminado(boolean condicion) {
        this.condicionEliminado = condicion;
    }

    public BUniversidad getUniversidad() {
        return universidad;
    }

    public void setUniversidad(BUniversidad universidad) {
        this.universidad = universidad;
    }
}
