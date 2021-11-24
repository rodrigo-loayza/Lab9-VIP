package pe.edu.pucp.vip.Dao;

import pe.edu.pucp.vip.Bean.BContinente;
import pe.edu.pucp.vip.Bean.BPais;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Locale;

public class PaisDAO extends BaseDAO {

    public ArrayList<BPais> listarPaises(String id) {
        ArrayList<BPais> listaPaises = new ArrayList<>();
        String sql;
        if (id.isEmpty()) {
            sql = "select p.idPais,p.idContinente,p.nombre,p.poblacion,p.tamano,c.nombre from pais p\n" +
                    "inner join continente c on p.idContinente = c.idContinente\n" +
                    "order by p.nombre asc ";
        } else {
            sql = "select p.idPais,p.idContinente,p.nombre,p.poblacion,p.tamano,c.nombre from pais p\n" +
                    "inner join continente c on p.idContinente = c.idContinente\n" +
                    "where p.idContinente=?\n" +
                    "order by p.nombre asc";
        }

        try (Connection conn = this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            if (!id.isEmpty()) {
                pstmt.setInt(1, Integer.parseInt(id));
            }
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {

                    int idC= rs.getInt(2);
                    String nombreC =rs.getString(6);
                    BContinente continente = new BContinente(idC,nombreC);

                    int idP=rs.getInt(1);
                    String nombreP=rs.getString(3);
                    int poblacionP=rs.getInt(4);
                    double tamanoP = rs.getDouble(5);
                    BPais pais = new BPais(idP,nombreP,poblacionP,tamanoP,continente);

                    listaPaises.add(pais);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return listaPaises;
    }

    public void insertarPais(BPais pais) {
        String sql = "insert into pais (nombre,idContinente,poblacion,tamano)\n" +
                "values(?,?,?,?)";

        try (Connection conn = this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, pais.getNombre());
            pstmt.setInt(2, pais.getIdPais());
            pstmt.setInt(3, pais.getPoblacion());
            pstmt.setDouble(4, pais.getTamano());
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void borrarPais(int idPais) {
        String sql = "delete from pais where idPais=?";

        try (Connection conn = this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, idPais);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void actualizarPais(BPais pais){
        String sql = "update pais set\n" +
                "nombre = ?, idContinente=?, poblacion=?, tamano =? where idPais=?;";

        try (Connection conn = this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, pais.getNombre());
            pstmt.setInt(2, pais.getIdPais());
            pstmt.setInt(3, pais.getPoblacion());
            pstmt.setDouble(4, pais.getTamano());
            pstmt.setInt(5,pais.getIdPais());
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public int buscarPais(String busqueda){
        int idcontinente=0;
        String sql = "select idContinente from continente where lower(nombre) like _utf8? collate utf8_unicode_ci limit 0,1";

        try (Connection conn = this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

                pstmt.setString(1, "%"+busqueda.toLowerCase(Locale.ROOT)+"%");

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    idcontinente=rs.getInt(1);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return idcontinente;
    }
}
