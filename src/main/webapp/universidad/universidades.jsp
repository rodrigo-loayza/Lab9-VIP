<%@ page import="pe.edu.pucp.vip.Bean.BUniversidad" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="listaUniversidades" scope="request" type="java.util.ArrayList<pe.edu.pucp.vip.Bean.BUniversidad>"/>
<%
    String columna = request.getParameter("columna") == null ? "ranking" : request.getParameter("columna");
    String orden = request.getParameter("orden") == null ? "asc" : request.getParameter("orden");
    String alerta = request.getParameter("ecode");
%>


<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
        <title>VIP - Universidades</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
              crossorigin="anonymous">
        <link rel="stylesheet" href="<%=request.getContextPath()%>/res/css/estilos.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Macondo&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/flag-icon-css/4.1.5/css/flag-icons.min.css"
              integrity="sha512-UwbBNAFoECXUPeDhlKR3zzWU3j8ddKIQQsDOsKhXQGdiB5i3IHEXr9kXx82+gaHigbNKbTDp3VY/G6gZqva6ZQ=="
              crossorigin="anonymous" referrerpolicy="no-referrer"/>
    </head>
    <body>
        <!--Navbar-->
        <jsp:include page="/includes/navbar.jsp">
            <jsp:param name="page" value="universidades"/>
        </jsp:include>
        <!--Espacio-->
        <div class="card-header py-2 my-4"></div>

        <!--Contenido-->

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
                    case ("error1"):
                        mensaje = "Hubo un error al registrar la universidad";
                        break;
                    case ("error2"):
                        mensaje = "Hubo un error al editar la universidad";
                        break;
                    case ("error3"):
                        mensaje = "Hubo un error al editar la banda";
                        break;
                    case ("error4"):
                        mensaje = "No se puede eliminar la banda, tiene por lo menos un album asociado";
                        break;
                    case ("error5"):
                        mensaje = "No se puede eliminar la banda, tiene por lo menos un artista asociado";
                        break;
                    case ("exito1"):
                        mensaje = "Se ha registrado la universidad";
                        break;
                    case ("exito2"):
                        mensaje = "Se ha editado la universidad";
                        break;
                    case ("exito3"):
                        mensaje = "Se ha editado la banda";
                        break;
                }
        %>
        <div class="alert alert-<%=tipoAlerta%> alert-dismissible fade show" role="alert"
             style="margin: 30px auto 20px; width: 90%">
            <%=mensaje%>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
        <%
            }
        %>

        <section class="py-3">
            <div class="container">
                <div class="table-responsive">
                    <div class="table-wrapper">
                        <div class="table-title ">
                            <div class="row">
                                <div class="col-sm-4">
                                    <h2>Lista de Universidades</h2>
                                </div>
                            </div>
                        </div>
                        <table class="table table-hover">
                            <!--Cabecera de la tabla -->
                            <thead>
                                <tr class="text-center">
                                    <th class="col-1">
                                        <%
                                            String hrefR = request.getContextPath()+"/universidades?columna=ranking&orden=asc";
                                            String classR = "bi bi-caret-up";
                                            if(columna.equals("ranking")){
                                                classR="bi bi-caret"+(orden.equals("asc")?"-up":"-down")+"-fill";
                                                hrefR = request.getContextPath()+"/universidades?columna=ranking&orden="+(orden.equals("asc")?"desc":"asc");
                                            }
                                        %>
                                        <a href="<%=hrefR%>"
                                           class="text-decoration-none black" style="color: black">
                                            Ranking

                                            <i class="<%=classR%>" ></i></a>
                                    </th>
                                    <th class="col-2">Imagen</th>
                                    <th class="col-3">
                                        <%
                                            String hrefN = request.getContextPath()+"/universidades?columna=nombre&orden=asc";
                                            String classN = "bi bi-caret-up";
                                            if(columna.equals("nombre")){
                                                classN="bi bi-caret"+(orden.equals("asc")?"-up":"-down")+"-fill";
                                                hrefN = request.getContextPath()+"/universidades?columna=nombre&orden="+(orden.equals("asc")?"desc":"asc");
                                            }
                                        %>
                                        <a href="<%=hrefN%>"
                                           class="text-decoration-none black" style="color: black">
                                            Nombre
                                            <i class="<%=classN%>" ></i></a>
                                    </th>
                                    <th class="col-1">
                                        <%
                                            String hrefP = request.getContextPath()+"/universidades?columna=nombrePais&orden=asc";
                                            String classP = "bi bi-caret-up";
                                            if(columna.equals("nombrePais")){
                                                classP="bi bi-caret"+(orden.equals("asc")?"-up":"-down")+"-fill";
                                                hrefP = request.getContextPath()+"/universidades?columna=nombrePais&orden="+(orden.equals("asc")?"desc":"asc");
                                            }
                                        %>
                                        <a href="<%=hrefP%>"
                                           class="text-decoration-none black" style="color: black">
                                            País
                                            <i class="<%=classP%>" ></i></a>
                                    </th>
                                    <th class="col-1">
                                        <%
                                            String hrefA = request.getContextPath()+"/universidades?columna=numAlumnos&orden=asc";
                                            String classA = "bi bi-caret-up";
                                            if(columna.equals("numAlumnos")){
                                                classA="bi bi-caret"+(orden.equals("asc")?"-up":"-down")+"-fill";
                                                hrefA = request.getContextPath()+"/universidades?columna=numAlumnos&orden="+(orden.equals("asc")?"desc":"asc");
                                            }
                                        %>
                                        <a href="<%=hrefA%>"
                                           class="text-decoration-none black" style="color: black">
                                            Alumnos
                                            <i class="<%=classA%>" ></i></a>
                                    </th>
                                    <th class="col-1">Editar</th>
                                    <th class="col-1">Eliminar</th>
                                    <th class="col-2">Ver alumnos</th>
                                </tr>
                            </thead>
                            <tbody>
                                <!-- Universidades -->
                                <%
                                for (BUniversidad universidad : listaUniversidades){
                                    String classRow = "text-center";
                                    String style ="";
                                    switch(universidad.getPais().getContinente().getIdContinente()){
                                        case(1):
                                            style ="--bs-table-bg: #78b2de; " +
                                                   "--bs-table-hover-bg: #789baf;";
                                            break;
                                        case(2):
                                            style ="--bs-table-bg: #f2bf6d; " +
                                                    "--bs-table-hover-bg: #b8a16d;";
                                            break;
                                        case(3):
                                            style ="--bs-table-bg: #a8e9a8; " +
                                                    "--bs-table-hover-bg: #96b496;";
                                            break;
                                        case(4):
                                            style ="--bs-table-bg: #f99678; " +
                                                    "--bs-table-hover-bg: #bb8e78;";
                                            break;
                                        case(5):
                                            style ="--bs-table-bg: #8bd5dd; " +
                                                    "--bs-table-hover-bg: #89abae;";
                                            break;
                                    }
                                %>
                                <tr class="text-center" style="<%=style%>">
                                    <td><%=universidad.getRanking()%></td>
                                    <td><img
                                            src="<%=universidad.getUrlFoto()%>"
                                            class="img-fluid " alt="<%=universidad.getNombre()%>" style="max-height: 120px; background-color: #fff;border-radius: 0.25rem">
                                    </td>
                                    <td><%=universidad.getNombre()%></td>
                                    <td><%=universidad.getPais().getNombre()%> <span class="flag-icon flag-icon-pe"></span></td>
                                    <td><%=universidad.getNumAlumnos()%></td>
                                    <td><a href="<%=request.getContextPath()%>/universidades?action=editarUniversidad&idUniversidad=<%=universidad.getIdUniversidad()%>" style="color: black"><i class="fas fa-edit"></i></a></td>
                                    <td><a href="#" style="color: black"><i class="fas fa-trash-alt"></i></a></td>
                                    <td><a href="<%=request.getContextPath()%>/universidades?action=listarAlumnos&idUniversidad=<%=universidad.getIdUniversidad()%>" style="color: black"><i class="fas fa-users"></i></a></td>
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