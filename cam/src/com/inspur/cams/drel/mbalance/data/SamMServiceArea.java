package com.inspur.cams.drel.mbalance.data;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;


/**
 * @title:SamMServiceArea
 * @description:医院入院备案对象属地配置bean
 * @author:luguosui
 * @since:2011-09-22
 * @version:1.0
*/
 @Table(tableName = "SAM_MEDICAL_SERVICE_AREA" , keyFields = "ORGAN_ID")
public class SamMServiceArea extends StatefulDatabean{
	//医院ID
	@Column(name="ORGAN_ID")
	private String organId;
	//对应的区县
	@Column(name="AREA_CODE")
	private String areaCode;
	public String getOrganId() {
		return organId;
	}
	public void setOrganId(String organId) {
		this.organId = organId;
	}
	public String getAreaCode() {
		return areaCode;
	}
	public void setAreaCode(String areaCode) {
		this.areaCode = areaCode;
	}
	
}