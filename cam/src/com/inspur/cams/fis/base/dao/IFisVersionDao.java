package com.inspur.cams.fis.base.dao;


import org.loushang.next.dao.*;

import com.inspur.cams.fis.base.data.FisVersion;


/**
* @Package com.inspur.cams.fis.base.dao
* @Description: TODO 程序版本
* @author luguosui 
* @date 2012-8-2
 */
 public interface IFisVersionDao extends BaseCURD<FisVersion>{
	public String getVersion();
}
