package com.inspur.sdmz.jtxx.data;

import java.math.BigDecimal;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:SamFamilyAssistance
 * @description:房屋基本信息
 * @author:licb
 * @since:2011-11-07	
 * @version:1.0
*/
 @Table(tableName = "SAM_FAMILY_HOUSE" , keyFields ={"houseId"} )
public class SamFamilyHouse extends StatefulDatabean {

	   //住房ID
		@Column(name = "HOUSE_ID")
	   private String houseId;
	   //家庭ID
		@Column(name = "FAMILY_ID"	)
	   private String familyId;
	   //产权证编号
		@Column(name = "PROPERTY_CERTIFICATE")
	   private String propertyCertificate;
	    //产权人
		@Column(name = "PROPERTY_OWNER")
	   private String propertyOwner;
	   //住房结构
		@Column(name = "HOUSE_STRUCTURE")
	   private String houseStructure;
	   //产权类型
		@Column(name = "PROPERTY_TYPE")
	   private String propertyType;
        //住房类型
		@Column(name = "HOUSE_QUALITY")
	   private String houseQuality;
	   //住房状况类型
		@Column(name = "HOUSE_STATUS"	)
	   private String houseStatus;
	   //房屋构造
		@Column(name = "HOUSE_STRUCTURE_TYPE")
	   private String houseStructureType;
		 //房屋间数
		@Column(name = "HOUSE_NUMBER")
	   private String houseNumber;
	   //住房建筑时间
		@Column(name = "BUILDING_DATE"	)
	   private String buildingDate;
	   //是否享受购建房补助
		@Column(name = "BUILDING_SUBSIDY_FLAG")
	   private String buildingSubsidyFlag;
		 //住房地址
		@Column(name = "HOUSE_ADD")
	   private String houseAdd;
	   //建筑面积
		@Column(name = "BUILD_AREA"	)
	   private BigDecimal buildArea;
	   //使用面积
		@Column(name = "USE_AREA")
	   private BigDecimal useArea;
		//房屋价值
		@Column(name = "HOUSE_VALUE"	)
	   private BigDecimal houseValue;
	   //备注
		@Column(name = "NOTE")
		private String note;
		public String getHouseId() {
			return houseId;
		}
		public void setHouseId(String houseId) {
			this.houseId = houseId;
		}
		public String getFamilyId() {
			return familyId;
		}
		public void setFamilyId(String familyId) {
			this.familyId = familyId;
		}
		public String getPropertyCertificate() {
			return propertyCertificate;
		}
		public void setPropertyCertificate(String propertyCertificate) {
			this.propertyCertificate = propertyCertificate;
		}
		public String getPropertyOwner() {
			return propertyOwner;
		}
		public void setPropertyOwner(String propertyOwner) {
			this.propertyOwner = propertyOwner;
		}
		public String getHouseStructure() {
			return houseStructure;
		}
		public void setHouseStructure(String houseStructure) {
			this.houseStructure = houseStructure;
		}
		public String getPropertyType() {
			return propertyType;
		}
		public void setPropertyType(String propertyType) {
			this.propertyType = propertyType;
		}
		public String getHouseQuality() {
			return houseQuality;
		}
		public void setHouseQuality(String houseQuality) {
			this.houseQuality = houseQuality;
		}
		public String getHouseStatus() {
			return houseStatus;
		}
		public void setHouseStatus(String houseStatus) {
			this.houseStatus = houseStatus;
		}
		public String getHouseStructureType() {
			return houseStructureType;
		}
		public void setHouseStructureType(String houseStructureType) {
			this.houseStructureType = houseStructureType;
		}
		public String getHouseNumber() {
			return houseNumber;
		}
		public void setHouseNumber(String houseNumber) {
			this.houseNumber = houseNumber;
		}
		public String getBuildingDate() {
			return buildingDate;
		}
		public void setBuildingDate(String buildingDate) {
			this.buildingDate = buildingDate;
		}
		public String getBuildingSubsidyFlag() {
			return buildingSubsidyFlag;
		}
		public void setBuildingSubsidyFlag(String buildingSubsidyFlag) {
			this.buildingSubsidyFlag = buildingSubsidyFlag;
		}
		public String getHouseAdd() {
			return houseAdd;
		}
		public void setHouseAdd(String houseAdd) {
			this.houseAdd = houseAdd;
		}
		
		public BigDecimal getUseArea() {
			return useArea;
		}
		public void setUseArea(BigDecimal useArea) {
			this.useArea = useArea;
		}
		public BigDecimal getHouseValue() {
			return houseValue;
		}
		public void setHouseValue(BigDecimal houseValue) {
			this.houseValue = houseValue;
		}
		public String getNote() {
			return note;
		}
		public void setNote(String note) {
			this.note = note;
		}
		public BigDecimal getBuildArea() {
			return buildArea;
		}
		public void setBuildArea(BigDecimal buildArea) {
			this.buildArea = buildArea;
		}
}