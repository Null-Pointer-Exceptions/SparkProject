package org.zdd.bookstore.common.utils;

import java.text.SimpleDateFormat;
import java.util.Date;

public class TimeUtils {

    public static String getTimes(){
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

        String format1 = format.format(new Date());
        return format1;
    }

    public static String getHDFSTimes(){
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");

        String format2 = format.format(new Date());
        return format2;
    }
}
