package com.inspur.cams.drel.application.comm;
/**
 * 低保业务类型
 * @author yanll
 *@time 2012年5月14日
 */
public class SamApplyType {
	/**
	 * "01"开头的为城市低保业务
	 * "02"开头的为农村低保业务
	 * "03"开头的为五保业务
	 */
	public static final String SAM_CITY_NEW_APPLY = "010";
	public static final String SAM_CITY_NEW_APPLY_CN ="城市低保新申请业务";
	public static final String SAM_CITY_CHANGE = "011";
	public static final String SAM_CITY_CHANGE_CN ="城市低保变更业务";
	public static final String SAM_CITY_HIS = "012";
	public static final String SAM_CITY_HIS_CN ="城市低保历史数据采集业务";
	public static final String SAM_CITY_RECHECK = "013";
	
	public static final String SAM_COUNTRY_NEW_APPLY = "020";
	public static final String SAM_COUNTRY_NEW_APPLY_CN ="农村低保新申请业务";
	public static final String SAM_COUNTRY_CHANGE = "021";
	public static final String SAM_COUNTRY_CHANGE_CN ="农村低保变更业务";
	public static final String SAM_COUNTRY_HIS = "022";
	public static final String SAM_COUNTRY_HIS_CN ="农村低保历史数据采集业务";
	
	public static final String SAM_FIVE_NEW_APPLY = "030";
	public static final String SAM_FIVE_NEW_APPLY_CN ="五保新申请业务";
	public static final String SAM_FIVE_CHANGE = "031";
	public static final String SAM_FIVE_CHANGE_CN ="农村五保变更业务";
	public static final String SAM_FIVE_HIS = "032";
	public static final String SAM_FIVE_HIS_CN ="农村五保历史数据采集业务";
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	public static String getSAM_CITY_NEW_APPLY() {
		return SAM_CITY_NEW_APPLY;
	}
	public static String getSAM_CITY_NEW_APPLY_CN() {
		return SAM_CITY_NEW_APPLY_CN;
	}
	
}
