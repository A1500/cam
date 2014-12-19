package com.inspur.cams.bpt.bptinstitution.data;

import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * @title:BptHospital
 * @description:
 * @author:
 * @since:2011-06-09
 * @version:1.0
*/
 @Table(tableName = "BPT_HOSPITAL" , keyFields = "hospitalId")
public class BptHospital extends StatefulDatabean {
   //ID
//   	@Rule(value="require")
	@Column(name = "HOSPITAL_ID")
   private String hospitalId;
   //单位全称
   	@Rule(value="require")
	@Column(name = "UNIT_FULLNAME")
   private String unitFullname;
   //行政区划
   	@Rule(value="require")
	@Column(name = "DOMICILE_CODE")
   private String domicileCode;
   //主管部门
	@Column(name = "PERSON_SECTION")
   private String personSection;
   //建立日期
	@Column(name = "CREATION_DATE")
   private String creationDate;
   //注册资产(万元)
   	@Rule(value="require")
	@Column(name = "REGISTER_PROPERTY")
   private String registerProperty;
   //固定资产原值(万元)
   	@Rule(value="require")
	@Column(name = "IMMOBILISATIONS")
   private String immobilisations;
   //占地面积(平方米)
   	@Rule(value="require")
	@Column(name = "FLOOR_AREA")
   private String floorArea;
   //业务用房面积(平方米)
	@Column(name = "BUSINESS_AREA")
   private String businessArea;
   //联系电话
	@Column(name = "TEL_CONTACT")
   private String telContact;
   //邮政编码
	@Column(name = "POSTCODE")
   private String postcode;
   //通信地址
	@Column(name = "MAILING_ADDRESS")
   private String mailingAddress;
   //单位介绍
	@Column(name = "UNIT_INTRODUCE")
   private String unitIntroduce;
   //编制人数
	@Transient
	@Column(name = "PREPARE_NUM")
   private String prepareNum;
   //录入人ID
	@Column(name = "REG_ID")
   private String regId;
   //录入时间
	@Column(name = "REG_TIME")
   private String regTime;
   //修改人ID
	@Column(name = "MOD_ID")
   private String modId;
   //修改时间
	@Column(name = "MOD_TIME")
   private String modTime;
 
	 //行政级别
	@Column(name = "ADMINISTRATIVE_LEVEL")
   private String administrativelevel;
	//单位性质
	@Column(name = "UNITS_NATURE")
   private String unitsnature;

	//录入单位行政区划
	@Column(name = "REG_ORGAN_CODE")
   private String regOrganCode;
	
   public String getAdministrativelevel() {
		return administrativelevel;
	}
	public void setAdministrativelevel(String administrativelevel) {
		this.administrativelevel = administrativelevel;
	}
	public String getUnitsnature() {
		return unitsnature;
	}
	public void setUnitsnature(String unitsnature) {
		this.unitsnature = unitsnature;
	}
/**
    * getter for ID
    * @generated
    */
   public String getHospitalId(){
      return this.hospitalId;
   }
   /**
    * setter for ID
    * @generated
    */
   public void setHospitalId(String hospitalId){
      this.hospitalId = hospitalId;
   }

   /**
    * getter for 单位全称
    * @generated
    */
   public String getUnitFullname(){
      return this.unitFullname;
   }
   /**
    * setter for 单位全称
    * @generated
    */
   public void setUnitFullname(String unitFullname){
      this.unitFullname = unitFullname;
   }

   /**
    * getter for 行政区划
    * @generated
    */
   public String getDomicileCode(){
      return this.domicileCode;
   }
   /**
    * setter for 行政区划
    * @generated
    */
   public void setDomicileCode(String domicileCode){
      this.domicileCode = domicileCode;
   }

   /**
    * getter for 主管部门
    * @generated
    */
   public String getPersonSection(){
      return this.personSection;
   }
   /**
    * setter for 主管部门
    * @generated
    */
   public void setPersonSection(String personSection){
      this.personSection = personSection;
   }

   /**
    * getter for 建立日期
    * @generated
    */
   public String getCreationDate(){
      return this.creationDate;
   }
   /**
    * setter for 建立日期
    * @generated
    */
   public void setCreationDate(String creationDate){
      this.creationDate = creationDate;
   }

   /**
    * getter for 注册资产(万元)
    * @generated
    */
   public String getRegisterProperty(){
      return this.registerProperty;
   }
   /**
    * setter for 注册资产(万元)
    * @generated
    */
   public void setRegisterProperty(String registerProperty){
      this.registerProperty = registerProperty;
   }

   /**
    * getter for 固定资产原值(万元)
    * @generated
    */
   public String getImmobilisations(){
      return this.immobilisations;
   }
   /**
    * setter for 固定资产原值(万元)
    * @generated
    */
   public void setImmobilisations(String immobilisations){
      this.immobilisations = immobilisations;
   }

   /**
    * getter for 占地面积(平方米)
    * @generated
    */
   public String getFloorArea(){
      return this.floorArea;
   }
   /**
    * setter for 占地面积(平方米)
    * @generated
    */
   public void setFloorArea(String floorArea){
      this.floorArea = floorArea;
   }

   /**
    * getter for 业务用房面积(平方米)
    * @generated
    */
   public String getBusinessArea(){
      return this.businessArea;
   }
   /**
    * setter for 业务用房面积(平方米)
    * @generated
    */
   public void setBusinessArea(String businessArea){
      this.businessArea = businessArea;
   }

   /**
    * getter for 联系电话
    * @generated
    */
   public String getTelContact(){
      return this.telContact;
   }
   /**
    * setter for 联系电话
    * @generated
    */
   public void setTelContact(String telContact){
      this.telContact = telContact;
   }

   /**
    * getter for 邮政编码
    * @generated
    */
   public String getPostcode(){
      return this.postcode;
   }
   /**
    * setter for 邮政编码
    * @generated
    */
   public void setPostcode(String postcode){
      this.postcode = postcode;
   }

   /**
    * getter for 通信地址
    * @generated
    */
   public String getMailingAddress(){
      return this.mailingAddress;
   }
   /**
    * setter for 通信地址
    * @generated
    */
   public void setMailingAddress(String mailingAddress){
      this.mailingAddress = mailingAddress;
   }

   /**
    * getter for 单位介绍
    * @generated
    */
   public String getUnitIntroduce(){
      return this.unitIntroduce;
   }
   /**
    * setter for 单位介绍
    * @generated
    */
   public void setUnitIntroduce(String unitIntroduce){
      this.unitIntroduce = unitIntroduce;
   }

   /**
    * getter for 编制人数
    * @generated
    */
   public String getPrepareNum(){
      return this.prepareNum;
   }
   /**
    * setter for 编制人数
    * @generated
    */
   public void setPrepareNum(String prepareNum){
      this.prepareNum = prepareNum;
   }
public String getRegId() {
	return regId;
}
public void setRegId(String regId) {
	this.regId = regId;
}
public String getRegTime() {
	return regTime;
}
public void setRegTime(String regTime) {
	this.regTime = regTime;
}
public String getModId() {
	return modId;
}
public void setModId(String modId) {
	this.modId = modId;
}
public String getModTime() {
	return modTime;
}
public void setModTime(String modTime) {
	this.modTime = modTime;
}
public String getRegOrganCode() {
	return regOrganCode;
}
public void setRegOrganCode(String regOrganCode) {
	this.regOrganCode = regOrganCode;
}

  
}