package com.app.utility;

import org.springframework.stereotype.Component;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

@Component
public class Utility {

    public String getCurrentDateInUsFormat(){

        DateTimeFormatter df = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDate date= LocalDate.now();
        return date.format(df);
    }

    public Long longNullValue(Object val){
        try {
            Long id=Long.parseLong(String.valueOf(val));
            return id;
        }catch (Exception e){
            return null;
        }
    }
    public Long longZeroValue(Object val){
        try {
            Long id=Long.parseLong(String.valueOf(val));
            if (id==null)id=0l;
            return id;
        }catch (Exception e){
            return 0l;
        }
    }
    public Double doubleNullValue(Object val){
          try {
              Double value = Double.parseDouble(String.valueOf(val));
                return value;
          }catch (Exception e){
              return null;
          }
    }
    public Double doubleZeroValue(Object val){
        try {
            Double value = Double.parseDouble(String.valueOf(val));
            return value;
        }catch (Exception e){
            return 0.0;
        }
    }
}
