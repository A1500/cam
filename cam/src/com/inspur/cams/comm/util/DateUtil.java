package com.inspur.cams.comm.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 * 时间工具类
 * @author shgtch
 * @date 2011-5-10
 */
public class DateUtil {

	private final static SimpleDateFormat sdfYear = new SimpleDateFormat("yyyy");
	
	private final static SimpleDateFormat sdfMonth = new SimpleDateFormat("yyyy-MM");
	
	private final static SimpleDateFormat sdfDay = new SimpleDateFormat("yyyy-MM-dd");
	
	private final static SimpleDateFormat sdfTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	/**
	 * 获取某月的工作日天数（除周六周日即为工作日，因每年法定假日不确定，暂没有把法定假日去掉）
	 * @author zhangdd
	 * @date 2013-12-18
	 * @param getWorkDay(2013, 5)
	 * @return workDays
	 */
	public static int getWorkDay(int year,int month){
		int workDays=0;
		Calendar c = Calendar.getInstance();
		c.set(year, month,1);
		c.add(Calendar.DAY_OF_YEAR, -1);
		int dayOfMonth = c.get(Calendar.DAY_OF_MONTH);
		c.set(Calendar.DAY_OF_MONTH, c.getActualMinimum(Calendar.DAY_OF_MONTH));
		 for (int i=0; i<dayOfMonth; i++) {
	            int wd = c.get(Calendar.DAY_OF_WEEK);
	            if (wd != Calendar.SATURDAY&&wd != Calendar.SUNDAY) {
	                workDays++;
	            }
	            c.add(Calendar.DAY_OF_MONTH, 1);
	        }
		return workDays;
	}
	/**
	 * 获取YYYY格式
	 * @return
	 */
	public static String getYear() {
		return sdfYear.format(new Date());
	}
	
	/**
	 * 获取YYYY-MM格式
	 * @return
	 */
	public static String getMonth() {
		return sdfMonth.format(new Date());
	}
	
	/**
	 * 获取YYYY-MM-DD格式
	 * @return
	 */
	public static String getDay() {
		return sdfDay.format(new Date());
	}
	
	/**
	 * 获取YYYY-MM-DD hh:mm:ss格式
	 * @return
	 */
	public static String getTime() {
		return sdfTime.format(new Date());
	}
	/**
	 * 获取YYYY-MM-DD格式的前一天
	 * @param today
	 * @return 前一天
	 */
	public static String getYestedayDate(String today){
		SimpleDateFormat sdf= new SimpleDateFormat("yyyy-MM-dd"); 
		Date date;
		try {
			date = sdf.parse(today);
			Calendar calendar = Calendar.getInstance(); 
			calendar.setTime(date); 
			calendar.add(Calendar.DATE, -1);//得到前一天
			String  yestedayDate
			= new SimpleDateFormat("yyyy-MM-dd").format(calendar.getTime());
			return yestedayDate;
		} catch (ParseException e) {
			e.printStackTrace();
			return null;
		} 
	}
	/**
	 * 获取YYYY-MM格式的前一月
	 * @param today
	 * @return 前一月
	 */
	public static String getLastmonth(String today){
		SimpleDateFormat sdf= new SimpleDateFormat("yyyy-MM"); 
		Date date;
		try {
			date = sdf.parse(today);
			Calendar calendar = Calendar.getInstance(); 
			calendar.setTime(date); 
			calendar.add(Calendar.MONTH, -1);   //得到前一月
			String  lastmonth
			= new SimpleDateFormat("yyyy-MM").format(calendar.getTime());
			return lastmonth;
		} catch (ParseException e) {
			e.printStackTrace();
			return null; 
		}
	}
	/**
	 * 有String类型的日期转换成long的时间，用于比较时间大小
	 * @param date 格式限制：yyyy-MM
	 * @return
	 */
	public static Long StringTimeToInt(String date){
		Date time=new Date();
		SimpleDateFormat sd=new SimpleDateFormat("yyyy-MM");
		try{
			 time=sd.parse(date);
		}
		catch (ParseException e) { 
			System.out.println("输入的日期格式有误！"); 
		}
		return time.getTime();
	}
}
