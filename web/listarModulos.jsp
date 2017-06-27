<%@page import="java.util.ArrayList"%>
<%@page import="DAO.ModuloDAO"%>
<%@page import="Modelo.Modulo"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <%@include file="header.jsp" %>
    <%@include file="permissao.jsp" %>

    <div id="content-wrapper">
        <div class="page-header">
            <h1><span class="text-light-gray">Listagem de </span>Módulos</h1>
        </div>
    </div>
    <div id="content-wrapper" style=margin-top:-80px>
        <div class="panel-body">
            <script>
                init.push(function () {
                    $('#tabela').dataTable(({"aoColumnDefs": [{'bSortable': false, 'aTargets': [7, 8]}]}));
                    $('#tabela .dataTables_filter input').attr('placeholder', 'Pesquisa...');
                });
            </script>
            <table id="tabela" class="table table-striped">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>NOME</th>
                        <th>INÍCIO</th>
                        <th>FIM</th>
                        <th>MÍN. PONTOS</th>
                        <th>MÍN. TAREFAS</th>
                        <th>CADASTRO</th>
                        <th></th>
                        <th>
                            <a href="/Gamification/acoes?acao=novoModulo"><button class="btn btn-primary" type="Submit" name="novo">Novo</button></a>
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <%  ArrayList<Modulo> listaDeModulos = new ModuloDAO().listarModulos();
                        for (int i = 0; i < listaDeModulos.size(); i++) {
                            Modulo va = listaDeModulos.get(i);
                    %>
                    <tr>
                        <td><%=va.getCodigo()%></td>
                        <td><%=va.getNome()%></td>
                        <td align="left"><%=Utils.Util.getDate(va.getInicioModulo())%></td>
                        <td align="left"><%=Utils.Util.getDate(va.getFimModulo())%></td>
                        <td align="left"><%=va.getMinimoPontos()%></td>
                        <td align="left"><%=va.getMinimoTarefas()%></td>
                        <td><%=va.getDataCadastro()%></td>
                        <td><a href="/Gamification/acoes?acao=alterarModulo&codigo=<%=va.getCodigo()%>"><img src="assets/icones/editar.png" title="alterar" border="0" style="width: 18px"></a></td>
                        <td><a href="/Gamification/acoes?acao=excluirModulo&codigo=<%=va.getCodigo()%>"><img src="assets/icones/excluir.png" title="excluir" border="0" style="width: 25px"></a></td>
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