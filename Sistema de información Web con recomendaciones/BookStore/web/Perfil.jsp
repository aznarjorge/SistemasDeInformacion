<%@ page import="com.bookstore.modelo.VO.UsuarioVO" %>
<%@ page import="static com.bookstore.modelo.TiendaFacade.leerUsuarioFacade" %>
<%@ page import="com.bookstore.controlador.CommonConstants" %>
<%@ page import="javafx.util.Pair" %>
<%@ page import="com.bookstore.modelo.TiendaFacade" %>
<%@ page import="com.bookstore.modelo.VO.GeneroVO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %><%--
  Created by IntelliJ IDEA.
  User: alex
  Date: 13/11/17
  Time: 19:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Perfil</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="/css/bootstrap.min.css"/>
    <script type="text/javascript" src="/js/jquery.min.js"></script>
    <script type="text/javascript" src="/js/bootstrap.min.js"></script>

    <link rel="stylesheet" type="text/css" href="/css/common.css"/>
    <link rel="stylesheet" type="text/css" href="/css/perfil.css"/>

</head>
<body>

<%
    String username = (String) session.getAttribute(CommonConstants.usernameParameterName);
    System.out.println(username + "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");

    List<Pair<String, String>> generos = new ArrayList<>();

    for (GeneroVO i : TiendaFacade.listarGeneros()){
    generos.add(new Pair<>( i.getNombre(),CommonConstants.browserLocation + "?" +CommonConstants.browserCategoryParameterName + "=" + i.getNombre()));
    }
%>

<nav class="navbar navbar-expand-lg bg-transp font-roboto">
    <div class="navbar-collapse">
        <ul class="nav navbar-nav">
            <li class="dropdown nav-item"><a class="dropdown-toggle" data-toggle="dropdown" href="">Todos los productos
                <span
                        class="caret"></span></a>
                <ul class="dropdown-menu">
                    <% for (Pair<String, String> genero : generos) {%>
                    <li><a href="<%= genero.getValue() %>"><%= genero.getKey() %>
                    </a></li>
                    <%}%>
                </ul>
            </li>

            <li class="nav-item"><a href="<%= CommonConstants.indexLocation %>">Inicio </a></li>
            <li class="nav-item"><a href="<%= CommonConstants.indexLocation + "?" + CommonConstants.pageStatusParameterName + "=" + CommonConstants.indexMasBuscadosPageStatus %>">Más populares </a></li>
            <li class="nav-item"><a href="<%=  CommonConstants.indexLocation + "?" + CommonConstants.pageStatusParameterName + "=" + CommonConstants.indexNovedadesPageStatus %>">Novedades </a></li>

            <li class="nav-item"><a href="#search">Buscar</a></li>
        </ul>
        <ul class="nav navbar-nav navbar-right">

            <%
                if (username != null) {%>

            <li class="dropdown nav-item"><a class="dropdown-toggle" data-toggle="dropdown" href=""><%= username%> <span
                    class="caret"></span></a>
                <ul class="dropdown-menu">
                    <li><a href="<%= CommonConstants.profileLocation %>">Ver Perfil</a></li>
                    <li><a href="<%= CommonConstants.logoutLocation %>">Desconectarse</a></li>

                </ul>
            </li>

            <%} else {%>
            <li class="nav-item"><a href="<%= CommonConstants.loginLocation%>">Acceder </a></li>
            <%}%>


        </ul>
    </div>
</nav>

<div class="container-fluid">
    <div class="row row-offcanvas row-offcanvas-right">
        <div class="col-xs-12 col-sm-9 col-sm-push-4">
            <p class="pull-right visible-xs">
                <button type="button" class="btn btn-primary btn-xs" data-toggle="offcanvas" title="Toggle sidebar"><i
                        class="fa fa-chevron-right"></i></button>
            </p>


            <!-- edit form column -->
            <div class="col-md-9 personal-info">
                <h2>Perfil</h2>
                <hr>
                <div class="row">
                    <div class="col-md-4">
                        <img src="images/user.jpg" height="200" width="200">
                    </div>
                    <div class="col-md-4">
                        <%
                            UsuarioVO user = null;
                            try{
                                System.out.println("Voy a llamar a la fachada para obtener perfil");

                                user = leerUsuarioFacade(username);
                            }catch (Exception e){
                                e.printStackTrace(System.err);
                                response.sendRedirect("errorInterno.html");
                            }

                            SimpleDateFormat formatter1= new SimpleDateFormat("yyyy MM dd");
                            String fecha = formatter1.format(user.getFechaDeNacimiento().getTime());
                        %>
                        <h5>Nombre: <%=user.getNombre()%></h5>
                        <h5>Localidad: <%=user.getDireccionPostal()%></h5>
                        <h5>Fecha de nacimiento: <%=fecha%></h5>
                    </div>
                </div>
                <hr>

                <a href="<%=CommonConstants.profileAccountEdit%>"><input class="btn btn-primary" value="Editar perfil" type="button"></a>
            </div>


        </div><!--/.col-xs-12.col-sm-9-->

        <div class="col-xs-6 col-sm-3 col-sm-pull-8 sidebar-offcanvas" id="sidebar">
            <div class="list-group">
                <a href="<%=CommonConstants.profileLocation%>" class="list-group-item active">Perfil</a>
                <a href="<%=CommonConstants.profileLibraryLocation%>" class="list-group-item">Tu biblioteca</a>
                <a href="<%=CommonConstants.profileCommentLocation%>" class="list-group-item">Tu críticas</a>
            </div>
        </div><!--/.sidebar-offcanvas-->
    </div><!--/row-->
</div><!--/.container-->

<div id="search">
    <button type="button" class="close">×</button>
    <form  role="form" action="<%= CommonConstants.browserLocation %>" method="get">
        <input type="search" value="" name="<%= CommonConstants.browserBookNameParameterName %>" placeholder="Introduce el nombre de un libro" />
        <input class="btn btn-primary" value="Buscar" type="submit">
    </form>
</div>

<script type="text/javascript" src="/js/script.js"></script>

</body>
</html>
