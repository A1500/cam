package com.inspur.cams.comm.util;

import java.text.DecimalFormat;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;


/**
 * 字符串工具类
 * @author shgtch
 * @date 2011-5-16
 */
public class StrUtil {

	public static String n2b(String str) {
		return str == null ? "" : str.trim();
	}

	/**
	 * base64转换为byte数组
	 * @param base64Code
	 * @return
	 */
	public static byte[] getFromBASE64(String base64Code) {
		if (base64Code == null) {
			return null;
		}
		BASE64Decoder decoder = new BASE64Decoder();
		try {
			byte[] bytes = decoder.decodeBuffer(base64Code);
			return bytes;
		} catch (Exception e) {
			return null;
		}
	}

	/**
	 * byte数组转换为base64
	 * @param content
	 * @return
	 */
	public static String getBASE64(byte[] content) {

		if (content == null ||content.length<1){
			return null;
		}
		BASE64Encoder encoder = new BASE64Encoder();
		try {
			return encoder.encode(content);
		} catch (Exception e) {
			return null;
		}
	}
	/**
	 * 数字格式化到小数点后两位
	 * @param num
	 * @return
	 */
	public static String changeTwoDecimal(String num){
		DecimalFormat df=new DecimalFormat("##0.00");
		return df.format(Double.parseDouble(num));
	}

	/**
	 * 数字格式化到小数点后两位
	 * @param num
	 * @return
	 */
	public static String formatInt(int num){
		return formatNum(num,"###,##0");
	}

	/**
	 * 数字格式化到小数点后两位
	 * @param num
	 * @return
	 */
	public static String formatNum(Object num,String formatStr){
		DecimalFormat df=new DecimalFormat(formatStr);
		return df.format(num);
	}
}
