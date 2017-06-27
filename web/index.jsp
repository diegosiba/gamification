<%@page import="DAO.ConexaoBD"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!--[if IE 8]>         <html class="ie8"> <![endif]-->
<!--[if IE 9]>         <html class="ie9 gt-ie8"> <![endif]-->
<!--[if gt IE 9]><!--> <html class="gt-ie8 gt-ie9 not-ie"> <!--<![endif]-->
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <title>GAMIFICATION</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">

        <!-- Open Sans font from Google CDN -->
        <link href="http://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,400,600,700,300&subset=latin" rel="stylesheet" type="text/css">

        <!-- stylesheets -->
        <link href="assets/stylesheets/bootstrap.min.css" rel="stylesheet" type="text/css">
        <link href="assets/stylesheets/pixel-admin.min.css" rel="stylesheet" type="text/css">
        <link href="assets/stylesheets/pages.min.css" rel="stylesheet" type="text/css">
        <link href="assets/stylesheets/rtl.min.css" rel="stylesheet" type="text/css">
        <link href="assets/stylesheets/themes.min.css" rel="stylesheet" type="text/css">
        <link href="assets/stylesheets/bootstrapValidator.css" rel="stylesheet" type="text/css">
        <link href="assets/stylesheets/bootstrapValidator.min.css" rel="stylesheet" type="text/css">
    </head>

    <body class="theme-default page-signin">

        <!-- Container -->
        <div class="signin-container">

            <!-- Left side -->
            <div class="signin-info">
                <a href="index.jsp" class="logo">
                    GAMIFICATION
                </a>
                <div class="slogan">
                    Simples. Fácil. Rápido.
                </div>
                <ul>
                   <!-- <li><i class="fa fa-sitemap signin-icon"></i> Competição saudável</li>
                    <li><i class="fa fa-outdent signin-icon"></i> Aprenda se divertinfo</li>
                    <li><i class="fa fa-users signin-icon"></i> Faça novos amigos</li>
                    <li><i class="fa fa-heart signin-icon"></i> Espalhe a corrente do bem</li> -->
                </ul>
            </div>

            <div class="signin-form">
                <!--<form name="login" method="post" class="login" action="login.jsp" id="signin-form_id">-->
                <form class="form-signin" role="form" name="email" method="post" action="login.jsp">
                    <div class="signin-text">
                        <span>Faça login na sua conta</span>
                    </div>

                    <div class="form-group w-icon">
                        <input type="text" name="email" id="username_id" class="form-control input-lg" placeholder="email">
                        <span class="fa fa-user signin-form-icon"></span>
                    </div>

                    <div class="form-group w-icon">
                        <input type="password" name="senha" id="password_id" class="form-control input-lg" placeholder="senha">
                        <span class="fa fa-lock signin-form-icon"></span>
                    </div>

                    <div class="form-actions">
                        <input type="submit" value="ENTRAR" class="signin-btn bg-primary">
                    </div>
                    <%
                        if (request.getAttribute("erro") != null) {
                    %>
                    <h4><font color="red"> Ops. Não encontramos você!!! </font></h4>
                    <h6>Tente novamente.</h6>
                    <%
                        }
                    %>
                </form>
            </div>
        </div>

        <!-- Get jQuery from Google CDN -->
        <!--[if !IE]> -->
        <script type="text/javascript"> window.jQuery || document.write('<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min.js">' + "<" + "/script>");</script>
        <!-- <![endif]-->
        <!--[if lte IE 9]>
                <script type="text/javascript"> window.jQuery || document.write('<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js">'+"<"+"/script>"); </script>
        <![endif]-->

        <!-- Pixel Admin's javascripts -->
        <script src="assets/javascripts/bootstrap.min.js"></script>
        <script src="assets/javascripts/pixel-admin.min.js"></script>
        <script src="assets/javascripts/bootstrapValidator.js"></script>
        <script src="assets/javascripts/bootstrapValidator.min.js"></script>
        <script src="assets/javascripts/language/pt_BR.js"></script>

        <script type="text/javascript">
            $(document).ready(function () {
                $('.login').bootstrapValidator({
                    fields: {
                        email: {
                            validators: {
                                notEmpty: {
                                }
                            }
                        },
                        senha: {
                            validators: {
                                notEmpty: {
                                }
                            }
                        }
                    }
                });
            });
        </script>
    </body>
