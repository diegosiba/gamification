package Modelo;

import DAO.ModuloDAO;
import DAO.NivelDAO;
import DAO.PremioDAO;
import DAO.UsuarioDAO;
import Utils.Util;
import java.text.ParseException;
import java.text.SimpleDateFormat;

public class Tarefa extends Custom {

    // codigo -- na classe custom
    private String titulo;
    private String descricao;
    private String dicas;
    private int pontosVale;
    private int codNivel;
    private int codModulo;
    private int codPremio;
    private int codProfessorCadastro;
    // dataHoraCadastro -- na classe custom
    private int codAlunoConcluiu;
    private String resposta;
    private boolean concluida;
    private String dataConclusao;
    private int codProfessorAvaliador;
    private int pontosGanhou;
    private String comentario;
    private String dataAvaliacao;
    private boolean avaliado;
    // deletado -- na classe custom

    public Nivel getNivel() {
        Nivel nivel = new NivelDAO().buscarUm(this.getCodNivel());
        if (nivel == null) {
            nivel = new Nivel();
            nivel.setNome(" - ");
        }
        return nivel;
    }

    public Modulo getModulo() {
        Modulo modulo = new ModuloDAO().buscarUm(this.getCodModulo());
        if (modulo == null) {
            modulo = new Modulo();
            modulo.setNome(" - ");
        }
        return modulo;
    }

    public Premio getPremio() {
        Premio premio = new PremioDAO().buscarUm(this.getCodPremio());
        if (premio == null) {
            premio = new Premio();
            premio.setNome(" - ");
        }
        return premio;
    }

    public Usuario getProfessorCadastro() {
        Usuario usuario = new UsuarioDAO().buscarUm(this.getCodProfessorCadastro());
        if (usuario == null) {
            usuario = new Usuario();
            usuario.setNome(" - ");
        }
        return usuario;
    }

    public Usuario getUsuarioConcluiu() {
        Usuario usuario = new UsuarioDAO().buscarUm(this.getCodAlunoConcluiu());
        if (usuario == null) {
            usuario = new Usuario();
            usuario.setNome(" - ");
        }
        return usuario;
    }

    public Usuario getProfessorAvaliador() {
        Usuario usuario = new UsuarioDAO().buscarUm(this.getCodProfessorAvaliador());
        if (usuario == null) {
            usuario = new Usuario();
            usuario.setNome(" - ");
        }
        return usuario;
    }

    public String getTarefaCodigoNome() {
        return this.codigo + " - " + this.titulo;
    }

    public boolean temPremio() {
        return this.codPremio != 0;
    }

    /**
     * @return the titulo
     */
    public String getTitulo() {
        return titulo;
    }

    /**
     * @param titulo the titulo to set
     */
    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    /**
     * @return the descricao
     */
    public String getDescricao() {
        return descricao;
    }

    /**
     * @param descricao the descricao to set
     */
    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }

    /**
     * @return the dicas
     */
    public String getDicas() {
        return dicas;
    }

    /**
     * @param dicas the dicas to set
     */
    public void setDicas(String dicas) {
        this.dicas = dicas;
    }

    /**
     * @return the pontosVale
     */
    public int getPontosVale() {
        return pontosVale;
    }

    /**
     * @param pontosVale the pontosVale to set
     */
    public void setPontosVale(int pontosVale) {
        this.pontosVale = pontosVale;
    }

    /**
     * @return the codNivel
     */
    public int getCodNivel() {
        return codNivel;
    }

    /**
     * @param codNivel the codNivel to set
     */
    public void setCodNivel(int codNivel) {
        this.codNivel = codNivel;
    }

    /**
     * @return the codPremio
     */
    public int getCodPremio() {
        return codPremio;
    }

    /**
     * @param codPremio the codPremio to set
     */
    public void setCodPremio(int codPremio) {
        this.codPremio = codPremio;
    }

    /**
     * @return the codProfessorCadastro
     */
    public int getCodProfessorCadastro() {
        return codProfessorCadastro;
    }

    /**
     * @param codProfessorCadastro the codProfessorCadastro to set
     */
    public void setCodProfessorCadastro(int codProfessorCadastro) {
        this.codProfessorCadastro = codProfessorCadastro;
    }

    /**
     * @return the codAlunoConcluiu
     */
    public int getCodAlunoConcluiu() {
        return codAlunoConcluiu;
    }

    /**
     * @param codAlunoConcluiu the codAlunoConcluiu to set
     */
    public void setCodAlunoConcluiu(int codAlunoConcluiu) {
        this.codAlunoConcluiu = codAlunoConcluiu;
    }

    /**
     * @return the resposta
     */
    public String getResposta() {
        return Util.isEmpty(this.resposta) ? "" : this.resposta;
    }

    /**
     * @param resposta the resposta to set
     */
    public void setResposta(String resposta) {
        this.resposta = resposta;
    }

    /**
     * @return the concluida
     */
    public boolean isConcluida() {
        return concluida;
    }

    /**
     * @param concluida the concluida to set
     */
    public void setConcluida(boolean concluida) {
        this.concluida = concluida;
    }

    /**
     * @return the dataConclusao
     */
    public String getDataConclusao() {
        try {
            String str_date = this.dataConclusao;
            if (!Util.isEmpty(str_date)) {
                str_date = str_date.substring(0, 19);
                SimpleDateFormat myFormat = new SimpleDateFormat("dd/MM/yyyy");
                SimpleDateFormat fromUser = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                return myFormat.format(fromUser.parse(str_date));
            }
        } catch (ParseException e) {
        }
        // Retorna um valor default
        return "";
    }

    /**
     * @param dataConclusao the dataConclusao to set
     */
    public void setDataConclusao(String dataConclusao) {
        this.dataConclusao = dataConclusao;
    }

    /**
     * @return the codProfessorAvaliador
     */
    public int getCodProfessorAvaliador() {
        return codProfessorAvaliador;
    }

    /**
     * @param codProfessorAvaliador the codProfessorAvaliador to set
     */
    public void setCodProfessorAvaliador(int codProfessorAvaliador) {
        this.codProfessorAvaliador = codProfessorAvaliador;
    }

    /**
     * @return the pontosGanhou
     */
    public int getPontosGanhou() {
        return pontosGanhou;
    }

    /**
     * @param pontosGanhou the pontosGanhou to set
     */
    public void setPontosGanhou(int pontosGanhou) {
        this.pontosGanhou = pontosGanhou;
    }

    /**
     * @return the comentario
     */
    public String getComentario() {
        return comentario;
    }

    /**
     * @param comentario the comentario to set
     */
    public void setComentario(String comentario) {
        this.comentario = comentario;
    }

    /**
     * @return the dataAvaliacao
     */
    public String getDataAvaliacao() {
        try {
            String str_date = this.dataAvaliacao;
            if (!Util.isEmpty(str_date)) {
                str_date = str_date.substring(0, 19);
                SimpleDateFormat myFormat = new SimpleDateFormat("dd/MM/yyyy");
                SimpleDateFormat fromUser = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                return myFormat.format(fromUser.parse(str_date));
            }
        } catch (ParseException e) {
        }
        // Retorna um valor default
        return "";
    }

    /**
     * @param dataAvaliacao the dataAvaliacao to set
     */
    public void setDataAvaliacao(String dataAvaliacao) {
        this.dataAvaliacao = dataAvaliacao;
    }

    /**
     * @return the avaliado
     */
    public boolean isAvaliado() {
        return avaliado;
    }

    /**
     * @param avaliado the avaliado to set
     */
    public void setAvaliado(boolean avaliado) {
        this.avaliado = avaliado;
    }

    /**
     * @return the codModulo
     */
    public int getCodModulo() {
        return codModulo;
    }

    /**
     * @param codModulo the codModulo to set
     */
    public void setCodModulo(int codModulo) {
        this.codModulo = codModulo;
    }
}
