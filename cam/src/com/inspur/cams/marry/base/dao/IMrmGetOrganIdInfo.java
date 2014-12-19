package com.inspur.cams.marry.base.dao;
 

import org.loushang.bsp.share.organization.bean.PubOrganParms;
import org.loushang.next.dao.BaseCURD;

/**
 * @author licb
 * @date:2011-12-5 下午12:06:51
 * @version :
 * MrmGetOrganIdInfo.java 
 */
 public interface IMrmGetOrganIdInfo extends BaseCURD<PubOrganParms>{
	 /**
	  * 根据organCode获取organId
	  * @param idCard
	  * @return
	  */
	 public String checkOrganId(String organCode);
}
