<%@page import="Modelo.Tarefa"%>
<%@page import="Modelo.Usuario"%>
<%@ page import="Utils.Consts"%>
<%@ page import="Utils.Util"%>
<%@ page import="java.io.*,java.util.*, javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <%
        try {
            // captura dados que vieram pela requisicao do POST
            Tarefa va = new Tarefa();

            va.setCodigo(Integer.parseInt(request.getParameter("codigo")));
            va.setCodAlunoConcluiu(Integer.parseInt(request.getParameter("codalunoconcluiu")));
            va.setCodProfessorAvaliador(Integer.parseInt(request.getParameter("codprofessoravaliador")));
            va.setPontosGanhou(Integer.parseInt(request.getParameter("pontosganhou")));
            va.setComentario(request.getParameter("comentario"));

            request.setAttribute("avaliacao", va);

            RequestDispatcher rd = request.getRequestDispatcher("/acoes?acao=gravarAvaliacao");
            rd.forward(request, response);
        } catch (Exception e) {
            System.out.println("Erro de encaminhamento = " + e);
        }
    %>
</html>
