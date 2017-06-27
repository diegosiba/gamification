<%
    if (usuarioSessao.isAluno()) {
        response.sendRedirect("semPermissao.jsp");
    }
%>