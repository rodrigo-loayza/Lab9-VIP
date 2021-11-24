<%@ page import="pe.edu.pucp.vip.Bean.BPais" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="listaPaises" scope="request"
             type="java.util.ArrayList<pe.edu.pucp.vip.Bean.BPais>"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>VIP - Registro Universidad</title>
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
    <jsp:param name="page" value="universidades"/>
</jsp:include>
<!--Espacio-->
<body>
<section
        class="d-flex flex-grow-1 flex-shrink-1 p-4 justify-content-md-center align-items-md-center justify-content-lg-center align-items-lg-center justify-content-xl-center align-items-xl-center vh-100 universidad-bg"
        style="min-height: 700px;">
    <div class="container d-flex justify-content-center">
        <div class="card text-white bg-dark mb-3 border-0 responsive-form">
            <div class="card-header">
                <h4 class="my-2">Registrar Universidad</h4>
            </div>
            <div class="card-body">
                <div class="container w-75">
                    <div class="row my-4">
                        <form method="post"
                              action="<%=request.getContextPath()%>/universidades?action=registrarUniversidad">
                            <div class="mb-3">
                                <input class="form-control"
                                       type="text" name="nombre" placeholder="Nombre de la universidad"
                                       maxlength="45" required>
                            </div>
                            <div class="row">
                                <div class="col-md-5 mb-3">
                                    <input class="form-control"
                                           min="1" step="1"
                                           type="number" name="ranking" placeholder="Ranking"
                                            maxlength="5" required>
                                </div>
                                <div class="col-md-7 mb-3">
                                    <select class="form-select" name="idPais" id="idPais" required>
                                        <option value="" disabled selected>Seleccione el país</option>
                                        <%for (BPais pais : listaPaises) {%>
                                        <option value="<%=pais.getIdPais()%>"  ><%=pais.getNombre()%>
                                        </option>
                                        <%}%>

                                    </select>
                                </div>
                            </div>
                            <div class="mb-3">
                                <input class="form-control"
                                       type="text" name="urlFoto" placeholder="URL de la Foto"
                                        maxlength="300" required>
                            </div>
                            <div class="mb-3">
                                <button class=" btn btn-primary btn-lg" type="submit"
                                        style="width: 100%; background-color: goldenrod;">
                                    <strong>Registrarse</strong>
                                </button>
                            </div>

                            <br>

                        </form>
                        <a class="text-center" href="<%=request.getContextPath()%>/universidades">Volver</a>
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
