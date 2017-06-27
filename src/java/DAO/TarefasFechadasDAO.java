package DAO;

import Modelo.TarefasFechadas;
import Utils.Consts;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class TarefasFechadasDAO extends CustomDAO<TarefasFechadas> {

    String sql = "";

    private TarefasFechadas getObject(ResultSet resultado) {
        try {
            TarefasFechadas tar = new TarefasFechadas();
            tar.setCodNivel(resultado.getInt("codNivel"));
            tar.setTotalNivel(resultado.getInt("total"));
            tar.setAbertas(resultado.getInt("abertas"));
            tar.setFechadas(resultado.getInt("fechadas"));
            return tar;
        } catch (SQLException e) {
            System.out.println("Erro ao montar objeto = " + e);
            return null;
        }
    }

    public ArrayList<TarefasFechadas> listarTarefasFechadas() {

        sql = "select t.codNivel as codNivel,\n"
                + "count(*) as total, \n"
                + "(select count(1) from tarefas t2 where t2.concluida = false and t2.codNivel=t.codnivel) as abertas,\n"
                + "(select count(1) from tarefas t3 where t3.concluida = true and t3.codNivel=t.codnivel) as fechadas \n"
                + "from tarefas t\n"
                + "group by t.codNivel\n"
                + "order by t.codNivel";
        return this.listaDeTarefasFechadas(sql);
    }

    private ArrayList<TarefasFechadas> listaDeTarefasFechadas(String sql) {
        ArrayList<TarefasFechadas> listaDeTarefasFechadas = new ArrayList<>();

        try {
            ResultSet rs = executarSql(sql);

            if (rs.isBeforeFirst()) {
                while (rs.next()) {

                    TarefasFechadas tarefaFechada = this.getObject(rs);
                    listaDeTarefasFechadas.add(tarefaFechada);
                }
            }
            return listaDeTarefasFechadas;
        } catch (SQLException e) {
            System.out.println("Erro obter lista de niveis: " + e.toString());
            return null;
        }
    }

    @Override
    protected String Tabela() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    protected String ChavePrimaria() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
}
