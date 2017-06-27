<%@page import="DAO.TarefaDAO"%>
<%@page import="Modelo.Usuario"%>
<%@ page import="Modelo.Tarefa"%>
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
        // captura dados que vieram pela requisicao do POST
        Tarefa va = new TarefaDAO().buscarUm(Integer.parseInt(request.getParameter("codigo")));
        va.setResposta(request.getParameter("resposta"));
        va.setCodAlunoConcluiu(Integer.parseInt(request.getParameter("codalunoconcluiu")));
        va.setConcluida(request.getParameter("concluida") != null);

        request.setAttribute("resposta", va);

        try {
            RequestDispatcher rd = request.getRequestDispatcher("/acoes?acao=gravarResposta");
            rd.forward(request, response);
        } catch (Exception e) {
            System.out.println("Erro de encaminhamento = " + e);
        }
    %>
</html>
