package com.inspur.cams.comm.brief.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 快报简报数量表databean
 * @author 
 * @date 2014-03-04
 */
@Table(tableName = "CAMS_BRIEF_COUNT", keyFields = "countId")
public class CamsBriefCount extends StatefulDatabean {

	// 数量ID
	private String countId;

	// 配置ID
	private String configId;
	
	// 期数ID
	private String seasonId;

	// 填报期数
	private String reportSeason;

	// 录入名称
	private String enterName;

	// 显示名称
	private String showName;

	// 单位
	private String unit;

	// 数量
	private BigDecimal count;
	
	// 是否加粗
	private String ifBold;
	
	// 缩进级别
	private String indentLevel;
	
	// 指标代码
	private String indexCode;
	
	// 录入顺序号
	private BigDecimal enterSerialNum;

	// 展示顺序号
	private BigDecimal showSerialNum;
	
	// 地区编码
	private String organArea;

	// 地区名称
	private String organName;

	/**
	 * 获取 数量ID
	 * @return String
	 */
	public String getCountId() {
		return countId;
	}

	public String getIndexCode() {
		return indexCode;
	}

	public void setIndexCode(String indexCode) {
		this.indexCode = indexCode;
	}

	public BigDecimal getEnterSerialNum() {
		return enterSerialNum;
	}

	public void setEnterSerialNum(BigDecimal enterSerialNum) {
		this.enterSerialNum = enterSerialNum;
	}

	public BigDecimal getShowSerialNum() {
		return showSerialNum;
	}

	public void setShowSerialNum(BigDecimal showSerialNum) {
		this.showSerialNum = showSerialNum;
	}

	/**
	 * 设置 数量ID
	 */
	public void setCountId(String countId) {
		this.countId = countId;
	}

	/**
	 * 获取 配置ID
	 * @return String
	 */
	public String getConfigId() {
		return configId;
	}

	/**
	 * 设置 配置ID
	 */
	public void setConfigId(String configId) {
		this.configId = configId;
	}

	/**
	 * 获取 填报期数
	 * @return String
	 */
	public String getReportSeason() {
		return reportSeason;
	}

	/**
	 * 设置 填报期数
	 */
	public void setReportSeason(String reportSeason) {
		this.reportSeason = reportSeason;
	}

	/**
	 * 获取 录入名称
	 * @return String
	 */
	public String getEnterName() {
		return enterName;
	}

	/**
	 * 设置 录入名称
	 */
	public void setEnterName(String enterName) {
		this.enterName = enterName;
	}

	/**
	 * 获取 显示名称
	 * @return String
	 */
	public String getShowName() {
		return showName;
	}

	/**
	 * 设置 显示名称
	 */
	public void setShowName(String showName) {
		this.showName = showName;
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
	 * 获取 数量
	 * @return BigDecimal
	 */
	public BigDecimal getCount() {
		return count;
	}

	/**
	 * 设置 数量
	 */
	public void setCount(BigDecimal count) {
		this.count = count;
	}

	public String getIfBold() {
		return ifBold;
	}

	public void setIfBold(String ifBold) {
		this.ifBold = ifBold;
	}

	public String getIndentLevel() {
		return indentLevel;
	}

	public void setIndentLevel(String indentLevel) {
		this.indentLevel = indentLevel;
	}

	public String getOrganArea() {
		return organArea;
	}

	public void setOrganArea(String organArea) {
		this.organArea = organArea;
	}

	public String getOrganName() {
		return organName;
	}

	public void setOrganName(String organName) {
		this.organName = organName;
	}

	public String getSeasonId() {
		return seasonId;
	}

	public void setSeasonId(String seasonId) {
		this.seasonId = seasonId;
	}

}