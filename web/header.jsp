<%@page import="jdk.nashorn.internal.ir.BreakNode"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF8"%>
<%@page import="Modelo.Usuario"%>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>Sistema</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">

    <!-- Open Sans font from Google CDN -->
    <link href="http://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,400,600,700,300&subset=latin" rel="stylesheet" type="text/css">
    <link href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css" rel="stylesheet" type="text/css">
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">


    <!-- stylesheets CSS -->
    <link href="assets/stylesheets/bootstrap.min.css" rel="stylesheet" type="text/css">
    <link href="assets/stylesheets/pixel-admin.min.css" rel="stylesheet" type="text/css">
    <link href="assets/stylesheets/widgets.min.css" rel="stylesheet" type="text/css">
    <link href="assets/stylesheets/rtl.min.css" rel="stylesheet" type="text/css">
    <link href="assets/stylesheets/themes.min.css" rel="stylesheet" type="text/css">
    <link href="assets/stylesheets/pages.min.css" rel="stylesheet" type="text/css">
    <link href="assets/stylesheets/bootstrapValidator.css" rel="stylesheet" type="text/css">
    <link href="assets/stylesheets/bootstrapValidator.min.css" rel="stylesheet" type="text/css">

    <!--  teste -->
    <link href="assets/css/widgets.min.css" rel="stylesheet" type="text/css">
    <script>function _pxDemo_loadStylesheet(a, b, c) {
            var c = c || decodeURIComponent((new RegExp(";\\s*" + encodeURIComponent("px-demo-theme") + "\\s*=\\s*([^;]+)\\s*;", "g").exec(";" + document.cookie + ";") || [])[1] || "clean"), d = "rtl" === document.getElementsByTagName("html")[0].getAttribute("dir");
            document.write(a.replace(/^(.*?)((?:\.min)?\.css)$/, '<link href="$1' + (c.indexOf("dark") !== -1 && a.indexOf("/css/") !== -1 && a.indexOf("/themes/") === -1 ? "-dark" : "") + (!d || 0 !== a.indexOf("assets/css") && 0 !== a.indexOf("assets/demo") ? "" : ".rtl") + '$2" rel="stylesheet" type="text/css"' + (b ? 'class="' + b + '"' : "") + ">"))
        }</script>

</head>
<body class="theme-default main-menu-animated">

    <script>var init = [];</script>

    <div id="main-wrapper">

        <%
            Usuario usuarioSessao = (Usuario) session.getAttribute("usuario");
            if (usuarioSessao == null) {
                session.invalidate();
                response.sendRedirect("index.jsp");
            }
        %>

        <div id="main-navbar" class="navbar navbar-inverse" role="navigation">

            <button type="button" id="main-menu-toggle"><i class="navbar-icon fa fa-bars icon"></i><span class="hide-menu-text">HIDE MENU</span></button>

            <div class="navbar-inner">
                <!-- Main navbar header -->
                <div class="navbar-header">

                    <!-- Logo -->
                    <a href="#" class="navbar-brand">
                        <div><img alt="Pixel Admin" src="assets/images/pixel-admin/main-navbar-logo.png"></div>
                        GAMIFICATION
                    </a>
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#main-navbar-collapse"><i class="navbar-icon fa fa-bars"></i></button>
                </div>

                <div id="main-navbar-collapse" class="collapse navbar-collapse main-navbar-collapse">
                    <div>
                        <div class="right clearfix">
                            <ul class="nav navbar-nav pull-right right-navbar-nav">
                                <li class="dropdown">
                                    <a href="#" class="dropdown-toggle user-menu" data-toggle="dropdown">
                                        <div><i class="fa fa-cloud-upload"></i>
                                            <span class="text-semibold"> CONTA <span>
                                                    </div>
                                                    </a>
                                                    <ul class="dropdown-menu">
                                                        <li><a href="/Gamification/acoes?acao=alterarUsuario&codigo=<%= usuarioSessao.getCodigo()%>"><i class="dropdown-icon fa fa-cog"></i>&nbsp;&nbsp;Configurações</a></li>
                                                        <li class="divider"></li>
                                                        <li><a href="/Gamification/acoes?acao=logout"><i class="dropdown-icon fa fa-power-off"></i>&nbsp;&nbsp;Sair</a></li>
                                                    </ul>
                                                    </li>
                                                    </ul>
                                                    </div>
                                                    </div>
                                                    </div>
                                                    </div>
                                                    </div>
                                                    <div id="main-menu" role="navigation">
                                                        <div id="main-menu-inner">
                                                            <div class="menu-content top" id="menu-content-demo">
                                                                <div class="text-bg">
                                                                    <span class="text-slim">Olá,</span> 
                                                                    <span class="text-semibold"><%= usuarioSessao.getNome()%></span>
                                                                </div>
                                                            </div>
                                                            <ul class="navigation">
                                                                <li class="mm-dropdown">
                                                                    <a href="#"><i class="menu-icon fa fa-th"></i>
                                                                        <span class="mm-text">Dashboard</span></a>

                                                                    <% if (usuarioSessao.isProfessor()) {%>
                                                                    <ul>
                                                                        <li>
                                                                            <a tabindex="-1" href="dashboard.jsp"><i class="menu-icon fa fa-hand-o-left"></i><span class="mm-text">Resultados</span></a>
                                                                        </li>
                                                                    </ul>
                                                                    <% } else { %>
                                                                    <ul>
                                                                        <li>
                                                                            <a tabindex="-1" href="dashboardAluno.jsp"><i class="menu-icon fa fa-hand-o-left"></i><span class="mm-text">Resultados</span></a>
                                                                        </li>
                                                                    </ul>
                                                                </li>
                                                                <% } %>
                                                                <li class="mm-dropdown">
                                                                    <a href="#"><i class="menu-icon fa fa-th"></i><span class="mm-text">Atividades</span></a>
                                                                            <% if (usuarioSessao.isProfessor()) {%>
                                                                    <ul>
                                                                        <li>
                                                                            <a tabindex="-1" href="listarTarefasCorrecao.jsp"><i class="menu-icon fa fa-th-list"></i><span class="mm-text">Corrigir tarefas</span></a>
                                                                        </li>
                                                                    </ul>
                                                                    <% } else { %>
                                                                    <ul>
                                                                        <li>
                                                                            <a tabindex="-1" href="listarMinhasTarefas.jsp"><i class="menu-icon fa fa-th-list"></i><span class="mm-text">Minhas tarefas</span></a>
                                                                        </li>
                                                                    </ul>
                                                                    <% }%>
                                                                </li>
                                                                <% if (usuarioSessao.isProfessor()) {%>
                                                                <li class="mm-dropdown">
                                                                    <a href="#"><i class="menu-icon fa fa-th"></i><span class="mm-text">Cadastros</span></a>
                                                                    <ul>
                                                                        <li>
                                                                            <a tabindex="-1" href="listarTarefas.jsp"><i class="menu-icon fa fa-th-list"></i><span class="mm-text">Tarefas</span></a>
                                                                        </li>
                                                                        <li>
                                                                            <a tabindex="-1" href="listarUsuarios.jsp"><i class="menu-icon fa fa-users"></i><span class="mm-text">Usuarios</span></a>
                                                                        </li>
                                                                        <li>
                                                                            <a tabindex="-1" href="listarNiveis.jsp"><i class="menu-icon fa fa-users"></i><span class="mm-text">Niveis</span></a>
                                                                        </li>
                                                                        <li>
                                                                            <a tabindex="-1" href="listarPremios.jsp"><i class="menu-icon fa fa-users"></i><span class="mm-text">Prêmios</span></a>
                                                                        </li>
                                                                        <li>
                                                                            <a tabindex="-1" href="listarModulos.jsp"><i class="menu-icon fa fa-users"></i><span class="mm-text">Módulos</span></a>
                                                                        </li>
                                                                    </ul>
                                                                </li>
                                                                
                                                                
                                                                    <li class="mm-dropdown">
                                                                
                                                                        <a href="webService.html"><i class="menu-icon fa fa-th"></i><span class="mm-text">WebService</span></a>
                                                                        
                                                                </li>
                                                                
                                                                
                                                                
                                                                
                                                                <% }%>
                                                            </ul>
                                                        </div>
                                                    </div>

                                                    <script type="text/javascript"> window.jQuery || document.write('<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min.js">' + "<" + "/script>");</script>

                                                    <!-- javascripts -->
                                                    <script src="assets/javascripts/bootstrap.min.js"></script>
                                                    <script src="assets/javascripts/pixel-admin.min.js"></script>
                                                    <script src="assets/javascripts/bootstrapValidator.js"></script>
                                                    <script src="assets/javascripts/bootstrapValidator.min.js"></script>
                                                    <script src="assets/javascripts/language/pt_BR.js"></script>
                                                    <script src="assets/javascripts/dropzone.js"></script>

                                                    <script type="text/javascript">
                                                        init.push(function () {
                                                            // Javascript code here
                                                        });
                                                        window.PixelAdmin.start(init);
                                                    </script>