package pe.edu.pucp.vip.Dao;

import pe.edu.pucp.vip.Bean.BContinente;
import pe.edu.pucp.vip.Bean.BPais;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Locale;

public class PaisDao extends BaseDao {

    public ArrayList<BPais> listarPaises(String busqueda) {
        ArrayList<BPais> listaPaises = new ArrayList<>();
        String sql = "";
        String orden = "";
        boolean filtrar = false;

        if (busqueda.isEmpty() || busqueda.equals("0")) {
            sql = "select p.idPais,p.idContinente,p.nombre,p.poblacion,p.tamano,c.nombre from pais p\n" +
                    "inner join continente c on p.idContinente = c.idContinente\n" +
                    "order by p.nombre asc ";
        } else if (busqueda.length() == 1) {
            sql = "select p.idPais,p.idContinente,p.nombre,p.poblacion,p.tamano,c.nombre from pais p\n" +
                    "inner join continente c on p.idContinente = c.idContinente\n" +
                    "where p.idContinente=?\n" +
                    "order by p.nombre asc";
            filtrar = true;
        } else {
            orden = busqueda.substring(1);
            if (busqueda.charAt(0) == '0') {
                sql = "select p.idPais,p.idContinente,p.nombre,p.poblacion,p.tamano,c.nombre from pais p\n" +
                        "inner join continente c on p.idContinente = c.idContinente\n" +
                        "order by ";
            } else {
                sql = "select p.idPais,p.idContinente,p.nombre,p.poblacion,p.tamano,c.nombre from pais p\n" +
                        "inner join continente c on p.idContinente = c.idContinente\n" +
                        "where p.idContinente=?\n" +
                        "order by ";
                filtrar = true;
            }
            if (orden.equals("na")) {
                sql = sql + "p.nombre asc";
            } else if (orden.equals("nd")) {
                sql = sql + "p.nombre desc";
            } else if (orden.equals("ca")) {
                sql = sql + "c.nombre asc";
            } else if (orden.equals("cd")) {
                sql = sql + "c.nombre desc";
            } else if (orden.equals("pa")) {
                sql = sql + "p.poblacion asc";
            } else if (orden.equals("pd")) {
                sql = sql + "p.poblacion desc";
            } else if (orden.equals("ta")) {
                sql = sql + "p.tamano asc";
            } else {
                sql = sql + "p.tamano desc";
            }


        }

        try (Connection conn = this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            if (filtrar) {
                pstmt.setInt(1, Integer.parseInt(busqueda.substring(0, 1)));
            }
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {

                    int idC = rs.getInt(2);
                    String nombreC = rs.getString(6);
                    BContinente continente = new BContinente(idC, nombreC);

                    int idP = rs.getInt(1);
                    String nombreP = rs.getString(3);
                    int poblacionP = rs.getInt(4);
                    double tamanoP = rs.getDouble(5);
                    BPais pais = new BPais(idP, nombreP, poblacionP, tamanoP, continente);

                    listaPaises.add(pais);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return listaPaises;
    }

    public ArrayList<BPais> listarPaises(String busqueda,int pag,int limit) {
        ArrayList<BPais> listaPaises = new ArrayList<>();
        String sql = "";
        String orden = "";
        boolean filtrar = false;

        if (busqueda.isEmpty() || busqueda.equals("0")) {
            sql = "select p.idPais,p.idContinente,p.nombre,p.poblacion,p.tamano,c.nombre from pais p\n" +
                    "inner join continente c on p.idContinente = c.idContinente\n" +
                    "order by p.nombre asc ";
        } else if (busqueda.length() == 1) {
            sql = "select p.idPais,p.idContinente,p.nombre,p.poblacion,p.tamano,c.nombre from pais p\n" +
                    "inner join continente c on p.idContinente = c.idContinente\n" +
                    "where p.idContinente=?\n" +
                    "order by p.nombre asc";
            filtrar = true;
        } else {
            orden = busqueda.substring(1);
            if (busqueda.charAt(0) == '0') {
                sql = "select p.idPais,p.idContinente,p.nombre,p.poblacion,p.tamano,c.nombre from pais p\n" +
                        "inner join continente c on p.idContinente = c.idContinente\n" +
                        "order by ";
            } else {
                sql = "select p.idPais,p.idContinente,p.nombre,p.poblacion,p.tamano,c.nombre from pais p\n" +
                        "inner join continente c on p.idContinente = c.idContinente\n" +
                        "where p.idContinente=?\n" +
                        "order by ";
                filtrar = true;
            }
            if (orden.equals("na")) {
                sql = sql + "p.nombre asc";
            } else if (orden.equals("nd")) {
                sql = sql + "p.nombre desc";
            } else if (orden.equals("ca")) {
                sql = sql + "c.nombre asc";
            } else if (orden.equals("cd")) {
                sql = sql + "c.nombre desc";
            } else if (orden.equals("pa")) {
                sql = sql + "p.poblacion asc";
            } else if (orden.equals("pd")) {
                sql = sql + "p.poblacion desc";
            } else if (orden.equals("ta")) {
                sql = sql + "p.tamano asc";
            } else {
                sql = sql + "p.tamano desc";
            }

        }
        sql=sql + "\nlimit "+((pag-1)*limit)+ " , "+limit;
        try (Connection conn = this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            if (filtrar) {
                pstmt.setInt(1, Integer.parseInt(busqueda.substring(0, 1)));
            }
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {

                    int idC = rs.getInt(2);
                    String nombreC = rs.getString(6);
                    BContinente continente = new BContinente(idC, nombreC);

                    int idP = rs.getInt(1);
                    String nombreP = rs.getString(3);
                    int poblacionP = rs.getInt(4);
                    double tamanoP = rs.getDouble(5);
                    BPais pais = new BPais(idP, nombreP, poblacionP, tamanoP, continente);

                    listaPaises.add(pais);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return listaPaises;
    }

    public void insertarPais(BPais pais) throws Exception {
        String sql = "insert into pais (nombre,idContinente,poblacion,tamano)\n" +
                "values(?,?,?,?)";

        try (Connection conn = this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, pais.getNombre());
            pstmt.setInt(2, pais.getContinente().getIdContinente());
            pstmt.setInt(3, pais.getPoblacion());
            pstmt.setDouble(4, pais.getTamano());
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new Exception(e.getMessage());
        }
    }

    public void borrarPais(int idPais) throws Exception {
        String sql = "delete from pais where idPais=?";

        try (Connection conn = this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, idPais);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new Exception(e.getMessage());
        }
    }

    public void actualizarPais(BPais pais) throws Exception {
        String sql = "update pais set\n" +
                "nombre = ?, idContinente=?, poblacion=?, tamano =? where idPais=?;";

        try (Connection conn = this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, pais.getNombre());
            pstmt.setInt(2, pais.getContinente().getIdContinente());
            pstmt.setInt(3, pais.getPoblacion());
            pstmt.setDouble(4, pais.getTamano());
            pstmt.setInt(5, pais.getIdPais());
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new Exception(e.getMessage());
        }
    }

    public BPais buscarPais(String busqueda) {
        BPais pais = new BPais();
        String sql = "select p.idPais,p.idContinente,p.nombre,p.poblacion,p.tamano,c.nombre from pais p\n" +
                "inner join continente c on p.idContinente = c.idContinente\n" +
                "where p.idPais=?";
        try (Connection conn = this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, Integer.parseInt(busqueda));
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    int idC = rs.getInt(2);
                    String nombreC = rs.getString(6);
                    BContinente continente = new BContinente(idC, nombreC);

                    int idP = rs.getInt(1);
                    String nombreP = rs.getString(3);
                    int poblacionP = rs.getInt(4);
                    double tamanoP = rs.getDouble(5);
                    pais = new BPais(idP, nombreP, poblacionP, tamanoP, continente);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return pais;
    }

    public int contarPaises(String busqueda) {
        ArrayList<BPais> listaPaises = new ArrayList<>();
        String sql = "";
        String orden = "";
        boolean filtrar = false;

        if (busqueda.isEmpty() || busqueda.equals("0")) {
            sql = "select count(*) from pais p\n" +
                    "inner join continente c on p.idContinente = c.idContinente\n";
        } else if (busqueda.length() == 1) {
            sql = "select count(*) from pais p\n" +
                    "inner join continente c on p.idContinente = c.idContinente\n" +
                    "where p.idContinente=?\n";
            filtrar = true;
        } else {
            orden = busqueda.substring(1);
            if (busqueda.charAt(0) == '0') {
                sql = "select count(*) from pais p\n" +
                        "inner join continente c on p.idContinente = c.idContinente\n";
            } else {
                sql = "select count(*) from pais p\n" +
                        "inner join continente c on p.idContinente = c.idContinente\n" +
                        "where p.idContinente=?\n";
                filtrar = true;
            }

        }

        try (Connection conn = this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            if (filtrar) {
                pstmt.setInt(1, Integer.parseInt(busqueda.substring(0, 1)));
            }
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    return rs.getInt(1);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
}
