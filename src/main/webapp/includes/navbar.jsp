<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!--Navbar-->
<nav class="navbar navbar-expand-lg py-3 navbar-dark bg-dark shadow-sm fixed-top">
    <div class="container">
        <!--Logo-->
        <a href="<%=request.getContextPath()%>/" class="navbar-brand">
            <span class="text-uppercase font-weight-bold">VIP</span>
        </a>
        <!--Boton de pantallas pequeñas-->
        <button type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
                aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"
                class="navbar-toggler"><span class="navbar-toggler-icon"></span></button>
        <!--Menú-->
        <div id="navbarSupportedContent" class="collapse navbar-collapse">
            <ul class="navbar-nav text-uppercase ms-auto py-4 py-lg-0">
                <li class="nav-item"><a class="nav-link <%=request.getParameter("page").equals("paises")? "active": "" %>"
                                        href="<%=request.getContextPath()%>/paises">Países</a></li>
                <li class="nav-item"><a class="nav-link <%=request.getParameter("page").equals("participantes")? "active": "" %>"
                                        href="<%=request.getContextPath()%>/participantes">Participantes</a></li>
                <li class="nav-item"><a class="nav-link <%=request.getParameter("page").equals("universidades")? "active": "" %>"
                                        href="<%=request.getContextPath()%>/universidades">Universidades</a></li>
            </ul>
        </div>
    </div>
</nav>

