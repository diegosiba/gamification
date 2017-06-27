<%@ page import="Modelo.Nivel"%>
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
        Nivel va = new Nivel();
        va.setCodigo(Integer.parseInt(request.getParameter("codigo")));
        va.setNome(request.getParameter("nome"));
        va.setFaixaInicio(Integer.parseInt(request.getParameter("faixainicio")));
        va.setFaixaFim(Integer.parseInt(request.getParameter("faixafim")));
        va.setDataHoraCadastro(request.getParameter("datacadastro"));
        va.setDeletado(false);

        request.setAttribute("nivel", va);

        try {
            RequestDispatcher rd = request.getRequestDispatcher("/acoes?acao=gravarNivel");
            rd.forward(request, response);
        } catch (Exception e) {
            System.out.println("Erro de encaminhamento = " + e);
        }
    %>
</html>
