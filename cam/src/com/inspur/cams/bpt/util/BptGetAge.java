package com.inspur.cams.bpt.util;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class BptGetAge {
	public static String getAgeByBirthday(String birth) { 

       
        
        
        if(birth.length()==8){
        	birth=checkDate(birth);
        }
        if("".equals(birth)||(birth.length()!=10&&birth.length()!=8)){
        	return "";
        }
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String thisdate = sdf.format(new Date());
		//得到当前的年份
		String cYear = thisdate.substring(0,4);
		String cMonth = thisdate.substring(5,7);
		String cDay = thisdate.substring(8,10);
		Date d = null;
		try{
            d = sdf.parse(birth);
        }catch(Exception e){
            //如果不能转换,肯定是错误格式
            return "";
        }
		birth = sdf.format(d);
		
		//得到生日年份
		String birthYear = birth.substring(0,4);
		String birthMonth = birth.substring(5,7);
		String birthDay = birth.substring(8,10);

		int age = Integer.parseInt(cYear) - Integer.parseInt(birthYear);
		if (Integer.parseInt(cMonth) == Integer.parseInt(birthMonth)) { 
                //monthNow==monthBirth 
                if (Integer.parseInt(cDay) < Integer.parseInt(birthDay)) { 
                    age--; 
                } 
        } else if(Integer.parseInt(cMonth) < Integer.parseInt(birthMonth)){
        	age--; 
        }


        return age +""; 
    } 
	
	public static String checkDate(String date) {
		SimpleDateFormat sf1 = new SimpleDateFormat("yyyyMMdd");
	     SimpleDateFormat sf2 =new SimpleDateFormat("yyyy-MM-dd");
	     String sfstr = "";
	     try {
	      sfstr = sf2.format(sf1.parse(date));
		  } catch (ParseException e) {
		   // TODO Auto-generated catch block
			  return sfstr;
		  }
	     return sfstr;
    }
	

}
