<%@ page import="Modelo.Modulo"%>
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
        Modulo va = new Modulo();
        va.setCodigo(Integer.parseInt(request.getParameter("codigo")));
        va.setNome(request.getParameter("nome"));
        va.setInicioModulo(request.getParameter("iniciomodulo"));
        va.setFimModulo(request.getParameter("fimmodulo"));
        va.setMinimoPontos(Integer.parseInt(request.getParameter("minimopontos")));
        va.setMinimoTarefas(Integer.parseInt(request.getParameter("minimotarefas")));
        va.setDataHoraCadastro(request.getParameter("datacadastro"));
        va.setDeletado(false);

        request.setAttribute("modulo", va);

        try {
            RequestDispatcher rd = request.getRequestDispatcher("/acoes?acao=gravarModulo");
            rd.forward(request, response);
        } catch (Exception e) {
            System.out.println("Erro de encaminhamento = " + e);
        }
    %>
</html>
