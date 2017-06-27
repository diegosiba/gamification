package Modelo;

import DAO.NivelDAO;

public class Usuario extends Custom {

    private String nome;
    private String email;
    private String senha;
    private boolean professor;
    private int totalPontos;

    /**
     * @return the nome
     */
    public Nivel getNivelAtual() {
        Nivel nivel = new NivelDAO().buscarNivelAtual(this.getTotalPontos());
        if (nivel == null) {
            nivel = new Nivel();
            nivel.setNome(" SEM NÍVEL ");
        }
        return nivel;
    }

    public String getNome() {
        return nome;
    }

    /**
     * @param nome the nome to set
     */
    public void setNome(String nome) {
        this.nome = nome;
    }

    /**
     * @return the email
     */
    public String getEmail() {
        return email;
    }

    /**
     * @param email the email to set
     */
    public void setEmail(String email) {
        this.email = email;
    }

    /**
     * @return the senha
     */
    public String getSenha() {
        return senha;
    }

    /**
     * @param senha the senha to set
     */
    public void setSenha(String senha) {
        this.senha = senha;
    }

    /**
     * @return the professor
     */
    public boolean isProfessor() {
        return professor;
    }

    /**
     * @param professor the professor to set
     */
    public void setProfessor(boolean professor) {
        this.professor = professor;
    }

    public boolean isAluno() {
        return !isProfessor();
    }

    /**
     * @return the totalPontos
     */
    public int getTotalPontos() {
        return totalPontos;
    }

    /**
     * @param totalPontos the totalPontos to set
     */
    public void setTotalPontos(int totalPontos) {
        this.totalPontos = totalPontos;
    }
}
