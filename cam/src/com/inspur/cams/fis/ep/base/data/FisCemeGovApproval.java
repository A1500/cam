package com.inspur.cams.fis.ep.base.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title: FIS_CEME_GOV_APPROVAL
 * @description:
 * @author:lidongdong(xuexzh-20120214)
 * @since:2011-11-14
 * @version:1.0
 */
@Table(tableName = "FIS_CEME_GOV_APPROVAL", keyFields = "recordId")
public class FisCemeGovApproval extends StatefulDatabean {
	// 序号
	@Column(name = "RECORD_ID")
	private String recordId;
	// CEME_ID
	@Column(name = "CEME_ID")
	private String cemeId;
	// 审批事项编号
	@Column(name = "ITEM_ID")
	private String itemId;
	// 政府部门类型
	@Column(name = "DEPT_ID")
	private String deptId;
	// 政府批准文号
	@Column(name = "DEPT_NUM")
	private String deptNum;
	// 政府批准时间
	@Column(name = "DEPT_TIME")
	private String deptTime;
	// 是否作废
	@Column(name = "IS_ENABLE")
	private String isEnable;

	public String getCemeId() {
		return cemeId;
	}

	public void setCemeId(String cemeId) {
		this.cemeId = cemeId;
	}

	public String getDeptId() {
		return deptId;
	}

	public void setDeptId(String deptId) {
		this.deptId = deptId;
	}

	public String getDeptNum() {
		return deptNum;
	}

	public void setDeptNum(String deptNum) {
		this.deptNum = deptNum;
	}

	public String getDeptTime() {
		return deptTime;
	}

	public void setDeptTime(String deptTime) {
		this.deptTime = deptTime;
	}

	public String getIsEnable() {
		return isEnable;
	}

	public void setIsEnable(String isEnable) {
		this.isEnable = isEnable;
	}

	public String getItemId() {
		return itemId;
	}

	public void setItemId(String itemId) {
		this.itemId = itemId;
	}

	public String getRecordId() {
		return recordId;
	}

	public void setRecordId(String recordId) {
		this.recordId = recordId;
	}
}