/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Utils;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 *
 * @author Diego
 */
public class Util {

    public static boolean isEmpty(String valor) {
        if (valor == null) {
            return true;
        } else if (valor.trim().equals("")) {
            return true;
        }
        return false;
    }

    public static Date Ontem() {
        Calendar ontem = Calendar.getInstance();
        ontem.add(Calendar.DATE, -1);
        ontem.set(Calendar.HOUR, -12);
        ontem.set(Calendar.MINUTE, 0);
        ontem.set(Calendar.SECOND, 0);
        ontem.set(Calendar.MILLISECOND, 0);
        ontem.clear(Calendar.SECOND);
        return ontem.getTime();
    }

    public static Date Hoje() {
        Calendar today = Calendar.getInstance();
        today.clear(Calendar.HOUR);
        today.clear(Calendar.MINUTE);
        today.clear(Calendar.SECOND);
        return today.getTime();
    }

    public static Date Agora() {
        Calendar today = Calendar.getInstance();
        return today.getTime();
    }

    public static String getDate(String data) {
        try {
            if (!Util.isEmpty(data)) {
                SimpleDateFormat myFormat = new SimpleDateFormat("dd/MM/yyyy");
                SimpleDateFormat fromUser = new SimpleDateFormat("yyyy-MM-dd");
                String temp = myFormat.format(fromUser.parse(data));
                return temp;
            }
        } catch (Exception e) {
        }
        // Retorna um valor default
        return null;
    }
}
