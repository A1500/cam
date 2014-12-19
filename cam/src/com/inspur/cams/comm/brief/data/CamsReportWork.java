package com.inspur.cams.comm.brief.data;

import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 填报期数配置表databean
 * @author 
 * @date 2014-04-23
 */
@Table(tableName = "CAMS_REPORT_WORK", keyFields = "workId")
public class CamsReportWork extends StatefulDatabean {

	// 期数ID
	private String workId;

	// 期数名称
	private String workDesc;

	// 期数状态
	private String status;

	// 创建单位代码
	private String createOrganCode;

	// 创建单位名称
	private String createOrganName;

	// 创建时间
	private String createTime;

	// 填报年份
	private String workYear;

	// 填报季度
	private String workQuarter;

	/**
	 * 获取 期数ID
	 * @return String
	 */
	public String getWorkId() {
		return workId;
	}

	/**
	 * 设置 期数ID
	 */
	public void setWorkId(String workId) {
		this.workId = workId;
	}

	/**
	 * 获取 期数名称
	 * @return String
	 */
	public String getWorkDesc() {
		return workDesc;
	}

	/**
	 * 设置 期数名称
	 */
	public void setWorkDesc(String workDesc) {
		this.workDesc = workDesc;
	}

	/**
	 * 获取 期数状态
	 * @return String
	 */
	public String getStatus() {
		return status;
	}

	/**
	 * 设置 期数状态
	 */
	public void setStatus(String status) {
		this.status = status;
	}

	/**
	 * 获取 创建单位代码
	 * @return String
	 */
	public String getCreateOrganCode() {
		return createOrganCode;
	}

	/**
	 * 设置 创建单位代码
	 */
	public void setCreateOrganCode(String createOrganCode) {
		this.createOrganCode = createOrganCode;
	}

	/**
	 * 获取 创建单位名称
	 * @return String
	 */
	public String getCreateOrganName() {
		return createOrganName;
	}

	/**
	 * 设置 创建单位名称
	 */
	public void setCreateOrganName(String createOrganName) {
		this.createOrganName = createOrganName;
	}

	/**
	 * 获取 创建时间
	 * @return String
	 */
	public String getCreateTime() {
		return createTime;
	}

	/**
	 * 设置 创建时间
	 */
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	/**
	 * 获取 填报年份
	 * @return String
	 */
	public String getWorkYear() {
		return workYear;
	}

	/**
	 * 设置 填报年份
	 */
	public void setWorkYear(String workYear) {
		this.workYear = workYear;
	}

	/**
	 * 获取 填报季度
	 * @return String
	 */
	public String getWorkQuarter() {
		return workQuarter;
	}

	/**
	 * 设置 填报季度
	 */
	public void setWorkQuarter(String workQuarter) {
		this.workQuarter = workQuarter;
	}

}