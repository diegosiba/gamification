<%@page import="java.util.ArrayList"%>
<%@page import="DAO.TarefaDAO"%>
<%@page import="Modelo.Tarefa"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <%@include file="header.jsp" %>
    <%@include file="permissao.jsp" %>
    <div id="content-wrapper">
        <div class="page-header">
            <h1><span class="text-light-gray">Listagem de </span>Tarefas </h1>
        </div>
    </div>
    <div id="content-wrapper" style=margin-top:-80px>
        <div class="panel-body">
            <script>
                init.push(function () {
                    $('#tabela').dataTable(({"aoColumnDefs": [{'bSortable': false, 'aTargets': [6,7]}]}));
                    $('#tabela .dataTables_filter input').attr('placeholder', 'Pesquisa...');
                });
            </script>
            <table id="tabela" class="table table-striped">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>TÍTULO</th>
                        <th>PONTUAÇÃO</th>
                        <th>PREMIO</th>
                        <th>NÍVEL</th>
                        <th>MÓDULO</th>
                        <th>CADASTRO</th>
                        <th></th>
                            <% if (usuarioSessao.isProfessor()) {%>
                        <th>
                            <a href="/Gamification/acoes?acao=novaTarefa"><button class="btn btn-primary" type="Submit" name="novo">Novo</button></a>
                        </th>
                        <% } %>
                    </tr>
                </thead>
                <tbody>
                    <%  ArrayList<Tarefa> listaDeTarefas = new TarefaDAO().listarTarefas();
                        for (int i = 0; i < listaDeTarefas.size(); i++) {
                            Tarefa t = listaDeTarefas.get(i);
                    %>
                    <tr>
                        <td><%=t.getCodigo()%></td>
                        <td><%=t.getTitulo()%></td>
                        <td align="left"><%=t.getPontosVale()%></td>
                        <td><%=t.getPremio().getNome()%></td>
                        <td><%=t.getNivel().getNome()%></td>
                        <td><%=t.getModulo().getNome()%></td>
                        <td><%=t.getDataCadastro()%></td>
                        <% if (usuarioSessao.isProfessor()) {%>
                        <td><a href="/Gamification/acoes?acao=alterarTarefa&codigo=<%=t.getCodigo()%>"><img src="assets/icones/editar.png" title="alterar" border="0" style="width: 18px"></a></td>
                        <td><a href="/Gamification/acoes?acao=excluirTarefa&codigo=<%=t.getCodigo()%>"><img src="assets/icones/excluir.png" title="excluir" border="0" style="width: 25px"></a></td>
                                <% } else {%>
                        <td><a href="/Gamification/acoes?acao=alterarTarefa&codigo=<%=t.getCodigo()%>"><img src="assets/icones/editar.png" title="alterar" border="0" style="width: 18px"></a></td>
                                <% } %>
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