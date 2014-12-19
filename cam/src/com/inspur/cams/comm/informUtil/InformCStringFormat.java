package com.inspur.cams.comm.informUtil;

public class InformCStringFormat {
	/**
	 * 格式化字符串，拼装sql
	 * @since 2009-12-15
	 * */
	public static String formatL5InParamsToSqlInParams(String str){
		return new StringBuffer("'").append(str.replaceAll(",", "','")).append("'").toString();
	}
	/**
	 * 判断一个字符串是否包含子串
	 * @param str
	 * @param subString
	 * @return
	 */
	 public  static boolean isIncludeSubString(String str, String subString) {
	       boolean result = false;
	       if (str == null || subString == null){
	           return false;
	       }
	       int strLength = str.length();
	       int subStrLength = subString.length();
	       String tmpStr = null;
	       for (int i = 0; i < strLength; i++) {
	           if (strLength - i < subStrLength){
	               return false;
	           }
	           tmpStr = str.substring(i, subStrLength + i);
	           if (tmpStr.endsWith(subString)){
	               return true;
	           }
	       }
	       return result;
	   }
}
