/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controle;

import DAO.ModuloDAO;
import DAO.NivelDAO;
import DAO.PremioDAO;
import DAO.TarefaDAO;
import DAO.UsuarioDAO;
import Modelo.Modulo;
import Modelo.Nivel;
import Modelo.Premio;
import Modelo.Tarefa;
import Modelo.Usuario;
import Utils.Consts;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class acoes extends HttpServlet {

    HttpServletRequest requisicao;
    HttpServletResponse resposta;
    String listarUsuarios = "listarUsuarios.jsp";
    String cadastroUsuario = "cadastroUsuario.jsp";

    String listarPremios = "listarPremios.jsp";
    String cadastroPremio = "cadastroPremio.jsp";

    String listarNiveis = "listarNiveis.jsp";
    String cadastroNivel = "cadastroNivel.jsp";

    String listarModulos = "listarModulos.jsp";
    String cadastroModulos = "cadastroModulo.jsp";

    String listarTarefas = "listarTarefas.jsp";
    String cadastroTarefa = "cadastroTarefa.jsp";

    String listarMinhasTarefas = "listarMinhasTarefas.jsp";
    String cadastroResposta = "cadastroResposta.jsp";

    String listarTarefasCorrecao = "listarTarefasCorrecao.jsp";
    String cadastroCorrecao = "cadastroCorrecao.jsp";

    String dashboard = "dashboard.jsp";
    String dashboardAluno = "dashboardAluno.jsp";

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        requisicao = request;
        resposta = response;

        String acao = request.getParameter("acao");
        switch (acao) {
            // USUÁRIO
            case "autenticar":
                autenticar();
                break;
            case "logout":
                fazerLogout();
                break;
            case "novoUsuario":
                novoUsuario();
                break;
            case "gravarUsuario":
                gravarUsuario();
                break;
            case "alterarUsuario":
                alterarUsuario();
                break;
            case "excluirUsuario":
                excluirUsuario();
                break;

            // TAREFA
            case "novaTarefa":
                novaTarefa();
                break;
            case "gravarTarefa":
                gravarTarefa();
                break;
            case "alterarTarefa":
                alterarTarefa();
                break;
            case "excluirTarefa":
                excluirTarefa();
                break;

            // RESPOSTA
            case "cadastroResposta":
                cadastroResposta();
                break;
            case "gravarResposta":
                gravarResposta();
                break;

            // CORREÇÃO
            case "cadastroCorrecao":
                cadastroCorrecao();
                break;
            case "gravarAvaliacao":
                gravarAvaliacao();
                break;

            // PREMIO
            case "novoPremio":
                novoPremio();
                break;
            case "gravarPremio":
                gravarPremio();
                break;
            case "alterarPremio":
                alterarPremio();
                break;
            case "excluirPremio":
                excluirPremio();
                break;

            // NÍVEL
            case "novoNivel":
                novoNivel();
                break;
            case "gravarNivel":
                gravarNivel();
                break;
            case "alterarNivel":
                alterarNivel();
                break;
            case "excluirNivel":
                excluirNivel();
                break;

            // MÓDULO
            case "novoModulo":
                novoModulo();
                break;
            case "gravarModulo":
                gravarModulo();
                break;
            case "alterarModulo":
                alterarModulo();
                break;
            case "excluirModulo":
                excluirModulo();
                break;
            case "atualizarDashboard":
                atualizarDashboard();
                break;
        }

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    // ##### USUÁRIOS
    public void autenticar() {

        Usuario usuario = (Usuario) requisicao.getAttribute("usuario");

        // Atualiza o objeto de usuário.
        usuario = new UsuarioDAO().autenticar(usuario);
        if (usuario != null) {

            // usuario validado: coloca seu nome na sessao
            HttpSession sessao = requisicao.getSession();

            // Salva o usuário na sessão
            sessao.setAttribute("usuario", usuario);

            // Não sei por que faz isso.
            requisicao.setAttribute("usuario", null);

            if (usuario.isAluno()) {
                encaminharPagina(this.dashboardAluno);
            } else {
                encaminharPagina(this.dashboard);
            }
        } else {
            requisicao.setAttribute("erro", "sem permissão");
            encaminharPagina("index.jsp");
        }
    }

    private void novoUsuario() {
        encaminharPagina(this.cadastroUsuario);
    }

    private void fazerLogout() {
        HttpSession sessao = requisicao.getSession();
        sessao.invalidate();
        encaminharPagina("index.jsp");
    }

    public void gravarUsuario() {
        Usuario usuario = (Usuario) requisicao.getAttribute("usuario");
        if (new UsuarioDAO().gravarUsuario(usuario)) {
            requisicao.setAttribute("usuario", null);
            encaminharPagina(this.listarUsuarios);
        }
    }

    private void alterarUsuario() {
        String codigo = requisicao.getParameter(Consts.COL_CODIGO);
        Usuario usuario = new UsuarioDAO().buscarUm(Integer.valueOf(codigo));
        requisicao.setAttribute("usuario", usuario);
        encaminharPagina(this.cadastroUsuario);
    }

    private void excluirUsuario() {
        String codigo = requisicao.getParameter(Consts.COL_CODIGO);

        if (new UsuarioDAO().excluirUsuario(codigo)) {
            encaminharPagina(this.listarUsuarios);
        } else {
            System.out.println("Erro ao excluir!");
        }
    }

    // ##### TAREFAS
    private void novaTarefa() {
        encaminharPagina(this.cadastroTarefa);
    }

    public void gravarTarefa() {
        Tarefa tarefa = (Tarefa) requisicao.getAttribute("tarefa");
        if (new TarefaDAO().gravarTarefa(tarefa)) {
            requisicao.setAttribute("tarefa", null);
            encaminharPagina(this.listarTarefas);
        }
    }

    private void alterarTarefa() {
        String codigo = requisicao.getParameter(Consts.COL_CODIGO);
        Tarefa tarefa = new TarefaDAO().buscarUm(Integer.valueOf(codigo));
        requisicao.setAttribute("tarefa", tarefa);
        encaminharPagina(this.cadastroTarefa);
    }

    private void excluirTarefa() {
        String codigo = requisicao.getParameter(Consts.COL_CODIGO);
        if (new TarefaDAO().excluirTarefa(codigo)) {
            encaminharPagina(this.listarTarefas);
        } else {
            System.out.println("Erro ao excluir!");
        }
    }

    // ##### RESPOSTA
    private void cadastroResposta() {
        String codigo = requisicao.getParameter(Consts.COL_CODIGO);
        Tarefa tarefa = new TarefaDAO().buscarUm(Integer.valueOf(codigo));
        requisicao.setAttribute("resposta", tarefa);
        encaminharPagina(this.cadastroResposta);
    }

    private void gravarResposta() {
        Tarefa tarefa = (Tarefa) requisicao.getAttribute("resposta");
        if (new TarefaDAO().gravarResposta(tarefa)) {
            requisicao.setAttribute("resposta", null);
            encaminharPagina(this.listarMinhasTarefas);
        }
    }

    // ##### RESPOSTA
    private void cadastroCorrecao() {
        String codigo = requisicao.getParameter(Consts.COL_CODIGO);
        Tarefa tarefa = new TarefaDAO().buscarUm(Integer.valueOf(codigo));
        requisicao.setAttribute("correcao", tarefa);
        encaminharPagina(this.cadastroCorrecao);
    }

    private void gravarAvaliacao() {
        Tarefa tarefa = (Tarefa) requisicao.getAttribute("avaliacao");
        if (new TarefaDAO().gravarAvaliacao(tarefa)) {
            requisicao.setAttribute("avaliacao", null);
            encaminharPagina(this.listarTarefasCorrecao);
        }
    }

    // ##### PREMIOS
    private void novoPremio() {
        encaminharPagina(this.cadastroPremio);
    }

    public void gravarPremio() {
        Premio premio = (Premio) requisicao.getAttribute("premio");
        if (new PremioDAO().gravarPremio(premio)) {
            requisicao.setAttribute("premio", null);
            encaminharPagina(this.listarPremios);
        }
    }

    private void alterarPremio() {
        String codigo = requisicao.getParameter(Consts.COL_CODIGO);
        Premio premio = new PremioDAO().buscarUm(Integer.valueOf(codigo));
        requisicao.setAttribute("premio", premio);
        encaminharPagina(this.cadastroPremio);
    }

    private void excluirPremio() {
        String codigo = requisicao.getParameter(Consts.COL_CODIGO);
        if (new PremioDAO().excluirPremio(codigo)) {
            encaminharPagina(this.listarPremios);
        } else {
            System.out.println("Erro ao excluir!");
        }
    }

    // ##### NÍVEIS
    private void novoNivel() {
        encaminharPagina(this.cadastroNivel);
    }

    public void gravarNivel() {
        Nivel nivel = (Nivel) requisicao.getAttribute("nivel");
        if (new NivelDAO().gravarNivel(nivel)) {
            requisicao.setAttribute("nivel", null);
            encaminharPagina(this.listarNiveis);
        }
    }

    private void alterarNivel() {
        String codigo = requisicao.getParameter(Consts.COL_CODIGO);
        Nivel nivel = new NivelDAO().buscarUm(Integer.valueOf(codigo));
        requisicao.setAttribute("nivel", nivel);
        encaminharPagina(this.cadastroNivel);
    }

    private void excluirNivel() {
        String codigo = requisicao.getParameter(Consts.COL_CODIGO);
        if (new NivelDAO().excluirNivel(codigo)) {
            encaminharPagina(this.listarNiveis);
        } else {
            System.out.println("Erro ao excluir!");
        }
    }

    // ##### MÓDULOS
    private void novoModulo() {
        encaminharPagina(this.cadastroModulos);
    }

    public void gravarModulo() {
        Modulo modulo = (Modulo) requisicao.getAttribute("modulo");
        if (new ModuloDAO().gravarModulo(modulo)) {
            requisicao.setAttribute("modulo", null);
            encaminharPagina(this.listarModulos);
        }
    }

    private void alterarModulo() {
        String codigo = requisicao.getParameter(Consts.COL_CODIGO);
        Modulo modulo = new ModuloDAO().buscarUm(Integer.valueOf(codigo));
        requisicao.setAttribute("modulo", modulo);
        encaminharPagina(this.cadastroModulos);
    }

    private void excluirModulo() {
        String codigo = requisicao.getParameter(Consts.COL_CODIGO);
        if (new ModuloDAO().excluirModulo(codigo)) {
            encaminharPagina(this.listarModulos);
        } else {
            System.out.println("Erro ao excluir!");
        }
    }

    private void atualizarDashboard() {
        encaminharPagina(this.dashboardAluno);
    }

    // metodo generico que sempre sera chamado para encaminhar as paginas
    private void encaminharPagina(String pagina) {
        try {
            RequestDispatcher rd = requisicao.getRequestDispatcher(pagina);
            rd.forward(requisicao, resposta);
        } catch (Exception e) {
            System.out.println("Erro de encaminhamento = " + e);
        }
    }
}
