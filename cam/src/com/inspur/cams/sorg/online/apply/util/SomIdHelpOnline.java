package com.inspur.cams.sorg.online.apply.util;

import org.loushang.bsp.id.util.MaxValueUtil;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;

/**
 * 社会组织编号公共类
 * @author shgtch
 * @date 2011-8-19
 */
public class SomIdHelpOnline {

	/**
	 * 获取社会团体业务编号
	 * @return
	 */
	public static String getGroupTaskCode(String areaCode) {
		return getSomTaskCode("S",areaCode);
	}
	
	/**
	 * 获取民非业务编号
	 * @return
	 */
	public static String getUngovTaskCode(String areaCode) {
		return getSomTaskCode("M",areaCode);
	}
	
	/**
	 * 获取基金会业务编号
	 * @return
	 */
	public static String getFundTaskCode(String areaCode) {
		return getSomTaskCode("J",areaCode);
	}
	
	public static String getSomTaskCode(String sorgType,String areaCode) {
		String year = DateUtil.getYear();
		String maxCode = MaxValueUtil.nextStringValue("SOM_TASK_CODE");
		return sorgType + areaCode.substring(0,6) + "O" + maxCode;
	}
	
	/**
	 * 获取社会团体编号
	 * @return
	 */
	public static String getGroupSorgId(String areaCode) {
		return getSomSorgId("O1",areaCode);
	}
	
	/**
	 * 获取民非编号
	 * @return
	 */
	public static String getUngovSorgId(String areaCode) {
		return getSomSorgId("O2",areaCode);
	}
	
	/**
	 * 获取基金会编号
	 * @return
	 */
	public static String getFundSorgId(String areaCode) {
		return getSomSorgId("O3",areaCode);
	}
	
	private static String getSomSorgId(String sorgType,String areaCode) {
		String maxCode = MaxValueUtil.nextStringValue("SOM_SORG_ID");
		return areaCode.substring(0,6) + sorgType + maxCode;
	}
	
	public static String getSomCaseCode() {
		String areaCode = BspUtil.getCorpOrgan().getOrganCode().substring(0, 6);
		String maxCode = MaxValueUtil.nextStringValue("SOM_CASE_CODE");
		return areaCode.substring(0,6) + maxCode;
	}
	
}
