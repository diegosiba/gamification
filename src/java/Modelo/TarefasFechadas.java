package Modelo;

public class TarefasFechadas extends Custom {

    private int codNivel;
    private int totalNivel;
    private int abertas;
    private int fechadas;

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
     * @return the totalNivel
     */
    public int getTotalNivel() {
        return totalNivel;
    }

    /**
     * @param totalNivel the totalNivel to set
     */
    public void setTotalNivel(int totalNivel) {
        this.totalNivel = totalNivel;
    }

    /**
     * @return the abertas
     */
    public int getAbertas() {
        return abertas;
    }

    /**
     * @param abertas the abertas to set
     */
    public void setAbertas(int abertas) {
        this.abertas = abertas;
    }

    /**
     * @return the fechadas
     */
    public int getFechadas() {
        return fechadas;
    }

    /**
     * @param fechadas the fechadas to set
     */
    public void setFechadas(int fechadas) {
        this.fechadas = fechadas;
    }
    

}
