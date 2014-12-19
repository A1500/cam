package com.inspur.cams.cdc.base.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * 基础信息自然状况信息�?databean
 * @author 
 * @date [Mon Dec 19 11:31:22 GMT 2011]
 */
@Table(tableName = "CDC_NATURE_INFO", keyFields = "natureId")
public class CdcNatureInfo extends StatefulDatabean {

	// 自然状况内码
	private String natureId;

	//统计内码
	private String recordId;
	
	// 自然村个�?
	@Rule(value="number")
	private BigDecimal villageNum;
	
	//村民小组数
	@Rule(value="number")
	private BigDecimal groupNum;

	// 辖区总面�?
//	@Rule(value="number")
	private BigDecimal totalArea;

	// 耕地面积
//	@Rule(value="number")
	private BigDecimal ploughArea;

	// 宅基地�?�面�?
//	@Rule(value="number")
	private BigDecimal houseArea;

	// 居住状况
	private String resideStatus;

	// 地理状况
	private String geographyStatus;


	/**
	 * 设置 自然状况内码
	 * @return String
	 */
	public String getNatureId() {
		return natureId;
	}

	/**
	 * 设置 自然状况内码
	 */
	public void setNatureId(String natureId) {
		this.natureId = natureId;
	}

	/**
	 * 设置 自然村个�?
	 * @return BigDecimal
	 */
	public BigDecimal getVillageNum() {
		return villageNum;
	}

	/**
	 * 设置 自然村个�?
	 */
	public void setVillageNum(BigDecimal villageNum) {
		this.villageNum = villageNum;
	}

	/**
	 * 设置 辖区总面�?
	 * @return BigDecimal
	 */
	public BigDecimal getTotalArea() {
		return totalArea;
	}

	/**
	 * 设置 辖区总面�?
	 */
	public void setTotalArea(BigDecimal totalArea) {
		this.totalArea = totalArea;
	}

	/**
	 * 设置 耕地面积
	 * @return BigDecimal
	 */
	public BigDecimal getPloughArea() {
		return ploughArea;
	}

	/**
	 * 设置 耕地面积
	 */
	public void setPloughArea(BigDecimal ploughArea) {
		this.ploughArea = ploughArea;
	}

	/**
	 * 设置 宅基地�?�面�?
	 * @return BigDecimal
	 */
	public BigDecimal getHouseArea() {
		return houseArea;
	}

	/**
	 * 设置 宅基地�?�面�?
	 */
	public void setHouseArea(BigDecimal houseArea) {
		this.houseArea = houseArea;
	}

	/**
	 * 设置 居住状况
	 * @return String
	 */
	public String getResideStatus() {
		return resideStatus;
	}

	/**
	 * 设置 居住状况
	 */
	public void setResideStatus(String resideStatus) {
		this.resideStatus = resideStatus;
	}

	/**
	 * 设置 地理状况
	 * @return String
	 */
	public String getGeographyStatus() {
		return geographyStatus;
	}

	/**
	 * 设置 地理状况
	 */
	public void setGeographyStatus(String geographyStatus) {
		this.geographyStatus = geographyStatus;
	}

	/**
	 * 统计内码
	 * @return
	 */
	public String getRecordId() {
		return recordId;
	}

	/**
	 * 统计内码
	 * @param recordId
	 */
	public void setRecordId(String recordId) {
		this.recordId = recordId;
	}

	/**
	 * 村民小组数
	 * @return
	 */
	public BigDecimal getGroupNum() {
		return groupNum;
	}

	/**
	 * 村民小组数
	 * @param groupNum
	 */
	public void setGroupNum(BigDecimal groupNum) {
		this.groupNum = groupNum;
	}

}