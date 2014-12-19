package com.inspur.cams.drel.archive.samfamilyhousearchive.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 基础信息_房屋信息databean
 * @author 
 * @date 2012-06-28
 */
@Table(tableName = "SAM_FAMILY_HOUSE_ARCHIVE", keyFields = "houseArchiveId")
public class SamFamilyHouseArchive extends StatefulDatabean {

	// 住房归档ID
	private String houseArchiveId;

	// 住房ID
	private String houseId;
	
	//家庭归档id
	private String familyArchiveId;

	// 产权证编号
	private String propertyCertificate;

	// 产权人
	private String propertyOwner;

	// 住房结构
	private String houseStructure;

	// 产权类型
	private String propertyType;

	// 住房类型
	private String houseQuality;

	// 住房状况类型
	private String houseStatus;

	// 房屋构造
	private String houseStructureType;

	// 房屋间数
	private String houseNumber;

	// 住房建筑时间
	private String buildingDate;

	// 是否享受购建房补助
	private String buildingSubsidyFlag;

	// 住房地址
	private String houseAdd;

	// 建筑面积
	private BigDecimal buildArea;

	// 使用面积
	private BigDecimal useArea;

	// 房屋价值
	private BigDecimal houseValue;

	// 备注
	private String note;

	// 申请ID
	private String applyId;

	/**
	 * 获取 住房归档ID
	 * @return String
	 */
	public String getHouseArchiveId() {
		return houseArchiveId;
	}

	/**
	 * 设置 住房归档ID
	 */
	public void setHouseArchiveId(String houseArchiveId) {
		this.houseArchiveId = houseArchiveId;
	}

	/**
	 * 获取 住房ID
	 * @return String
	 */
	public String getHouseId() {
		return houseId;
	}

	/**
	 * 设置 住房ID
	 */
	public void setHouseId(String houseId) {
		this.houseId = houseId;
	}


	/**
	 * 获取 产权证编号
	 * @return String
	 */
	public String getPropertyCertificate() {
		return propertyCertificate;
	}

	/**
	 * 设置 产权证编号
	 */
	public void setPropertyCertificate(String propertyCertificate) {
		this.propertyCertificate = propertyCertificate;
	}

	/**
	 * 获取 产权人
	 * @return String
	 */
	public String getPropertyOwner() {
		return propertyOwner;
	}

	/**
	 * 设置 产权人
	 */
	public void setPropertyOwner(String propertyOwner) {
		this.propertyOwner = propertyOwner;
	}

	/**
	 * 获取 住房结构
	 * @return String
	 */
	public String getHouseStructure() {
		return houseStructure;
	}

	/**
	 * 设置 住房结构
	 */
	public void setHouseStructure(String houseStructure) {
		this.houseStructure = houseStructure;
	}

	/**
	 * 获取 产权类型
	 * @return String
	 */
	public String getPropertyType() {
		return propertyType;
	}

	/**
	 * 设置 产权类型
	 */
	public void setPropertyType(String propertyType) {
		this.propertyType = propertyType;
	}

	/**
	 * 获取 住房类型
	 * @return String
	 */
	public String getHouseQuality() {
		return houseQuality;
	}

	/**
	 * 设置 住房类型
	 */
	public void setHouseQuality(String houseQuality) {
		this.houseQuality = houseQuality;
	}

	/**
	 * 获取 住房状况类型
	 * @return String
	 */
	public String getHouseStatus() {
		return houseStatus;
	}

	/**
	 * 设置 住房状况类型
	 */
	public void setHouseStatus(String houseStatus) {
		this.houseStatus = houseStatus;
	}

	/**
	 * 获取 房屋构造
	 * @return String
	 */
	public String getHouseStructureType() {
		return houseStructureType;
	}

	/**
	 * 设置 房屋构造
	 */
	public void setHouseStructureType(String houseStructureType) {
		this.houseStructureType = houseStructureType;
	}

	/**
	 * 获取 房屋间数
	 * @return String
	 */
	public String getHouseNumber() {
		return houseNumber;
	}

	/**
	 * 设置 房屋间数
	 */
	public void setHouseNumber(String houseNumber) {
		this.houseNumber = houseNumber;
	}

	/**
	 * 获取 住房建筑时间
	 * @return String
	 */
	public String getBuildingDate() {
		return buildingDate;
	}

	/**
	 * 设置 住房建筑时间
	 */
	public void setBuildingDate(String buildingDate) {
		this.buildingDate = buildingDate;
	}

	/**
	 * 获取 是否享受购建房补助
	 * @return String
	 */
	public String getBuildingSubsidyFlag() {
		return buildingSubsidyFlag;
	}

	/**
	 * 设置 是否享受购建房补助
	 */
	public void setBuildingSubsidyFlag(String buildingSubsidyFlag) {
		this.buildingSubsidyFlag = buildingSubsidyFlag;
	}

	/**
	 * 获取 住房地址
	 * @return String
	 */
	public String getHouseAdd() {
		return houseAdd;
	}

	/**
	 * 设置 住房地址
	 */
	public void setHouseAdd(String houseAdd) {
		this.houseAdd = houseAdd;
	}

	/**
	 * 获取 建筑面积
	 * @return BigDecimal
	 */
	public BigDecimal getBuildArea() {
		return buildArea;
	}

	/**
	 * 设置 建筑面积
	 */
	public void setBuildArea(BigDecimal buildArea) {
		this.buildArea = buildArea;
	}

	/**
	 * 获取 使用面积
	 * @return BigDecimal
	 */
	public BigDecimal getUseArea() {
		return useArea;
	}

	/**
	 * 设置 使用面积
	 */
	public void setUseArea(BigDecimal useArea) {
		this.useArea = useArea;
	}

	/**
	 * 获取 房屋价值
	 * @return BigDecimal
	 */
	public BigDecimal getHouseValue() {
		return houseValue;
	}

	/**
	 * 设置 房屋价值
	 */
	public void setHouseValue(BigDecimal houseValue) {
		this.houseValue = houseValue;
	}

	/**
	 * 获取 备注
	 * @return String
	 */
	public String getNote() {
		return note;
	}

	/**
	 * 设置 备注
	 */
	public void setNote(String note) {
		this.note = note;
	}

	/**
	 * 获取 申请ID
	 * @return String
	 */
	public String getApplyId() {
		return applyId;
	}

	/**
	 * 设置 申请ID
	 */
	public void setApplyId(String applyId) {
		this.applyId = applyId;
	}

	public String getFamilyArchiveId() {
		return familyArchiveId;
	}

	public void setFamilyArchiveId(String familyArchiveId) {
		this.familyArchiveId = familyArchiveId;
	}

}