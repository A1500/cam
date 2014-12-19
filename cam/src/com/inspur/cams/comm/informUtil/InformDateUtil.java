package com.inspur.cams.comm.informUtil;

import java.util.Date;
import java.util.GregorianCalendar;
import java.text.SimpleDateFormat;
import java.util.Calendar;

//import org.loushang.util.properties.ResourceBundle;

/**
 * @author 王建华 mailto:wangjhua@langchao.com Created on 2001-5-14} $Id:
 *         DateUtil.java,v 1.1 2004/11/04 05:54:39 yulj Exp $
 *
 */
public class InformDateUtil{
//SimpleDateFormat 作为静态变量使用，而SimpleDateFormat是线程不安全的，这样在高并发的情况下会出问题。20080822
//	private static SimpleDateFormat timeFormator =
//		new SimpleDateFormat("yyyyMMdd HH:mm:ss");

	public static String getCurrentDateTime() {
		return GetToday() + " " + GetCurrentTime();
	}
	//@add by ssq Created on 2009-10-14
	public static Date getCurrentDate() {
		SimpleDateFormat timeFormator= new SimpleDateFormat("yyyyMMdd HH:mm:ss");
		try {
		return timeFormator.parse(getCurrentDateTime());
		}
		catch (Exception e) {
				throw new RuntimeException("解析日期时间格式出错，期望的字符串格式为[yyyyMMdd HH:mm:ss]");
		}

	}

	/**
	 * 判断两个日期时间的大小(接受的日期时间格式为 yyyyMMdd HH:mm:ss )
	 *
	 * @param dateTime1
	 *            日期
	 * @param dateTime2
	 *            日期
	 * @return int date1大于date2返回1，返回-1则date1小于date2，返回0则相同
	 *
	 */
	public static int compareDateTime(String dateTime1, String dateTime2) {
		try {
			//单独对SimpleDateFormat生成新对象 20080822
			SimpleDateFormat timeFormator= new SimpleDateFormat("yyyyMMdd HH:mm:ss");
			Date date1 = timeFormator.parse(dateTime1);
			Date date2 = timeFormator.parse(dateTime2);
			if (date1.before(date2))
				return -1;
			if (date1.after(date2))
				return 1;
			else
				return 0;
		} catch (Exception e) {
			//ResourceBundle rb= ResourceBundle.getBundle("org.loushang.bsp.util.resource.util");
			throw new RuntimeException("解析日期时间格式出错，期望的字符串格式为[yyyyMMdd HH:mm:ss]");
		}
	}

	/**
	 * 判断当前日期时间和指定日期时间的大小(接受的日期时间格式为 yyyyMMdd HH:mm:ss )
	 *
	 * @param dateTime
	 *            日期时间
	 * @return int 返回1则当前时间大于dateTime，返回-1则当前时间小于dateTime，返回0则相同
	 */
	public static int compareDateTimeWithNow(String dateTime) {
		GregorianCalendar cal = new GregorianCalendar();
		Date current = cal.getTime();
		//单独对SimpleDateFormat生成新对象 20080822
		SimpleDateFormat timeFormator= new SimpleDateFormat("yyyyMMdd HH:mm:ss");
		try {
			Date date = timeFormator.parse(dateTime);
			if (current.before(date))
				return -1;
			if (current.after(date))
				return 1;
			else
				return 0;
		} catch (Exception e) {
		//	ResourceBundle rb= ResourceBundle.getBundle("org.loushang.bsp.util.resource.util");
			throw new RuntimeException("解析日期时间格式出错，期望的字符串格式为[yyyyMMdd HH:mm:ss]");
		}

	}

	public static String GetToday() {
		Calendar calendar = Calendar.getInstance();
		String s = String.valueOf(calendar.get(1));
		int i = calendar.get(2) + 1;
		String s1 = "";
		String s2 = "";
		if (i < 10)
			s1 = String.valueOf("0" + i);
		else
			s1 = String.valueOf(i);
		int j = calendar.get(5);
		if (j < 10)
			s2 = String.valueOf("0" + j);
		else
			s2 = String.valueOf(j);
		return s + s1 + s2;
	}

	public static String GetCurrentTime() {
		StringBuffer result = new StringBuffer();
		Calendar calendar = Calendar.getInstance();
		int h = calendar.get(Calendar.HOUR_OF_DAY);
		int m = calendar.get(Calendar.MINUTE);
		int s = calendar.get(Calendar.SECOND);
		if (h < 10) {
			result.append("0");
		}
		result.append(h);
		result.append(":");
		if (m < 10) {
			result.append("0");
		}
		result.append(m);
		result.append(":");
		if (s < 10) {
			result.append("0");
		}
		result.append(s);
		return result.toString();
	}

	public static boolean isLeapYear(String year) {
		if (year == null || year.equals("")) {
		//	ResourceBundle rb= ResourceBundle.getBundle("org.loushang.bsp.util.resource.util");
			throw new RuntimeException("判断年份是否闰年时输入的参数不符合系统规格.");
		}
		int y=0;
		try {
			y = Integer.parseInt(year);
		}
		 catch (Exception e) {
					throw new RuntimeException("进行日期运算时输入得参数不符合系统规格."+ e);
		 }
		if (y % 4 == 0 && y % 100 != 0 || y % 400 == 0) {
			return true;
		} else {
			return false;
		}
	}

	public static String getNextDay() {
		return getNextDay(GetToday());
	}

	public static String getNextDay(String today) {
		if (today == null || "".equals(today) || today.length() != 8) {
		//	ResourceBundle rb= ResourceBundle.getBundle("org.loushang.bsp.util.resource.util");
			throw new RuntimeException("由于缺少必要的参数，系统无法进行制定的日期换算.");
		}
		try {
			String sYear = today.substring(0, 4);
			int year = Integer.parseInt(sYear);
			String sMonth = today.substring(4, 6);
			int month = Integer.parseInt(sMonth);
			String sDay = today.substring(6, 8);
			int day = Integer.parseInt(sDay);
			Calendar cal = Calendar.getInstance();
			cal.set(year, month - 1, day);
			cal.add(Calendar.DATE, 1);
			SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");
			return df.format(cal.getTime());

		} catch (Exception e) {
		//	ResourceBundle rb= ResourceBundle.getBundle("org.loushang.bsp.util.resource.util");
			throw new RuntimeException("进行日期运算时输入得参数不符合系统规格."+ e);

		}
	}

	public static String getPreviousDay() {
		return getPreviousDay(GetToday());
	}

	public static String getPreviousDay(String today) {
		if (today == null || "".equals(today) || today.length() != 8) {
		//	ResourceBundle rb= ResourceBundle.getBundle("org.loushang.bsp.util.resource.util");
			throw new RuntimeException("由于缺少必要的参数，系统无法进行制定的日期换算.");
		}
		try {
			String sYear = today.substring(0, 4);
			int year = Integer.parseInt(sYear);
			String sMonth = today.substring(4, 6);
			int month = Integer.parseInt(sMonth);
			String sDay = today.substring(6, 8);
			int day = Integer.parseInt(sDay);
			Calendar cal = Calendar.getInstance();
			cal.set(year, month - 1, day);
			cal.add(Calendar.DATE, -1);
			SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");
			return df.format(cal.getTime());

		} catch (Exception e) {
		//	ResourceBundle rb= ResourceBundle.getBundle("org.loushang.bsp.util.resource.util");
			throw new RuntimeException("进行日期运算时输入得参数不符合系统规格."+ e);

		}
	}

	public static boolean isBigMonth(int month) {
		if (month < 1 || month > 12) {
		//	ResourceBundle rb= ResourceBundle.getBundle("org.loushang.bsp.util.resource.util");
			throw new RuntimeException("进行日期运算时输入得参数不符合系统规格.");
		}
		if (month == 1
			|| month == 3
			|| month == 5
			|| month == 7
			|| month == 8
			|| month == 10
			|| month == 12) {
			return true;
		}
		return false;
	}

	public static boolean isLittleMonth(int month) {
		if (month < 1 || month > 12) {
		//	ResourceBundle rb= ResourceBundle.getBundle("org.loushang.bsp.util.resource.util");
			throw new RuntimeException("进行日期运算时输入得参数不符合系统规格.");
		}
		if (month == 4 || month == 6 || month == 9 || month == 11) {
			return true;
		}
		return false;
	}

	public static long getElapsedSeconds(
		GregorianCalendar gc1,
		GregorianCalendar gc2) {
		Date d1 = gc1.getTime();
		Date d2 = gc2.getTime();
		long l1 = d1.getTime();
		long l2 = d2.getTime();
		long difference = Math.abs(l2 - l1);
		return difference / 1000;
	}

	public static long getElapsedTimes(
		GregorianCalendar gc1,
		GregorianCalendar gc2) {
		Date d1 = gc1.getTime();
		Date d2 = gc2.getTime();
		long l1 = d1.getTime();
		long l2 = d2.getTime();
		long difference = Math.abs(l2 - l1);
		return difference;
	}
	public static String getCurrentDateTime1() {
		Calendar noww = Calendar.getInstance();
		String tempYear = String.valueOf(noww.get(Calendar.YEAR));
		String tempMonth = String.valueOf(noww.get(Calendar.MONTH) + 1);
		String tempHour = String.valueOf(noww.get(Calendar.HOUR_OF_DAY));
		String tempMinute = String.valueOf(noww.get(Calendar.MINUTE));
		String tempSecond = String.valueOf(noww.get(Calendar.SECOND));
		if (tempMonth.length() == 1)
			tempMonth = "0" + tempMonth;
		String tempDay = String.valueOf(noww.get(Calendar.DAY_OF_MONTH));
		if (tempDay.length() == 1)
			tempDay = "0" + tempDay;
		if(tempHour.length()==1)
			tempHour = "0" + tempHour;
		if(tempMinute.length()==1)
			tempMinute = "0" + tempMinute;
		if(tempSecond.length()==1)
			tempSecond = "0" + tempSecond;
		return (tempYear+tempMonth+tempDay+" "+tempHour+":"+tempMinute+":"+tempSecond);

	}
	/*
	 * 获取时间戳
	 * add by huangqiqing
	 * 返回值格式：20091028153713281
	 */
	public static synchronized String getTimeStamp(){
		StringBuffer result=new StringBuffer();
		Calendar now = Calendar.getInstance();// 使用默认时区和语言环境获得一个日历。
        int month = now.get(Calendar.MONTH) + 1;//如果是一月，now.get(Calendar.MONTH)的值是0，所以后面需要加1.
        int day = now.get(Calendar.DAY_OF_MONTH);
        int year = now.get(Calendar.YEAR);
        int hour=now.get(Calendar.HOUR_OF_DAY);
        int minute=now.get(Calendar.MINUTE);
        int second=now.get(Calendar.SECOND);
        int minisecond=now.get(Calendar.MILLISECOND);

        result.append(year);
        if(month<10)
        {
        	result.append("0");
        }
        result.append(month);
        if(day<10)
        {
        	result.append("0");
        }
        result.append(day);
        if(hour<10)
        {
        	result.append("0");
        }
        result.append(hour);
        if(minute<10)
        {
        	result.append("0");
        }
        result.append(minute);
        if(second<10)
        {
        	result.append("0");
        }
        result.append(second);
        result.append(minisecond);
        return result.toString();
	}

}