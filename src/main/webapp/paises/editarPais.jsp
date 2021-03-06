<%@ page import="pe.edu.pucp.vip.Bean.BPais" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="pais" scope="request" type="pe.edu.pucp.vip.Bean.BPais"></jsp:useBean>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
        <style>
            /* Chrome, Safari, Edge, Opera */
            input::-webkit-outer-spin-button,
            input::-webkit-inner-spin-button {
                -webkit-appearance: none;
                margin: 0;
            }

            /* Firefox */
            input[type=number] {
                -moz-appearance: textfield;
            }
        </style>
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
    <!--Navbar-->
    <jsp:include page="/includes/navbar.jsp">
        <jsp:param name="page" value="paises"/>
    </jsp:include>
    <!--Espacio-->
    <body>
        <section
                class="d-flex flex-grow-1 flex-shrink-1 p-4 justify-content-md-center align-items-md-center justify-content-lg-center align-items-lg-center justify-content-xl-center align-items-xl-center vh-100 pais-bg"
                style="min-height: 700px;">
            <div class="container d-flex justify-content-center">
                <div class="card text-white bg-dark mb-3 border-0 responsive-form">
                    <div class="card-header">
                        <h4 class="my-2">Editar País</h4>
                    </div>
                    <div class="card-body">
                        <div class="container w-75">
                            <div class="row my-4">
                                <form method="post"
                                      action="<%=request.getContextPath()%>/paises?action=editar">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <input hidden value="<%=pais.getIdPais()%>" name="idpais" id="idpais">
                                            <label>Nombre</label>
                                            <input class="form-control mb-3" type="text" name="nombre" placeholder="Nombre" pattern="[A-zÀ-ž\s]+"
                                                   placeholder="" maxlength="70"
                                                   required value="<%=pais.getNombre()%>">
                                        </div>
                                        <h1></h1>
                                    </div>
                                    <div class="col">
                                        <label>Continente</label>
                                        <select class="float-right form-control" id="idcontinente"
                                                name="idcontinente" required>
                                            <option value="" disabled hidden>
                                                Seleccione el continente
                                            </option>
                                            <option value="1" <%if (pais.getContinente().getIdContinente()==1) {%><%="selected"%><%}%>>
                                                América
                                            </option>
                                            <option value="2" <%if (pais.getContinente().getIdContinente()==2) {%><%="selected"%><%}%>>
                                                Europa
                                            </option>
                                            <option value="3" <%if (pais.getContinente().getIdContinente()==3) {%><%="selected"%><%}%>>
                                                África
                                            </option>
                                            <option value="4" <%if (pais.getContinente().getIdContinente()==4) {%><%="selected"%><%}%>>
                                                Oceanía
                                            </option>
                                            <option value="5" <%if (pais.getContinente().getIdContinente()==5) {%><%="selected"%><%}%>>
                                                Asia
                                            </option>
                                        </select>
                                        <br>
                                    </div>
                                    <label>Poblacion</label>
                                    <div class="mb-3">
                                        <input class="form-control"
                                               type="number" name="poblacion" placeholder="Cantidad de personas" max="9999999.99"
                                               maxlength="70" min="0" value="<%=pais.getPoblacion()%>" required>
                                    </div>
                                    <label>Tamaño</label>
                                    <div class="mb-3">
                                        <input class="form-control"
                                               type="number" step="0.01" name="tamano" placeholder="km²" maxlength="70" max="999999999"
                                               min="0" value="<%=pais.getTamano()%>" required>
                                    </div>

                                    <div class="mb-3">
                                        <button class=" btn btn-primary btn-lg" type="submit"
                                                style="width: 100%; background-color: goldenrod;">
                                            <strong>Guardar cambios</strong>
                                        </button>
                                    </div>
                                    <br>

                                </form>
                                <a class="text-center" href="<%=request.getContextPath()%>/paises">Salir del formulario</a>
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
