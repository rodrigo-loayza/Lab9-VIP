<%@ page import="pe.edu.pucp.vip.Bean.BPais" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="participante" scope="request" type="pe.edu.pucp.vip.Bean.BParticipante"/>
<jsp:useBean id="listaPaises" scope="request" type="java.util.ArrayList<pe.edu.pucp.vip.Bean.BPais>"/>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
        <title>VIP - Editar participante</title>
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
    <!--Navbar-->
    <jsp:include page="/includes/navbar.jsp">
        <jsp:param name="page" value="participantes"/>
    </jsp:include>
    <!--Espacio-->
    <body>
        <section
                class="d-flex flex-grow-1 flex-shrink-1 p-4 justify-content-md-center align-items-md-center justify-content-lg-center align-items-lg-center justify-content-xl-center align-items-xl-center vh-100 participante-bg"
                style="min-height: 700px;">
            <div class="container d-flex justify-content-center">
                <div class="card text-white bg-dark mb-3 border-0 responsive-form">
                    <div class="card-header">
                        <h4 class="my-2">Editar</h4>
                    </div>
                    <div class="card-body">
                        <div class="container w-75">
                            <div class="row my-4">
                                <form method="post"
                                      action="<%=request.getContextPath()%>/participantes?action=editar">
                                    <input name="idParticipante" value="<%=participante.getIdParticipante()%>" hidden>
                                    <div class="mb-3">
                                        <!--El pattern ayudará a validar que no se ingrese numeros en los nombres-->
                                        <input class="form-control mb-3" type="text" name="nombre"
                                               placeholder="Nombre" maxlength="45" value="<%=participante.getNombre()%>"
                                               pattern="[A-zÀ-ž\s]+"
                                               required>
                                    </div>
                                    <div class="mb-3">
                                        <input class="form-control mb-3" type="text" name="apellido"
                                               placeholder="Apellido" value="<%=participante.getApellido()%>"
                                               pattern="[A-zÀ-ž\s]+"
                                               maxlength="45" required>
                                    </div>
                                    <div class="row mb-3">
                                        <!--El min hará que no se acepten numeros menores a 18-->
                                        <div class="col-md-6">
                                            <input class="form-control" type="number" name="edad"
                                                   placeholder="Edad" value="<%=participante.getEdad()%>"
                                                   min="18" required>
                                        </div>
                                        <div class="col-md-6">
                                            <label>
                                                <select class="form-select" name="genero" required>
                                                    <option value="hombre" <%=participante.getGenero().equals("hombre") ? "selected" : ""%>>
                                                        Masculino
                                                    </option>
                                                    <option value="mujer" <%=participante.getGenero().equals("mujer") ? "selected" : ""%>>
                                                        Femenino
                                                    </option>
                                                    <option value="otros" <%=participante.getGenero().equals("otros") ? "selected" : ""%>>
                                                        Otros
                                                    </option>
                                                </select>
                                            </label>
                                        </div>
                                    </div>
                                    <div class="mb-3">
                                        <label>
                                            <select class="form-select" name="pais" required>
                                                <% for (BPais pais : listaPaises) { %>
                                                <option value="<%=pais.getIdPais()%>"><%=pais.getNombre()%>
                                                </option>
                                                <% } %>
                                            </select>
                                        </label>
                                    </div>
                                    <div class="mb-3">
                                        <button class="btn btn-primary btn-lg" type="submit"
                                                style="width: 100%; background-color: goldenrod;">
                                            <strong>Registrarse</strong>
                                        </button>
                                    </div>
                                </form>
                                <a class="text-center" href="<%=request.getContextPath()%>/participantes">Volver</a>
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
    </body>
</html>
