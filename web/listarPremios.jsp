<%@page import="java.util.ArrayList"%>
<%@page import="DAO.PremioDAO"%>
<%@page import="Modelo.Premio"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <%@include file="header.jsp" %>
    <%@include file="permissao.jsp" %>

    <div id="content-wrapper">
        <div class="page-header">
            <h1><span class="text-light-gray">Listagem de </span>Prêmios</h1>
        </div>
    </div>
    <div id="content-wrapper" style=margin-top:-80px>
        <div class="panel-body">
            <script>
                init.push(function () {
                    $('#tabela').dataTable(({"aoColumnDefs": [{'bSortable': false, 'aTargets': [4, 5]}]}));
                    $('#tabela .dataTables_filter input').attr('placeholder', 'Pesquisa...');
                });
            </script>
            <table id="tabela" class="table table-striped">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>NOME</th>
                        <th>ICONE</th>
                        <th>CADASTRO</th>
                        <th></th>
                        <th>
                            <a href="/Gamification/acoes?acao=novoPremio"><button class="btn btn-primary" type="Submit" name="novo">Novo</button></a>
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <%  ArrayList<Premio> listaDePremios = new PremioDAO().listarPremios();
                        for (int i = 0; i < listaDePremios.size(); i++) {
                            Premio va = listaDePremios.get(i);
                    %>
                    <tr>
                        <td><%=va.getCodigo()%></td>
                        <td><%=va.getNome()%></td>
                        <td><img src="<%= va.getImagem()%>" border="0" style="width: 15%"></td>
                        <td><%=va.getDataCadastro()%></td>
                        <td><a href="/Gamification/acoes?acao=alterarPremio&codigo=<%=va.getCodigo()%>"><img src="assets/icones/editar.png" title="alterar" border="0" style="width: 18px"></a></td>
                        <td><a href="/Gamification/acoes?acao=excluirPremio&codigo=<%=va.getCodigo()%>"><img src="assets/icones/excluir.png" title="excluir" border="0" style="width: 25px"></a></td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>
    <div id="main-menu-bg"></div>
    <%@include file="footer.jsp" %>
</html>