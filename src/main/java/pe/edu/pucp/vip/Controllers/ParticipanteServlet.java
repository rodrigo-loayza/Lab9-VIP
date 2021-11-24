package pe.edu.pucp.vip.Controllers;

import pe.edu.pucp.vip.Bean.BPais;
import pe.edu.pucp.vip.Bean.BParticipante;
import pe.edu.pucp.vip.Dao.PaisDao;
import pe.edu.pucp.vip.Dao.ParticipanteDao;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "ParticipanteServlet", value = "/participantes")
public class ParticipanteServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        ParticipanteDao participanteDao = new ParticipanteDao();
        PaisDao paisDao = new PaisDao();
        String action = request.getParameter("action") == null ? "listar" : request.getParameter("action");

        String resultado = request.getParameter("resultado") == null ? "" : request.getParameter("resultado");

        RequestDispatcher view;
        switch (action) {
            case "listar":
                //Parametros para listar
                String busqueda = request.getParameter("busqueda") == null ? "" : request.getParameter("busqueda");
                request.setAttribute("busqueda", busqueda);
                int limit = request.getParameter("limit") == null ? 5 : Integer.parseInt(request.getParameter("limit"));
                request.setAttribute("limit", limit);
                String columna = request.getParameter("columna") == null ? "p.nombre" : request.getParameter("columna");
                request.setAttribute("columna", columna);
                String orden = request.getParameter("orden") == null ? "asc" : request.getParameter("orden");
                request.setAttribute("orden", orden);
                request.setAttribute("totalParticipantes", participanteDao.listarParticipantes(-1, "", columna, orden).size());
                request.setAttribute("listaParticipantes", participanteDao.listarParticipantes(limit, busqueda, columna, orden));

                //Alerta
                request.setAttribute("resultado", resultado);

                //Estadisticas
                request.setAttribute("pctGenero", participanteDao.porcentajeGenero());
                request.setAttribute("paisMasParticipantes", participanteDao.paisMasParticipantes());
                request.setAttribute("edadPromedio", participanteDao.edadPromedio());
                request.setAttribute("cantPais", participanteDao.paisCantidadParticipantes());
                request.setAttribute("cantOtrosPaises", participanteDao.sumaParticipantesOtrosPaises());

                //Vista
                view = request.getRequestDispatcher("/participante/participantes.jsp");
                view.forward(request, response);
                break;

            case "crear":
                request.setAttribute("listaPaises", paisDao.listarPaises(""));
                view = request.getRequestDispatcher("/participante/registrarParticipante.jsp");
                view.forward(request, response);
                break;

            case "editar":
                int idParticipante = Integer.parseInt(request.getParameter("idParticipante"));
                request.setAttribute("participante", participanteDao.participanteById(idParticipante));
                request.setAttribute("listaPaises", paisDao.listarPaises(""));
                view = request.getRequestDispatcher("/participante/editarParticipante.jsp");
                view.forward(request, response);
                break;

            case "eliminar":
                int idParticipanteP = Integer.parseInt(request.getParameter("idParticipante"));
                if (participanteDao.eliminarParticipante(idParticipanteP)) {
                    response.sendRedirect(request.getContextPath() + "/participantes?action=listar&resultado=exitoDel");
                } else {
                    response.sendRedirect(request.getContextPath() + "/participantes?action=listar&resultado=falloDel");
                }
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ParticipanteDao participanteDao = new ParticipanteDao();
        PaisDao paisDao = new PaisDao();
        String action = request.getParameter("action");

        RequestDispatcher view;
        switch (action) {
            case "crear":
                String nombre = request.getParameter("nombre");
                String apellido = request.getParameter("apellido");
                int edad = Integer.parseInt(request.getParameter("edad"));
                String genero = request.getParameter("genero");
                int idPais = Integer.parseInt(request.getParameter("pais"));
                BParticipante participante = new BParticipante(nombre, apellido, edad, genero, new BPais(idPais));
                if (participanteDao.crearParticipante(participante)) {
                    response.sendRedirect(request.getContextPath() + "/participantes?action=listar&resultado=exitoReg");
                } else {
                    response.sendRedirect(request.getContextPath() + "/participantes?action=listar&resultado=falloReg");
                }
                break;

            case "editar":
                int idParticipante = Integer.parseInt(request.getParameter("idParticipante"));
                String nombreP = request.getParameter("nombre");
                String apellidoP = request.getParameter("apellido");
                int edadP = Integer.parseInt(request.getParameter("edad"));
                String generoP = request.getParameter("genero");
                int idPaisP = Integer.parseInt(request.getParameter("pais"));
                BParticipante participanteP = new BParticipante(idParticipante, nombreP, apellidoP, edadP, generoP, new BPais(idPaisP));
                if (participanteDao.editarParticipante(participanteP)) {
                    response.sendRedirect(request.getContextPath() + "/participantes?action=listar&resultado=exitoEdit");
                } else {
                    response.sendRedirect(request.getContextPath() + "/participantes?action=listar&resultado=falloEdit");
                }
                break;

            case "listar":
                String busqueda = request.getParameter("busqueda") == null ? "" : request.getParameter("busqueda");
                response.sendRedirect(request.getContextPath() + "/participantes?action=listar&busqueda=" + busqueda);
                break;
        }


    }
}
