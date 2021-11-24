<%@ page import="pe.edu.pucp.vip.Bean.BPais" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="listaPaises" scope="request" type="java.util.ArrayList<pe.edu.pucp.vip.Bean.BPais>"/>
<jsp:useBean id="busqueda" scope="request" type="java.lang.Integer"/>
<jsp:useBean id="mensaje" scope="request" type="java.lang.String" class="java.lang.String"/>
<jsp:useBean id="E" scope="request" type="java.lang.String" class="java.lang.String"/>
<jsp:useBean id="orden" scope="request" type="java.lang.String" class="java.lang.String"/>
<jsp:useBean id="columna" scope="request" type="java.lang.String" class="java.lang.String"/>
<jsp:useBean id="limit" scope="request" type="java.lang.Integer"/>
<jsp:useBean id="pag" scope="request" type="java.lang.Integer"/>
<jsp:useBean id="paginas" scope="request" type="java.lang.Integer"/>
<%String direccionBasePag = request.getContextPath() + "/paises?busqueda=" + busqueda + "&limit=" + limit + "&orden=" + orden + "&columna=" + columna;%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
        <title>VIP - Países</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
              crossorigin="anonymous">
        <link rel="stylesheet" href="<%=request.getContextPath()%>/res/css/estilos.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Macondo&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700" rel="stylesheet">

        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/flag-icon-css/4.1.5/css/flag-icons.min.css"
              integrity="sha512-UwbBNAFoECXUPeDhlKR3zzWU3j8ddKIQQsDOsKhXQGdiB5i3IHEXr9kXx82+gaHigbNKbTDp3VY/G6gZqva6ZQ=="
              crossorigin="anonymous" referrerpolicy="no-referrer"/>
    </head>
    <body>
        <!--Navbar-->
        <jsp:include page="/includes/navbar.jsp">
            <jsp:param name="page" value="paises"/>
        </jsp:include>

        <!--Espacio-->
        <div class="card-header py-2 my-4"></div>

        <!--Contenido-->
        <section class="py-3">
            <%
                String tipoAlerta;
                String texto;
                if (E.equals("1")) {
                    tipoAlerta = "success";
                    if (mensaje.equals("1")) {
                        texto = "Se ha borrado el país de forma exitosa";
                    } else if (mensaje.equals("2")) {
                        texto = "Se ha registrado al país de forma exitosa";
                    } else {
                        texto = "Los cambios han sido guardados";
                    }
                } else {
                    tipoAlerta = "danger";
                    if (mensaje.equals("1")) {
                        texto = "Ha ocurrido un error al borrar el país, verifica que no tenga relación con algún participante o universidad antes de borrar";
                    } else if (mensaje.equals("2")) {
                        texto = "Ha ocurrido un error al registrar el país, verifique que todos los datos que ha ingresado sean válidos";
                    } else {
                        texto = "Ha ocurrido un error al editar la información del país, verifique que todos los datos que ha ingresado sean válidos";
                    }
                }

                if (!mensaje.equals("0")) {
            %>
            <div class="alert alert-<%=tipoAlerta%> alert-dismissible fade show" role="alert"
                 style="margin: 30px auto 20px; width: 90%">
                <%=texto%>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <%
                }
            %>
            <div class="container">
                <div class="table-responsive">
                    <div class="table-wrapper">
                        <div class="table-title ">
                            <div class="row">
                                <div class="col-sm-4">
                                    <h2>Lista de Países</h2>
                                </div>
                                <div class="col-sm-8 text-end" style="margin-top: -8px">
                                    <a role="button" class="text-warning"
                                       href="<%=request.getContextPath()%>/paises?action=registrar">
                                        <i class="bi bi-plus-circle-fill"
                                           style="font-size: 30px;"></i>
                                    </a>
                                </div>
                            </div>
                        </div>
                        <div class="table-filter">
                            <div class="row">
                                <div class="col-sm-3">
                                    <div class="show-entries">
                                        <form method="get"
                                              action="<%=request.getContextPath()+"/paises"%>">
                                            <span>Mostrar</span>
                                            <input hidden name="columna" value="<%=columna%>">
                                            <input hidden name="orden" value="<%=orden%>">
                                            <input hidden name="busqueda" value="<%=busqueda%>">
                                            <select class="form-control" name="limit" onchange='this.form.submit();'>
                                                <option value="5" <%=limit == 5 ? "selected" : "" %>>5</option>
                                                <option value="10" <%=limit == 10 ? "selected" : "" %>>10</option>
                                                <option value="15" <%=limit == 15 ? "selected" : "" %>>15</option>
                                                <option value="-1" <%=limit == -1 ? "selected" : "" %>>All</option>
                                            </select>
                                            <span>filas</span>
                                        </form>
                                    </div>
                                </div>
                                <div class="col-sm-9">
                                    <form method="post"
                                          action="<%=request.getContextPath()%>/paises?action=buscar"
                                          id="filtro">
                                        <button type="submit" class="btn btn-primary"><p class="bi bi-filter-circle"
                                                                                         style="margin-top: -4px"></p>
                                        </button>
                                        <div class="filter-group">
                                            <input hidden id="limitb" name="limitb" value="<%=limit%>">
                                            <input hidden name="columna" value="<%=columna%>">
                                            <label for="idcontinente">Filtrar por continente</label>
                                            <select class="float-right form-control w-30" id="idcontinente"
                                                    name="idcontinente" onchange='this.form.submit();'>
                                                <option value="0" <%if (busqueda.toString().isEmpty()) {%><%="selected"%><%}%>>
                                                    Todos
                                                </option>
                                                <option value="1" <%=busqueda == 1 ? "selected" : ""%>>
                                                    América
                                                </option>
                                                <option value="2" <%=busqueda == 2 ? "selected" : ""%>>
                                                    Europa
                                                </option>
                                                <option value="3" <%=busqueda == 3 ? "selected" : ""%>>
                                                    África
                                                </option>
                                                <option value="4" <%=busqueda == 4 ? "selected" : ""%>>
                                                    Oceanía
                                                </option>
                                                <option value="5" <%=busqueda == 5 ? "selected" : ""%>>
                                                    Asia
                                                </option>
                                            </select>
                                        </div>
                                    </form>
                                    </button>
                                </div>
                            </div>
                        </div>
                        <table class="table table-striped table-hover">
                            <thead>
                                <tr class="text-center">
                                    <th class="col-2">
                                        <%
                                            String hrefN = request.getContextPath() + "/paises?columna=p.nombre&orden=asc&limit=" + limit;
                                            String classN = "fa-minus-circle";
                                            if (columna.equals("p.nombre")) {
                                                classN = "fa-chevron-circle" + (orden.equals("asc") ? "-up" : "-down");
                                                hrefN = request.getContextPath() + "/paises?columna=p.nombre&orden=" + (orden.equals("asc") ? "desc" : "asc") + "&limit=" + limit;
                                            }
                                        %>
                                        <a href="<%=hrefN%>"
                                           class="text-decoration-none text-dark d-flex justify-content-between">
                                            Nombre
                                            <i class="fas <%=classN%> pt-2"></i>
                                        </a>
                                    </th>
                                    <th class="col-2">
                                        <%
                                            String hrefC = request.getContextPath() + "/paises?columna=c.nombre&orden=asc&limit=" + limit;
                                            String classC = "fa-minus-circle";
                                            if (columna.equals("c.nombre")) {
                                                classC = "fa-chevron-circle" + (orden.equals("asc") ? "-up" : "-down");
                                                hrefC = request.getContextPath() + "/paises?columna=c.nombre&orden=" + (orden.equals("asc") ? "desc" : "asc") + "&limit=" + limit;
                                            }
                                        %>
                                        <a href="<%=hrefC%>"
                                           class="text-decoration-none text-dark d-flex justify-content-between">
                                            Continente
                                            <i class="fas <%=classC%> pt-2"></i>
                                        </a>
                                    </th>
                                    <th class="col-2">
                                        <%
                                            String hrefP = request.getContextPath() + "/paises?columna=p.poblacion&orden=asc&limit=" + limit;
                                            String classP = "fa-minus-circle";
                                            if (columna.equals("p.poblacion")) {
                                                classP = "fa-chevron-circle" + (orden.equals("asc") ? "-up" : "-down");
                                                hrefP = request.getContextPath() + "/paises?columna=p.poblacion&orden=" + (orden.equals("asc") ? "desc" : "asc") + "&limit=" + limit;
                                            }
                                        %>
                                        <a href="<%=hrefP%>"
                                           class="text-decoration-none text-dark d-flex justify-content-between">
                                            Población
                                            <i class="fas <%=classP%> pt-2"></i>
                                        </a>
                                    </th>
                                    <th class="col-2">
                                        <%
                                            String hrefT = request.getContextPath() + "/paises?columna=p.tamano&orden=asc&limit=" + limit;
                                            String classT = "fa-minus-circle";
                                            if (columna.equals("p.tamano")) {
                                                classT = "fa-chevron-circle" + (orden.equals("asc") ? "-up" : "-down");
                                                hrefT = request.getContextPath() + "/paises?columna=p.tamano&orden=" + (orden.equals("asc") ? "desc" : "asc") + "&limit=" + limit;
                                            }
                                        %>
                                        <a href="<%=hrefT%>"
                                           class="text-decoration-none text-dark d-flex justify-content-between">
                                            Tamaño (km²)
                                            <i class="fas <%=classT%> pt-2"></i>
                                        </a>
                                    </th>
                                    <th class="col-1">Editar</th>
                                    <th class="col-1">Eliminar</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%for (BPais pais : listaPaises) {%>

                                <tr class="text-center">
                                    <td><span class="flag-icon flag-icon-pe"></span> <%=pais.getNombre()%>
                                    </td>
                                    <td><%=pais.getContinente().getNombre()%>
                                    </td>
                                    <td><%=pais.getPoblacion()%>
                                    </td>
                                    <td><%=pais.getTamano()%>
                                    </td>
                                    <td>
                                        <a href="<%=request.getContextPath()%>/paises?action=editar&id=<%=pais.getIdPais()%>"><i
                                                class="fas fa-edit"></i></a></td>
                                    <td>
                                        <form action="<%=request.getContextPath()%>/paises?action=eliminar"
                                              method="post" id="el<%=pais.getIdPais()%>">
                                            <input hidden name="busqueda" value="<%=busqueda%>">
                                            <input hidden name="orden2" value="<%=orden%>">
                                            <input hidden name="limite" value="<%=limit%>">
                                            <input name="id" value="<%=pais.getIdPais()%>" hidden>
                                        </form>
                                        <a href="#" class="text-danger"
                                           onclick="document.getElementById('el<%=pais.getIdPais()%>').submit()"><i
                                                class="fas fa-trash-alt"></i></a>
                                    </td>
                                </tr>
                                <%}%>
                            </tbody>
                        </table>
                        <jsp:include page="/includes/paginacion.jsp">
                            <jsp:param name="paginas" value="<%=paginas%>"/>
                            <jsp:param name="pag" value="<%=pag%>"/>
                            <jsp:param name="direccionBasePag" value="<%=direccionBasePag%>"/>
                        </jsp:include>
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