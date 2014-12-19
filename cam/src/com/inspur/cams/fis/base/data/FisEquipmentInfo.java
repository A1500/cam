package com.inspur.cams.fis.base.data;

import java.math.BigDecimal;

import org.loushang.next.dao.*;
import org.loushang.next.data.*;
/**
 * @Path com.inspur.cams.fis.base.data.FisEquipmentInfo  
 * @Description: TODO 殡葬业务设备表
 * @author wangziming
 * @date 2011-11-16
 */
 @Table(tableName = "fis_equipment_info" , keyFields = "equipmentId")
public class FisEquipmentInfo extends StatefulDatabean {
   //设备内码
   //@Rule(value="require")
	@Column(name = "equipment_Id")
   private String equipmentId;
   //资源分类编号
	@Column(name = "resource_Type")
   private String resourceType;
   //设备编号
	@Column(name = "equipment_Code")
   private String equipmentCode;
   //设备名称
	@Column(name = "equipment_Name")
   private String equipmentName;
   //设备厂商
	@Column(name = "manufacturer")
   private String manufacturer;
   //厂商联系电话
	@Column(name = "phone")
   private String phone;
   //规格型号
	@Column(name = "equipment_Format")
   private String equipmentFormat;
   //签定文号
	@Column(name = "file_Code")
   private String fileCode;
   //采购价格
	@Column(name = "purchase_Money")
   private BigDecimal purchaseMoney;
   //采购单位
	@Column(name = "purchase_Organ")
   private String purchaseOrgan;
   //采购日期
	@Column(name = "purchase_Date")
   private String purchaseDate;
   //投入使用日期
	@Column(name = "use_Date")
   private String useDate;
   //报废日期
	@Column(name = "scrap_Date")
   private String scrapDate;
   //设备状态
   	@Rule(value="require")
	@Column(name = "status")
   private String status;
   //描述
	@Column(name = "equipment_Desc")
   private String equipmentDesc;
   //备注
	@Column(name = "note")
   private String note;
   //登记单位
	@Column(name = "create_Organ")
   private String createOrgan;
   //登记单位名称
	@Column(name = "create_Organ_Name")
   private String createOrganName;
   //登记人
	@Column(name = "create_People")
   private String createPeople;
   //登记人姓名
	@Column(name = "create_People_Name")
   private String createPeopleName;
   //登记时间
	@Column(name = "create_Time")
   private String createTime;
	
	@Transient
	private String ifLevel;
	
   public String getIfLevel() {
		return ifLevel;
	}
	public void setIfLevel(String ifLevel) {
		this.ifLevel = ifLevel;
	}
/**
    * getter for 设备内码
    * @generated
    */
   public String getEquipmentId(){
      return this.equipmentId;
   }
   /**
    * setter for 设备内码
    * @generated
    */
   public void setEquipmentId(String equipmentId){
      this.equipmentId = equipmentId;
   }

   /**
    * getter for 资源分类编号
    * @generated
    */
   public String getResourceType(){
      return this.resourceType;
   }
   /**
    * setter for 资源分类编号
    * @generated
    */
   public void setResourceType(String resourceType){
      this.resourceType = resourceType;
   }

   /**
    * getter for 设备编号
    * @generated
    */
   public String getEquipmentCode(){
      return this.equipmentCode;
   }
   /**
    * setter for 设备编号
    * @generated
    */
   public void setEquipmentCode(String equipmentCode){
      this.equipmentCode = equipmentCode;
   }

   /**
    * getter for 设备名称
    * @generated
    */
   public String getEquipmentName(){
      return this.equipmentName;
   }
   /**
    * setter for 设备名称
    * @generated
    */
   public void setEquipmentName(String equipmentName){
      this.equipmentName = equipmentName;
   }

   /**
    * getter for 设备厂商
    * @generated
    */
   public String getManufacturer(){
      return this.manufacturer;
   }
   /**
    * setter for 设备厂商
    * @generated
    */
   public void setManufacturer(String manufacturer){
      this.manufacturer = manufacturer;
   }

   /**
    * getter for 厂商联系电话
    * @generated
    */
   public String getPhone(){
      return this.phone;
   }
   /**
    * setter for 厂商联系电话
    * @generated
    */
   public void setPhone(String phone){
      this.phone = phone;
   }

   /**
    * getter for 规格型号
    * @generated
    */
   public String getEquipmentFormat(){
      return this.equipmentFormat;
   }
   /**
    * setter for 规格型号
    * @generated
    */
   public void setEquipmentFormat(String equipmentFormat){
      this.equipmentFormat = equipmentFormat;
   }

   /**
    * getter for 签定文号
    * @generated
    */
   public String getFileCode(){
      return this.fileCode;
   }
   /**
    * setter for 签定文号
    * @generated
    */
   public void setFileCode(String fileCode){
      this.fileCode = fileCode;
   }

   /**
    * getter for 采购价格
    * @generated
    */
   public BigDecimal getPurchaseMoney(){
      return this.purchaseMoney;
   }
   /**
    * setter for 采购价格
    * @generated
    */
   public void setPurchaseMoney(BigDecimal purchaseMoney){
      this.purchaseMoney = purchaseMoney;
   }

   /**
    * getter for 采购单位
    * @generated
    */
   public String getPurchaseOrgan(){
      return this.purchaseOrgan;
   }
   /**
    * setter for 采购单位
    * @generated
    */
   public void setPurchaseOrgan(String purchaseOrgan){
      this.purchaseOrgan = purchaseOrgan;
   }

   /**
    * getter for 采购日期
    * @generated
    */
   public String getPurchaseDate(){
      return this.purchaseDate;
   }
   /**
    * setter for 采购日期
    * @generated
    */
   public void setPurchaseDate(String purchaseDate){
      this.purchaseDate = purchaseDate;
   }

   /**
    * getter for 投入使用日期
    * @generated
    */
   public String getUseDate(){
      return this.useDate;
   }
   /**
    * setter for 投入使用日期
    * @generated
    */
   public void setUseDate(String useDate){
      this.useDate = useDate;
   }

   /**
    * getter for 报废日期
    * @generated
    */
   public String getScrapDate(){
      return this.scrapDate;
   }
   /**
    * setter for 报废日期
    * @generated
    */
   public void setScrapDate(String scrapDate){
      this.scrapDate = scrapDate;
   }

   /**
    * getter for 设备状态
    * @generated
    */
   public String getStatus(){
      return this.status;
   }
   /**
    * setter for 设备状态
    * @generated
    */
   public void setStatus(String status){
      this.status = status;
   }

   /**
    * getter for 描述
    * @generated
    */
   public String getEquipmentDesc(){
      return this.equipmentDesc;
   }
   /**
    * setter for 描述
    * @generated
    */
   public void setEquipmentDesc(String equipmentDesc){
      this.equipmentDesc = equipmentDesc;
   }

   /**
    * getter for 备注
    * @generated
    */
   public String getNote(){
      return this.note;
   }
   /**
    * setter for 备注
    * @generated
    */
   public void setNote(String note){
      this.note = note;
   }

   /**
    * getter for 登记单位
    * @generated
    */
   public String getCreateOrgan(){
      return this.createOrgan;
   }
   /**
    * setter for 登记单位
    * @generated
    */
   public void setCreateOrgan(String createOrgan){
      this.createOrgan = createOrgan;
   }

   /**
    * getter for 登记单位名称
    * @generated
    */
   public String getCreateOrganName(){
      return this.createOrganName;
   }
   /**
    * setter for 登记单位名称
    * @generated
    */
   public void setCreateOrganName(String createOrganName){
      this.createOrganName = createOrganName;
   }

   /**
    * getter for 登记人
    * @generated
    */
   public String getCreatePeople(){
      return this.createPeople;
   }
   /**
    * setter for 登记人
    * @generated
    */
   public void setCreatePeople(String createPeople){
      this.createPeople = createPeople;
   }

   /**
    * getter for 登记人姓名
    * @generated
    */
   public String getCreatePeopleName(){
      return this.createPeopleName;
   }
   /**
    * setter for 登记人姓名
    * @generated
    */
   public void setCreatePeopleName(String createPeopleName){
      this.createPeopleName = createPeopleName;
   }

   /**
    * getter for 登记时间
    * @generated
    */
   public String getCreateTime(){
      return this.createTime;
   }
   /**
    * setter for 登记时间
    * @generated
    */
   public void setCreateTime(String createTime){
      this.createTime = createTime;
   }

}