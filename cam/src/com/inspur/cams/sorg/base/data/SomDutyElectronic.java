package com.inspur.cams.sorg.base.data;

import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;
/**
 * 职务与相关附件中间表
 * @author yanliangliang
 * @date 2011-12-17
 */
@Table(tableName = "SOM_DUTY_ELECTRONIC", keyFields = "id")
public class SomDutyElectronic extends StatefulDatabean{
	
	//主键
	private String id;
	//任职ID
	private String dutyId;
	//附件ID
	private String electronicId;

	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getDutyId() {
		return dutyId;
	}

	public void setDutyId(String dutyId) {
		this.dutyId = dutyId;
	}

	public String getElectronicId() {
		return electronicId;
	}

	public void setElectronicId(String electronicId) {
		this.electronicId = electronicId;
	}
	

}
