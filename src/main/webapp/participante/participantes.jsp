<%@ page import="pe.edu.pucp.vip.Bean.BParticipante" %>
<%@ page import="java.util.Set" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="limit" scope="request" type="java.lang.Integer"/>
<jsp:useBean id="busqueda" scope="request" type="java.lang.String"/>
<jsp:useBean id="orden" scope="request" type="java.lang.String"/>
<jsp:useBean id="columna" scope="request" type="java.lang.String"/>
<jsp:useBean id="totalParticipantes" scope="request" type="java.lang.Integer"/>
<jsp:useBean id="listaParticipantes" scope="request" type="java.util.ArrayList<pe.edu.pucp.vip.Bean.BParticipante>"/>
<jsp:useBean id="paisMasParticipantes" scope="request" type="java.lang.String"/>
<jsp:useBean id="edadPromedio" scope="request" type="java.lang.Integer"/>
<jsp:useBean id="pctGenero" scope="request" type="java.util.HashMap<java.lang.String, java.lang.Integer>"/>
<jsp:useBean id="cantPais" scope="request" type="java.util.HashMap<java.lang.String, java.lang.Integer>"/>
<jsp:useBean id="cantOtrosPaises" scope="request" type="java.lang.Integer"/>
<jsp:useBean id="resultado" scope="request" type="java.lang.String"/>

<%
    //Mapeo de las listas de paises y su cantidad de participantes para pasarlas a javascript
    Set<String> keys = cantPais.keySet();
    String[] paisC = keys.toArray(new String[keys.size()]);
    int[] cantP = new int[5];
    for (int i = 0; i < 5; i++) {
        cantP[i] = cantPais.get(paisC[i]);
    }
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
        <title>VIP - Participantes</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
              crossorigin="anonymous">
        <link rel="stylesheet" href="<%=request.getContextPath()%>/res/css/estilos.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Macondo&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/flag-icon-css/4.1.5/css/flag-icons.min.css"
              integrity="sha512-UwbBNAFoECXUPeDhlKR3zzWU3j8ddKIQQsDOsKhXQGdiB5i3IHEXr9kXx82+gaHigbNKbTDp3VY/G6gZqva6ZQ=="
              crossorigin="anonymous" referrerpolicy="no-referrer"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.css"
              integrity="sha512-SUJFImtiT87gVCOXl3aGC00zfDl6ggYAw5+oheJvRJ8KBXZrr/TMISSdVJ5bBarbQDRC2pR5Kto3xTR0kpZInA=="
              crossorigin="anonymous" referrerpolicy="no-referrer"/>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
    </head>
    <%--pais(<%=listaPaisesCantidad.toString()%>,<%=listaCantidadPaises.toString()%>,<%=cantOtrosPaises%>);--%>
    <body onload="start(<%=pctGenero.get("hombre")%>,<%=pctGenero.get("mujer")%>,<%=pctGenero.get("otros")%>,<%="'"+paisC[0]+"'"%>,<%="'"+paisC[1]+"'"%>,<%="'"+paisC[2]+"'"%>,<%="'"+paisC[3]+"'"%>,<%="'"+paisC[4]+"'"%>,<%=cantP[0]%>,<%=cantP[1]%>,<%=cantP[2]%>,<%=cantP[3]%>,<%=cantP[4]%>,<%=cantOtrosPaises%>);">
        <!--Navbar-->
        <jsp:include page="/includes/navbar.jsp">
            <jsp:param name="page" value="participantes"/>
        </jsp:include>

        <!--Espacio-->
        <div class="card-header py-2 my-4"></div>

        <!--Contenido-->
        <section class="py-3">
            <div class="container">
                <%
                    String alertClass = "";
                    String alertMssg = "";
                    if (!resultado.equals("")) {
                        switch (resultado) {
                            case "exitoReg":
                                alertClass = "alert-success";
                                alertMssg = "Registrado exitosamente!";
                                break;
                            case "falloReg":
                                alertClass = "alert-danger";
                                alertMssg = "Fallo en el registro";
                                break;
                            case "exitoEdit":
                                alertClass = "alert-success";
                                alertMssg = "Editado exitosamente!";
                                break;
                            case "falloEdit":
                                alertClass = "alert-danger";
                                alertMssg = "Fallo al editar";
                                break;
                            case "exitoDel":
                                alertClass = "alert-success";
                                alertMssg = "Eliminado exitosamente!";
                                break;
                            case "falloDel":
                                alertClass = "alert-danger";
                                alertMssg = "Fallo al eliminar";
                                break;
                        }
                %>
                <div class="alert <%=alertClass%> alert-dismissible fade show" role="alert">
                    <%=alertMssg%>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <% } %>
                <!--Tabla de participantes-->
                <div class="table-responsive">
                    <div class="table-wrapper">
                        <!--Título tabla-->
                        <div class="table-title ">
                            <div class="row">
                                <div class="col-sm-4">
                                    <h2>Lista de Participantes</h2>
                                </div>
                                <div class="col-sm-8 text-end" style="margin-top: -8px">
                                    <a role="button" class="text-warning"
                                       href="<%=request.getContextPath()%>/participantes?action=crear">
                                        <i class="bi bi-person-plus-fill"
                                           style="font-size: 30px;"></i>
                                    </a>
                                </div>
                            </div>
                        </div>
                        <div class="table-filter">
                            <div class="row">
                                <div class="col-sm-3">
                                    <div class="show-entries">
                                        <span>Mostrar</span>
                                        <label>
                                            <form method='get'
                                                  action='<%=request.getContextPath()%>/participantes?action=listar&columna=<%=columna%>&orden=<%=orden%>'>
                                                <select class="form-control" name="limit"
                                                        onchange='this.form.submit();'>
                                                    <option value="5" <%=limit == 5 ? "selected" : ""%>>5</option>
                                                    <option value="10" <%=limit == 10 ? "selected" : ""%>>10</option>
                                                    <option value="15" <%=limit == 15 ? "selected" : ""%>>15</option>
                                                    <option value="-1" <%=limit == -1 ? "selected" : ""%>>All</option>
                                                </select>
                                            </form>
                                        </label>
                                        <span>participantes</span>
                                    </div>
                                </div>
                                <div class="col-sm-9">
                                    <form method="post"
                                          action="<%=request.getContextPath()%>/participantes?action=listar">
                                        <button type="submit" class="btn btn-primary"><i class="fa fa-search"></i>
                                        </button>
                                        <div class="filter-group">
                                            <label>Nombre</label>
                                            <input type="text" class="form-control" name="busqueda"
                                                   value="<%=busqueda%>">
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                        <table class="table table-striped table-bordered table-hover">
                            <thead>
                                <tr class="text-center" id="cabecera-container">
                                    <th class="col-2">
                                        <%
                                            String hrefN = request.getContextPath() + "/participantes?columna=p.nombre&orden=asc&limit=" + limit;
                                            String classN = "fa-minus-circle";
                                            if (columna.equals("p.nombre")) {
                                                classN = "fa-chevron-circle" + (orden.equals("asc") ? "-up" : "-down");
                                                hrefN = request.getContextPath() + "/participantes?columna=p.nombre&orden=" + (orden.equals("asc") ? "desc" : "asc");
                                            }
                                        %>
                                        <a href="<%=hrefN%>"
                                           class="text-decoration-none text-dark d-flex justify-content-between">
                                            Nombre
                                            <i class="fas <%=classN%> pt-2"></i></a>
                                    </th>
                                    <th class="col-3">
                                        <%
                                            String hrefA = request.getContextPath() + "/participantes?columna=p.apellido&orden=asc&limit=" + limit;
                                            String classA = "fa-minus-circle";
                                            if (columna.equals("p.apellido")) {
                                                classA = "fa-chevron-circle" + (orden.equals("asc") ? "-up" : "-down");
                                                hrefA = request.getContextPath() + "/participantes?columna=p.apellido&orden=" + (orden.equals("asc") ? "desc" : "asc");
                                            }
                                        %>
                                        <a href="<%=hrefA%>"
                                           class="text-decoration-none text-dark d-flex justify-content-between">
                                            Apellido
                                            <i class="fas <%=classA%> pt-2"></i>
                                        </a>
                                    </th>
                                    <th class="col-1">
                                        <%
                                            String hrefE = request.getContextPath() + "/participantes?columna=p.edad&orden=asc&limit=" + limit;
                                            String classE = "fa-minus-circle";
                                            if (columna.equals("p.edad")) {
                                                classE = "fa-chevron-circle" + (orden.equals("asc") ? "-up" : "-down");
                                                hrefE = request.getContextPath() + "/participantes?columna=p.edad&orden=" + (orden.equals("asc") ? "desc" : "asc");
                                            }
                                        %>
                                        <a href="<%=hrefE%>"
                                           class="text-decoration-none text-dark d-flex justify-content-between">
                                            Edad
                                            <i class="fas <%=classE%> pt-2"></i>
                                        </a>
                                    </th>
                                    <th class="col-2">
                                        <%
                                            String hrefNa = request.getContextPath() + "/participantes?columna=p2.nombre&orden=asc&limit=" + limit;
                                            String classNa = "fa-minus-circle";
                                            if (columna.equals("p2.nombre")) {
                                                classNa = "fa-chevron-circle" + (orden.equals("asc") ? "-up" : "-down");
                                                hrefNa = request.getContextPath() + "/participantes?columna=p2.nombre&orden=" + (orden.equals("asc") ? "desc" : "asc");
                                            }
                                        %>
                                        <a href="<%=hrefNa%>"
                                           class="text-decoration-none text-dark d-flex justify-content-between">
                                            Nacionalidad
                                            <i class="fas <%=classNa%> pt-2"></i>
                                        </a>
                                    </th>
                                    <th class="col-2">
                                        <%
                                            String hrefG = request.getContextPath() + "/participantes?columna=p.genero&orden=asc&limit=" + limit;
                                            String classG = "fa-minus-circle";
                                            if (columna.equals("p.genero")) {
                                                classG = "fa-chevron-circle" + (orden.equals("asc") ? "-up" : "-down");
                                                hrefG = request.getContextPath() + "/participantes?columna=p.genero&orden=" + (orden.equals("asc") ? "desc" : "asc");
                                            }
                                        %>
                                        <a href="<%=hrefG%>"
                                           class="text-decoration-none text-dark d-flex justify-content-between">
                                            Género
                                            <i class="fas <%=classG%> pt-2"></i>
                                        </a>
                                    </th>
                                    <th class="col-1">Editar
                                    </th>
                                    <th class="col-1">Eliminar
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    for (BParticipante participante : listaParticipantes) {
                                %>
                                <tr class="text-center">
                                    <td><%=participante.getNombre()%>
                                    </td>
                                    <td><%=participante.getApellido()%>
                                    </td>
                                    <td><%=participante.getEdad()%>
                                    </td>
                                    <td><%=participante.getPais().getNombre()%>
                                        <span class="flag-icon flag-icon-pe"></span>
                                    </td>
                                    <td><%=participante.getGenero().substring(0, 1).toUpperCase() + participante.getGenero().substring(1)%>
                                    </td>
                                    <td>
                                        <a href="<%=request.getContextPath()%>/participantes?action=editar&idParticipante=<%=participante.getIdParticipante()%>">
                                            <i class="fas fa-edit"></i>
                                        </a>
                                    </td>
                                    <td>
                                        <a href="<%=request.getContextPath()%>/participantes?action=eliminar&idParticipante=<%=participante.getIdParticipante()%>">
                                            <i class="fas fa-trash-alt text-danger"></i>
                                        </a>
                                    </td>
                                </tr>
                                <%
                                    }
                                %>
                            </tbody>
                        </table>
                        <div class="clearfix">
                            <div class="hint-text">Mostrando <b><%=limit == -1 ? totalParticipantes : limit%>
                            </b> de <b><%=totalParticipantes%>
                            </b> participantes
                            </div>
                            <%--                            <ul class="pagination">--%>
                            <%--                                <li class="page-item disabled"><a href="#">Previous</a></li>--%>
                            <%--                                <li class="page-item"><a href="#" class="page-link">1</a></li>--%>
                            <%--                                <li class="page-item"><a href="#" class="page-link">2</a></li>--%>
                            <%--                                <li class="page-item"><a href="#" class="page-link">3</a></li>--%>
                            <%--                                <li class="page-item active"><a href="#" class="page-link">4</a></li>--%>
                            <%--                                <li class="page-item"><a href="#" class="page-link">5</a></li>--%>
                            <%--                                <li class="page-item"><a href="#" class="page-link">6</a></li>--%>
                            <%--                                <li class="page-item"><a href="#" class="page-link">7</a></li>--%>
                            <%--                                <li class="page-item"><a href="#" class="page-link">Next</a></li>--%>
                            <%--                            </ul>--%>
                        </div>
                    </div>
                </div>
                <!--Estadísticas-->
                <div class="table-responsive">
                    <!--Contenido-->
                    <div class="table-wrapper">
                        <!--Tiltulo-->
                        <div class="table-title">
                            <div class="row">
                                <div class="col-sm-4">
                                    <h2>Estadísticas</h2>
                                </div>
                            </div>
                        </div>
                        <!--Estadísticas-->
                        <div class="row justify-content-around">
                            <!--Género-->
                            <div class="col-xl-4 px-0">
                                <div class="row">
                                    <div class="card shadow mb-3 px-0">
                                        <!--Card Header-->
                                        <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                            <h6 class="m-0 font-weight-bold">Porcentajes de Género</h6>
                                        </div>
                                        <!--Card Body-->
                                        <div class="card-body d-flex justify-content-center align-items-center">
                                            <div class="chart-pie">
                                                <canvas id="myChart"></canvas>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <!--Edad promedio-->
                                    <div class="card border-left-card shadow py-2 mb-2">
                                        <div class="card-body">
                                            <div class="row no-gutters align-items-center">
                                                <div class="col mr-2">
                                                    <div class="fs-6 font-weight-bold text-warning mb-1">
                                                        Edad promedio
                                                    </div>
                                                    <div class="h5 mb-0 font-weight-bold text-gray-800">
                                                        <%=edadPromedio%>
                                                    </div>
                                                </div>
                                                <div class="col-auto">
                                                    <i class="fas fa-user fa-2x text-gray-300"></i>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <!--País con más participantes-->
                                    <div class="card border-left-card shadow py-2 my-auto">
                                        <div class="card-body">
                                            <div class="row no-gutters align-items-center">
                                                <div class="col mr-2">
                                                    <div class="fs-6 font-weight-bold text-warning mb-1">
                                                        País con más participantes
                                                    </div>
                                                    <div class="h5 mb-0 font-weight-bold text-gray-800">
                                                        <%=paisMasParticipantes%>
                                                    </div>
                                                </div>
                                                <div class="col-auto">
                                                    <i class="fas fa-globe-americas fa-2x text-gray-300"></i>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!--Cards-->
                            <%--                            <div class="col-xl-12 col-md-12">--%>
                            <%--                                <div class="d-flex flex-column justify-content-between h-100">--%>
                            <%--                                    <!--Edad promedio-->--%>
                            <%--                                    <div class="card border-left-card shadow py-2 my-auto">--%>
                            <%--                                        <div class="card-body">--%>
                            <%--                                            <div class="row no-gutters align-items-center">--%>
                            <%--                                                <div class="col mr-2">--%>
                            <%--                                                    <div class="fs-6 font-weight-bold text-warning mb-1">--%>
                            <%--                                                        Edad promedio--%>
                            <%--                                                    </div>--%>
                            <%--                                                    <div class="h5 mb-0 font-weight-bold text-gray-800">--%>
                            <%--                                                        <%=edadPromedio%>--%>
                            <%--                                                    </div>--%>
                            <%--                                                </div>--%>
                            <%--                                                <div class="col-auto">--%>
                            <%--                                                    <i class="fas fa-user fa-2x text-gray-300"></i>--%>
                            <%--                                                </div>--%>
                            <%--                                            </div>--%>
                            <%--                                        </div>--%>
                            <%--                                    </div>--%>
                            <%--                                    <!--País con más participantes-->--%>
                            <%--                                    <div class="card border-left-card shadow py-2 my-auto">--%>
                            <%--                                        <div class="card-body">--%>
                            <%--                                            <div class="row no-gutters align-items-center">--%>
                            <%--                                                <div class="col mr-2">--%>
                            <%--                                                    <div class="fs-6 font-weight-bold text-warning mb-1">--%>
                            <%--                                                        País con más participantes--%>
                            <%--                                                    </div>--%>
                            <%--                                                    <div class="h5 mb-0 font-weight-bold text-gray-800">--%>
                            <%--                                                        <%=paisMasParticipantes%>--%>
                            <%--                                                    </div>--%>
                            <%--                                                </div>--%>
                            <%--                                                <div class="col-auto">--%>
                            <%--                                                    <i class="fas fa-globe-americas fa-2x text-gray-300"></i>--%>
                            <%--                                                </div>--%>
                            <%--                                            </div>--%>
                            <%--                                        </div>--%>
                            <%--                                    </div>--%>
                            <%--                                </div>--%>
                            <%--                            </div>--%>
                            <!--Participantes por país-->
                            <div class="card shadow mb-4 col-xl-7 px-0">
                                <!-- Card Header - Dropdown -->
                                <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                    <h6 class="m-0 font-weight-bold">Participantes por país</h6>
                                </div>
                                <!-- Card Body -->
                                <div class="card-body">
                                    <div class="chart-pie pt-4 pb-2">
                                        <canvas id="myChartPais"></canvas>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!--JS-->
        <script src="https://kit.fontawesome.com/5733880de3.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
                crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.bundle.js"
                integrity="sha512-U3hGSfg6tQWADDQL2TUZwdVSVDxUt2HZ6IMEIskuBizSDzoe65K3ZwEybo0JOcEjZWtWY3OJzouhmlGop+/dBg=="
                crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <script src="<%=request.getContextPath()%>/res/js/estadisticasParticipante.js"></script>
    </body>
</html>