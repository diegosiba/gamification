package DAO;

import Modelo.Usuario;
import Utils.Consts;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class UsuarioDAO extends CustomDAO<Usuario> {

    @Override
    protected String Tabela() {
        return "usuarios";
    }

    @Override
    protected String ChavePrimaria() {
        return "codigo";
    }

    String sql = "";

    public Usuario autenticar(Usuario usuario) {

        try {
            sql = "select * from " + this.Tabela()
                    + " where " + Consts.COL_EMAIL + " = '" + usuario.getEmail() + "'"
                    + " and " + Consts.COL_DELETADO + " = FALSE ";

            ResultSet rs = ConexaoBD.getInstance().getConnection().createStatement().executeQuery(sql);

            // Se o retorno não for nulo e tiver um registro
            if (rs != null) {
                if (rs.next()) {
                    // Compara a senha informada com a senha do registro. Evita SQL inject.
                    if (rs.getString("senha").equals(usuario.getSenha())) {
                        return this.getObject(rs);
                    }
                }
            }
        } catch (SQLException e) {
            System.out.println("Erro na autenticação: " + e.toString());
        }
        return null;
    }

    public boolean gravarUsuario(Usuario usuario) {

        try {
            if (usuario.isPrecisaInserir()) {
                this.inserirUsuario(usuario);
            } else {
                this.atualizarUsuario(usuario);
            }
        } catch (Exception e) {
            System.out.println("Erro ao inserir usuario = " + e);
            return false;
        }
        return true;
    }

    private boolean inserirUsuario(Usuario usuario) {
        try {

            sql = "insert into " + this.Tabela() + " values"
                    + "(default,"
                    + "'" + usuario.getNome() + "',"
                    + "'" + usuario.getEmail() + "',"
                    + "'" + usuario.getSenha() + "',"
                    + "'" + usuario.isProfessor() + "',"
                    + "'0',"
                    + "now(),"
                    + "'" + usuario.isDeletado() + "')";

            int resultado = executarSQL(sql);

            // Retorna true se inseriu um registro.
            return resultado != 0;
        } catch (Exception e) {
            System.out.println("Erro ao inserir usuario = " + e);
            return false;
        }
    }

    private boolean atualizarUsuario(Usuario usuario) {
        try {
            // O status de deletado não é alterado no update
            sql = "update " + this.Tabela() + " set "
                    + Consts.COL_NOME + " = '" + usuario.getNome() + "', "
                    + Consts.COL_EMAIL + " = '" + usuario.getEmail() + "', ";
            // Se a senha do usuário foi alterada
            if (!usuario.getSenha().trim().equals("")) {
                sql += Consts.COL_SENHA + " = '" + usuario.getSenha() + "', ";
            }
            sql += Consts.COL_PROFESSOR + " ='" + usuario.isProfessor() + "', "
                    + Consts.COL_DATA_CADASTRO + " ='now()'"
                    + "where " + Consts.COL_CODIGO + " = " + usuario.getCodigo();

            int resultado = executarSQL(sql);

            // Retorna true se atualizou o registro.
            return resultado != 0;
        } catch (Exception e) {
            System.out.println("Erro ao inserir usuario = " + e);
            return false;
        }
    }

    public boolean excluirUsuario(String codigo) {
        try {
            return excluir(this.Tabela(), Consts.COL_CODIGO, codigo);
        } catch (Exception e) {
            System.out.println("Erro ao inserir usuario = " + e);
            return false;
        }
    }

    private Usuario getObject(ResultSet resultado) {
        try {
            Usuario usuario = new Usuario();
            usuario.setCodigo(resultado.getInt(ChavePrimaria()));
            usuario.setNome(resultado.getString(Consts.COL_NOME));
            usuario.setEmail(resultado.getString(Consts.COL_EMAIL));
            usuario.setSenha(resultado.getString(Consts.COL_SENHA));
            usuario.setProfessor(resultado.getBoolean(Consts.COL_PROFESSOR));
            usuario.setTotalPontos(resultado.getInt(Consts.COL_TOTAL_PONTOS));
            usuario.setDataHoraCadastro(resultado.getString(Consts.COL_DATA_CADASTRO));
            usuario.setDeletado(resultado.getBoolean(Consts.COL_DELETADO));
            return usuario;
        } catch (SQLException e) {
            System.out.println("Erro ao montar objeto = " + e);
            return null;
        }
    }

    public Usuario buscarUm(int codigo) {
        try {
            ResultSet rs = this.consultar(this.Tabela(), this.ChavePrimaria(), String.valueOf(codigo));
            return this.getObject(rs);
        } catch (Exception e) {
            System.out.println("Erro ao montar objeto = " + e);
            return null;
        }
    }

    public ArrayList<Usuario> listarProfessores() {

        sql = "select * from " + this.Tabela()
                + " where " + Consts.COL_DELETADO + " = false "
                + " and " + Consts.COL_PROFESSOR + " = true order by " + this.ChavePrimaria();
        return this.listaDeUsuarios(sql);
    }

    public ArrayList<Usuario> listarUsuarios() {

        sql = "select * from " + this.Tabela()
                + " where " + Consts.COL_DELETADO + " = false order by " + this.ChavePrimaria();
        return this.listaDeUsuarios(sql);
    }

    public ArrayList<Usuario> listarMelhoresAlunos() {

        sql = "select * from " + this.Tabela()
                + " where " + Consts.COL_DELETADO + " = false "
                + " and " + Consts.COL_PROFESSOR + " = false "
                + " order by " + Consts.COL_TOTAL_PONTOS + " desc ";
        return this.listaDeUsuarios(sql);
    }
    
    private ArrayList<Usuario> listaDeUsuarios(String sql) {
        ArrayList<Usuario> listaDeUsuarios = new ArrayList<>();

        try {
            ResultSet rs = executarSql(sql);

            if (rs.isBeforeFirst()) {
                while (rs.next()) {

                    Usuario usuario = this.getObject(rs);
                    listaDeUsuarios.add(usuario);
                }
            }
            return listaDeUsuarios;
        } catch (SQLException e) {
            System.out.println("Erro obter lista de usuários: " + e.toString());
            return null;
        }
    }
}
