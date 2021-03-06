<%@page import="DAO.PremioDAO"%>
<%@page import="DAO.TarefaDAO"%>
<%@page import="DAO.UsuarioDAO"%>
<%@page import="DAO.NivelDAO"%>
<%@page import="Modelo.Premio"%>
<%@page import="Modelo.Tarefa"%>
<%@page import="Modelo.Usuario"%>
<%@page import="Modelo.Nivel"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <%@include file="header.jsp" %>

    <div id="content-wrapper">
        <div class="page-header">
            <h1><span class="text-light-gray">Cadastro de </span>Resposta</h1>
        </div> 
        <%            Tarefa va = (Tarefa) request.getAttribute("resposta");
            if (va == null) {
                va = new Tarefa();
                va.setTitulo("");
                va.setDescricao("");
                va.setVideo("");
                va.setPontosVale(-1);
                va.setConcluida(false);
            }
        %>
        <div class="row">
            <div class="col-sm-12">
                <form class="gravar" method="post" action="gravarResposta.jsp" class="panel form-horizontal">
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-sm-6">
                                <div class="form-group no-margin-hr">
                                    <label class="control-label">Título</label>
                                    <input type="text" name="titulo" disabled="" class="form-control" value="<%=va.getTitulo()%>">
                                    <input type="hidden" name="codigo" class="form-control" value="<%=va.getCodigo()%>">
                                    <input type="hidden" name="codalunoconcluiu" class="form-control" value="<%=usuarioSessao.getCodigo()%>">
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="form-group no-margin-hr">
                                    <label class="control-label">Resposta</label>
                                    <textarea type="text" name="resposta" class="form-control" rows="6"><%=va.getResposta()%></textarea>
                                </div>
                            </div>

                        </div>
                        <div class="row">
                            <div class="col-sm-6">
                                <div class="form-group no-margin-hr">
                                    <label class="control-label">Descrição</label>
                                    <textarea type="text" name="descricao" disabled="" class="form-control" rows="3"><%=va.getDescricao()%></textarea>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="form-group no-margin-hr">
                                        <label class="control-label">Concluir tarefa</label>
                                        <input type="checkbox" name="concluida" class="form-control" 
                                               <%if (va.isConcluida()) {%>
                                               checked
                                               <%}%>>
                                    </div>
                                </div>
                            </div>



                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="form-group no-margin-hr">
                                        <label class="control-label">Link Video</label>
                                        <textarea type="text" name="dicas" disabled="" class="form-control" rows="3"><%=va.getVideo()%></textarea>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-3">
                                    <div class="form-group no-margin-hr">
                                        <label class="control-label">Pontuação</label>
                                        <input type="number" name="pontosvale" disabled="" class="form-control" value="<%=va.getPontosVale()%>">
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group no-margin-hr">
                                        <label class="control-label">Nível</label>
                                        <select  name = "codnivel" disabled="" class="form-control">
                                            <% ArrayList<Nivel> niveis = new NivelDAO().listarNiveis();
                                                for (int i = 0; i < niveis.size(); i++) {
                                                    Nivel nivel = niveis.get(i);
                                            %>
                                            <option value="<%=nivel.getCodigo()%>" 
                                                    <% if (va.getCodNivel() == nivel.getCodigo()) {%>
                                                    selected="selected"
                                                    <%}%>>
                                                <%=nivel.getNome()%> </option>
                                                <% }%>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-3">
                                    <div class="form-group no-margin-hr">
                                        <label class="control-label">Prêmio</label>
                                        <select  name = "codpremio" disabled="" class="form-control">
                                            <% ArrayList<Premio> premios = new PremioDAO().listarPremios();
                                                for (int i = 0; i < premios.size(); i++) {
                                                    Premio premio = premios.get(i);
                                            %>
                                            <option value="<%=premio.getCodigo()%>" 
                                                    <% if (va.getCodPremio() == premio.getCodigo()) {%>
                                                    selected="selected"
                                                    <%}%>>
                                                <%=premio.getNome()%> </option>
                                                <% }%>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group no-margin-hr">
                                        <label class="control-label">Professor</label>
                                        <select  name = "codprofessor" disabled="" class="form-control"> 
                                            <% ArrayList<Usuario> professores = new UsuarioDAO().listarProfessores();
                                                for (int i = 0; i < professores.size(); i++) {
                                                    Usuario professor = professores.get(i);
                                            %>
                                            <option value="<%=professor.getCodigo()%>" 
                                                    <% if (va.getCodProfessorCadastro() == professor.getCodigo()) {%>
                                                    selected="selected"
                                                    <%}%>>
                                                <%=professor.getNome()%> </option>
                                                <% }%>
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="form-group no-margin-hr">
                                        <label class="control-label">Exibir Video</label>
                                  
                                        <iframe width="560" height="315" src="https://www.youtube.com/embed/<%=va.getVideo()%>" frameborder="0" allowfullscreen></iframe>
                                        
                                    </div>
                                </div>
                            </div>

                        </div>
                        <div class="panel-footer text-right">
                            <a href="/Gamification/listarMinhasTarefas.jsp"><button class="btn btn-primary" type="button" name="voltar">Voltar</button></a>
                            <button type="submit" class="btn btn-primary">Salvar</button>
                        </div>
                </form>
            </div>
        </div>
    </div>
    <div id="main-menu-bg"></div>
    <%@include file="footer.jsp" %>
    <script type="text/javascript">
        $(document).ready(function () {
            $('.gravar').bootstrapValidator({
                fields: {
                    resposta: {
                        validators: {
                            notEmpty: {
                            }
                        }
                    }
                }
            });
        });
    </script>
</html>