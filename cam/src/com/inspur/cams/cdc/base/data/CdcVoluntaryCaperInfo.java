package com.inspur.cams.cdc.base.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 志愿者参加活动信息databean
 * 
 * @author
 * @date 2013-02-26
 */
@Table(tableName = "CDC_VOLUNTARY_CAPER_INFO", keyFields = "recordId")
public class CdcVoluntaryCaperInfo extends StatefulDatabean {

	// 关系内码
	private String recordId;

	// 志愿者编号
	private String voluntaryId;

	// 活动编号
	private String caperId;

	// 开始时间
	private String startTime;

	// 结束时间
	private String endTime;

	// 时间间隔-分
	private BigDecimal diffTimes;

	/**
	 * 获取 关系内码
	 * 
	 * @return String
	 */
	public String getRecordId() {
		return recordId;
	}

	/**
	 * 设置 关系内码
	 */
	public void setRecordId(String recordId) {
		this.recordId = recordId;
	}

	/**
	 * 获取 志愿者编号
	 * 
	 * @return String
	 */
	public String getVoluntaryId() {
		return voluntaryId;
	}

	/**
	 * 设置 志愿者编号
	 */
	public void setVoluntaryId(String voluntaryId) {
		this.voluntaryId = voluntaryId;
	}

	/**
	 * 获取 活动编号
	 * 
	 * @return String
	 */
	public String getCaperId() {
		return caperId;
	}

	/**
	 * 设置 活动编号
	 */
	public void setCaperId(String caperId) {
		this.caperId = caperId;
	}

	public String getStartTime() {
		return startTime;
	}

	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

	public String getEndTime() {
		return endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	public BigDecimal getDiffTimes() {
		return diffTimes;
	}

	public void setDiffTimes(BigDecimal diffTimes) {
		this.diffTimes = diffTimes;
	}

}