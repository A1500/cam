package com.inspur.cams.sorg.util;

import org.loushang.bsp.id.util.MaxValueUtil;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;

/**
 * 社会组织编号公共类
 * @author shgtch
 * @date 2011-8-19
 */
public class SomIdHelp {

	/**
	 * 获取社会团体业务编号
	 * @return
	 */
	public static String getGroupTaskCode() {
		return getSomTaskCode("S");
	}
	
	/**
	 * 获取民非业务编号
	 * @return
	 */
	public static String getUngovTaskCode() {
		return getSomTaskCode("M");
	}
	
	/**
	 * 获取基金会业务编号
	 * @return
	 */
	public static String getFundTaskCode() {
		return getSomTaskCode("J");
	}
	
	public static String getSomTaskCode(String sorgType) {
		String year = DateUtil.getYear();
		String areaCode = BspUtil.getCorpOrgan().getOrganCode().substring(0, 6);
		String maxCode = MaxValueUtil.nextStringValue("SOM_TASK_CODE");
		return sorgType + areaCode + year + maxCode;
	}
	
	/**
	 * 获取社会团体编号
	 * @return
	 */
	public static String getGroupSorgId() {
		return getSomSorgId("01");
	}
	
	/**
	 * 获取民非编号
	 * @return
	 */
	public static String getUngovSorgId() {
		return getSomSorgId("02");
	}
	
	/**
	 * 获取基金会编号
	 * @return
	 */
	public static String getFundSorgId() {
		return getSomSorgId("03");
	}
	
	private static String getSomSorgId(String sorgType) {
		String areaCode = BspUtil.getCorpOrgan().getOrganCode().substring(0, 6);
		String maxCode = MaxValueUtil.nextStringValue("SOM_SORG_ID");
		return areaCode + sorgType + maxCode;
	}
	
	public static String getSomCaseCode() {
		String areaCode = BspUtil.getCorpOrgan().getOrganCode().substring(0, 6);
		String maxCode = MaxValueUtil.nextStringValue("SOM_CASE_CODE");
		return areaCode + maxCode;
	}
	
}
