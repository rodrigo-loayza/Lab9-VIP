<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!--Navbar-->
<%int paginas = Integer.parseInt(request.getParameter("paginas"));
int pag = Integer.parseInt(request.getParameter("pag"));
String direccionBasePag = request.getParameter("direccionBasePag");%>
<div class="clearfix">
    <ul class="pagination">
        <%
            if(paginas>1){
            if (pag!=1) {
        %>
        <li class="page-item"><a href="<%=direccionBasePag+"&pag="+(pag-1)%>" class="page-link">Previous</a></li>
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
            if ( pag!=paginas) {
        %>
        <li class="page-item"><a href="<%=direccionBasePag+"&pag="+(pag+1)%>" class="page-link">Next</a></li>
        <%
            }}
        %>

    </ul>
</div>

