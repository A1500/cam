package com.inspur.cams.fis.base.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 公墓撤销备案表databean
 * @author 
 * @date 2013-08-01
 */
@Table(tableName = "FIS_CEME_LOGOFF", keyFields = "logoffId")
public class FisCemeLogoff extends StatefulDatabean {

	// 记录编码
	private String logoffId;

	// 业务审批编码
	private String cemeApplyId;

	// 公墓记录编码
	private String recordId;

	// 单位编号
	private String organId;

	// 公墓名称
	private String name;

	// 撤销时间
	private String logoffDate;

	// 撤销原因
	private String logoffReason;

	// 撤销备案时间
	private String regDate;

	// 是否确认
	private String ifConfirm;
	
	//撤销公墓合格证编号
	private String certificateId;
	
	//撤销公墓合格证发证时间
	private String certificateTime;
	
	/**
	 * 获取 合格证编号
	 * @return certificateId
	 */
	public String getCertificateId() {
		return certificateId;
	}

	/**
	 * 设置 合格证编号
	 * @param certificateId 要设置的 certificateId
	 */
	public void setCertificateId(String certificateId) {
		this.certificateId = certificateId;
	}

	/**
	 * 获取 发证时间
	 * @return certificateTime
	 */
	public String getCertificateTime() {
		return certificateTime;
	}

	/**
	 * 设置 发证时间
	 * @param certificateTime 要设置的 certificateTime
	 */
	public void setCertificateTime(String certificateTime) {
		this.certificateTime = certificateTime;
	}

	/**
	 * 获取 记录编码
	 * @return String
	 */
	public String getLogoffId() {
		return logoffId;
	}

	/**
	 * 设置 记录编码
	 */
	public void setLogoffId(String logoffId) {
		this.logoffId = logoffId;
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
	 * 获取 撤销时间
	 * @return String
	 */
	public String getLogoffDate() {
		return logoffDate;
	}

	/**
	 * 设置 撤销时间
	 */
	public void setLogoffDate(String logoffDate) {
		this.logoffDate = logoffDate;
	}

	/**
	 * 获取 撤销原因
	 * @return String
	 */
	public String getLogoffReason() {
		return logoffReason;
	}

	/**
	 * 设置 撤销原因
	 */
	public void setLogoffReason(String logoffReason) {
		this.logoffReason = logoffReason;
	}

	/**
	 * 获取 撤销备案时间
	 * @return String
	 */
	public String getRegDate() {
		return regDate;
	}

	/**
	 * 设置 撤销备案时间
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