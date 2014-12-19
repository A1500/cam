package com.inspur.cams.fis.base.data;

import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * @title:FisGlobalConfig
 * @description:
 * @author:
 * @since:2011-12-15
 * @version:1.0
*/
 @Table(tableName = "FIS_GLOBAL_CONFIG" ,keyFields = "isRegDrive")
public class FisGlobalConfig extends StatefulDatabean {
   //登记派工-接运
	@Column(name = "IS_REG_DRIVE")
   private String isRegDrive;
   //登记派工-保存
	@Column(name = "IS_REG_STORAGE")
   private String isRegStorage;
   //登记派工-整容
	@Column(name = "IS_REG_COSMETIC")
   private String isRegCosmetic;
   //登记派工-告别
	@Column(name = "IS_REG_FAREWELL")
   private String isRegFarewell;
   //登记派工-火化
	@Column(name = "IS_REG_CREMATION")
   private String isRegCremation;
   //确认派工-接运
	@Column(name = "IS_AUTO_COMMIT_DRIVE")
   private String isAutoCommitDrive;
   //确认派工-保存
	@Column(name = "IS_AUTO_COMMIT_STORAGE")
   private String isAutoCommitStorage;
   //确认派工-整容
	@Column(name = "IS_AUTO_COMMIT_COSMETIC")
   private String isAutoCommitCosmetic;
   //确认派工-告别
	@Column(name = "IS_AUTO_COMMIT_FAREWELL")
   private String isAutoCommitFarewell;
   //确认派工-火化
	@Column(name = "IS_AUTO_COMMIT_CREMATION")
   private String isAutoCommitCremation;
   //接运默认时间间隔
	@Column(name = "DRIVE_INTERVAL")
   private BigDecimal driveInterval;
   //保存默认时间间隔
	@Column(name = "STORAGE_INTERVAL")
   private BigDecimal storageInterval;
   //告别默认时间间隔
	@Column(name = "FAREWELL_INTERVAL")
   private BigDecimal farewellInterval;
   //火化默认时间间隔
	@Column(name = "CREMATION_INTERVAL")
   private BigDecimal cremationInterval;
   //寄存默认时间
	@Column(name = "EMPLACING_INTERVAL")
   private BigDecimal emplacingInterval;
	//是否自动接收逝者
	@Column(name = "IS_AUTO_RECEIVE")
   private BigDecimal isAutoReceive;
	
   //缴清费用时，是否自动完成接运
	@Column(name = "FEE_IS_AUTO_COMMIT_DRIVE")
   private BigDecimal feeIsAutoCommitDrive;
   //缴清费用时，是否自动完成保存
	@Column(name = "FEE_IS_AUTO_COMMIT_STORAGE")
   private BigDecimal feeIsAutoCommitStorage;
   //缴清费用时，是否自动完成告别
	@Column(name = "FEE_IS_AUTO_COMMIT_COSMETIC")
   private BigDecimal feeIsAutoCommitCosmetic;
   //缴清费用时，是否自动完成整容
	@Column(name = "FEE_IS_AUTO_COMMIT_FAREWELL")
   private BigDecimal feeIsAutoCommitFarewell;
   //缴清费用时，是否自动完成火化
	@Column(name = "FEE_IS_AUTO_COMMIT_CREMATION")
   private BigDecimal feeIsAutoCommitCremation;
	//缴清费用时，是否自动完成领灰
	@Column(name = "FEE_IS_AUTO_COMMIT_ASHES")
   private BigDecimal feeIsAutoCommitAshes;
	//寄存业务办理时，是否可以收费
	@Column(name = "IS_ENABLE_FEE_FOR_EMPLACING")
   private BigDecimal isEnableFeeForEmplacing;
	//殡仪业务办理时，是否可以收费
	@Column(name = "IS_ENABLE_FEE_FOR_FUNERAL")
   private BigDecimal isEnableFeeForFuneral;
	

	//默认机构编号(F-殡仪馆-默认，C-公墓，S-服务机构)
	@Column(name = "DEFAULT_ORGAN_FLAG")
   private String defaultOrganFlag;
	
   /**
    * getter for IS_REG_DRIVE
    * @generated
    */
   public String getIsRegDrive(){
      return this.isRegDrive;
   }
   /**
    * setter for IS_REG_DRIVE
    * @generated
    */
   public void setIsRegDrive(String isRegDrive){
      this.isRegDrive = isRegDrive;
   }

   /**
    * getter for IS_REG_STORAGE
    * @generated
    */
   public String getIsRegStorage(){
      return this.isRegStorage;
   }
   /**
    * setter for IS_REG_STORAGE
    * @generated
    */
   public void setIsRegStorage(String isRegStorage){
      this.isRegStorage = isRegStorage;
   }

   /**
    * getter for IS_REG_COSMETIC
    * @generated
    */
   public String getIsRegCosmetic(){
      return this.isRegCosmetic;
   }
   /**
    * setter for IS_REG_COSMETIC
    * @generated
    */
   public void setIsRegCosmetic(String isRegCosmetic){
      this.isRegCosmetic = isRegCosmetic;
   }

   /**
    * getter for IS_REG_FAREWELL
    * @generated
    */
   public String getIsRegFarewell(){
      return this.isRegFarewell;
   }
   /**
    * setter for IS_REG_FAREWELL
    * @generated
    */
   public void setIsRegFarewell(String isRegFarewell){
      this.isRegFarewell = isRegFarewell;
   }

   /**
    * getter for IS_REG_CREMATION
    * @generated
    */
   public String getIsRegCremation(){
      return this.isRegCremation;
   }
   /**
    * setter for IS_REG_CREMATION
    * @generated
    */
   public void setIsRegCremation(String isRegCremation){
      this.isRegCremation = isRegCremation;
   }

   /**
    * getter for IS_AUTO_COMMIT_DRIVE
    * @generated
    */
   public String getIsAutoCommitDrive(){
      return this.isAutoCommitDrive;
   }
   /**
    * setter for IS_AUTO_COMMIT_DRIVE
    * @generated
    */
   public void setIsAutoCommitDrive(String isAutoCommitDrive){
      this.isAutoCommitDrive = isAutoCommitDrive;
   }

   /**
    * getter for IS_AUTO_COMMIT_STORAGE
    * @generated
    */
   public String getIsAutoCommitStorage(){
      return this.isAutoCommitStorage;
   }
   /**
    * setter for IS_AUTO_COMMIT_STORAGE
    * @generated
    */
   public void setIsAutoCommitStorage(String isAutoCommitStorage){
      this.isAutoCommitStorage = isAutoCommitStorage;
   }

   /**
    * getter for IS_AUTO_COMMIT_COSMETIC
    * @generated
    */
   public String getIsAutoCommitCosmetic(){
      return this.isAutoCommitCosmetic;
   }
   /**
    * setter for IS_AUTO_COMMIT_COSMETIC
    * @generated
    */
   public void setIsAutoCommitCosmetic(String isAutoCommitCosmetic){
      this.isAutoCommitCosmetic = isAutoCommitCosmetic;
   }

   /**
    * getter for IS_AUTO_COMMIT_FAREWELL
    * @generated
    */
   public String getIsAutoCommitFarewell(){
      return this.isAutoCommitFarewell;
   }
   /**
    * setter for IS_AUTO_COMMIT_FAREWELL
    * @generated
    */
   public void setIsAutoCommitFarewell(String isAutoCommitFarewell){
      this.isAutoCommitFarewell = isAutoCommitFarewell;
   }

   /**
    * getter for IS_AUTO_COMMIT_CREMATION
    * @generated
    */
   public String getIsAutoCommitCremation(){
      return this.isAutoCommitCremation;
   }
   /**
    * setter for IS_AUTO_COMMIT_CREMATION
    * @generated
    */
   public void setIsAutoCommitCremation(String isAutoCommitCremation){
      this.isAutoCommitCremation = isAutoCommitCremation;
   }

   /**
    * getter for DRIVE_INTERVAL
    * @generated
    */
   public BigDecimal getDriveInterval(){
      return this.driveInterval;
   }
   /**
    * setter for DRIVE_INTERVAL
    * @generated
    */
   public void setDriveInterval(BigDecimal driveInterval){
      this.driveInterval = driveInterval;
   }

   /**
    * getter for STORAGE_INTERVAL
    * @generated
    */
   public BigDecimal getStorageInterval(){
      return this.storageInterval;
   }
   /**
    * setter for STORAGE_INTERVAL
    * @generated
    */
   public void setStorageInterval(BigDecimal storageInterval){
      this.storageInterval = storageInterval;
   }

   /**
    * getter for FAREWELL_INTERVAL
    * @generated
    */
   public BigDecimal getFarewellInterval(){
      return this.farewellInterval;
   }
   /**
    * setter for FAREWELL_INTERVAL
    * @generated
    */
   public void setFarewellInterval(BigDecimal farewellInterval){
      this.farewellInterval = farewellInterval;
   }

   /**
    * getter for CREMATION_INTERVAL
    * @generated
    */
   public BigDecimal getCremationInterval(){
      return this.cremationInterval;
   }
   /**
    * setter for CREMATION_INTERVAL
    * @generated
    */
   public void setCremationInterval(BigDecimal cremationInterval){
      this.cremationInterval = cremationInterval;
   }
	public BigDecimal getIsAutoReceive() {
		return isAutoReceive;
	}
	public void setIsAutoReceive(BigDecimal isAutoReceive) {
		this.isAutoReceive = isAutoReceive;
	}
	public BigDecimal getEmplacingInterval() {
		return emplacingInterval;
	}
	public void setEmplacingInterval(BigDecimal emplacingInterval) {
		this.emplacingInterval = emplacingInterval;
	}
	public BigDecimal getFeeIsAutoCommitDrive() {
		return feeIsAutoCommitDrive;
	}
	public void setFeeIsAutoCommitDrive(BigDecimal feeIsAutoCommitDrive) {
		this.feeIsAutoCommitDrive = feeIsAutoCommitDrive;
	}
	public BigDecimal getFeeIsAutoCommitStorage() {
		return feeIsAutoCommitStorage;
	}
	public void setFeeIsAutoCommitStorage(BigDecimal feeIsAutoCommitStorage) {
		this.feeIsAutoCommitStorage = feeIsAutoCommitStorage;
	}
	public BigDecimal getFeeIsAutoCommitCosmetic() {
		return feeIsAutoCommitCosmetic;
	}
	public void setFeeIsAutoCommitCosmetic(BigDecimal feeIsAutoCommitCosmetic) {
		this.feeIsAutoCommitCosmetic = feeIsAutoCommitCosmetic;
	}
	public BigDecimal getFeeIsAutoCommitFarewell() {
		return feeIsAutoCommitFarewell;
	}
	public void setFeeIsAutoCommitFarewell(BigDecimal feeIsAutoCommitFarewell) {
		this.feeIsAutoCommitFarewell = feeIsAutoCommitFarewell;
	}
	public BigDecimal getFeeIsAutoCommitCremation() {
		return feeIsAutoCommitCremation;
	}
	public void setFeeIsAutoCommitCremation(BigDecimal feeIsAutoCommitCremation) {
		this.feeIsAutoCommitCremation = feeIsAutoCommitCremation;
	}
	public BigDecimal getFeeIsAutoCommitAshes() {
		return feeIsAutoCommitAshes;
	}
	public void setFeeIsAutoCommitAshes(BigDecimal feeIsAutoCommitAshes) {
		this.feeIsAutoCommitAshes = feeIsAutoCommitAshes;
	}
	public BigDecimal getIsEnableFeeForEmplacing() {
		return isEnableFeeForEmplacing;
	}
	public void setIsEnableFeeForEmplacing(BigDecimal isEnableFeeForEmplacing) {
		this.isEnableFeeForEmplacing = isEnableFeeForEmplacing;
	}
	public BigDecimal getIsEnableFeeForFuneral() {
		return isEnableFeeForFuneral;
	}
	public void setIsEnableFeeForFuneral(BigDecimal isEnableFeeForFuneral) {
		this.isEnableFeeForFuneral = isEnableFeeForFuneral;
	}
	public String getDefaultOrganFlag() {
		return defaultOrganFlag;
	}
	public void setDefaultOrganFlag(String defaultOrganFlag) {
		this.defaultOrganFlag = defaultOrganFlag;
	}
}