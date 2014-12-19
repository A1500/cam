package com.inspur.cams.drel.special.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 特殊困难帮扶单位信息表databean
 * @author 
 * @date 2013-08-12
 */
@Table(tableName = "SPECIALPOOR_SUPPORT_UNIT", keyFields = "supportUnitCode")
public class SpecialpoorSupportUnit extends StatefulDatabean {

	// 帮扶单位代码
	private String supportUnitCode;

	// 单位类型代码
	private String supportUnitTypeCode;

	// 单位类型名称
	private String supportUnitTypeName;

	// 顺序号
	private BigDecimal supportUnitSn;

	// 帮扶单位名称
	private String supportUnitName;

	// 帮扶区县代码
	private String supportCountyCode;

	// 帮扶区县名称
	private String supportCountyName;

	// 帮扶镇级代码
	private String supportTownCode;

	// 帮扶镇级名称
	private String supportTownName;

	// 帮扶村代码
	private String supportVillageCode;

	// 帮扶村名称
	private String supportVillageName;

	/**
	 * 获取 帮扶单位代码
	 * @return String
	 */
	public String getSupportUnitCode() {
		return supportUnitCode;
	}

	/**
	 * 设置 帮扶单位代码
	 */
	public void setSupportUnitCode(String supportUnitCode) {
		this.supportUnitCode = supportUnitCode;
	}

	/**
	 * 获取 单位类型代码
	 * @return String
	 */
	public String getSupportUnitTypeCode() {
		return supportUnitTypeCode;
	}

	/**
	 * 设置 单位类型代码
	 */
	public void setSupportUnitTypeCode(String supportUnitTypeCode) {
		this.supportUnitTypeCode = supportUnitTypeCode;
	}

	/**
	 * 获取 单位类型名称
	 * @return String
	 */
	public String getSupportUnitTypeName() {
		return supportUnitTypeName;
	}

	/**
	 * 设置 单位类型名称
	 */
	public void setSupportUnitTypeName(String supportUnitTypeName) {
		this.supportUnitTypeName = supportUnitTypeName;
	}

	/**
	 * 获取 顺序号
	 * @return BigDecimal
	 */
	public BigDecimal getSupportUnitSn() {
		return supportUnitSn;
	}

	/**
	 * 设置 顺序号
	 */
	public void setSupportUnitSn(BigDecimal supportUnitSn) {
		this.supportUnitSn = supportUnitSn;
	}

	/**
	 * 获取 帮扶单位名称
	 * @return String
	 */
	public String getSupportUnitName() {
		return supportUnitName;
	}

	/**
	 * 设置 帮扶单位名称
	 */
	public void setSupportUnitName(String supportUnitName) {
		this.supportUnitName = supportUnitName;
	}

	/**
	 * 获取 帮扶区县代码
	 * @return String
	 */
	public String getSupportCountyCode() {
		return supportCountyCode;
	}

	/**
	 * 设置 帮扶区县代码
	 */
	public void setSupportCountyCode(String supportCountyCode) {
		this.supportCountyCode = supportCountyCode;
	}

	/**
	 * 获取 帮扶区县名称
	 * @return String
	 */
	public String getSupportCountyName() {
		return supportCountyName;
	}

	/**
	 * 设置 帮扶区县名称
	 */
	public void setSupportCountyName(String supportCountyName) {
		this.supportCountyName = supportCountyName;
	}

	/**
	 * 获取 帮扶镇级代码
	 * @return String
	 */
	public String getSupportTownCode() {
		return supportTownCode;
	}

	/**
	 * 设置 帮扶镇级代码
	 */
	public void setSupportTownCode(String supportTownCode) {
		this.supportTownCode = supportTownCode;
	}

	/**
	 * 获取 帮扶镇级名称
	 * @return String
	 */
	public String getSupportTownName() {
		return supportTownName;
	}

	/**
	 * 设置 帮扶镇级名称
	 */
	public void setSupportTownName(String supportTownName) {
		this.supportTownName = supportTownName;
	}

	/**
	 * 获取 帮扶村代码
	 * @return String
	 */
	public String getSupportVillageCode() {
		return supportVillageCode;
	}

	/**
	 * 设置 帮扶村代码
	 */
	public void setSupportVillageCode(String supportVillageCode) {
		this.supportVillageCode = supportVillageCode;
	}

	/**
	 * 获取 帮扶村名称
	 * @return String
	 */
	public String getSupportVillageName() {
		return supportVillageName;
	}

	/**
	 * 设置 帮扶村名称
	 */
	public void setSupportVillageName(String supportVillageName) {
		this.supportVillageName = supportVillageName;
	}

}