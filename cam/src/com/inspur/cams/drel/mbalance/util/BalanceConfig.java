package com.inspur.cams.drel.mbalance.util;

import com.inspur.cams.comm.util.CamsProperties;
import com.inspur.cams.comm.util.StrUtil;

public class BalanceConfig {
    public static boolean needConnect(String areaCode){
    	String noNeedConnect = StrUtil.n2b(CamsProperties.getString("no_connect_area"));
    	if(noNeedConnect.indexOf(areaCode)>=0){
    		return false;
    	}
    	return true;
    }
    
    public static String getDeductible(String areaCode,String assistanceType){
    	if(areaCode.startsWith("370784")){
    		if("01".equals(assistanceType)||"02".equals(assistanceType)){
        		return "2000";
        	}
    	}
    	return "0";
    }


}
