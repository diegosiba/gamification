<%-- 
    Document   : consultaWeb
    Created on : 13/07/2017, 23:06:40
    Author     : diego
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<body>
    Este é o local do churrasco no sábado!!
    
</body>

<%-- start web service invocation --%><hr/>
    <%
    try {
	br.com.correios.bsb.sigep.master.bean.cliente.AtendeClienteService service = new br.com.correios.bsb.sigep.master.bean.cliente.AtendeClienteService();
	br.com.correios.bsb.sigep.master.bean.cliente.AtendeCliente port = service.getAtendeClientePort();
	 // TODO initialize WS operation arguments here
	java.lang.String cep = request.getParameter("cep");
	// TODO process result here
	br.com.correios.bsb.sigep.master.bean.cliente.EnderecoERP result = port.consultaCEP(cep);
	
        out.println("Endereço: "+result.getEnd()+ "<br>") ;
        out.println("Bairro: "+result.getBairro()+ "<br>");
        out.println("Cidade: "+result.getCidade()+ "<br>");
        out.println("UF: "+result.getUf());      
        
                
    } catch (Exception ex) {
	// TODO handle custom exceptions here
    }
    %>
    <%-- end web service invocation --%><hr/>
