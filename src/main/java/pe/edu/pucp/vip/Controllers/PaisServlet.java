package pe.edu.pucp.vip.Controllers;

import pe.edu.pucp.vip.Bean.BContinente;
import pe.edu.pucp.vip.Bean.BPais;
import pe.edu.pucp.vip.Dao.PaisDao;
import pe.edu.pucp.vip.Dao.PaisDao;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.ArrayList;

@WebServlet(name = "PaisServlet", value = "/paises")
public class PaisServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PaisDao paisDAO = new PaisDao();
        ArrayList<BPais> listaPaises = new ArrayList<>();
        RequestDispatcher view;
        String action = request.getParameter("action") == null ? "buscar" : request.getParameter("action");

        switch (action) {
            case "buscar":
                String busqueda = request.getParameter("id") == null ? "0" : request.getParameter("id");
                String mensaje = request.getParameter("mensaje") == null ? "0" : request.getParameter("mensaje");
                String orden = request.getParameter("orden") == null ? "na" : request.getParameter("orden");
                int limit = request.getParameter("limit") == null ? 0 : Integer.parseInt(request.getParameter("limit"));
                int pag = request.getParameter("pag") == null ? 1 : Integer.parseInt(request.getParameter("pag"));
                request.setAttribute("limit", limit);
                request.setAttribute("orden", orden);
                request.setAttribute("idcontinente", busqueda);

                if (limit == 0) {
                    request.setAttribute("pag", pag);
                    listaPaises = paisDAO.listarPaises(busqueda + orden);
                    request.setAttribute("paginas", 0);
                } else {
                    listaPaises = paisDAO.listarPaises(busqueda + orden, pag, limit);
                    int total = paisDAO.contarPaises(busqueda);
                    int paginas = total / limit;
                    if (total % limit != 0) {
                        paginas++;
                    }
                    request.setAttribute("paginas", paginas);
                    request.setAttribute("pag", pag);

                }

                request.setAttribute("listaPaises", listaPaises);
                request.setAttribute("mensaje", mensaje);
                request.setAttribute("E", request.getParameter("E"));


                view = request.getRequestDispatcher("paises/paises.jsp");
                view.forward(request, response);
                break;
            case "registrar":


                view = request.getRequestDispatcher("paises/registrarPais.jsp");
                view.forward(request, response);
                break;
            case "editar":
                BPais pais = paisDAO.buscarPais(request.getParameter("id"));
                request.setAttribute("pais", pais);
                view = request.getRequestDispatcher("paises/editarPais.jsp");
                view.forward(request, response);
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PaisDao paisDAO = new PaisDao();
        ArrayList<BPais> listaPaises = new ArrayList<>();
        RequestDispatcher view;
        String action = request.getParameter("action") == null ? "" : request.getParameter("action");
        String id;
        String busqueda;
        String orden;
        String limit;
        int limite;
        switch (action) {
            case "buscar":
                id = request.getParameter("idcontinente") == null ? "" : request.getParameter("idcontinente");
                limit = request.getParameter("limitb") == null? "0" : request.getParameter("limitb");
                if (id.equals("0")) {
                    response.sendRedirect(request.getContextPath() + "/paises?limit="+limit);
                } else {
                    response.sendRedirect(request.getContextPath() + "/paises?action=buscar&id=" + id+"&limit="+limit);
                }
                break;
            case "eliminar":

                id = request.getParameter("id") == null ? "" : request.getParameter("id");
                busqueda = request.getParameter("busqueda") == null ? "" : request.getParameter("busqueda");
                orden = request.getParameter("orden2") == null ? "na" : request.getParameter("orden2");
                limite = request.getParameter("limite") == null ? 0 : Integer.parseInt(request.getParameter("limite"));
                if (id.isEmpty()) {
                    response.sendRedirect(request.getContextPath() + "/paises?&orden=" + orden + "&id=" + busqueda);
                } else {
                    try {
                        paisDAO.borrarPais(Integer.parseInt(id));

                        if (busqueda.equals("0") || busqueda.isEmpty()) {
                            response.sendRedirect(request.getContextPath() + "/paises?orden=" + orden + "&limit=" + limite + "&E=1&mensaje=1");
                        } else {
                            response.sendRedirect(request.getContextPath() + "/paises?action=buscar&orden=" + orden + "&id=" + busqueda + "&limit=" + limite + "&E=1&mensaje=1");
                        }
                    } catch (Exception e) {
                        if (busqueda.equals("0") || busqueda.isEmpty()) {
                            response.sendRedirect(request.getContextPath() + "/paises?orden=" + orden + "&limit=" + limite + "&mensaje=1");
                        } else {
                            response.sendRedirect(request.getContextPath() + "/paises?action=buscar&orden=" + orden + "&id=" + busqueda + "&limit=" + limite + "&mensaje=1");
                        }

                    }
                }
                break;
            case "registrar":
                String nombre = request.getParameter("nombre");
                int idcontinente = Integer.parseInt(request.getParameter("idcontinente"));
                int poblacion = Integer.parseInt(request.getParameter("poblacion"));
                double tamano = Double.parseDouble(request.getParameter("tamano"));
                BContinente continente = new BContinente(idcontinente, "");
                BPais pais = new BPais(0, nombre, poblacion, tamano, continente);

                try {
                    paisDAO.insertarPais(pais);
                    response.sendRedirect(request.getContextPath() + "/paises?" + "E=1&mensaje=2");
                } catch (Exception e) {
                    e.printStackTrace();
                    response.sendRedirect(request.getContextPath() + "/paises?mensaje=2");
                }
                break;
            case "editar":
                int idpais = Integer.parseInt(request.getParameter("idpais"));
                String nombreE = request.getParameter("nombre");
                int idcontinenteE = Integer.parseInt(request.getParameter("idcontinente"));
                int poblacionE = Integer.parseInt(request.getParameter("poblacion"));
                double tamanoE = Double.parseDouble(request.getParameter("tamano"));
                BContinente continenteE = new BContinente(idcontinenteE, "");
                BPais paisE = new BPais(idpais, nombreE, poblacionE, tamanoE, continenteE);

                try {
                    paisDAO.actualizarPais(paisE);
                    response.sendRedirect(request.getContextPath() + "/paises?" + "E=1&mensaje=3");
                } catch (Exception e) {
                    e.printStackTrace();
                    response.sendRedirect(request.getContextPath() + "/paises?mensaje=3");
                }
        }

    }

}
