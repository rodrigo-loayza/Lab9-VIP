<%@ page contentType="text/html;charset=UTF-8" language="java" %>

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
    </head>
    <body>
        <!--Navbar-->
        <jsp:include page="/includes/navbar.jsp">
            <jsp:param name="page" value="participantes"/>
        </jsp:include>

        <!--Espacio-->
        <div class="card-header py-2 my-4"></div>

        <!--Contenido-->
        <section class="py-3">
            <div class="container">
                <!--Tabla de participantes-->
                <div class="table-responsive">
                    <div class="table-wrapper">
                        <div class="table-title ">
                            <div class="row">
                                <div class="col-sm-4">
                                    <h2>Lista de Universidades</h2>
                                </div>
                            </div>
                        </div>
                        <div class="table-filter">
                            <div class="row">
                                <div class="col-sm-3">
                                    <div class="show-entries">
                                        <span>Show</span>
                                        <select class="form-control">
                                            <option>5</option>
                                            <option>10</option>
                                            <option>15</option>
                                            <option>20</option>
                                        </select>
                                        <span>entries</span>
                                    </div>
                                </div>
                                <div class="col-sm-9">
                                    <button type="button" class="btn btn-primary"><i class="fa fa-search"></i></button>
                                    <div class="filter-group">
                                        <label>Name</label>
                                        <input type="text" class="form-control">
                                    </div>
                                    <span class="filter-icon"><i class="fa fa-filter"></i></span>
                                </div>
                            </div>
                        </div>
                        <table class="table table-striped table-hover">
                            <thead>
                                <tr class="text-center">
                                    <th class="col-2">Nombre</th>
                                    <th class="col-3">Apellido</th>
                                    <th class="col-1">Edad</th>
                                    <th class="col-2">Nacionalidad</th>
                                    <th class="col-2">Género</th>
                                    <th class="col-1">Editar</th>
                                    <th class="col-1">Eliminar</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr class="text-center">
                                    <td>Rodrigo Sebastián</td>
                                    <td>Loayza La Rosa</td>
                                    <td>21</td>
                                    <td>Perú <span class="flag-icon flag-icon-pe"></span></td>
                                    <td>Masculino <i class="fas fa-mars"></i></td>
                                    <td><a href="#"><i class="fas fa-trash-alt"></i></a></td>
                                    <td><a href="#"><i class="fas fa-edit"></i></a></td>
                                </tr>
                                <tr class="text-center">
                                    <td>Rodrigo Sebastián</td>
                                    <td>Loayza La Rosa</td>
                                    <td>21</td>
                                    <td>Perú <span class="flag-icon flag-icon-pe"></span></td>
                                    <td>Masculino <i class="fas fa-mars"></i></td>
                                    <td><a href="#"><i class="fas fa-trash-alt"></i></a></td>
                                    <td><a href="#"><i class="fas fa-edit"></i></a></td>
                                </tr>
                                <tr class="text-center">
                                    <td>Rodrigo Sebastián</td>
                                    <td>Loayza La Rosa</td>
                                    <td>21</td>
                                    <td>Perú <span class="flag-icon flag-icon-pe"></span></td>
                                    <td>Masculino <i class="fas fa-mars"></i></td>
                                    <td><a href="#"><i class="fas fa-trash-alt"></i></a></td>
                                    <td><a href="#"><i class="fas fa-edit"></i></a></td>
                                </tr>
                            </tbody>
                        </table>
                        <div class="clearfix">
                            <div class="hint-text">Showing <b>5</b> out of <b>25</b> entries</div>
                            <ul class="pagination">
                                <li class="page-item disabled"><a href="#">Previous</a></li>
                                <li class="page-item"><a href="#" class="page-link">1</a></li>
                                <li class="page-item"><a href="#" class="page-link">2</a></li>
                                <li class="page-item"><a href="#" class="page-link">3</a></li>
                                <li class="page-item active"><a href="#" class="page-link">4</a></li>
                                <li class="page-item"><a href="#" class="page-link">5</a></li>
                                <li class="page-item"><a href="#" class="page-link">6</a></li>
                                <li class="page-item"><a href="#" class="page-link">7</a></li>
                                <li class="page-item"><a href="#" class="page-link">Next</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
                <!--Estadísticas-->
                <div class="table-responsive">
                    <div class="table-wrapper">
                        <div class="table-title ">
                            <div class="row">
                                <div class="col-sm-4">
                                    <h2>Estadísticas</h2>
                                </div>
                            </div>
                        </div>
                        XD
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