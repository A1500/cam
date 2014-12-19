package com.inspur.cams.cdc.base.data;

import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 基层民主与社区建设工作交流databean
 * @author shgtch
 * @date 2012-3-1
 */
@Table(tableName = "CDC_WORK_INFO", keyFields = "workId")
public class CdcWorkInfo extends StatefulDatabean {

	// 通讯录内码
	private String workId;

	// 类别
	private String workType;

	// 主题
	private String name;

	// 内容
	private String content;

	// 单位
	private String organ;

	// 年度
	private String yearly;

	// 分类
	private String kind;

	// 上报人
	private String reportPeople;

	// 上报日期
	private String reportDate;

	// 附件
	private String fileId;

	// 创建单位行政区划
	private String organCode;

	// 创建单位名称
	private String organName;

	// 创建日期
	private String createTime;

	/**
	 * 获取 工作流内码
	 * @return
	 */
	public String getWorkId() {
		return workId;
	}

	/**
	 * 设置 工作流内码
	 * @param workId
	 */
	public void setWorkId(String workId) {
		this.workId = workId;
	}

	/**
	 * 获取 类别
	 * @return
	 */
	public String getWorkType() {
		return workType;
	}

	/**
	 * 设置 类别
	 * @param workType
	 */
	public void setWorkType(String workType) {
		this.workType = workType;
	}

	/**
	 * 获取 主题
	 * @return
	 */
	public String getName() {
		return name;
	}

	/**
	 * 设置 主题
	 * @param name
	 */
	public void setName(String name) {
		this.name = name;
	}

	/**
	 * 获取 内容
	 * @return
	 */
	public String getContent() {
		return content;
	}

	/**
	 * 设置 内容
	 * @param content
	 */
	public void setContent(String content) {
		this.content = content;
	}

	/**
	 * 获取 单位
	 * @return
	 */
	public String getOrgan() {
		return organ;
	}

	/**
	 * 设置 单位
	 * @param organ
	 */
	public void setOrgan(String organ) {
		this.organ = organ;
	}

	/**
	 * 获取 年度
	 * @return
	 */
	public String getYearly() {
		return yearly;
	}

	/**
	 * 设置 年度
	 * @param yearly
	 */
	public void setYearly(String yearly) {
		this.yearly = yearly;
	}

	/**
	 * 获取 分类
	 * @return
	 */
	public String getKind() {
		return kind;
	}

	/**
	 * 设置 分类
	 * @param kind
	 */
	public void setKind(String kind) {
		this.kind = kind;
	}

	/**
	 * 获取 上报人
	 * @return
	 */
	public String getReportPeople() {
		return reportPeople;
	}

	/**
	 * 设置 上报人
	 * @param reportPeople
	 */
	public void setReportPeople(String reportPeople) {
		this.reportPeople = reportPeople;
	}

	/**
	 * 获取 上报日期
	 * @return
	 */
	public String getReportDate() {
		return reportDate;
	}

	/**
	 * 设置 上报日期
	 * @param reportDate
	 */
	public void setReportDate(String reportDate) {
		this.reportDate = reportDate;
	}

	/**
	 * 获取 附件
	 * @return
	 */
	public String getFileId() {
		return fileId;
	}

	/**
	 * 设置 附件
	 * @param fileId
	 */
	public void setFileId(String fileId) {
		this.fileId = fileId;
	}

	/**
	 * 获取 创建单位行政区划
	 * @return
	 */
	public String getOrganCode() {
		return organCode;
	}

	/**
	 * 设置 创建单位行政区划
	 * @param organCode
	 */
	public void setOrganCode(String organCode) {
		this.organCode = organCode;
	}

	/**
	 * 获取 创建单位名称
	 * @return
	 */
	public String getOrganName() {
		return organName;
	}

	/**
	 * 设置 创建单位名称
	 * @param organName
	 */
	public void setOrganName(String organName) {
		this.organName = organName;
	}

	/**
	 * 获取 创建时间
	 * @return
	 */
	public String getCreateTime() {
		return createTime;
	}

	/**
	 * 设置 创建时间
	 * @param createTime
	 */
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

}