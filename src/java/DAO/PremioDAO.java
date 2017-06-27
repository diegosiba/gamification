package DAO;

import Modelo.Premio;
import Utils.Consts;
//import com.sun.mail.handlers.image_gif;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class PremioDAO extends CustomDAO<Premio> {

    @Override
    protected String Tabela() {
        return "premios";
    }

    @Override
    protected String ChavePrimaria() {
        return "codigo";
    }

    String sql = "";

    public boolean gravarPremio(Premio premio) {

        try {
            if (premio.isPrecisaInserir()) {
                this.inserirPremio(premio);
            } else {
                this.atualizarPremio(premio);
            }
        } catch (Exception e) {
            System.out.println("Erro ao inserir premio = " + e);
            return false;
        }
        return true;
    }

    private boolean inserirPremio(Premio premio) {
        try {

            sql = "insert into " + this.Tabela() + " values"
                    + "(default,"
                    + "'" + premio.getNome() + "',"
                    + "'" + premio.getIcone() + "',"
                    + "now(),"
                    + "'" + premio.isDeletado() + "')";

            int resultado = executarSQL(sql);

            // Retorna true se inseriu um registro.
            return resultado != 0;
        } catch (Exception e) {
            System.out.println("Erro ao inserir premio = " + e);
            return false;
        }
    }

    private boolean atualizarPremio(Premio premio) {
        try {
            // O status de deletado não é alterado no update
            sql = "update " + this.Tabela() + " set "
                    + Consts.COL_NOME + " = '" + premio.getNome() + "', "
                    + Consts.COL_ICONE + " = '" + premio.getIcone() + "', "
                    + Consts.COL_DATA_CADASTRO + " ='now()'"
                    + "where " + Consts.COL_CODIGO + " = " + premio.getCodigo();

            int resultado = executarSQL(sql);

            // Retorna true se atualizou o registro.
            return resultado != 0;
        } catch (Exception e) {
            System.out.println("Erro ao inserir premio = " + e);
            return false;
        }
    }

    public boolean excluirPremio(String codigo) {
        try {
            return excluir(this.Tabela(), Consts.COL_CODIGO, codigo);
        } catch (Exception e) {
            System.out.println("Erro ao inserir premio = " + e);
            return false;
        }
    }

    private Premio getObject(ResultSet resultado) {
        try {
            Premio premio = new Premio();
            premio.setCodigo(resultado.getInt(ChavePrimaria()));
            premio.setNome(resultado.getString(Consts.COL_NOME));
            premio.setIcone(resultado.getString(Consts.COL_ICONE));
            premio.setDataHoraCadastro(resultado.getString(Consts.COL_DATA_CADASTRO));
            premio.setDeletado(resultado.getBoolean(Consts.COL_DELETADO));
            return premio;
        } catch (SQLException e) {
            System.out.println("Erro ao montar objeto = " + e);
            return null;
        }
    }

    public Premio buscarUm(int codigo) {
        try {
            ResultSet rs = this.consultar(this.Tabela(), this.ChavePrimaria(), String.valueOf(codigo));
            return this.getObject(rs);
        } catch (Exception e) {
            System.out.println("Erro ao montar objeto = " + e);
            return null;
        }
    }

    public ArrayList<Premio> listarPremios() {

        sql = "select * from " + this.Tabela()
                + " where " + Consts.COL_DELETADO + " = false order by " + this.ChavePrimaria();
        return this.listaDePremios(sql);
    }

    private ArrayList<Premio> listaDePremios(String sql) {
        ArrayList<Premio> listaDePremios = new ArrayList<>();

        try {
            ResultSet rs = executarSql(sql);

            if (rs.isBeforeFirst()) {
                while (rs.next()) {

                    Premio premio = this.getObject(rs);
                    listaDePremios.add(premio);
                }
            }
            return listaDePremios;
        } catch (SQLException e) {
            System.out.println("Erro obter lista de premios: " + e.toString());
            return null;
        }
    }

    public ArrayList<String> listarImagens() {
        ArrayList<String> imagens = new ArrayList<>();
        imagens.add("participacao");
        imagens.add("estrela");
        imagens.add("merito");
        imagens.add("bronze");
        imagens.add("prata");
        imagens.add("ouro");
        imagens.add("diamante");
        imagens.add("coroa");
        return imagens;
    }
}
