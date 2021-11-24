package pe.edu.pucp.vip.Controllers;

import pe.edu.pucp.vip.Bean.BContinente;
import pe.edu.pucp.vip.Bean.BPais;
import pe.edu.pucp.vip.Bean.BUniversidad;
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
        PaisDao paisDao = new PaisDao();
        RequestDispatcher view;
        String action = request.getParameter("action") == null ? "buscar" : request.getParameter("action");

        switch (action) {
            case "buscar":
                int busqueda = request.getParameter("busqueda") == null ? 0 : Integer.parseInt(request.getParameter("busqueda"));
                request.setAttribute("busqueda", busqueda);
                String mensaje = request.getParameter("mensaje") == null ? "0" : request.getParameter("mensaje");
                String columna = request.getParameter("columna") == null ? "p.nombre" : request.getParameter("columna");
                request.setAttribute("columna", columna);
                String orden = request.getParameter("orden") == null ? "asc" : request.getParameter("orden");
                request.setAttribute("orden", orden);
                int limit = request.getParameter("limit") == null ? -1 : Integer.parseInt(request.getParameter("limit"));
                request.setAttribute("limit", limit);
                int pag = request.getParameter("pag") == null ? 1 : Integer.parseInt(request.getParameter("pag"));

                request.setAttribute("totalPaises", paisDao.listarPaises(-1,0,columna,orden).size());
                ArrayList<BPais> listaPa = paisDao.listarPaises(-1, busqueda, columna, orden);
                int total = listaPa.size();

                ArrayList<BPais> listaPaises = new ArrayList<>();
                limit = limit == -1 ? 0 : limit;
                int paginas = 0;
                int max = limit * pag;
                if (max > total) {
                    max = total;
                }
                if (limit != 0) {
                    int inicial = ((pag - 1) * limit);
                    paginas = (total % limit) == 0 ? total / limit : (total / limit) + 1;
                    for (int i = inicial; i < max; i++) {
                        listaPaises.add(listaPa.get(i));

                    }
                } else {
                    listaPaises = listaPa;
                }

                request.setAttribute("listaPaises", listaPaises);
                request.setAttribute("pag", pag);
                request.setAttribute("paginas", paginas);

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
                BPais pais = paisDao.buscarPais(request.getParameter("id"));
                request.setAttribute("pais", pais);
                view = request.getRequestDispatcher("paises/editarPais.jsp");
                view.forward(request, response);
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PaisDao paisDao = new PaisDao();
        ArrayList<BPais> listaPaises = new ArrayList<>();
        RequestDispatcher view;
        String action = request.getParameter("action") == null ? "" : request.getParameter("action");
        String id;
        String busqueda;
        String orden;
        String limit;
        int pag;
        int limite;
        switch (action) {
            case "buscar":
                id = request.getParameter("idcontinente") == null ? "0" : request.getParameter("idcontinente");
                limit = request.getParameter("limitb") == null ? "0" : request.getParameter("limitb");
                String columna = request.getParameter("columna") == null ? "p.nombe" : request.getParameter("columna");
//                if (id.equals("0")) {
//                    response.sendRedirect(request.getContextPath() + "/paises?limit=" + limit);
//                } else {
                response.sendRedirect(request.getContextPath() + "/paises?action=buscar&busqueda=" + id + "&limit=" + limit + "&columna=" + columna);
//                }
                break;
            case "eliminar":

                id = request.getParameter("id") == null ? "" : request.getParameter("id");
                busqueda = request.getParameter("busqueda") == null ? "" : request.getParameter("busqueda");
                orden = request.getParameter("orden2") == null ? "na" : request.getParameter("orden2");
                limite = request.getParameter("limite") == null ? 0 : Integer.parseInt(request.getParameter("limite"));
                pag = request.getParameter("page") == null ? 1 : Integer.parseInt(request.getParameter("page"));
                if (id.isEmpty()) {
                    response.sendRedirect(request.getContextPath() + "/paises?&orden=" + orden + "&id=" + busqueda +"&limite=" +limite +"&pag="+pag);
                } else {
                    try {
                        paisDao.borrarPais(Integer.parseInt(id));

                        if (busqueda.equals("0") || busqueda.isEmpty()) {
                            response.sendRedirect(request.getContextPath() + "/paises?orden=" + orden + "&limit=" + limite +"&pag="+pag + "&E=1&mensaje=1");
                        } else {
                            response.sendRedirect(request.getContextPath() + "/paises?action=buscar&orden=" + orden + "&id=" + busqueda + "&limit=" + limite +"&pag="+pag  + "&E=1&mensaje=1");
                        }
                    } catch (Exception e) {
                        if (busqueda.equals("0") || busqueda.isEmpty()) {
                            response.sendRedirect(request.getContextPath() + "/paises?orden=" + orden + "&limit=" + limite +"&pag="+pag + "&mensaje=1");
                        } else {
                            response.sendRedirect(request.getContextPath() + "/paises?action=buscar&orden=" + orden + "&id=" + busqueda + "&limit=" + limite +"&pag="+pag + "&mensaje=1");
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
                    paisDao.insertarPais(pais);
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
                    paisDao.actualizarPais(paisE);
                    response.sendRedirect(request.getContextPath() + "/paises?" + "E=1&mensaje=3");
                } catch (Exception e) {
                    e.printStackTrace();
                    response.sendRedirect(request.getContextPath() + "/paises?mensaje=3");
                }
        }

    }

}
