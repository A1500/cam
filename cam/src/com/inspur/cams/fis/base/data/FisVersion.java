package com.inspur.cams.fis.base.data;


import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * @Path com.inspur.cams.fis.base.data.FisVersion  
 * @Description: TODO 程序版本
 * @author luguosui
 * @date 2011-11-16
 */
 @Table(tableName = "fis_version" , keyFields = "versionNum")
public class FisVersion extends StatefulDatabean {
   //规格编号
	@Column(name = "VERSION_NUM")
   private String versionNum;

	public String getVersionNum() {
		return versionNum;
	}

	public void setVersionNum(String versionNum) {
		this.versionNum = versionNum;
	}
   
}