<%@page import="Modelo.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <%

        // captura dados que vieram pela requisicao do POST
        Usuario usuario = new Usuario();
        usuario.setEmail(request.getParameter("email"));
        usuario.setSenha(request.getParameter("senha"));

        request.setAttribute("usuario", usuario);
        
        try {
            RequestDispatcher rd = request.getRequestDispatcher("/acoes?acao=autenticar");
            rd.forward(request, response);
        } catch (Exception e) {
            System.out.println("Erro de encaminhamento = " + e);
        }
    %>
</html>
