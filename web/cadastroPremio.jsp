<%@page import="DAO.PremioDAO"%>
<%@page import="Modelo.Premio"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <%@include file="header.jsp" %>
    <%@include file="permissao.jsp" %>

    <div id="content-wrapper">
        <div class="page-header">
            <h1><span class="text-light-gray">Cadastro de </span>Prêmio</h1>
        </div> 
        <%            Premio va = (Premio) request.getAttribute("premio");
            if (va == null) {
                va = new Premio();
                va.setNome("");
                va.setIcone("");
            }
        %>
        <div class="row">
            <div class="col-sm-12">
                <form class="gravar" method="post" action="gravarPremio.jsp" class="panel form-horizontal">
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
                                    <label class="control-label">Ícone</label>
                                    <select  name = "icone" class="form-control">
                                        <% ArrayList<String> imagens = new PremioDAO().listarImagens();
                                            for (int i = 0; i < imagens.size(); i++) {
                                                String imagem = imagens.get(i).toString();
                                        %>
                                        <option value="<%=imagem%>" 
                                                <% if (imagem.equals(va.getIcone())) {%>
                                                selected="selected"
                                                <%}%>>
                                            <%=imagem%> </option>
                                            <% }%>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="panel-footer text-right">
                        <a href="/Gamification/listarPremios.jsp"><button class="btn btn-primary" type="button" name="voltar">Voltar</button></a>
                        <button type="submit" class="btn btn-primary">Salvar</button>
                    </div>
                </form>
            </div>
        </div>
        <%@include file="exemploPremio.jsp" %>
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
                        icone: {
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