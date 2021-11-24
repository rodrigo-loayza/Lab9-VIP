<%@ page import="pe.edu.pucp.vip.Bean.BAlumno" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="listaAlumnos" scope="request" type="java.util.ArrayList<pe.edu.pucp.vip.Bean.BAlumno>"/>
<jsp:useBean id="universidad" scope="request" type="pe.edu.pucp.vip.Bean.BUniversidad"/>
<%String alerta = request.getParameter("alerta");%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
        <title>VIP - Alumnos PUCP</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
              crossorigin="anonymous">
        <link rel="stylesheet" href="<%=request.getContextPath()%>/res/css/estilos.css">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Macondo&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
        <link href="https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/flag-icon-css/4.1.5/css/flag-icons.min.css"
              integrity="sha512-UwbBNAFoECXUPeDhlKR3zzWU3j8ddKIQQsDOsKhXQGdiB5i3IHEXr9kXx82+gaHigbNKbTDp3VY/G6gZqva6ZQ=="
              crossorigin="anonymous" referrerpolicy="no-referrer"/>
    </head>
    <body>
    <jsp:include page="/includes/navbar.jsp">
        <jsp:param name="page" value="universidades"/>
    </jsp:include>
        <!--Espacio-->
        <div class="card-header py-2 my-4"></div>

    <!--Alerta de errores-->
    <%
        if (alerta != null) {
            String tipoAlerta = "warning";
            String mensaje = "";
            if (alerta.startsWith("error")) {
                tipoAlerta = "danger";
            }
            if (alerta.startsWith("exito")) {
                tipoAlerta = "success";
            }
            switch (alerta) {
                case ("exito4"):
                    mensaje = "Se ha registrado el alumno";
                    break;
                case ("exito5"):
                    mensaje = "Se ha editado el alumno";
                    break;
                case ("exito6"):
                    mensaje = "Se ha eliminado el alumno";
                    break;
                case ("exito7"):
                    mensaje = "Se ha borrado el alumno";
                    break;
            }
    %>
    <div class="alert alert-<%=tipoAlerta%> alert-dismissible fade show" role="alert"
         style="margin: 52px auto 0px; width: 90%">
        <%=mensaje%>
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    <%
        }
    %>

        <!--Contenido-->
        <section class="py-3">
            <div class="container">
                <div class="table-responsive">
                    <div class="table-wrapper">
                        <div class="table-title ">
                            <div class="row">
                                <div class="row" style="width: 95%;">
                                    <div class="col-sm-8" style="width: fit-content;">
                                        <img src="<%=universidad.getUrlFoto()%>" class="img-fluid " alt="<%=universidad.getNombre()%>" style="max-height: 120px; background-color: #fff;border-radius: 0.25rem">
                                    </div>
                                    <div class="col-sm-8" style="width: fit-content;">
                                        <h1><%=universidad.getNombre()%></h1>
                                        <h5><%=universidad.getPais().getNombre()%></h5>
                                    </div>
                                </div>
                                <div class="col-sm-8 text-end" style="width: 5%">
                                    <a role="button" class="text-warning"
                                       href="<%=request.getContextPath()%>/universidades?action=registrarAlumno&idUniversidad=<%=universidad.getIdUniversidad()%>">
                                        <i class="bi bi-person-plus-fill"
                                           style="font-size: 30px;"></i>
                                    </a>
                                </div>
                            </div>
                        </div>
                        <table class="table table-striped table-hover">
                            <thead>
                                <tr class="text-center">
                                    <th class="col-2">Nombre</th>
                                    <th class="col-2">Apellido</th>
                                    <th class="col-1">Edad</th>
                                    <th class="col-2">Código</th>
                                    <th class="col-1">Promedio</th>
                                    <th class="col-2">Condición</th>
                                    <th class="col-1">Editar</th>
                                    <th class="col-1">Eliminar</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                for(BAlumno alumno : listaAlumnos){
                                    String classText="";
                                    String classStIcon = "bi bi-emoji-smile-fill text-success";
                                    String classDelIcon = "bi bi-x-circle-fill";
                                    String condicion = "Normal";
                                    String action = request.getContextPath()+"/universidades?action=eliminarAlumno&idUniversidad="+universidad.getIdUniversidad()+"&idParticipante="+alumno.getIdParticipante();
                                    if(alumno.getCondicionEliminado()){
                                        classText = "text-danger";
                                        classStIcon = "bi bi-emoji-frown-fill text-danger";
                                        classDelIcon = "fas fa-trash-alt";
                                        condicion = "Eliminado";
                                        action = request.getContextPath()+"/universidades?action=borrarAlumno&idUniversidad="+universidad.getIdUniversidad()+"&idParticipante="+alumno.getIdParticipante();
                                    }
                                %>
                                <tr class="text-center">
                                    <td class="<%=classText%>"><%=alumno.getNombre()%></td>
                                    <td class="<%=classText%>"><%=alumno.getApellido()%></td>
                                    <td class="<%=classText%>"><%=alumno.getEdad()%></td>
                                    <td class="<%=classText%>"><%=alumno.getCodigo()%></td>
                                    <td class="<%=classText%>"><%=String.format("%.2f", alumno.getPromedio())%></td>
                                    <td class="<%=classText%>"><i class="<%=classStIcon%>"></i> <%=condicion%></td>
                                    <td class="<%=classText%>">
                                        <%
                                        if(!alumno.getCondicionEliminado()){
                                        %>
                                        <a href="<%=request.getContextPath()%>/universidades?action=editarAlumno&idUniversidad=<%=universidad.getIdUniversidad()%>&idParticipante=<%=alumno.getIdParticipante()%>">
                                            <i class="fas fa-edit"></i>
                                        </a>
                                        <%
                                        }
                                        %>
                                    </td>
                                    <td class="text-danger">
                                        <form id="formBorrar<%=alumno.getIdParticipante()%>" method="post" action="<%=action%>">
                                            <a href="#" class="text-danger" style="color: black" onclick="document.getElementById('formBorrar<%=alumno.getIdParticipante()%>').submit()"><i class="<%=classDelIcon%>"></i></a>
                                        </form>
                                    </td>
                                </tr>
                                <%
                                }
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </section>

        <!--JS-->
        <script src="https://kit.fontawesome.com/5733880de3.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
                crossorigin="anonymous"></script>
    </body>
</html>