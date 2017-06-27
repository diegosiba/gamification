<%@page import="DAO.ModuloDAO"%>
<%@page import="Modelo.Modulo"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <%@include file="header.jsp" %>
    <%@include file="permissao.jsp" %>

    <div id="content-wrapper">
        <div class="page-header">
            <h1><span class="text-light-gray">Cadastro de </span>Módulo</h1>
        </div> 
        <%            Modulo modulo = (Modulo) request.getAttribute("modulo");
            if (modulo == null) {
                modulo = new Modulo();
                modulo.setNome("");
                modulo.setInicioModulo("");
                modulo.setFimModulo("");
            }
        %>
        <div class="row">
            <div class="col-sm-12">
                <form class="gravar" method="post" action="gravarModulo.jsp" class="panel form-horizontal">
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-sm-6">
                                <div class="form-group no-margin-hr">
                                    <label class="control-label">Nome</label>
                                    <input type="text" name="nome" class="form-control" value="<%=modulo.getNome()%>">
                                    <input type="hidden" name="codigo" class="form-control" value="<%=modulo.getCodigo()%>">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-3">
                                <div class="form-group no-margin-hr">
                                    <label class="control-label">Data Início</label>
                                    <input type="date" name="iniciomodulo" class="form-control" value="<%=modulo.getInicioModulo()%>">
                                </div>
                            </div>
                            <div class="col-sm-3">
                                <div class="form-group no-margin-hr">
                                    <label class="control-label">Data Fim</label>
                                    <input type="date" name="fimmodulo" class="form-control" value="<%=modulo.getFimModulo()%>">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-3">
                                <div class="form-group no-margin-hr">
                                    <label class="control-label">Mínimo Pontos</label>
                                    <input type="number" min="0" name="minimopontos" class="form-control" value="<%=modulo.getMinimoPontos()%>">
                                </div>
                            </div>
                            <div class="col-sm-3">
                                <div class="form-group no-margin-hr">
                                    <label class="control-label">Mínimo Tarefas</label>
                                    <input type="number" min="0" name="minimotarefas" class="form-control" value="<%=modulo.getMinimoTarefas()%>">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="panel-footer text-right">
                        <a href="/Gamification/listarModulos.jsp"><button class="btn btn-primary" type="button" name="voltar">Voltar</button></a>
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
                    iniciomodulo: {
                        validators: {
                            notEmpty: {
                            }
                        }
                    },
                    fimmodulo: {
                        validators: {
                            notEmpty: {
                            }
                        }
                    }
                }
            });
        });
    </script>
</html>