package pe.edu.pucp.vip.Controllers;

import pe.edu.pucp.vip.Bean.BAlumno;
import pe.edu.pucp.vip.Bean.BPais;
import pe.edu.pucp.vip.Bean.BParticipante;
import pe.edu.pucp.vip.Bean.BUniversidad;
import pe.edu.pucp.vip.Dao.PaisDAO;
import pe.edu.pucp.vip.Dao.UniversidadDAO;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.ArrayList;

@WebServlet(name = "UniversidadServlet", value = "/universidades")
public class UniversidadServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UniversidadDAO universidadDAO = new UniversidadDAO();
        PaisDAO paisDAO = new PaisDAO();
        String action = request.getParameter("action")==null? "listarUniversidades" : request.getParameter("action");
        RequestDispatcher view;
        ArrayList<BPais> listaPaises;
        switch (action){
            case("listarUniversidades"):
                String columna = request.getParameter("columna") == null ? "u.ranking" : request.getParameter("columna");
                String orden = request.getParameter("orden") == null ? "asc" : request.getParameter("orden");
                if (columna.equals("ranking") || columna.equals("nombre") || columna.equals("numAlumnos")){
                    columna = "u."+columna;
                }else if (columna.equals("nombrePais")){
                    columna="p.nombre";
                }else{
                    columna = "u.ranking";
                }

                ArrayList<BUniversidad> listaUniversidades= universidadDAO.listarUniversidades(columna,orden);
                request.setAttribute("listaUniversidades",listaUniversidades);
                view = request.getRequestDispatcher("/universidad/universidades.jsp");
                view.forward(request, response);
                break;
            case ("listarAlumnos"):
                try{
                    int idUniversidad = Integer.parseInt(request.getParameter("idUniversidad"));
                    BUniversidad universidad = universidadDAO.obtenerUniversidad(idUniversidad);
                    ArrayList<BAlumno> listaAlumnos = universidadDAO.listarAlumnos(idUniversidad);
                    request.setAttribute("universidad",universidad);
                    request.setAttribute("listaAlumnos",listaAlumnos);
                    view = request.getRequestDispatcher("/universidad/alumnosUniversidades.jsp");
                    view.forward(request, response);
                }catch (Exception e){
                    view = request.getRequestDispatcher("/index.jsp");
                    view.forward(request, response);
                }
                break;
            case("registrarUniversidad"):
                listaPaises = paisDAO.listarPaises("");
                request.setAttribute("listaPaises",listaPaises);
                view = request.getRequestDispatcher("/universidad/registrarUniversidad.jsp");
                view.forward(request, response);
                break;
            case("editarUniversidad"):
                try{
                    int idUniversidad = Integer.parseInt(request.getParameter("idUniversidad"));
                    BUniversidad universidadEdit = universidadDAO.obtenerUniversidad(idUniversidad);
                    listaPaises = paisDAO.listarPaises("");
                    request.setAttribute("listaPaises",listaPaises);
                    request.setAttribute("universidad",universidadEdit);
                    view = request.getRequestDispatcher("/universidad/editarUniversidad.jsp");
                    view.forward(request, response);
                }catch (Exception e){
                    view = request.getRequestDispatcher("/index.jsp");
                    view.forward(request, response);
                }
                break;
            case("registrarAlumno"):
                try{
                    int idUniversidad = Integer.parseInt(request.getParameter("idUniversidad"));
                    ArrayList<BParticipante> listaParticipantes = universidadDAO.listarParticipantesDisponibles(idUniversidad);
                    request.setAttribute("listaParticipantes",listaParticipantes);
                    view = request.getRequestDispatcher("/universidad/registrarAlumno.jsp");
                    view.forward(request, response);
                }catch (Exception e){
                    view = request.getRequestDispatcher("/index.jsp");
                    view.forward(request, response);
                }
                break;
            case("editarAlumno"):
                try{
                    int idUniversidad = Integer.parseInt(request.getParameter("idUniversidad"));
                    int idParticipante = Integer.parseInt(request.getParameter("idParticipante"));
                    BAlumno alumno = universidadDAO.obtenerAlumno(idUniversidad, idParticipante);
                    request.setAttribute("alumno",alumno);
                    view = request.getRequestDispatcher("/universidad/editarAlumno.jsp");
                    view.forward(request, response);
                }catch (Exception e){
                    view = request.getRequestDispatcher("/index.jsp");
                    view.forward(request, response);
                }
                break;
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UniversidadDAO universidadDAO = new UniversidadDAO();
        switch (request.getParameter("action")) {
            case "registrarUniversidad":
                try{
                    String nombre = request.getParameter("nombre");
                    String urlFoto = request.getParameter("urlFoto");
                    int ranking = Integer.parseInt(request.getParameter("ranking"));
                    int idPais = Integer.parseInt(request.getParameter("idPais"));
                    BPais pais = new BPais(idPais);
                    BUniversidad universidad = new BUniversidad(nombre,ranking,urlFoto,pais);
                    universidadDAO.registrarUniversidad(universidad);
                    response.sendRedirect(request.getContextPath() + "/universidades?action=listarUniversidades&alerta=exito1");
                }catch(Exception e){
                    response.sendRedirect(request.getContextPath() + "/universidades?action=listarUniversidades&alerta=error1");
                }
                break;
            case "editarUniversidad":
                try{
                    int idUniversidad = Integer.parseInt(request.getParameter("idUniversidad"));
                    String nombre = request.getParameter("nombre");
                    String urlFoto = request.getParameter("urlFoto");
                    int ranking = Integer.parseInt(request.getParameter("ranking"));
                    int idPais = Integer.parseInt(request.getParameter("idPais"));
                    BPais pais = new BPais(idPais);
                    BUniversidad universidad = new BUniversidad(idUniversidad,nombre,ranking,urlFoto,pais);
                    universidadDAO.editarUniversidad(universidad);
                    response.sendRedirect(request.getContextPath() + "/universidades?action=listarUniversidades&alerta=exito2");
                }catch(Exception e){
                    response.sendRedirect(request.getContextPath() + "/universidades?action=listarUniversidades&alerta=error2");
                }
                break;
            case "eliminarUniversidad":
                try{
                    int idUniversidad = Integer.parseInt(request.getParameter("idUniversidad"));
                    int idPais = universidadDAO.obtenerUniversidad(idUniversidad).getPais().getIdPais();
                    universidadDAO.eliminarAlumnosDeUniversidad(idUniversidad);
                    universidadDAO.eliminarUniversidad(idUniversidad);
                    universidadDAO.eliminarParticipantesPaisSinUniversidad(idPais);
                    universidadDAO.eliminarPaisSinUniversidad(idPais);
                    response.sendRedirect(request.getContextPath() + "/universidades?action=listarUniversidades&alerta=exito3");
                }catch(Exception e){
                    response.sendRedirect(request.getContextPath() + "/universidades?action=listarUniversidades&alerta=error3");
                }
                break;
            case "registrarAlumno":
                try{
                    int idUniversidad = Integer.parseInt(request.getParameter("idUniversidad"));
                    int idParticipante = Integer.parseInt(request.getParameter("idParticipante"));
                    String codigo = request.getParameter("codigo");
                    double promedio = Double.parseDouble(request.getParameter("promedio"));
                    BUniversidad universidad = new BUniversidad(idUniversidad);
                    universidadDAO.registrarAlumno(new BAlumno(idParticipante,codigo,promedio,universidad));
                    response.sendRedirect(request.getContextPath() + "/universidades?action=listarAlumnos&idUniversidad="+idUniversidad+"&alerta=exito4");
                }catch(Exception e){
                    response.sendRedirect(request.getContextPath() + "/universidades?action=listarUniversidades&alerta=error4");
                }
                break;
            case "editarAlumno":
                try{
                    int idUniversidad = Integer.parseInt(request.getParameter("idUniversidad"));
                    int idParticipante = Integer.parseInt(request.getParameter("idParticipante"));
                    String codigo = request.getParameter("codigo");
                    double promedio = Double.parseDouble(request.getParameter("promedio"));
                    BUniversidad universidad = new BUniversidad(idUniversidad);
                    universidadDAO.editarAlumno(new BAlumno(idParticipante,codigo,promedio,universidad));
                    response.sendRedirect(request.getContextPath() + "/universidades?action=listarAlumnos&idUniversidad="+idUniversidad+"&alerta=exito5");
                }catch(Exception e){
                    response.sendRedirect(request.getContextPath() + "/universidades?action=listarUniversidades&alerta=error5");
                }
                break;
            case "eliminarAlumno":
                try{
                    int idUniversidad = Integer.parseInt(request.getParameter("idUniversidad"));
                    int idParticipante = Integer.parseInt(request.getParameter("idParticipante"));
                    universidadDAO.eliminarAlumno(idParticipante);
                    response.sendRedirect(request.getContextPath() + "/universidades?action=listarAlumnos&idUniversidad="+idUniversidad+"&alerta=exito6");
                }catch(Exception e){
                    response.sendRedirect(request.getContextPath() + "/universidades?action=listarUniversidades&alerta=error6");
                }
                break;
            case "borrarAlumno":
                try{
                    int idUniversidad = Integer.parseInt(request.getParameter("idUniversidad"));
                    int idParticipante = Integer.parseInt(request.getParameter("idParticipante"));
                    universidadDAO.borrarAlumno(idParticipante);
                    response.sendRedirect(request.getContextPath() + "/universidades?action=listarAlumnos&idUniversidad="+idUniversidad+"&alerta=exito7");
                }catch(Exception e){
                    response.sendRedirect(request.getContextPath() + "/universidades?action=listarAlumnos&&alerta=error7");
                }
                break;
        }
    }

}

/*
* Lista alertas:
* error1: hubo un problema al registrar la universidad
* error2: hubo un problema al editar la universidad
* error3: hubo un problema al eliminar la universidad
* error4: hubo un problema al registrar alumno
* error5: hubo un problema al editar alumno
* error6: hubo un problema al eliminar alumno
* error7: hubo un problema al borrar alumno
*
* exito1: se ha registrado la universidad
* exito2: se ha editado la universidad
* exito3: se ha eliminado la universidad
* exito4: se ha registrado el alumno
* exito5: se ha editado el alumno
* exito6: se ha eliminado el alumno
* exito7: se ha borrado el alumno
*/