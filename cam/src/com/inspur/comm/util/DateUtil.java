package com.inspur.comm.util;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 * 时间工具类
 * @author shgtch
 * @date 2012-3-14
 */
public class DateUtil {

	private final static SimpleDateFormat sdfYear = new SimpleDateFormat("yyyy");
	
	private final static SimpleDateFormat sdfMonth7 = new SimpleDateFormat("yyyy-MM");
	
	private final static SimpleDateFormat sdfMonth6 = new SimpleDateFormat("yyyyMM");
	
	private final static SimpleDateFormat sdfDay10 = new SimpleDateFormat("yyyy-MM-dd");
	
	private final static SimpleDateFormat sdfDay8 = new SimpleDateFormat("yyyyMMdd");
	
	private final static SimpleDateFormat sdfTime19 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	private final static SimpleDateFormat sdfTime17 = new SimpleDateFormat("yyyyMMdd HH:mm:ss");
	
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
	public static String getMonth7() {
		return sdfMonth7.format(new Date());
	}
	
	/**
	 * 获取YYYYMM格式
	 * @return
	 */
	public static String getMonth6() {
		return sdfMonth6.format(new Date());
	}
	
	/**
	 * 获取YYYY-MM-DD格式
	 * @return
	 */
	public static String getDay10() {
		return sdfDay10.format(new Date());
	}
	
	/**
	 * 获取YYYYMMDD格式
	 * @return
	 */
	public static String getDay8() {
		return sdfDay8.format(new Date());
	}
	
	/**
	 * 获取YYYY-MM-DD hh:mm:ss格式
	 * @return
	 */
	public static String getTime19() {
		return sdfTime19.format(new Date());
	}
	
	/**
	 * 获取YYYYMMDD hh:mm:ss格式
	 * @return
	 */
	public static String getTime17() {
		return sdfTime17.format(new Date());
	}
	/**
	 * 获取YYYYMMDD hh:mm:ss格式
	 * @return
	 */
	public static String getPreDay8() {
		Calendar calendar = Calendar.getInstance();
		calendar.add(Calendar.DATE, -1);    //得到前一天
		Date date = calendar.getTime();
		return sdfDay8.format(date);
	}
	
}
