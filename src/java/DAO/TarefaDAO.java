package DAO;

import static DAO.CustomDAO.executarSQL;
import Modelo.Modulo;
import Modelo.Tarefa;
import Utils.Consts;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class TarefaDAO extends CustomDAO<Tarefa> {

    @Override
    protected String Tabela() {
        return "tarefas";
    }

    @Override
    protected String ChavePrimaria() {
        return "codigo";
    }

    String sql = "";

    public boolean gravarTarefa(Tarefa tarefa) {

        try {
            if (tarefa.isPrecisaInserir()) {
                this.inserirTarefa(tarefa);
            } else {
                this.atualizarTarefa(tarefa);
            }
        } catch (Exception e) {
            System.out.println("Erro ao inserir tarefa = " + e);
            return false;
        }
        return true;
    }

    private boolean inserirTarefa(Tarefa tarefa) {
        try {

            sql = "insert into " + this.Tabela() + "(codigo, titulo, descricao, "
                    + "dicas, pontosvale, codnivel, codmodulo, codpremio, codprofessorcadastro,"
                    + " dataCadastro, deletado) values "
                    + "(default,"
                    + "'" + tarefa.getTitulo() + "',"
                    + "'" + tarefa.getDescricao() + "',"
                    + "'" + tarefa.getDicas() + "',"
                    + "'" + tarefa.getPontosVale() + "',"
                    + "'" + tarefa.getCodNivel() + "',"
                    + "'" + tarefa.getCodModulo() + "',"
                    + "'" + tarefa.getCodPremio() + "',"
                    + "'" + tarefa.getCodProfessorCadastro() + "',"
                    + "now(), "
                    + "false)";

            int resultado = executarSQL(sql);

            // Retorna true se inseriu um registro.
            return resultado != 0;
        } catch (Exception e) {
            System.out.println("Erro ao inserir tarefa = " + e);
            return false;
        }
    }

    private boolean atualizarTarefa(Tarefa tarefa) {
        try {
            // O status de deletado não é alterado no update
            sql = "update " + this.Tabela() + " set "
                    + Consts.COL_TITULO + " = '" + tarefa.getTitulo() + "', "
                    + Consts.COL_DESCRICAO + " = '" + tarefa.getDescricao() + "', "
                    + Consts.COL_DICAS + " = '" + tarefa.getDicas() + "', "
                    + Consts.COL_PONTOS_VALE + " = '" + tarefa.getPontosVale() + "', "
                    + Consts.COL_COD_NIVEL + " = '" + tarefa.getCodNivel() + "', "
                    + Consts.COL_COD_MODULO + " = '" + tarefa.getCodModulo() + "', "
                    + Consts.COL_COD_PREMIO + " = '" + tarefa.getCodPremio() + "', "
                    + Consts.COL_COD_PROFESSOR_CADASTRO + " = '" + tarefa.getCodProfessorCadastro() + "'"
                    + " where " + Consts.COL_CODIGO + " = " + tarefa.getCodigo();

            int resultado = executarSQL(sql);

            // Retorna true se atualizou o registro.
            return resultado != 0;
        } catch (Exception e) {
            System.out.println("Erro ao inserir tarefa = " + e);
            return false;
        }
    }

    public boolean excluirTarefa(String codigo) {
        try {
            return excluir(this.Tabela(), Consts.COL_CODIGO, codigo);
        } catch (Exception e) {
            System.out.println("Erro ao inserir tarefa = " + e);
            return false;
        }
    }

    public boolean gravarResposta(Tarefa tarefa) {
        try {
            sql = "update " + this.Tabela() + " set "
                    + Consts.COL_RESPOSTA + " = '" + tarefa.getResposta() + "', "
                    + Consts.COL_CONCLUIDA + " = '" + tarefa.isConcluida() + "', "
                    + Consts.COL_COD_ALUNO_CONCLUIU + " = '" + tarefa.getCodAlunoConcluiu() + "', "
                    + Consts.COL_DATA_CONCLUSAO + " ='now()' "
                    + "where " + Consts.COL_CODIGO + " = " + tarefa.getCodigo();

            int resultado = executarSQL(sql);

            // Retorna true se atualizou o registro.
            return resultado != 0;
        } catch (Exception e) {
            System.out.println("Erro ao inserir tarefa = " + e);
            return false;
        }
    }

    public boolean gravarAvaliacao(Tarefa tarefa) {
        try {

            sql = "update " + this.Tabela() + " set "
                    + Consts.COL_COD_PROFESSOR_AVALIADOR + " = '" + tarefa.getCodProfessorAvaliador() + "', "
                    + Consts.COL_PONTOS_GANHOU + " = '" + tarefa.getPontosGanhou() + "', "
                    + Consts.COL_COMENTARIO + " = '" + tarefa.getComentario() + "', "
                    + Consts.COL_DATA_AVALIACAO + " ='now()', "
                    + Consts.COL_AVALIADO + " = 'true' "
                    + "where " + Consts.COL_CODIGO + " = " + tarefa.getCodigo();

            int resultado = executarSQL(sql);

            // Incrementa pontuação do usuário
            incrementarPontosAluno(tarefa.getPontosGanhou(), tarefa.getCodAlunoConcluiu());

            // Retorna true se inseriu um registro.
            return resultado != 0;
        } catch (Exception e) {
            System.out.println("Erro ao inserir avaliacao = " + e);
            return false;
        }
    }

    private boolean incrementarPontosAluno(int pontos, int codAluno) {

        sql = "update usuarios set totalpontos = "
                + "(select totalpontos from usuarios "
                + "where codigo = " + codAluno + ") + "
                + pontos + " where codigo = " + codAluno;
        return executarSQL(sql) != 0;
    }

    private Tarefa getObject(ResultSet resultado) {
        try {
            Tarefa tarefa = new Tarefa();
            tarefa.setCodigo(resultado.getInt(ChavePrimaria()));
            tarefa.setTitulo(resultado.getString(Consts.COL_TITULO));
            tarefa.setDescricao(resultado.getString(Consts.COL_DESCRICAO));
            tarefa.setDicas(resultado.getString(Consts.COL_DICAS));
            tarefa.setPontosVale(resultado.getInt(Consts.COL_PONTOS_VALE));
            tarefa.setCodNivel(resultado.getInt(Consts.COL_COD_NIVEL));
            tarefa.setCodModulo(resultado.getInt(Consts.COL_COD_MODULO));
            tarefa.setCodPremio(resultado.getInt(Consts.COL_COD_PREMIO));
            tarefa.setCodProfessorCadastro(resultado.getInt(Consts.COL_COD_PROFESSOR_CADASTRO));
            tarefa.setDataHoraCadastro(resultado.getString(Consts.COL_DATA_CADASTRO));
            tarefa.setCodAlunoConcluiu(resultado.getInt(Consts.COL_COD_ALUNO_CONCLUIU));
            tarefa.setResposta(resultado.getString(Consts.COL_RESPOSTA));
            tarefa.setConcluida(resultado.getBoolean(Consts.COL_CONCLUIDA));
            tarefa.setDataConclusao(resultado.getString(Consts.COL_DATA_CONCLUSAO));
            tarefa.setCodProfessorAvaliador(resultado.getInt(Consts.COL_COD_PROFESSOR_AVALIADOR));
            tarefa.setPontosGanhou(resultado.getInt(Consts.COL_PONTOS_GANHOU));
            tarefa.setComentario(resultado.getString(Consts.COL_COMENTARIO));
            tarefa.setDataAvaliacao(resultado.getString(Consts.COL_DATA_AVALIACAO));
            tarefa.setAvaliado(resultado.getBoolean(Consts.COL_AVALIADO));
            tarefa.setDeletado(resultado.getBoolean(Consts.COL_DELETADO));
            return tarefa;
        } catch (SQLException e) {
            System.out.println("Erro ao montar objeto = " + e);
            return null;
        }
    }

    public Tarefa buscarUm(int codigo) {
        try {
            ResultSet rs = this.consultar(this.Tabela(), this.ChavePrimaria(), String.valueOf(codigo));
            return this.getObject(rs);
        } catch (Exception e) {
            System.out.println("Erro ao montar objeto = " + e);
            return null;
        }
    }

    /**
     * LISTA DE TAREFAS CONCLUÍDAS QUE APARECE PARA O PROFESSOR CORRIGIR
     *
     * @return
     */
    public ArrayList<Tarefa> listarTarefasParaAvaliar() {

        sql = "select * from " + this.Tabela()
                + " where " + Consts.COL_DELETADO + " = false "
                + " AND " + Consts.COL_CONCLUIDA + " = true order by " + this.ChavePrimaria();
        return this.listaDeTarefas(sql);
    }

    /**
     * LISTA DE TAREFAS QUE APARECE PARA O USUÁRIO RESOLVER
     *
     * @return
     */
    public ArrayList<Tarefa> listarMinhasTarefasParaResolver() {
        Modulo modulo = new ModuloDAO().buscarModuloAtual();

        if (modulo == null) {
            return new ArrayList<>();
        }
        sql = "select * from " + this.Tabela()
                + " where " + Consts.COL_DELETADO + " = false "
                + " AND " + Consts.COL_COD_MODULO + " = " + modulo.getCodigo() + " order by " + this.ChavePrimaria();
        return this.listaDeTarefas(sql);
    }

    public ArrayList<Tarefa> listarMinhasTarefasPremios(int codUsuario) {

        sql = "select * from " + this.Tabela()
                + " where " + Consts.COL_DELETADO + " = false "
                + " AND " + Consts.COL_COD_ALUNO_CONCLUIU + " = " + codUsuario
                + " AND " + Consts.COL_AVALIADO + " = true "
                + " order by " + this.ChavePrimaria();
        return this.listaDeTarefas(sql);
    }

    public ArrayList<Tarefa> listarTarefas() {

        sql = "select * from " + this.Tabela()
                + " where " + Consts.COL_DELETADO + " = false order by " + this.ChavePrimaria();
        return this.listaDeTarefas(sql);
    }

    private ArrayList<Tarefa> listaDeTarefas(String sql) {
        ArrayList<Tarefa> listaDeTarefas = new ArrayList<>();

        try {
            ResultSet rs = executarSql(sql);

            if (rs.isBeforeFirst()) {
                while (rs.next()) {

                    Tarefa tarefa = this.getObject(rs);
                    listaDeTarefas.add(tarefa);
                }
            }
            return listaDeTarefas;
        } catch (SQLException e) {
            System.out.println("Erro obter lista de tarefas: " + e.toString());
            return null;
        }
    }
}
