<%@page import="DAO.ModuloDAO"%>
<%@page import="DAO.PremioDAO"%>
<%@page import="DAO.TarefaDAO"%>
<%@page import="DAO.UsuarioDAO"%>
<%@page import="DAO.NivelDAO"%>
<%@page import="Modelo.Modulo"%>
<%@page import="Modelo.Premio"%>
<%@page import="Modelo.Tarefa"%>
<%@page import="Modelo.Usuario"%>
<%@page import="Modelo.Nivel"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <%@include file="header.jsp" %>
    <%@include file="permissao.jsp" %>

    <div id="content-wrapper">
        <div class="page-header">
            <h1><span class="text-light-gray">Cadastro de </span>Tarefa</h1>
        </div> 
        <%            Tarefa va = (Tarefa) request.getAttribute("tarefa");
            if (va == null) {
                va = new Tarefa();
                va.setTitulo("");
                va.setDescricao("");
                va.setVideo("");
                va.setPontosVale(0);
                va.setConcluida(false);
            }
        %>
        <div class="row">
            <div class="col-sm-12">
                <form class="gravar" method="post" action="gravarTarefa.jsp" class="panel form-horizontal">
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-sm-6">
                                <div class="form-group no-margin-hr">
                                    <label class="control-label">Título</label>
                                    <input type="text" name="titulo" class="form-control" value="<%=va.getTitulo()%>">
                                    <input type="hidden" name="codigo" class="form-control" value="<%=va.getCodigo()%>">
                                </div>
                            </div>
                        </div>
                                
                                
                        <div class="row">
                            <div class="col-sm-6">
                                <div class="form-group no-margin-hr">
                                    <label class="control-label">Descrição</label>
                                    <textarea type="text" name="descricao" class="form-control" rows="3"><%=va.getDescricao()%></textarea>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-6">
                                <div class="form-group no-margin-hr">
                                    <label class="control-label">Link Video</label>
                                    <textarea type="text" name="dicas" class="form-control" rows="3"><%=va.getVideo()%></textarea>
                                </div>
                            </div>
                        </div>
                                
                                                                
                        <div class="row">
                            <div class="col-sm-3">
                                <div class="form-group no-margin-hr">
                                    <label class="control-label">Pontuação</label>
                                    <input type="number" name="pontosvale" class="form-control" value="<%=va.getPontosVale()%>">
                                </div>
                            </div>
                            <div class="col-sm-3">
                                <div class="form-group no-margin-hr">
                                    <label class="control-label">Nível</label>
                                    <select  name = "codnivel" class="form-control">
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
                                    <select  name = "codpremio" class="form-control">
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
                                    <select  name = "codprofessor" class="form-control"> 
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
                            <div class="col-sm-3">
                                <div class="form-group no-margin-hr">
                                    <label class="control-label">Módulo</label>
                                    <select  name = "codmodulo" class="form-control">
                                        <% ArrayList<Modulo> modulos = new ModuloDAO().listarModulosNaoFechados();
                                            for (int i = 0; i < modulos.size(); i++) {
                                                Modulo modulo = modulos.get(i);
                                        %>
                                        <option value="<%=modulo.getCodigo()%>" 
                                                <% if (va.getCodPremio() == modulo.getCodigo()) {%>
                                                selected="selected"
                                                <%}%>>
                                            <%=modulo.getNome()%> </option>
                                            <% }%>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="panel-footer text-right">
                        <a href="/Gamification/listarTarefas.jsp"><button class="btn btn-primary" type="button" name="voltar">Voltar</button></a>
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
                    titulo: {
                        validators: {
                            notEmpty: {
                            }
                        }
                    },
                    descricao: {
                        validators: {
                            notEmpty: {
                            }
                        }
                    },
                    pontuacao: {
                        validators: {
                            notEmpty: {
                            }
                        }
                    },
                    resultado: {
                        validators: {
                            notEmpty: {
                            }
                        }
                    },
                    codPremio: {
                        validators: {
                            notEmpty: {
                            }
                        }
                    },
                    codProfessor: {
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