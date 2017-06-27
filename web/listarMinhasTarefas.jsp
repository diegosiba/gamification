<%@page import="DAO.ModuloDAO"%>
<%@page import="Modelo.Modulo"%>
<%@page import="java.util.ArrayList"%>
<%@page import="DAO.TarefaDAO"%>
<%@page import="Modelo.Tarefa"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <%@include file="header.jsp" %>

    <div id="content-wrapper">
        <div class="page-header">
            <h1><span class="text-light-gray">Listagem de </span>Minhas Tarefas</h1><br>
            Você está no nível <%=usuarioSessao.getNivelAtual().getNome()%><br>
            <%Modulo modulo = new ModuloDAO().buscarModuloAtual();
                if (modulo != null) {%>
            Você está no módulo <%=modulo.getNome()%>
            <%} else {%>
            Nenhum módulo aberto no momento
            <%}%>
        </div>
    </div>
    <div id="content-wrapper" style=margin-top:-80px>
        <div class="panel-body">
            <script>
                init.push(function () {
                    $('#tabela').dataTable(({"aoColumnDefs": [{'bSortable': false, 'aTargets': [5]}]}));
                    $('#tabela .dataTables_filter input').attr('placeholder', 'Pesquisa...');
                });
            </script>
            <table id="tabela" class="table table-striped">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>TÍTULO</th>
                        <th>NIVEL</th>
                        <th>PONTUAÇÃO</th>
                        <th>PREMIO</th>
                        <th>CONCLUSÃO</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    <%  ArrayList<Tarefa> listaDeTarefas = new TarefaDAO().listarMinhasTarefasParaResolver();
                        for (int i = 0; i < listaDeTarefas.size(); i++) {
                            Tarefa t = listaDeTarefas.get(i);
                    %>
                    <tr>
                        <td><%=t.getCodigo()%></td>
                        <td><%=t.getTitulo()%></td>
                        <td><%=t.getNivel().getNome()%></td>
                        <td align="left"><%=t.getPontosVale()%></td>
                        <td><%=t.getPremio().getNome()%></td>
                        <td><%=t.getDataConclusao()%></td>
                        <%if (t.isConcluida()) {%>
                        <td><button data-type="warning" disabled="" class="btn btn-warning">Respondida!</button></td>
                        <% } else {%>
                        <td><a href="/Gamification/acoes?acao=cadastroResposta&codigo=<%=t.getCodigo()%>"><button data-type="warning" class="btn btn-success">Responder</button></a></td>
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