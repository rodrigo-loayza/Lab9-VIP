<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
        <title>VIP - Consorcio de Universidades</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
              integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
              crossorigin="anonymous">
        <link rel="stylesheet" href="<%=request.getContextPath()%>/res/css/estilos.css" type="text/css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Macondo&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700" rel="stylesheet">
        <script src="https://kit.fontawesome.com/5733880de3.js" crossorigin="anonymous"></script>
    </head>
    <body>
        <!--Navbar-->
        <jsp:include page="/includes/navbar.jsp">
            <jsp:param name="page" value="inicio"/>
        </jsp:include>
        <!--Espacio-->
        <div class="card-header py-2 my-4"></div>

        <!--Contenido-->
        <section class="vip-bg">
            <header class="masthead" style="height: 100vh">
                <div class="container">
                    <div class="masthead-subheading">Bienvenido a VIP</div>
                    <div class="masthead-heading text-uppercase">El mejor consorcio de universidades</div>
                    <a class="btn btn-primary btn-xl text-uppercase" href="#services">Ver el registro</a>
                </div>
            </header>
        </section>


        <!--JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js"
                integrity="sha384-QJHtvGhmr9XOIpI6YVutG+2QOK9T+ZnN4kzFN1RtK3zEFEIsxhlmWl5/YESvpZ13"
                crossorigin="anonymous"></script>
    </body>
</html>