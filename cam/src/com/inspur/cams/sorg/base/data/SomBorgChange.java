package com.inspur.cams.sorg.base.data;

import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:业务主管单位变更databean
 * @description:
 * @author:
 * @since:2013-03-05
 * @version:1.0
 */
@Table(tableName = "SOM_BUSINESS_ORGAN_CHANGE", keyFields = "CHANGE_ID")
public class SomBorgChange extends StatefulDatabean {
	// 变更id
	private String changeId;
	// 原业务主管单位id
	private String changeBeforeId;
	// 原业务主管单位名称
	private String changeBeforeName;
	// 变更后业务主管单位id
	private String changeAfterId;
	// 变更后业务主管单位名称
	private String changeAfterName;
	// 变更时间
	private String changeTime;
	// 变更人
	private String changePerson;
	// 变更单位
	private String changeOrgan;
	// 登记管理机关区划
	private String morgArea;
	// 登记管理机关名称
	private String morgName;

	public String getChangeId() {
		return changeId;
	}

	public void setChangeId(String changeId) {
		this.changeId = changeId;
	}

	public String getChangeBeforeId() {
		return changeBeforeId;
	}

	public void setChangeBeforeId(String changeBeforeId) {
		this.changeBeforeId = changeBeforeId;
	}

	public String getChangeBeforeName() {
		return changeBeforeName;
	}

	public void setChangeBeforeName(String changeBeforeName) {
		this.changeBeforeName = changeBeforeName;
	}

	public String getChangeAfterId() {
		return changeAfterId;
	}

	public void setChangeAfterId(String changeAfterId) {
		this.changeAfterId = changeAfterId;
	}

	public String getChangeAfterName() {
		return changeAfterName;
	}

	public void setChangeAfterName(String changeAfterName) {
		this.changeAfterName = changeAfterName;
	}

	public String getChangeTime() {
		return changeTime;
	}

	public void setChangeTime(String changeTime) {
		this.changeTime = changeTime;
	}

	public String getChangePerson() {
		return changePerson;
	}

	public void setChangePerson(String changePerson) {
		this.changePerson = changePerson;
	}

	public String getChangeOrgan() {
		return changeOrgan;
	}

	public void setChangeOrgan(String changeOrgan) {
		this.changeOrgan = changeOrgan;
	}

	public String getMorgArea() {
		return morgArea;
	}

	public void setMorgArea(String morgArea) {
		this.morgArea = morgArea;
	}

	public String getMorgName() {
		return morgName;
	}

	public void setMorgName(String morgName) {
		this.morgName = morgName;
	}
}