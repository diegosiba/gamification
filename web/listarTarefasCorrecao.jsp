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
            <h1><span class="text-light-gray">Listagem de </span>Tarefas para corrigir</h1><br>
        </div>
    </div>
    <div id="content-wrapper" style=margin-top:-80px>
        <div class="panel-body">
            <script>
                init.push(function () {
                    $('#tabela').dataTable(({"aoColumnDefs": [{'bSortable': false, 'aTargets': [6]}]}));
                    $('#tabela .dataTables_filter input').attr('placeholder', 'Pesquisa...');
                });
            </script>
            <table id="tabela" class="table table-striped">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>TÍTULO</th>
                        <th>NÍVEL</th>
                        <th>PONTUAÇÃO</th>
                        <th>RESULTADO</th>
                        <th>MODULO</th>
                        <th>CORREÇÃO</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    <%  ArrayList<Tarefa> listaDeTarefas = new TarefaDAO().listarTarefasParaAvaliar();
                        for (int i = 0; i < listaDeTarefas.size(); i++) {
                            Tarefa t = listaDeTarefas.get(i);
                    %>
                    <tr>
                        <td><%=t.getCodigo()%></td>
                        <td><%=t.getTitulo()%></td>
                        <td><%=t.getNivel().getNome()%></td>
                        <td align="left"><%=t.getPontosVale()%></td>
                        <td align="left"><%=t.getPontosGanhou()%></td>
                        <td><%=t.getModulo().getNome()%></td>
                        <td><%=t.getDataAvaliacao()%></td>
                        <%if (t.isAvaliado()) {%>
                        <td><button data-type="warning" disabled="" class="btn btn-warning">Corrigido!</button></td>
                        <% } else {%>
                        <td><a href="/Gamification/acoes?acao=cadastroCorrecao&codigo=<%=t.getCodigo()%>"><button data-type="warning" class="btn btn-success">Avaliar</button></a></td>
                        <% }%>
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