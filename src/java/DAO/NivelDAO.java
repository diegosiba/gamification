package DAO;

import Modelo.Nivel;
import Utils.Consts;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class NivelDAO extends CustomDAO<Nivel> {

    @Override
    protected String Tabela() {
        return "niveis";
    }

    @Override
    protected String ChavePrimaria() {
        return "codigo";
    }

    String sql = "";

    public boolean gravarNivel(Nivel nivel) {

        try {
            if (nivel.isPrecisaInserir()) {
                this.inserirNivel(nivel);
            } else {
                this.atualizarNivel(nivel);
            }
        } catch (Exception e) {
            System.out.println("Erro ao inserir nivel = " + e);
            return false;
        }
        return true;
    }

    private boolean inserirNivel(Nivel nivel) {
        try {

            sql = "insert into " + this.Tabela() + " values"
                    + "(default,"
                    + "'" + nivel.getNome() + "',"
                    + "'" + nivel.getFaixaInicio() + "',"
                    + "'" + nivel.getFaixaFim() + "',"
                    + "now(),"
                    + "'" + nivel.isDeletado() + "')";

            int resultado = executarSQL(sql);

            // Retorna true se inseriu um registro.
            return resultado != 0;
        } catch (Exception e) {
            System.out.println("Erro ao inserir nivel = " + e);
            return false;
        }
    }

    private boolean atualizarNivel(Nivel nivel) {
        try {
            // O status de deletado não é alterado no update
            sql = "update " + this.Tabela() + " set "
                    + Consts.COL_NOME + " = '" + nivel.getNome() + "', "
                    + Consts.COL_FAIXA_INICIO + " = '" + nivel.getFaixaInicio() + "', "
                    + Consts.COL_FAIXA_FIM + " = '" + nivel.getFaixaFim() + "', "
                    + Consts.COL_DATA_CADASTRO + " ='now()'"
                    + "where " + Consts.COL_CODIGO + " = " + nivel.getCodigo();

            int resultado = executarSQL(sql);

            // Retorna true se atualizou o registro.
            return resultado != 0;
        } catch (Exception e) {
            System.out.println("Erro ao inserir nivel = " + e);
            return false;
        }
    }

    public boolean excluirNivel(String codigo) {
        try {
            return excluir(this.Tabela(), Consts.COL_CODIGO, codigo);
        } catch (Exception e) {
            System.out.println("Erro ao inserir nivel = " + e);
            return false;
        }
    }

    private Nivel getObject(ResultSet resultado) {
        try {
            Nivel nivel = new Nivel();
            nivel.setCodigo(resultado.getInt(ChavePrimaria()));
            nivel.setNome(resultado.getString(Consts.COL_NOME));
            nivel.setFaixaInicio(resultado.getInt(Consts.COL_FAIXA_INICIO));
            nivel.setFaixaFim(resultado.getInt(Consts.COL_FAIXA_FIM));
            nivel.setDataHoraCadastro(resultado.getString(Consts.COL_DATA_CADASTRO));
            nivel.setDeletado(resultado.getBoolean(Consts.COL_DELETADO));
            return nivel;
        } catch (SQLException e) {
            System.out.println("Erro ao montar objeto = " + e);
            return null;
        }
    }

    public Nivel buscarUm(int codigo) {
        try {
            ResultSet rs = this.consultar(this.Tabela(), this.ChavePrimaria(), String.valueOf(codigo));
            return this.getObject(rs);
        } catch (Exception e) {
            System.out.println("Erro ao montar objeto = " + e);
            return null;
        }
    }

    public Nivel buscarNivelAtual(int totalPontos) {
        try {
            sql = "select * from " + this.Tabela()
                    + " where " + totalPontos + " between faixainicio and faixafim limit 1";
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

    public ArrayList<Nivel> listarNiveis() {

        sql = "select * from " + this.Tabela()
                + " where " + Consts.COL_DELETADO + " = false order by " + this.ChavePrimaria();
        return this.listaDeNiveis(sql);
    }

    private ArrayList<Nivel> listaDeNiveis(String sql) {
        ArrayList<Nivel> listaDeNiveis = new ArrayList<>();

        try {
            ResultSet rs = executarSql(sql);

            if (rs.isBeforeFirst()) {
                while (rs.next()) {

                    Nivel nivel = this.getObject(rs);
                    listaDeNiveis.add(nivel);
                }
            }
            return listaDeNiveis;
        } catch (SQLException e) {
            System.out.println("Erro obter lista de niveis: " + e.toString());
            return null;
        }
    }
}
