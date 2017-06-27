package DAO;

import Modelo.Usuario;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public abstract class CustomDAO<T> {

    protected abstract String Tabela();

    protected abstract String ChavePrimaria();

    /**
     * Método que recebe uma string SQL e executa na base de dados.
     *
     * @param sql
     * @return boolean - true se o comando foi executado com sucesso.
     */
    public static boolean executarSQLBoolean(String sql) {
        try {
            Statement st = ConexaoBD.getStatement();

            int resultado = st.executeUpdate(sql);
            return (resultado == 1);
        } catch (SQLException e) {
            System.out.println("erro = " + e);
            return false;
        }
    }

    /**
     * Método que recebe uma string SQL e executa na base de dados.
     *
     * @param sql
     * @return int - id do registro inserido
     */
    public static int executarSQL(String sql) {
        try {
            Statement st = ConexaoBD.getStatement();
            st.execute(sql, Statement.RETURN_GENERATED_KEYS);
            ResultSet keyset = st.getGeneratedKeys();
            if (keyset.next()) {
                // Retorna o código do registro gerado.
                int key = keyset.getInt(1);
                return key;
            }
        } catch (SQLException e) {
            System.out.println("erro = " + e);
        }
        return -1;
    }

    /**
     * Executa um sql no banco de dados e retorna um result set. É preciso pular
     * o result set para o primeiro registro.
     *
     * @param sql
     * @return
     */
    public static ResultSet executarSql(String sql) {
        try {
            Statement st = ConexaoBD.getStatement();
            return st.executeQuery(sql);
        } catch (SQLException e) {
            System.out.println("erro = " + e);
            return null;
        }
    }

    /**
     * Retorna um objeto de determinada tabela, procurando em tal campo pelo
     * registro de valor tal.
     *
     * @param tabela
     * @param campo
     * @param valor
     * @return
     */
    public ResultSet consultar(String tabela, String campo, String valor) {

        try {
            Statement st = ConexaoBD.getStatement();
            String sql = String.format("SELECT * FROM %s WHERE %s = %s", tabela, campo, valor);

            ResultSet resultSet = st.executeQuery(sql);
            if (resultSet.next()) {
                return resultSet;
            }
            return null;
        } catch (SQLException e) {
            System.out.println("erro = " + e);
            return null;
        }
    }

    /**
     * Marca um registro da tabela passada por parâmetro como deletado
     *
     * @param tabela tabela onde será excluído o registro
     * @param campo campo no qual o delete vai se basear
     * @param codigo valor do registro a ser deletado
     * @return
     */
    public boolean excluir(String tabela, String campo, String codigo) {
        try {
            String st = String.format("UPDATE %s SET DELETADO = TRUE WHERE %s = %s", tabela, campo, codigo);
            return executarSQLBoolean(st);
        } catch (Exception e) {
            System.out.println("erro = " + e);
            return false;
        }
    }

    /**
     * Retorna todos os registros de uma tabela.
     *
     * @return
     */
    public ResultSet listarTodos() {
        return listarTodos("1=1", ChavePrimaria());
    }

    /**
     * Retorna os registros de uma tabela, filtrando por uma condição.
     *
     * Faz validação para garantir que os parâmetros não estejam vazios.
     *
     * @param where
     * @return
     */
    public ResultSet listarTodos(String where) {
        if ("".equals(where.trim())) {
            where = " 1=1 ";
        }
        return listarTodos(where, ChavePrimaria());
    }

    /**
     * Retorna os registros que o usuário tem permissão de ver.
     *
     * @param where
     * @param order
     * @param usuario
     * @return
     */
    public ResultSet listarTodosDoUsuario(String where, String order, Usuario usuario) {
        return listarTodos(where, order, usuario);
    }

    public ResultSet listarTodos(String where, String order) {
        return listarTodos(where, order, null);
    }

    public ResultSet listarTodos(String where, Usuario usuario) {
        return listarTodos(where, "", usuario);
    }

    private ResultSet listarTodos(String where, String order, Usuario usuario) {
        try {
            if ("".equals(where.trim())) {
                where = " 1=1 ";
            }
            if (usuario != null) {
                where += " AND idUsuario = " + usuario.getCodigo();
            }
            if ("".equals(order.trim())) {
                order = ChavePrimaria();
            }
            Statement st = ConexaoBD.getStatement();
            String temp = String.format("SELECT * FROM %s WHERE %s ORDER BY %s",
                    Tabela(), where, order);
            return st.executeQuery(temp);

        } catch (SQLException e) {
            System.out.println("erro = " + e);
            return null;
        }
    }
}
