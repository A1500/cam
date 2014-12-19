package com.inspur.cams.fis.base.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 公墓信息变更备案表databean
 * @author 
 * @date 2013-08-01
 */
@Table(tableName = "FIS_CEME_CHANGE", keyFields = "changeId")
public class FisCemeChange extends StatefulDatabean {

	// 变更ID
	private String changeId;

	// 业务审批编码
	private String cemeApplyId;

	// 公墓记录编码
	private String recordId;

	// 单位编号
	private String organId;

	// 公墓名称
	private String name;

	// 变更理由
	private String changeReason;

	// 变更备案时间
	private String regDate;

	// 是否确认
	private String ifConfirm;

	/**
	 * 获取 变更ID
	 * @return String
	 */
	public String getChangeId() {
		return changeId;
	}

	/**
	 * 设置 变更ID
	 */
	public void setChangeId(String changeId) {
		this.changeId = changeId;
	}

	/**
	 * 获取 业务审批编码
	 * @return String
	 */
	public String getCemeApplyId() {
		return cemeApplyId;
	}

	/**
	 * 设置 业务审批编码
	 */
	public void setCemeApplyId(String cemeApplyId) {
		this.cemeApplyId = cemeApplyId;
	}

	/**
	 * 获取 公墓记录编码
	 * @return String
	 */
	public String getRecordId() {
		return recordId;
	}

	/**
	 * 设置 公墓记录编码
	 */
	public void setRecordId(String recordId) {
		this.recordId = recordId;
	}

	/**
	 * 获取 单位编号
	 * @return String
	 */
	public String getOrganId() {
		return organId;
	}

	/**
	 * 设置 单位编号
	 */
	public void setOrganId(String organId) {
		this.organId = organId;
	}

	/**
	 * 获取 公墓名称
	 * @return String
	 */
	public String getName() {
		return name;
	}

	/**
	 * 设置 公墓名称
	 */
	public void setName(String name) {
		this.name = name;
	}

	/**
	 * 获取 变更理由
	 * @return String
	 */
	public String getChangeReason() {
		return changeReason;
	}

	/**
	 * 设置 变更理由
	 */
	public void setChangeReason(String changeReason) {
		this.changeReason = changeReason;
	}

	/**
	 * 获取 变更备案时间
	 * @return String
	 */
	public String getRegDate() {
		return regDate;
	}

	/**
	 * 设置 变更备案时间
	 */
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	/**
	 * 获取 是否确认
	 * @return String
	 */
	public String getIfConfirm() {
		return ifConfirm;
	}

	/**
	 * 设置 是否确认
	 */
	public void setIfConfirm(String ifConfirm) {
		this.ifConfirm = ifConfirm;
	}

}