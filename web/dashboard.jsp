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
            <h1><span class="text-light-gray">Ranking </span>Alunos</h1>
        </div>
    </div>
    <div id="content-wrapper" style=margin-top:-80px>
        <div class="panel-body">
            <table id="tabela" class="table table-striped">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Nome</th>
                        <th>Nivel</th>
                        <th>Pontos</th>
                    </tr>
                </thead>
                <tbody>
                    <%  ArrayList<Usuario> listaDeUsuarios = new UsuarioDAO().listarMelhoresAlunos();
                        for (int i = 0; i < listaDeUsuarios.size(); i++) {
                            Usuario u = listaDeUsuarios.get(i);
                    %>
                    <tr>
                        <td><%=u.getCodigo()%></td>
                        <td><%=u.getNome()%></td>
                        <td><%=u.getNivelAtual().getNome()%></td>
                        <td><%=u.getTotalPontos()%></td>
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