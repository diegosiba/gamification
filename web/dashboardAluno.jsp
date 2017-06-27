<%@page import="DAO.ModuloDAO"%>
<%@page import="Modelo.Modulo"%>
<%@page import="DAO.TarefasFechadasDAO"%>
<%@page import="Modelo.TarefasFechadas"%>
<%@page import="Modelo.Nivel"%>
<%@page import="DAO.NivelDAO"%>
<%@page import="Modelo.Tarefa"%>
<%@page import="DAO.TarefaDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/data.js"></script>
<script src="https://code.highcharts.com/modules/drilldown.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>

<!DOCTYPE html>


<style type="text/css">
    #teste {
        font-family:  'Hoefler Text', Georgia, 'Times New Roman', serif;
        font-weight: normal;
        font-size: 1.75em;
        letter-spacing: .2em;
        line-height: 1.1em;
        margin:0px;
        text-align: center;
        text-transform: uppercase;
    }
</style>

<html>
    <%@include file="header.jsp" %>
    <%
           
        String nivelAtual = usuarioSessao.getNivelAtual().getNome();
        int totalPontos = usuarioSessao.getTotalPontos();
        int pontosFaltamProximoNivel = usuarioSessao.getNivelAtual().getFaixaFim() - usuarioSessao.getTotalPontos();
        int rangeNivel = usuarioSessao.getNivelAtual().getFaixaFim() - usuarioSessao.getNivelAtual().getFaixaInicio();
        int pontosDesseNivel = usuarioSessao.getTotalPontos() - usuarioSessao.getNivelAtual().getFaixaInicio();
        int percentualGrafico = (pontosDesseNivel * 100) / rangeNivel;
        String exibirNoGrafico = pontosDesseNivel + " pontos - (" + percentualGrafico + "%)";
        int codModulo = 0;
        String temp = (String) session.getAttribute("codModulo");
        if (temp != null)
            codModulo = Integer.parseInt(temp);
        
    %>

    <div id="content-wrapper">
        <div class="page-header">
            <div class="col-sm-6" >
                <h1><span class="text-light-gray">Acompanhamento do </span>Aluno</h1>
            </div>
            <div class="col-sm-6" >
                <div class="col-sm-3">
                    <label class="control-label">Módulo</label>
                </div>
                <div class="col-sm-5">
                    <select  name = "codmodulo" class="form-control">
                        <% ArrayList<Modulo> modulos = new ModuloDAO().listarModulos();
                            for (int i = 0; i < modulos.size(); i++) {
                                Modulo modulo = modulos.get(i);
                        %>
                        <option value="<%=modulo.getCodigo()%>" 
                                <% if (i == 0) {%>
                                selected="selected"
                                <%}%>>
                            <%=modulo.getNome()%> </option>
                            <% }%>
                    </select>
                </div>
                <div class="col-sm-1"></div>
                <div class="col-sm-2">
                    <td><a href="/Gamification/dashboardAluno.jsp"><button data-type="warning" class="btn btn-success">Atualizar</button></a></td>
                </div>
            </div>
        </div> 
        <div class="panel-body">
            <div class="row">
                <div class="col-sm-6" >
                    <a id="teste">você está no nível <br><%=nivelAtual%></a>
                </div>
                <div class="col-sm-6">
                    <a id="teste">Para atingir o próximo nível faltam <%=pontosFaltamProximoNivel%> pontos</a>
                </div>
            </div>
            <div class="row" style="margin-top: 50px">
                <div class="col-sm-6">
                    <a id="teste">Sua pontuação total é de <br><%=totalPontos%> pontos</a>
                </div>
                <div class="col-sm-6">
                    <div class="row">
                        <div class="col-sm-3">
                            <%=usuarioSessao.getNivelAtual().getFaixaInicio()%> pontos
                        </div>
                        <div class="col-sm-6"></div>
                        <div class="col-sm-3">
                            <%=usuarioSessao.getNivelAtual().getFaixaFim()%> pontos
                        </div>
                    </div>
                    <div class="box">
                        <div id="myProgress" style="width: 100%; background-color: gray">
                            <div id="myBar" style="width: <%=percentualGrafico%>%; height: 40px; 
                                 background-color: #4CAF50; text-align: center; 
                                 line-height: 30px; color: white"><%=exibirNoGrafico%></div>
                        </div>
                    </div>
                </div>
            </div> 
            <div class="row" style="margin-top: 50px"> 
                <div class="col-md-6">
                    <div id="barras" style="min-width: 310px; height: 400px; margin: 0 auto"></div>
                </div>         
                <div class="col-md-6">
                    <div class="col-sm-12">
                        <a id="teste">Prêmios Conquistados <br></a>
                    </div>
                    <br>
                    <br>
                    <br>
                    <%  ArrayList<Tarefa> tarefasPremio = new TarefaDAO().listarMinhasTarefasPremios(usuarioSessao.getCodigo());
                        for (int i = 0; i < tarefasPremio.size(); i++) {
                            Tarefa tarefa = tarefasPremio.get(i);
                            if (tarefa.temPremio()) {
                    %>
                    <div class="col-md-6">
                        <img src="<%= tarefa.getPremio().getImagem()%>" border="0" style="width: 30%">
                        <br>
                        <%--<%=tarefa.getPremio().getNome()%>--%>
                        <br>
                        <%--=tarefa.getTarefaCodigoNome()--%> 
                    </div>
                    <%                            }
                        }
                    %>
                </div>
            </div> 
            <script>
                Highcharts.chart('barras', {
                chart: {
                type: 'column'
                },
                        title: {
                        text: 'Tarefas por Nível'
                        },
                        subtitle: {
                        text: 'considera todas as tarefas do jogo'
                        },
                        xAxis: {
                        categories: [
                <% ArrayList<Nivel> niveis = new NivelDAO().listarNiveis();
                    for (int i = 0;
                            i < niveis.size();
                            i++) {
                        Nivel va = niveis.get(i);
                %>
                        '<%=va.getNome()%>'
                <%  if (i != niveis.size() - 1) {%>
                        ,
                <%}%>
                <%
                    }
                %>
                        ],
                                crosshair: true
                        },
                        yAxis: {
                        min: 0,
                                title: {
                                text: 'Quantidade'
                                }
                        },
                        tooltip: {
                        headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
                                pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                                '<td style="padding:0"><b>{point.y:.1f}</b></td></tr>',
                                footerFormat: '</table>',
                                shared: true,
                                useHTML: true
                        },
                        plotOptions: {
                        column: {
                        pointPadding: 0.2,
                                borderWidth: 0
                        }
                        },
                        series: [{
                        name: 'Abertas',
                                data: [
                <% ArrayList<TarefasFechadas> tarefas = new TarefasFechadasDAO().listarTarefasFechadas();
                    for (int i = 0;
                            i < tarefas.size();
                            i++) {
                        TarefasFechadas tarefaFechada = tarefas.get(i);
                %>
                <%=tarefaFechada.getAbertas()%>
                <%  if (i != tarefas.size() - 1) {%>
                                ,
                <%}%>
                <%}%>
                                ]
                        }, {
                        name: 'Fechadas',
                                data: [
                <%
                    for (int i = 0;
                            i < tarefas.size();
                            i++) {
                        TarefasFechadas tarefaFechada = tarefas.get(i);
                %>
                <%=tarefaFechada.getFechadas()%>
                <%  if (i != tarefas.size() - 1) {%>
                                ,
                <%}%>
                <%}%>
                                ]

                        }]
                });
            </script>
            <%@include file="footer.jsp" %>
            </html>