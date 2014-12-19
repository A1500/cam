package com.inspur.cams.jcm.data;

import java.math.BigDecimal;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 人员简历信息(多条记录)databean
 * @author 
 * @date 2014-05-19
 */
@Table(tableName = "JCM_PEOPLE_RESUME", keyFields = "resumeId")
public class JcmPeopleResume extends StatefulDatabean {

	// 人员主键
	private String peopleId;

	// 简历主键
	private String resumeId;

	// 时间段
	private String timeInfo;

	// 单位
	private String unit;

	// 任职情况
	private String duitInfo;

	/**
	 * 获取 人员主键
	 * @return String
	 */
	public String getPeopleId() {
		return peopleId;
	}

	/**
	 * 设置 人员主键
	 */
	public void setPeopleId(String peopleId) {
		this.peopleId = peopleId;
	}

	/**
	 * 获取 简历主键
	 * @return String
	 */
	public String  getResumeId() {
		return resumeId;
	}

	/**
	 * 设置 简历主键
	 */
	public void setResumeId(String resumeId) {
		this.resumeId = resumeId;
	}

	/**
	 * 获取 时间段
	 * @return String
	 */
	public String getTimeInfo() {
		return timeInfo;
	}

	/**
	 * 设置 时间段
	 */
	public void setTimeInfo(String timeInfo) {
		this.timeInfo = timeInfo;
	}

	/**
	 * 获取 单位
	 * @return String
	 */
	public String getUnit() {
		return unit;
	}

	/**
	 * 设置 单位
	 */
	public void setUnit(String unit) {
		this.unit = unit;
	}

	/**
	 * 获取 任职情况
	 * @return String
	 */
	public String getDuitInfo() {
		return duitInfo;
	}

	/**
	 * 设置 任职情况
	 */
	public void setDuitInfo(String duitInfo) {
		this.duitInfo = duitInfo;
	}

}