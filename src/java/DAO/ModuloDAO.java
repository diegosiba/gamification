package DAO;

import Modelo.Modulo;
import Utils.Consts;
import Utils.Util;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class ModuloDAO extends CustomDAO<Modulo> {

    @Override
    protected String Tabela() {
        return "modulos";
    }

    @Override
    protected String ChavePrimaria() {
        return "codigo";
    }

    String sql = "";

    public boolean gravarModulo(Modulo modulo) {

        try {
            if (modulo.isPrecisaInserir()) {
                this.inserirModulo(modulo);
            } else {
                this.atualizarModulo(modulo);
            }
        } catch (Exception e) {
            System.out.println("Erro ao inserir modulo = " + e);
            return false;
        }
        return true;
    }

    private boolean inserirModulo(Modulo modulo) {
        try {

            sql = "insert into " + this.Tabela() + " values"
                    + "(default,"
                    + "'" + modulo.getNome() + "',"
                    + "'" + modulo.getInicioModulo() + "',"
                    + "'" + modulo.getFimModulo() + "',"
                    + "'" + modulo.getMinimoPontos() + "',"
                    + "'" + modulo.getMinimoTarefas() + "',"
                    + "now(),"
                    + "'" + modulo.isDeletado() + "')";

            int resultado = executarSQL(sql);

            // Retorna true se inseriu um registro.
            return resultado != 0;
        } catch (Exception e) {
            System.out.println("Erro ao inserir Modulo = " + e);
            return false;
        }
    }

    private boolean atualizarModulo(Modulo modulo) {
        try {
            // O status de deletado não é alterado no update
            sql = "update " + this.Tabela() + " set "
                    + Consts.COL_NOME + " = '" + modulo.getNome() + "', "
                    + Consts.COL_INICIO_MODULO + " = '" + modulo.getInicioModulo() + "', "
                    + Consts.COL_FIM_MODULO + " = '" + modulo.getFimModulo() + "', "
                    + Consts.COL_MINIMO_PONTOS + " = '" + modulo.getMinimoPontos() + "', "
                    + Consts.COL_MINIMO_TAREFAS + " = '" + modulo.getMinimoTarefas() + "', "
                    + Consts.COL_DATA_CADASTRO + " ='now()'"
                    + "where " + Consts.COL_CODIGO + " = " + modulo.getCodigo();

            int resultado = executarSQL(sql);

            // Retorna true se atualizou o registro.
            return resultado != 0;
        } catch (Exception e) {
            System.out.println("Erro ao inserir Modulo = " + e);
            return false;
        }
    }

    public boolean excluirModulo(String codigo) {
        try {
            return excluir(this.Tabela(), Consts.COL_CODIGO, codigo);
        } catch (Exception e) {
            System.out.println("Erro ao inserir Modulo = " + e);
            return false;
        }
    }

    private Modulo getObject(ResultSet resultado) {
        try {
            Modulo modulo = new Modulo();
            modulo.setCodigo(resultado.getInt(ChavePrimaria()));
            modulo.setNome(resultado.getString(Consts.COL_NOME));
            modulo.setInicioModulo(resultado.getString(Consts.COL_INICIO_MODULO));
            modulo.setFimModulo(resultado.getString(Consts.COL_FIM_MODULO));
            modulo.setMinimoPontos(resultado.getInt(Consts.COL_MINIMO_PONTOS));
            modulo.setMinimoTarefas(resultado.getInt(Consts.COL_MINIMO_TAREFAS));
            modulo.setDataHoraCadastro(resultado.getString(Consts.COL_DATA_CADASTRO));
            modulo.setDeletado(resultado.getBoolean(Consts.COL_DELETADO));
            return modulo;
        } catch (SQLException e) {
            System.out.println("Erro ao montar objeto = " + e);
            return null;
        }
    }

    public Modulo buscarUm(int codigo) {
        try {
            ResultSet rs = this.consultar(this.Tabela(), this.ChavePrimaria(), String.valueOf(codigo));
            return this.getObject(rs);
        } catch (Exception e) {
            System.out.println("Erro ao montar objeto = " + e);
            return null;
        }
    }

    public Modulo buscarModuloAtual() {
        try {
            sql = "select * from " + this.Tabela()
                    + " where '" + Util.Hoje() + "' between iniciomodulo and fimmodulo "
                    + " and " + Consts.COL_DELETADO + " = false "
                    + " limit 1";
            ResultSet rs = executarSql(sql);
            if (rs.next()) {
                return this.getObject(rs);
            }
            return null;

        } catch (Exception e) {
            System.out.println("Erro ao montar objeto = " + e);
            return null;
        }
    }

    public ArrayList<Modulo> listarModulos() {

        sql = "select * from " + this.Tabela()
                + " where " + Consts.COL_DELETADO + " = false order by " + this.ChavePrimaria();
        return this.listaDeModulos(sql);
    }

    public ArrayList<Modulo> listarModulosNaoFechados() {

        sql = "select * from " + this.Tabela()
                + " where " + Consts.COL_DELETADO + " = false "
                + " and '" + Util.Hoje() + "' < fimmodulo "
                + " order by " + this.ChavePrimaria();
        return this.listaDeModulos(sql);
    }

    private ArrayList<Modulo> listaDeModulos(String sql) {
        ArrayList<Modulo> listaDeModulos = new ArrayList<>();

        try {
            ResultSet rs = executarSql(sql);

            if (rs.isBeforeFirst()) {
                while (rs.next()) {

                    Modulo modulo = this.getObject(rs);
                    listaDeModulos.add(modulo);
                }
            }
            return listaDeModulos;
        } catch (SQLException e) {
            System.out.println("Erro obter lista de Modulos: " + e.toString());
            return null;
        }
    }
}
