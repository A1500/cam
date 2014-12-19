package com.inspur.cams.drel.sam.data;

import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:人员类型
 * @description:
 * @author:zhangjian
 * @since:2011-05-28
 * @version:1.0
 */
@Table(tableName = "SAM_PEOPLE_TYPE", keyFields = "peopleTypeId")
public class SamPeopleType extends StatefulDatabean {
	// 人员类型ID
	private String peopleTypeId;
	// 人员ID
	private String peopleId;
	// 类型
	private String peopleType;
	// 备注
	private String remarks;
	public String getPeopleTypeId() {
		return peopleTypeId;
	}
	public void setPeopleTypeId(String peopleTypeId) {
		this.peopleTypeId = peopleTypeId;
	}
	public String getPeopleId() {
		return peopleId;
	}
	public void setPeopleId(String peopleId) {
		this.peopleId = peopleId;
	}
	public String getPeopleType() {
		return peopleType;
	}
	public void setPeopleType(String peopleType) {
		this.peopleType = peopleType;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
}