package pe.edu.pucp.vip.Dao;

import pe.edu.pucp.vip.Bean.BPais;
import pe.edu.pucp.vip.Bean.BParticipante;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;

public class ParticipanteDao extends BaseDao {

    public ArrayList<BParticipante> listarParticipantes(int limit, String busqueda, String columna, String order) {

        ArrayList<BParticipante> listaParticipantes = new ArrayList<>();

        String sql = "";


        if (columna.equals("p.edad")) {
            sql = "select p.idParticipante,p.nombre,p.apellido,p.edad,p.genero,p2.idPais, p2.nombre \n" +
                    "from participante p \n" +
                    "inner join pais p2 on p.idPais = p2.idPais \n" +
                    "where lower(concat(p.nombre, ' ', p.apellido)) like ? \n" +
                    "order by " + columna + "  " + order;
        } else {
            sql = "select p.idParticipante,p.nombre,p.apellido,p.edad,p.genero,p2.idPais, p2.nombre \n" +
                    "from participante p \n" +
                    "inner join pais p2 on p.idPais = p2.idPais \n" +
                    "where lower(concat(p.nombre, ' ', p.apellido)) like ? \n" +
                    "order by " + columna + " collate utf8_bin collate utf8_unicode_ci  " + order;
        }
        if (limit != -1) {
            sql = sql + " limit " + limit;
        }

        try (Connection conn = this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, "%" + busqueda.trim() + "%");

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    int idParticipante = rs.getInt(1);
                    String nombre = rs.getString(2);
                    String apellido = rs.getString(3);
                    int edad = rs.getInt(4);
                    String genero = rs.getString(5);
                    int idPais = rs.getInt(6);
                    String nombrePais = rs.getString(7);
                    BPais pais = new BPais(idPais, nombrePais);
                    BParticipante participante = new BParticipante(idParticipante, nombre, apellido, edad, genero, pais);
                    listaParticipantes.add(participante);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return listaParticipantes;
    }

    public BParticipante participanteById(int id) {

        BParticipante participante = new BParticipante();

        String sql = "select p.idParticipante, p.nombre,p.apellido,p.edad,p.genero, p2.idPais, p2.nombre from participante p \n" +
                "inner join pais p2 on (p.idPais = p2.idPais) " +
                "where p.idParticipante = ?;";

        try (Connection conn = this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, id);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    int idParticipante = rs.getInt(1);
                    String nombre = rs.getString(2);
                    String apellido = rs.getString(3);
                    int edad = rs.getInt(4);
                    String genero = rs.getString(5);
                    int idPais = rs.getInt(6);
                    String nombrePais = rs.getString(7);
                    participante = new BParticipante(idParticipante, nombre, apellido, edad, genero, new BPais(idPais, nombrePais));
                    return participante;
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return participante;
    }

    public boolean crearParticipante(BParticipante participante) {

        String sql = "insert into participante (idPais, nombre, apellido, edad, genero) " +
                "VALUES (?,?,?,?,?);";

        try (Connection conn = this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);) {

            pstmt.setInt(1, participante.getPais().getIdPais());
            pstmt.setString(2, participante.getNombre());
            pstmt.setString(3, participante.getApellido());
            pstmt.setInt(4, participante.getEdad());
            pstmt.setString(5, participante.getGenero());
            pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }

    public boolean editarParticipante(BParticipante participante) {

        String sql = "update participante \n" +
                "set idPais=?,nombre=?,apellido=?,edad=?,genero=? where idParticipante = ?";

        try (Connection conn = this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, participante.getPais().getIdPais());
            pstmt.setString(2, participante.getNombre());
            pstmt.setString(3, participante.getApellido());
            pstmt.setInt(4, participante.getEdad());
            pstmt.setString(5, participante.getGenero());
            pstmt.setInt(6, participante.getIdParticipante());
            pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }

    public boolean eliminarParticipante(int idParticipante) {

        String sql = "delete from participante where idParticipante = ? ;";

        try (Connection conn = this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, idParticipante);
            pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }

    public HashMap<String, Integer> porcentajeGenero() {

        HashMap<String, Integer> listaPorcentajesGenero = new HashMap<>();

        String sql = "select (count(idParticipante)/(select count(idParticipante) " +
                "from participante))*100, genero\n" +
                "from participante\n" +
                "group by genero;";

        try (Connection conn = this.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                listaPorcentajesGenero.put(rs.getString(2), rs.getInt(1));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return listaPorcentajesGenero;
    }

    public int edadPromedio() {

        String sql = "select round(sum(edad)/count(idParticipante)) from participante;";

        try (Connection conn = this.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            rs.next();
            return rs.getInt(1);

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }

    public String paisMasParticipantes() {

        String sql = "select pp.nombre from participante p\n" +
                "inner join pais pp on (p.idPais = pp.idPais)\n" +
                "group by p.idPais\n" +
                "having count(idParticipante) = (select max(`participantes`)\n" +
                "from (select count(idParticipante) as `participantes`\n" +
                "from participante\n" +
                "group by idPais) tabla);";

        try (Connection conn = this.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            rs.next();
            return rs.getString(1);

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return "";
    }

    public HashMap<String, Integer> paisCantidadParticipantes() {

        HashMap<String, Integer> lista = new HashMap<>();

        String sql = "select pp.nombre, count(p.idParticipante)\n" +
                "from participante p\n" +
                "inner join pais pp on (p.idPais = pp.idPais)\n" +
                "group by p.idPais\n" +
                "order by count(p.idParticipante) desc\n" +
                "limit 5;";

        try (Connection conn = this.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                lista.put(rs.getString(1), rs.getInt(2));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return lista;
    }

    public int sumaParticipantesOtrosPaises() {
        String sql = "select count(idParticipante) - (select sum(`participantes`) from (select count(idParticipante) as `participantes` \n" +
                "from participante\n" +
                "group by idPais\n" +
                "order by `participantes` desc\n" +
                "limit 5) tabla) \n" +
                "from participante;";

        try (Connection conn = this.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            rs.next();
            return rs.getInt(1);

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }


}
