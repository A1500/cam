package com.inspur.cams.bpt.util;

/**
 * 依据行政区划过滤权限
 * @author wangbaocai
 * @since 2012/05/12
 */
public class FilterLimit {
	
	/**
	 * 依据行政区划过滤权限
	 */
	public static String filterByOrganCode(StringBuffer sql,String organCode){
		if (!organCode.substring(0, 2).equals("00") && organCode.substring(2, 12).equals("0000000000")) {
			sql.append(" AND  DOMICILE_CODE like ? ");// 省局
			organCode = organCode.substring(0, 2)+"%";
		}else if(!organCode.substring(2, 4).equals("00")&&organCode.substring(4, 12).equals("00000000")){
			sql.append(" AND DOMICILE_CODE like ? ");//市局
			organCode = organCode.substring(0, 4)+"%";
		}else if(!organCode.substring(4, 6).equals("00")&&organCode.substring(6, 12).equals("000000")){
			sql.append(" AND DOMICILE_CODE like ? ");//县局
			organCode = organCode.substring(0, 6)+"%";
		}else if(!organCode.substring(6, 9).equals("00")&&organCode.substring(9, 12).equals("000")){
			sql.append(" AND DOMICILE_CODE like ? ");//乡镇
			organCode = organCode.substring(0, 9)+"%";
		}else{
			sql.append(" AND DOMICILE_CODE= ? ");//区县
			organCode = organCode;
		}
		return organCode;
	}
	
}
