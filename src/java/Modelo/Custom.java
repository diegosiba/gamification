package Modelo;

import Utils.Util;
import java.io.Serializable;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class Custom implements Serializable {

    private static final long serialVersionUID = 1L;

    protected int codigo;
    protected boolean deletado;
    private String dataHoraCadastro;

    /**
     * @return the codigo
     */
    public int getCodigo() {
        return codigo;
    }

    /**
     * @param codigo the codigo to set
     */
    public void setCodigo(int codigo) {
        this.codigo = codigo;
    }

    /**
     * @return the deletado
     */
    public boolean isDeletado() {
        return deletado;
    }

    /**
     * @param deletado the deletado to set
     */
    public void setDeletado(boolean deletado) {
        this.deletado = deletado;
    }

    /**
     * Se o código do registro for zero, significa que é um registro novo e
     * precisa ser inserido na base.
     *
     * @return
     */
    public boolean isPrecisaInserir() {
        return this.codigo == 0;
    }

    /**
     * @return the dataHoraCadastro
     */
    public String getDataHoraCadastro() {
        return dataHoraCadastro;
    }

    /**
     * @param dataHoraCadastro the dataHoraCadastro to set
     */
    public void setDataHoraCadastro(String dataHoraCadastro) {
        this.dataHoraCadastro = dataHoraCadastro;
    }

    public String getHoraCadastro() {
        String str_hour = this.getDataHoraCadastro();
        if (!Util.isEmpty(str_hour)) {
            return str_hour.substring(11, 16);
        }
        // Retorna um valor default
        return "null";
    }

    public Date getHoraCadastro2() {
        try {
            String str_hour = this.getDataHoraCadastro();
            if (!Util.isEmpty(str_hour)) {
                str_hour = str_hour.substring(11);
                DateFormat formatter = new SimpleDateFormat("hh:mm:ss");
                return (Date) formatter.parse(str_hour);
            }
        } catch (ParseException e) {
        }
        // Retorna um valor default
        return null;
    }

    /**
     * Retorna a data de cadastro do registro em formato String
     *
     * @return
     */
    public String getDataCadastro() {
        try {
            String str_date = this.getDataHoraCadastro();
            if (!Util.isEmpty(str_date)) {
                str_date = str_date.substring(0, 19);
                SimpleDateFormat myFormat = new SimpleDateFormat("dd/MM/yyyy");
                SimpleDateFormat fromUser = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                return myFormat.format(fromUser.parse(str_date));
            }
        } catch (ParseException e) {
        }
        // Retorna um valor default
        return "01/01/2000";
    }

    /**
     * Retorna a data de cadastro do registro em formato Date
     *
     * @return
     */
    public Date getDateCadastro() {
        try {
            DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
            return df.parse(this.getDataCadastro());
        } catch (ParseException e) {
        }
        // Retorna um valor default
        return null;
    }

    /**
     * Retorna o valor a ser exibido na time line. Pode ser X horas atrás, pode
     * ser só o valor em horas (significa que foi no dia de ontem) e pode ser a
     * quantidade de dias.
     *
     * @return
     */
    public String getExibirTimeLine() {
        // Se a data de cadastro for maior que ontem, exibe a hora, senão exibe a data.
        if (!Util.Ontem().after(this.getDateCadastro())) {
            return this.getHoraCadastro();
        }
        return this.getDataCadastro();
    }
}
