package com.inspur.sdmz.comm.util;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * 时间工具类
 * @author shgtch
 * @date 2011-4-28
 */
public class DateUtil {

	public final static SimpleDateFormat sdfYear = new SimpleDateFormat("yyyy");
	public final static SimpleDateFormat sdfDay = new SimpleDateFormat("yyyy-MM-dd");
	public final static SimpleDateFormat sdfTime = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
	public final static SimpleDateFormat sdfNewTime = new SimpleDateFormat("yyyyMMdd hh:mm:ss");
	
	/**
	 * 获取YYYY格式
	 * @return
	 */
	public static String getYear() {
		return sdfYear.format(new Date());
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
	 * 获取YYYYMMDD hh:mm:ss格式
	 * @return
	 */
	public static String getNewTime() {
		return sdfNewTime.format(new Date());
	}
	
}
