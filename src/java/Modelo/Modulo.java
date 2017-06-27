package Modelo;

public class Modulo extends Custom {

    private String nome;
    private String inicioModulo;
    private String fimModulo;
    private int minimoPontos;
    private int minimoTarefas;

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
     * @return the inicioModulo
     */
    public String getInicioModulo() {
        return inicioModulo;
    }

    /**
     * @param inicioModulo the inicioModulo to set
     */
    public void setInicioModulo(String inicioModulo) {
        this.inicioModulo = inicioModulo;
    }

    /**
     * @return the fimModulo
     */
    public String getFimModulo() {
        return fimModulo;
    }

    /**
     * @param fimModulo the fimModulo to set
     */
    public void setFimModulo(String fimModulo) {
        this.fimModulo = fimModulo;
    }

    /**
     * @return the minimoPontos
     */
    public int getMinimoPontos() {
        return minimoPontos;
    }

    /**
     * @param minimoPontos the minimoPontos to set
     */
    public void setMinimoPontos(int minimoPontos) {
        this.minimoPontos = minimoPontos;
    }

    /**
     * @return the minimoTarefas
     */
    public int getMinimoTarefas() {
        return minimoTarefas;
    }

    /**
     * @param minimoTarefas the minimoTarefas to set
     */
    public void setMinimoTarefas(int minimoTarefas) {
        this.minimoTarefas = minimoTarefas;
    }

}
