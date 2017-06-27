<%@page import="DAO.UsuarioDAO"%>
<%@page import="Modelo.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <%@include file="header.jsp" %>

    <%            Usuario va = (Usuario) request.getAttribute("usuario");
        if (va == null) {
            va = new Usuario();
            va.setNome("");
            va.setEmail("");
            va.setSenha("");
        }

        if (usuarioSessao.isAluno() && va.getCodigo() != usuarioSessao.getCodigo()) {
    %>
    <%@include file="permissao.jsp" %>
    <%        }
    %>
    <div id="content-wrapper">
        <div class="page-header">
            <h1><span class="text-light-gray">Cadastro de </span>Usuário</h1>
        </div>        
        <div class="row">
            <div class="col-sm-12">
                <form class="gravar" method="post" action="gravarUsuario.jsp" class="panel form-horizontal">
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-sm-6">
                                <div class="form-group no-margin-hr">
                                    <label class="control-label">Nome</label>
                                    <input type="text" name="nome" class="form-control" value="<%=va.getNome()%>">
                                    <input type="hidden" name="codigo" class="form-control" value="<%=va.getCodigo()%>">
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="form-group no-margin-hr">
                                    <label class="control-label">E-mail</label>
                                    <input type="email" name="email" class="form-control" value="<%=va.getEmail()%>">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-6">
                                <div class="form-group no-margin-hr">
                                    <label class="control-label">Senha</label>
                                    <input type="password" name="senha" class="form-control" value="<%=va.getSenha()%>">
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="form-group no-margin-hr">
                                    <label class="control-label">Confirmar Senha</label>
                                    <input type="password" name="confirmarSenha" class="form-control" value="<%=va.getSenha()%>">
                                </div>
                            </div>
                        </div>
                        <% if (usuarioSessao.isProfessor()) {%>
                        <div class="row">
                            <div class="col-sm-6">
                                <div class="form-group no-margin-hr">
                                    <label class="control-label">Professor</label>
                                    <input type="checkbox" name="professor" class="form-control" 
                                           <%if (va.isProfessor()) {%>
                                           checked
                                           <%}%>>
                                </div>
                            </div>
                        </div>
                        <%}%>
                    </div>
                    <div class="panel-footer text-right">
                        <a href="/Gamification/listarUsuarios.jsp"><button class="btn btn-primary" type="button" name="voltar">Voltar</button></a>
                        <button type="submit" class="btn btn-primary">Salvar</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <div id="main-menu-bg"></div>
    <%@include file="footer.jsp" %>
    <script type="text/javascript">
        $(document).ready(function () {
            $('.gravar').bootstrapValidator({
                fields: {
                    nome: {
                        validators: {
                            notEmpty: {
                            }
                        }
                    },
                    email: {
                        validators: {
                            notEmpty: {
                            }
                        }
                    },
                    senha: {
                        validators: {
                            notEmpty: {
                            },
                            identical: {
                                field: 'confirmarSenha'
                            }
                        }
                    },
                    confirmarSenha: {
                        validators: {
                            notEmpty: {
                            },
                            identical: {
                                field: 'senha'
                            }
                        }
                    }
                }
            });
        });
    </script>
</html>