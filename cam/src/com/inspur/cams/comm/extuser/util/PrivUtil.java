package com.inspur.cams.comm.extuser.util;

public class PrivUtil {
    public static boolean hasEsureyPriv(String organType){
    	if("01,02,03,04,05,06,07,08,09,10".indexOf(organType)>=0){
    		return true;
    	}
    	//40  组织部,50  机关工委,60  工会,70  团委,80  妇联,90  老龄办,100  残联,110  教育局,120司法局,130卫生局,140计生委
        //150红十字会,160慈善总会,170 市金融办,180 纪委,190 督查室（市热线办）,200 财政局,210 宣传部,220 社会经济调查局,230 编办,250 外侨办
    	if("40,50,60,70,80,90,100,110,120,130,140,150,160,170,180,190,210,220,230,250".indexOf(organType)>=0){
    		return true;
    	}
    	return false;
    }
    
    public static boolean hasMbalancePriv(String organType){
    	if("30".equals(organType)){
    		return true;
    	}
    	return false;
    }
    /**
     * 民间组织网上年检平台
     * @param organType
     * @return
     */
    public static boolean hasSomPriv(String organType){
    	if("JJ,MF,ST,04".indexOf(organType)>=0){
    		return true;
    	}
    	return false;
    }
    public static boolean hasCdcPriv(String organType){
    	if("JD,SQ".indexOf(organType)>=0){
    		return true;
    	}
    	return false;
    }
    public static boolean hasAimsPriv(String organType){
    	if("LT".indexOf(organType)>=0){
    		return true;
    	}
    	return false;
    }
    public static boolean hasDeclarePriv(String organType){
    	if("NY".indexOf(organType)>=0){
    		return true;
    	}
    	return false;
    }
    public static boolean hasWelfarePriv(String organType){
    	if("FL,JZ".indexOf(organType)>=0){
    		return true;
    	}
    	return false;
    }
    public static boolean hasEXPriv(String organType){
    	if("EX".indexOf(organType)>=0){
    		return true;
    	}
    	return false;
    }
    public static boolean hasPrsPriv(String organType){
    	if("PRS_SB,PRS_XX".indexOf(organType)>=0){
    		return true;
    	}
    	return false;
    }
}
