package pe.edu.pucp.vip.Dao;

import pe.edu.pucp.vip.Bean.*;

import java.sql.*;
import java.util.ArrayList;

public class UniversidadDao extends BaseDao {
    public ArrayList<BUniversidad> listarUniversidades(String columna, String orden) {

        ArrayList<BUniversidad> listaUniversidades = new ArrayList<>();
        String sql = "";

        if (columna.equals("u.ranking") || columna.equals("u.numAlumnos")) {
            sql = "select u.idUniversidad ,u.nombre, u.ranking, u.numAlumnos, u.urlFoto, p.idPais, p.nombre, p.idContinente " +
                    "from universidad u " +
                    "inner join pais p on u.idPais = p.idPais " +
                    "order by " + columna + " " + orden + ";";
        } else{
            sql = "select u.idUniversidad ,u.nombre, u.ranking, u.numAlumnos, u.urlFoto, p.idPais, p.nombre, p.idContinente " +
                    "from universidad u " +
                    "inner join pais p on u.idPais = p.idPais " +
                    "order by " + columna + " collate utf8_bin collate utf8_unicode_ci " + orden + ";";
        }

        try (Connection conn = this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            try (ResultSet rs = pstmt.executeQuery();) {

                while (rs.next()) {
                    int idUniversidad = rs.getInt(1);
                    String nombre = rs.getString(2);
                    int ranking = rs.getInt(3);
                    int numAlumnos = rs.getInt(4);
                    String urlFoto = rs.getString(5);
                    int idPais = rs.getInt(6);
                    String nombrePais = rs.getString(7);
                    int idContinente = rs.getInt(8);
                    BContinente continente = new BContinente(idContinente);
                    BPais pais = new BPais(idPais, nombrePais, continente);
                    listaUniversidades.add(new BUniversidad(idUniversidad, nombre, ranking, numAlumnos, urlFoto, pais));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return listaUniversidades;
    }

    public ArrayList<BAlumno> listarAlumnos(int idUniversidad) {

        ArrayList<BAlumno> listaAlumnos = new ArrayList<>();

        try (Connection conn = this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(
                     "select p.idParticipante, p.nombre, p.apellido,p.edad,a.codigo,a.promedio,a.condicion from alumno a " +
                             "inner join participante p on a.idParticipante = p.idParticipante " +
                             "inner join universidad u on a.idUniversidad = u.idUniversidad " +
                             "where a.idUniversidad = ? " +
                             "order by promedio desc;")) {

            pstmt.setInt(1, idUniversidad);

            try (ResultSet rs = pstmt.executeQuery();) {

                while (rs.next()) {
                    int idParticipante = rs.getInt(1);
                    String nombre = rs.getString(2);
                    String apellido = rs.getString(3);
                    int edad = rs.getInt(4);
                    String codigo = rs.getString(5);
                    double promedio = rs.getDouble(6);
                    boolean condicionEliminado = rs.getBoolean(7);
                    BUniversidad universidad = new BUniversidad(idUniversidad);
                    listaAlumnos.add(new BAlumno(idParticipante, nombre, apellido, edad, codigo, promedio, condicionEliminado, universidad));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return listaAlumnos;
    }

    public ArrayList<BParticipante> listarParticipantesDisponibles(int idUniversidad) {

        ArrayList<BParticipante> listaParticipantes = new ArrayList<>();

        try (Connection conn = this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(
                     "select p.idParticipante, p.nombre, p.apellido, p.idPais, u.idPais from participante p " +
                             "inner join universidad u on p.idPais = u.idPais " +
                             "where u.idUniversidad = ? and p.idParticipante not in (select idParticipante from alumno);")) {

            pstmt.setInt(1, idUniversidad);

            try (ResultSet rs = pstmt.executeQuery();) {

                while (rs.next()) {
                    int idParticipante = rs.getInt(1);
                    String nombre = rs.getString(2);
                    String apellido = rs.getString(3);
                    listaParticipantes.add(new BParticipante(idParticipante, nombre, apellido));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return listaParticipantes;
    }

    public BUniversidad obtenerUniversidad(int idUniversidad) {

        String sql = "select u.idPais, p.nombre, u.nombre, u.ranking, u.numAlumnos, u.urlFoto " +
                "from universidad u " +
                "inner join pais p on u.idPais = p.idPais " +
                "where idUniversidad = ? ; ";

        try (Connection conn = this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);) {

            pstmt.setInt(1, idUniversidad);

            try (ResultSet rs = pstmt.executeQuery();) {

                while (rs.next()) {
                    int idPais = rs.getInt(1);
                    String nombrePais = rs.getString(2);
                    String nombre = rs.getString(3);
                    int ranking = rs.getInt(4);
                    int numAlumnos = rs.getInt(5);
                    String urlFoto = rs.getString(6);
                    BPais pais = new BPais(idPais, nombrePais);
                    return new BUniversidad(idUniversidad, nombre, ranking, numAlumnos, urlFoto, pais);
                }

            }

        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
        return null;
    }

    public BAlumno obtenerAlumno(int idUniversidad, int idParticipante) {

        String sql = "select p.nombre, p.apellido, a.codigo, a.promedio " +
                "from alumno a " +
                "inner join participante p on a.idParticipante = p.idParticipante " +
                "where a.idUniversidad = ? and a.idParticipante = ? ; ";

        try (Connection conn = this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);) {

            pstmt.setInt(1, idUniversidad);
            pstmt.setInt(2, idParticipante);

            try (ResultSet rs = pstmt.executeQuery();) {

                while (rs.next()) {
                    String nombre = rs.getString(1);
                    String apellido = rs.getString(2);
                    String codigo = rs.getString(3);
                    double promedio = rs.getDouble(4);
                    BUniversidad universidad = new BUniversidad(idUniversidad);
                    return new BAlumno(idParticipante, nombre, apellido, codigo, promedio, universidad);
                }

            }

        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
        return null;
    }

    public void registrarUniversidad(BUniversidad universidad) throws Exception {

        String sql = "insert into universidad (idPais, nombre, ranking, numAlumnos, urlFoto) " +
                "values(?,?,?,?,?);";

        try (Connection conn = this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);) {

            pstmt.setInt(1, universidad.getPais().getIdPais());
            pstmt.setString(2, universidad.getNombre());
            pstmt.setInt(3, universidad.getRanking());
            pstmt.setInt(4, 0);
            pstmt.setString(5, universidad.getUrlFoto());
            pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
    }

    public void editarUniversidad(BUniversidad universidad) throws Exception {
        String sql = "update universidad set idPais=?, nombre =?, ranking=?, urlFoto=? " +
                "where idUniversidad = ? ;";

        try (Connection conn = this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);) {

            pstmt.setInt(1, universidad.getPais().getIdPais());
            pstmt.setString(2, universidad.getNombre());
            pstmt.setInt(3, universidad.getRanking());
            pstmt.setString(4, universidad.getUrlFoto());
            pstmt.setInt(5, universidad.getIdUniversidad());
            pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
    }

    public void eliminarAlumnosDeUniversidad(int idUniversidad) throws Exception {
        String sql = "delete from alumno where idUniversidad=?;";

        try (
                Connection conn = this.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql);) {
            pstmt.setInt(1, idUniversidad);
            pstmt.executeUpdate();

        } catch (
                SQLException e) {
            e.printStackTrace();
            throw e;
        }

    }

    public void eliminarUniversidad(int idUniversidad) throws Exception {
        String sql = "delete from universidad where idUniversidad=?";

        try (
                Connection conn = this.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql);) {
            pstmt.setInt(1, idUniversidad);
            pstmt.executeUpdate();

        } catch (
                SQLException e) {
            e.printStackTrace();
            throw e;
        }

    }

    public void eliminarPaisSinUniversidad(int idPais) throws Exception {
        String sql = "delete from pais where idPais = " +
                "(select * from (select p.idPais from pais p \n" +
                "where p.idPais not in (select idPais from universidad) and p.idPais=?) as p);";
        try (
                Connection conn = this.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql);) {
            pstmt.setInt(1, idPais);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
    }

    public void eliminarParticipantesPaisSinUniversidad(int idPais) throws Exception {
        String sql = "delete from participante where idPais = " +
                "(select * from (select p.idPais from pais p " +
                "where p.idPais not in (select idPais from universidad) and p.idPais=?) as p);";
        try (
                Connection conn = this.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql);) {
            pstmt.setInt(1, idPais);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
    }

    public void registrarAlumno(BAlumno alumno) throws Exception {

        String sql = "insert into alumno (idParticipante, idUniversidad, codigo, promedio, condicion) " +
                "values(?,?,?,?,0);";

        try (Connection conn = this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);) {

            pstmt.setInt(1, alumno.getIdParticipante());
            pstmt.setInt(2, alumno.getUniversidad().getIdUniversidad());
            pstmt.setString(3, alumno.getCodigo());
            pstmt.setDouble(4, alumno.getPromedio());
            pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
    }

    public void editarAlumno(BAlumno alumno) throws Exception {
        String sql = "update alumno set codigo =?, promedio =? " +
                "where idUniversidad = ? and idParticipante = ? ;";

        try (Connection conn = this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);) {

            pstmt.setString(1, alumno.getCodigo());
            pstmt.setDouble(2, alumno.getPromedio());
            pstmt.setInt(3, alumno.getUniversidad().getIdUniversidad());
            pstmt.setInt(4, alumno.getIdParticipante());
            pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
    }

    public void eliminarAlumno(int idParticipante) throws Exception {
        String sql = "update alumno set condicion=1 where idParticipante=?;";

        try (
                Connection conn = this.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql);) {
            pstmt.setInt(1, idParticipante);
            pstmt.executeUpdate();

        } catch (
                SQLException e) {
            e.printStackTrace();
            throw e;
        }

    }

    public void borrarAlumno(int idParticipante) throws Exception {
        String sql = "delete from alumno where condicion=1 and idParticipante=?;";

        try (
                Connection conn = this.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql);) {
            pstmt.setInt(1, idParticipante);
            pstmt.executeUpdate();

        } catch (
                SQLException e) {
            e.printStackTrace();
            throw e;
        }

    }

}
