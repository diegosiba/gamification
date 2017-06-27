<%@page import="DAO.NivelDAO"%>
<%@page import="Modelo.Nivel"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <%@include file="header.jsp" %>
    <%@include file="permissao.jsp" %>
    
    <div id="content-wrapper">
        <div class="page-header">
            <h1><span class="text-light-gray">Cadastro de </span>Nível</h1>
        </div> 
        <%            Nivel nivel = (Nivel) request.getAttribute("nivel");
            if (nivel == null) {
                nivel = new Nivel();
                nivel.setNome("");
            }
        %>
        <div class="row">
            <div class="col-sm-12">
                <form class="gravar" method="post" action="gravarNivel.jsp" class="panel form-horizontal">
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-sm-6">
                                <div class="form-group no-margin-hr">
                                    <label class="control-label">Nome</label>
                                    <input type="text" name="nome" class="form-control" value="<%=nivel.getNome()%>">
                                    <input type="hidden" name="codigo" class="form-control" value="<%=nivel.getCodigo()%>">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-3">
                                <div class="form-group no-margin-hr">
                                    <label class="control-label">Faixa Início</label>
                                    <input type="text" name="faixainicio" class="form-control" value="<%=nivel.getFaixaInicio()%>">
                                </div>
                            </div>
                            <div class="col-sm-3">
                                <div class="form-group no-margin-hr">
                                    <label class="control-label">Faixa Fim</label>
                                    <input type="text" name="faixafim" class="form-control" value="<%=nivel.getFaixaFim()%>">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="panel-footer text-right">
                        <a href="/Gamification/listarNiveis.jsp"><button class="btn btn-primary" type="button" name="voltar">Voltar</button></a>
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
                    faixainicio: {
                        validators: {
                            notEmpty: {
                            }
                        }
                    },
                    faixafim: {
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