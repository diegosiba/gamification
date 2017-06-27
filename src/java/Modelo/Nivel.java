package Modelo;

public class Nivel extends Custom {

    private String nome;
    private int faixaInicio;
    private int faixaFim;

    /**
     * @return the nome
     */
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
     * @return the faixaInicio
     */
    public int getFaixaInicio() {
        return faixaInicio;
    }

    /**
     * @param faixaInicio the faixaInicio to set
     */
    public void setFaixaInicio(int faixaInicio) {
        this.faixaInicio = faixaInicio;
    }

    /**
     * @return the faixaFim
     */
    public int getFaixaFim() {
        return faixaFim;
    }

    /**
     * @param faixaFim the faixaFim to set
     */
    public void setFaixaFim(int faixaFim) {
        this.faixaFim = faixaFim;
    }
}
