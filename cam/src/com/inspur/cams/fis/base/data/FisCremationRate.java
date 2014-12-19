package com.inspur.cams.fis.base.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 火化率计算表databean
 * @author 
 * @date Thu Apr 19 18:46:28 GMT+08:00 2012
 */
@Table(tableName = "FIS_CREMATION_RATE", keyFields = "recordId")
public class FisCremationRate extends StatefulDatabean {

	// 记录内码
	private String recordId;

	// 区划代码
	private String areaCode;

	// 区划名称
	private String areaName;

	// 年份
	private String sumYear;

	// 总人口数
	private BigDecimal totalNum;

	// 死亡率
	private BigDecimal deadRate;

	// 死亡人口数
	private BigDecimal deadNum;

	// 火化人口数
	private BigDecimal cremationNum;

	// 火化率
	private BigDecimal cremationRate;

	// 填报时间
	private String sumTime;

	// 填报人
	private String sumPeople;

	/**
	 * 获取 记录内码
	 * @return String
	 */
	public String getRecordId() {
		return recordId;
	}

	/**
	 * 设置 记录内码
	 */
	public void setRecordId(String recordId) {
		this.recordId = recordId;
	}

	/**
	 * 获取 区划代码
	 * @return String
	 */
	public String getAreaCode() {
		return areaCode;
	}

	/**
	 * 设置 区划代码
	 */
	public void setAreaCode(String areaCode) {
		this.areaCode = areaCode;
	}

	/**
	 * 获取 区划名称
	 * @return String
	 */
	public String getAreaName() {
		return areaName;
	}

	/**
	 * 设置 区划名称
	 */
	public void setAreaName(String areaName) {
		this.areaName = areaName;
	}

	/**
	 * 获取 年份
	 * @return String
	 */
	public String getSumYear() {
		return sumYear;
	}

	/**
	 * 设置 年份
	 */
	public void setSumYear(String sumYear) {
		this.sumYear = sumYear;
	}

	/**
	 * 获取 总人口数
	 * @return BigDecimal
	 */
	public BigDecimal getTotalNum() {
		return totalNum;
	}

	/**
	 * 设置 总人口数
	 */
	public void setTotalNum(BigDecimal totalNum) {
		this.totalNum = totalNum;
	}

	/**
	 * 获取 死亡率
	 * @return BigDecimal
	 */
	public BigDecimal getDeadRate() {
		return deadRate;
	}

	/**
	 * 设置 死亡率
	 */
	public void setDeadRate(BigDecimal deadRate) {
		this.deadRate = deadRate;
	}

	/**
	 * 获取 死亡人口数
	 * @return BigDecimal
	 */
	public BigDecimal getDeadNum() {
		return deadNum;
	}

	/**
	 * 设置 死亡人口数
	 */
	public void setDeadNum(BigDecimal deadNum) {
		this.deadNum = deadNum;
	}

	/**
	 * 获取 火化人口数
	 * @return BigDecimal
	 */
	public BigDecimal getCremationNum() {
		return cremationNum;
	}

	/**
	 * 设置 火化人口数
	 */
	public void setCremationNum(BigDecimal cremationNum) {
		this.cremationNum = cremationNum;
	}

	/**
	 * 获取 火化率
	 * @return BigDecimal
	 */
	public BigDecimal getCremationRate() {
		return cremationRate;
	}

	/**
	 * 设置 火化率
	 */
	public void setCremationRate(BigDecimal cremationRate) {
		this.cremationRate = cremationRate;
	}

	/**
	 * 获取 填报时间
	 * @return String
	 */
	public String getSumTime() {
		return sumTime;
	}

	/**
	 * 设置 填报时间
	 */
	public void setSumTime(String sumTime) {
		this.sumTime = sumTime;
	}

	/**
	 * 获取 填报人
	 * @return String
	 */
	public String getSumPeople() {
		return sumPeople;
	}

	/**
	 * 设置 填报人
	 */
	public void setSumPeople(String sumPeople) {
		this.sumPeople = sumPeople;
	}

}