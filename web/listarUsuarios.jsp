<%@page import="java.util.ArrayList"%>
<%@page import="DAO.UsuarioDAO"%>
<%@page import="Modelo.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <%@include file="header.jsp" %>
    <%@include file="permissao.jsp" %>
    
    <div id="content-wrapper">
        <div class="page-header">
            <h1><span class="text-light-gray">Listagem de </span>Usuários</h1>
        </div>
    </div>
    <div id="content-wrapper" style=margin-top:-80px>
        <div class="panel-body">
            <script>
                init.push(function () {
                    $('#tabela').dataTable(({"aoColumnDefs": [{'bSortable': false, 'aTargets': [5, 6]}]}));
                    $('#tabela .dataTables_filter input').attr('placeholder', 'Pesquisa...');
                });
            </script>
            <table id="tabela" class="table table-striped">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Nome</th>
                        <th>Email</th>
                        <th>TIPO</th>
                        <th>CADASTRO</th>
                        <th></th>
                        <th>
                            <a href="/Gamification/acoes?acao=novoUsuario"><button class="btn btn-primary" type="Submit" name="novo">Novo</button></a>
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <%  ArrayList<Usuario> listaDeUsuarios = new UsuarioDAO().listarUsuarios();
                        for (int i = 0; i < listaDeUsuarios.size(); i++) {
                            Usuario u = listaDeUsuarios.get(i);
                    %>
                    <tr>
                        <td><%=u.getCodigo()%></td>
                        <td><%=u.getNome()%></td>
                        <td align="left"><%=u.getEmail()%></td>
                        <td align="left"><% if (u.isProfessor()) {%>
                            PROFESSOR
                            <%} else {%>
                            ALUNO
                            <%}%>
                        </td>
                        <td><%=u.getDataCadastro()%></td>
                        <td><a href="/Gamification/acoes?acao=alterarUsuario&codigo=<%=u.getCodigo()%>"><img src="assets/icones/editar.png" title="alterar" border="0" style="width: 18px"></a></td>
                        <td><a href="/Gamification/acoes?acao=excluirUsuario&codigo=<%=u.getCodigo()%>"><img src="assets/icones/excluir.png" title="excluir" border="0" style="width: 25px"></a></td>
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