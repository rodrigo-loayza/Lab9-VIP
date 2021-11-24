<%@ page import="pe.edu.pucp.vip.Bean.BPais" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="listaPaises" scope="request" type="java.util.ArrayList<pe.edu.pucp.vip.Bean.BPais>"/>
<jsp:useBean id="idcontinente" scope="request" type="java.lang.String"></jsp:useBean>
<jsp:useBean id="mensaje" scope="request" type="java.lang.String" class="java.lang.String"></jsp:useBean>
<jsp:useBean id="E" scope="request" type="java.lang.String" class="java.lang.String"></jsp:useBean>
<jsp:useBean id="orden" scope="request" type="java.lang.String" class="java.lang.String"></jsp:useBean>
<jsp:useBean id="limit" scope="request" type="java.lang.Integer"></jsp:useBean>
<jsp:useBean id="pag" scope="request" type="java.lang.Integer"></jsp:useBean>
<jsp:useBean id="paginas" scope="request" type="java.lang.Integer"></jsp:useBean>

<%String direccionBaseOrden = request.getContextPath() + "/paises?id=" + idcontinente + "&limit=" + limit;%>
<%String direccionBasePag= request.getContextPath() + "/paises?id=" + idcontinente + "&limit=" + limit+"&orden="+orden;%>
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
                                <div class="col-sm-8 justify-content-end">
                                    <a role="button" class="btn btn-primary pe-2"
                                       href="<%=request.getContextPath()%>/paises?action=registrar">
                                        <i class="fas fa-plus"></i>
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
                                            <input hidden id="orden" name="orden" value="<%=orden%>">
                                            <input hidden id="id" name="id" value="<%=idcontinente%>">
                                            <select class="form-control" name="limit" id="limit"
                                                    onchange='this.form.submit();'>
                                                <option value="5" <%=limit == 5 ? "selected" : "" %>>5</option>
                                                <option value="10" <%=limit == 10 ? "selected" : "" %>>10</option>
                                                <option value="15" <%=limit == 15 ? "selected" : "" %>>15</option>
                                                <option value="0" <%=limit == 0 ? "selected" : "" %>>Todo</option>
                                            </select>
                                            <span>Filas</span>
                                        </form>

                                    </div>
                                </div>
                                <div class="col-sm-9">
                                    <form method="post" action="<%=request.getContextPath()%>/paises?action=buscar"
                                          id="filtro">
                                        <div class="form-group d-flex flex-row-reverse">
                                            <input hidden id="limitb" name="limitb" value="<%=limit%>">
                                            <button type="submit" class="btn btn-primary"><i class="fa fa-search"></i>
                                            </button>
                                            <select class="float-right form-control w-25" id="idcontinente"
                                                    name="idcontinente">
                                                <option value="0" <%if (idcontinente.isEmpty()) {%><%="selected"%><%}%>>
                                                    Todos
                                                </option>
                                                <option value="1" <%if (idcontinente.equals("1")) {%><%="selected"%><%}%>>
                                                    América
                                                </option>
                                                <option value="2" <%if (idcontinente.equals("2")) {%><%="selected"%><%}%>>
                                                    Europa
                                                </option>
                                                <option value="3" <%if (idcontinente.equals("3")) {%><%="selected"%><%}%>>
                                                    África
                                                </option>
                                                <option value="4" <%if (idcontinente.equals("4")) {%><%="selected"%><%}%>>
                                                    Oceanía
                                                </option>
                                                <option value="5" <%if (idcontinente.equals("5")) {%><%="selected"%><%}%>>
                                                    Asia
                                                </option>
                                            </select>
                                            <label class="float-right h-30" for="idcontinente">Buscar por
                                                continente</label>
                                        </div>
                                    </form>
                                    </button>
                                </div>
                            </div>
                        </div>
                        <table class="table table-sortable table-striped table-hover">
                            <thead>
                                <tr class="text-center">
                                    <%if (orden.equals("na")) {%>
                                    <th class="col-2 table-sorter">
                                        <a href="<%=direccionBaseOrden+"&orden=nd"%>"
                                           class="text-dark text-decoration-none"> Nombre
                                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                                 fill="currentColor" class="bi bi-chevron-down" viewBox="0 0 16 16">
                                                <path fill-rule="evenodd"
                                                      d="M1.646 4.646a.5.5 0 0 1 .708 0L8 10.293l5.646-5.647a.5.5 0 0 1 .708.708l-6 6a.5.5 0 0 1-.708 0l-6-6a.5.5 0 0 1 0-.708z"/>
                                            </svg>
                                        </a></th>
                                    <%} else if (orden.equals("nd")) {%>
                                    <th class="col-2 table-sorter">
                                        <a href="<%=direccionBaseOrden+"&orden=na"%>"
                                           class="text-dark text-decoration-none"> Nombre
                                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                                 fill="currentColor" class="bi bi-chevron-up" viewBox="0 0 16 16">
                                                <path fill-rule="evenodd"
                                                      d="M7.646 4.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1-.708.708L8 5.707l-5.646 5.647a.5.5 0 0 1-.708-.708l6-6z"/>
                                            </svg>
                                        </a></th>
                                    <%} else {%>
                                    <th class="col-2 table-sorter">
                                        <a href="<%=direccionBaseOrden+"&orden=na"%>"
                                           class="text-dark text-decoration-none"> Nombre
                                        </a></th>
                                    <%
                                        }
                                        if (orden.equals("ca")) {
                                    %>
                                    <th class="col-2 table-sorter">
                                        <a href="<%=direccionBaseOrden+"&orden=cd"%>"
                                           class="text-dark text-decoration-none"> Continente
                                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                                 fill="currentColor" class="bi bi-chevron-down" viewBox="0 0 16 16">
                                                <path fill-rule="evenodd"
                                                      d="M1.646 4.646a.5.5 0 0 1 .708 0L8 10.293l5.646-5.647a.5.5 0 0 1 .708.708l-6 6a.5.5 0 0 1-.708 0l-6-6a.5.5 0 0 1 0-.708z"/>
                                            </svg>
                                        </a></th>
                                    <%} else if (orden.equals("cd")) {%>
                                    <th class="col-2 table-sorter">
                                        <a href="<%=direccionBaseOrden+"&orden=ca"%>"
                                           class="text-dark text-decoration-none"> Continente
                                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                                 fill="currentColor" class="bi bi-chevron-up" viewBox="0 0 16 16">
                                                <path fill-rule="evenodd"
                                                      d="M7.646 4.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1-.708.708L8 5.707l-5.646 5.647a.5.5 0 0 1-.708-.708l6-6z"/>
                                            </svg>
                                        </a></th>
                                    <%} else {%>
                                    <th class="col-2 table-sorter">
                                        <a href="<%=direccionBaseOrden+"&orden=ca"%>"
                                           class="text-dark text-decoration-none"> Continente
                                        </a></th>
                                    <%
                                        }
                                        if (orden.equals("pd")) {
                                    %>
                                    <th class="col-2 table-sorter">
                                        <a href="<%=direccionBaseOrden+"&orden=pa"%>"
                                           class="text-dark text-decoration-none"> Población(personas)
                                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                                 fill="currentColor" class="bi bi-chevron-down" viewBox="0 0 16 16">
                                                <path fill-rule="evenodd"
                                                      d="M1.646 4.646a.5.5 0 0 1 .708 0L8 10.293l5.646-5.647a.5.5 0 0 1 .708.708l-6 6a.5.5 0 0 1-.708 0l-6-6a.5.5 0 0 1 0-.708z"/>
                                            </svg>
                                        </a></th>
                                    <%} else if (orden.equals("pa")) {%>
                                    <th class="col-2 table-sorter">
                                        <a href="<%=direccionBaseOrden+"&orden=pd"%>"
                                           class="text-dark text-decoration-none"> Población(personas)
                                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                                 fill="currentColor" class="bi bi-chevron-up" viewBox="0 0 16 16">
                                                <path fill-rule="evenodd"
                                                      d="M7.646 4.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1-.708.708L8 5.707l-5.646 5.647a.5.5 0 0 1-.708-.708l6-6z"/>
                                            </svg>
                                        </a></th>
                                    <%} else {%>
                                    <th class="col-2 table-sorter">
                                        <a href="<%=direccionBaseOrden+"&orden=pd"%>"
                                           class="text-dark text-decoration-none"> Población(personas)
                                        </a></th>
                                    <%
                                        }
                                        if (orden.equals("td")) {
                                    %>
                                    <th class="col-2 table-sorter">
                                        <a href="<%=direccionBaseOrden+"&orden=ta"%>"
                                           class="text-dark text-decoration-none"> Tamaño (millones km²)
                                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                                 fill="currentColor" class="bi bi-chevron-down" viewBox="0 0 16 16">
                                                <path fill-rule="evenodd"
                                                      d="M1.646 4.646a.5.5 0 0 1 .708 0L8 10.293l5.646-5.647a.5.5 0 0 1 .708.708l-6 6a.5.5 0 0 1-.708 0l-6-6a.5.5 0 0 1 0-.708z"/>
                                            </svg>
                                        </a></th>
                                    <%} else if (orden.equals("ta")) {%>
                                    <th class="col-2 table-sorter">
                                        <a href="<%=direccionBaseOrden+"&orden=td"%>"
                                           class="text-dark text-decoration-none"> Tamaño (millones km²)
                                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                                 fill="currentColor" class="bi bi-chevron-up" viewBox="0 0 16 16">
                                                <path fill-rule="evenodd"
                                                      d="M7.646 4.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1-.708.708L8 5.707l-5.646 5.647a.5.5 0 0 1-.708-.708l6-6z"/>
                                            </svg>
                                        </a></th>
                                    <%} else {%>
                                    <th class="col-2 table-sorter">
                                        <a href="<%=direccionBaseOrden+"&orden=td"%>"
                                           class="text-dark text-decoration-none"> Tamaño (millones km²)
                                        </a></th>
                                    <%}%>

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
                                            <input hidden id="busqueda" name="busqueda" value="<%=idcontinente%>">
                                            <input hidden id="orden2" name="orden2" value="<%=orden%>">
                                            <input hidden id="limite" name="limite" value="<%=limit%>">
                                            <input name="id" value="<%=pais.getIdPais()%>" hidden>
                                        </form>
                                        <a href="#"
                                           onclick="document.getElementById('el<%=pais.getIdPais()%>').submit()"><i
                                                class="fas fa-trash-alt"></i></a>
                                    </td>
                                </tr>
                                <%}%>
                            </tbody>
                        </table>
                        <div class="clearfix">
                            <ul class="pagination">
                                <%
                                    if (paginas != 0 && pag!=1) {
                                %>
                                <li class="page-item disabled"><a href="<%=direccionBasePag+"&pag="+(pag-1)%>">Previous</a></li>
                                <%
                                    }
                                %>

                                <%
                                    int i = 1;
                                    while (i <= paginas) {
                                %>
                                <li class="page-item <%=i==pag? "active":""%>"><a href="<%=direccionBasePag+"&pag="+i%>" class="page-link"><%=i%>
                                </a></li>
                                <%
                                        i = i + 1;
                                    }
                                %>

                                <%
                                    if (paginas != 0 && pag!=paginas) {
                                %>
                                <li class="page-item"><a href="<%=direccionBasePag+"&pag="+(pag+1)%>" class="page-link">Next</a></li>
                                <%
                                    }
                                %>

                            </ul>
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
    </body>
</html>