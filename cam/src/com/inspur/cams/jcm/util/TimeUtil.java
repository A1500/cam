/*
 * Util
 * V 1.0.0
 * 2012/11/14
 *
 * Copyright © 2012 中国电信股份有限公司增值业务运营中心 版权所有
 *
 * 所有文字、代码资料，版权均属中国电信股份有限公司增值业务运营中心
 * 所有，任何公司或个人未经本司协议授权，不得复制、下载、存储或公开
 * 显示。违者本公司将依法追究责任。
 */
package com.inspur.cams.jcm.util;

import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * @author LiuTong
 * 
 */
public class TimeUtil {

	/**
	 * 将字符转换日期
	 * @param str
	 * @param format 格式
	 * @return
	 * @throws ParseException 
	 */
	public static Date getDate(String str, String format) throws ParseException{
		if(StringUtils.isNotEmpty(str)){
			DateFormat df = new SimpleDateFormat(format);
			return df.parse(str);
		}
		return null;
	}
	
	/**
	 * 将日期转换字符串
	 * @param date
	 * @param format 格式
	 * @return
	 */
	public static String getDateString(Date date, String format){
		DateFormat df = new SimpleDateFormat(format);
		return df.format(date);
	}
	
	/**
	 * 将毫秒专为xx时xx分xx秒xx毫秒
	 * 
	 * @param var
	 * @return
	 */
	public static String formatMillisecond(long var) {
		StringBuffer format = new StringBuffer();

		// 计算毫秒
		long millisecond = var % 1000;
		// 计算秒
		long second = (var / 1000) % 60;
		// 计算分
		long minute = (var / 1000 / 60) % 60;
		// 计算小时
		long hour = var / 1000 / 60 / 60;

		if (hour != 0)
			format.append(hour + "小时");
		if (minute != 0)
			format.append(minute + "分");
		// if (second != 0)
			format.append(second);
		if (millisecond != 0)
			format.append(".").append(new DecimalFormat("000").format(millisecond));
		format.append("秒");

		return format.toString();
	}
	
	/**
	 * 当月1号0点
	 * @return
	 */
	public static Date getDY(Date date) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		// 0点
		calendar.set(Calendar.HOUR_OF_DAY, 0);
		calendar.set(Calendar.MINUTE, 0);
		calendar.set(Calendar.SECOND, 0);
		calendar.set(Calendar.MILLISECOND, 0);
		// 日期
		calendar.set(Calendar.DAY_OF_MONTH, 1);
		
		// calendar.add(Calendar.MONTH, -1); // 测试修改当月日期
		return calendar.getTime();
	}
	
	/**
	 * 上月1号0点
	 * @return
	 */
	public static Date getSY(Date date) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(getDY(date));
		// 上月
		calendar.add(Calendar.MONTH, -1);
		return calendar.getTime();
	}
	
	/**
	 * 下月1号0点
	 * @return
	 */
	public static Date getXY(Date date) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(getDY(date));
		// 下月
		calendar.add(Calendar.MONTH, 1);
		return calendar.getTime();
	}

	/**日期格式：yyyy-MM-dd hh:mm:ss*/
	public static final String FORMAT1 = "yyyy-MM-dd hh:mm:ss";
	/**日期格式：yyyy/MM/ddhh:mm*/
	public static final String FORMAT2 = "yyyy/MM/dd hh:mm";
	/**日期格式：yyyyMMdd*/
	public static final String FORMAT3 = "yyyyMMdd";
	/**日期格式：yyyy/MM/dd*/
	public static final String FORMAT4 = "yyyy/MM/dd";
	/**日期格式：yyyyMMddhhmmss*/
	public static final String FORMAT5 = "yyyyMMddhhmmss";
	final static Logger logger = LoggerFactory.getLogger(TimeUtil.class);
}
