package com.inspur.cams.dataexchange.util;
/**
 * 数据交换数据异常类
 * @author YLL
 * @since 2013年5月23日
 */
public class DataExChangeError {
	
	/**
	 * 未授权，不能查询
	 */
	public static final String PERMISSION_DENIED = "00000";
	public static final String PERMISSION_DENIED_CN = "未授权，不能查询";
	
	/**
	 * 未查询到相关信息
	 */
	public static final String DATA_NOT_FOUND = "01001";
	public static final String DATA_NOT_FOUND_CN = "未查询到相关信息";
	
	/**
	 * 查询时间条件超长
	 */
	public static final String TIME_EXPIRED = "01002";
	public static final String TIME_EXPIRED_CN = "查询时间条件超长";
	
	/**
	 * 查询结果记录数超量（5万）
	 */
	public static final String DATA_TOO_MUCH = "01003";
	public static final String DATA_TOO_MUCH_CN = "查询结果记录数超量（5万）";

	/**
	 * 数据有误
	 */
	public static final String DATA_ERROR = "01004";
	public static final String DATA_ERROR_CN = "数据有误";
	
	/**
	 * 用户登录成功
	 */
	public static final String LOGIN_SUCCESS = "02000";
	public static final String LOGIN_SUCCESS_CN = "用户登录成功";
	
	/**
	 * 用户名或密码不能为空
	 */
	public static final String NOT_NULL_LOGIN = "02001";
	public static final String NOT_NULL_LOGIN_CN = "用户名或密码不能为空";
	
	/**
	 * 用户名或密码错误
	 */
	public static final String ID_OR_PASS_WORD_FALSE = "02002";
	public static final String ID_OR_PASS_WORD_FALSE_CN = "用户名或密码错误";
	
	
	public static String getID_OR_PASS_WORD_FALSE() {
		return ID_OR_PASS_WORD_FALSE;
	}
	public static String getID_OR_PASS_WORD_FALSE_CN() {
		return ID_OR_PASS_WORD_FALSE_CN;
	}
	public static String getNOT_NULL_LOGIN() {
		return NOT_NULL_LOGIN;
	}
	public static String getNOT_NULL_LOGIN_CN() {
		return NOT_NULL_LOGIN_CN;
	}
	public static String getDATA_ERROR() {
		return DATA_ERROR;
	}
	public static String getDATA_ERROR_CN() {
		return DATA_ERROR_CN;
	}
	public static String getPERMISSION_DENIED() {
		return PERMISSION_DENIED;
	}
	public static String getPERMISSION_DENIED_CN() {
		return PERMISSION_DENIED_CN;
	}
	public static String getDATA_NOT_FOUND() {
		return DATA_NOT_FOUND;
	}
	public static String getDATA_NOT_FOUND_CN() {
		return DATA_NOT_FOUND_CN;
	}
	public static String getTIME_EXPIRED() {
		return TIME_EXPIRED;
	}
	public static String getTIME_EXPIRED_CN() {
		return TIME_EXPIRED_CN;
	}
	public static String getDATA_TOO_MUCH() {
		return DATA_TOO_MUCH;
	}
	public static String getDATA_TOO_MUCH_CN() {
		return DATA_TOO_MUCH_CN;
	}
	
}
