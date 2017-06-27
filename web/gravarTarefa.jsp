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
        Tarefa va = new Tarefa();
        va.setCodigo(Integer.parseInt(request.getParameter("codigo")));
        va.setTitulo(request.getParameter("titulo"));
        va.setDescricao(request.getParameter("descricao"));
        va.setDicas(request.getParameter("dicas"));
        va.setPontosVale(Integer.parseInt(request.getParameter("pontosvale")));
        va.setCodNivel(Integer.parseInt(request.getParameter("codnivel")));
        va.setCodPremio(Integer.parseInt(request.getParameter("codpremio")));
        va.setCodProfessorCadastro(Integer.parseInt(request.getParameter("codprofessor")));
        va.setCodModulo(Integer.parseInt(request.getParameter("codmodulo")));
        va.setDataHoraCadastro(request.getParameter("datacadastro"));
        va.setResposta(""); // Não tem resposta no cadastro
        va.setDeletado(false);

        Usuario professor = (Usuario) session.getAttribute("usuario");
        // Só altera o código do professor se for uma tarefa nova (código 0)
        if (professor != null && va.getCodigo() == 0) {
            va.setCodProfessorCadastro(professor.getCodigo());
        }

        request.setAttribute("tarefa", va);

        try {
            RequestDispatcher rd = request.getRequestDispatcher("/acoes?acao=gravarTarefa");
            rd.forward(request, response);
        } catch (Exception e) {
            System.out.println("Erro de encaminhamento = " + e);
        }
    %>
</html>