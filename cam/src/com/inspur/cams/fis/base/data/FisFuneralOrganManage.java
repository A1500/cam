package com.inspur.cams.fis.base.data;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * @title:FisFuneralOrganManage
 * @description:
 * @author:
 * @since:2012-04-03
 * @version:1.0
*/
 @Table(tableName = "FIS_FUNERAL_ORGAN_MANAGE" , keyFields = "organCode")
public class FisFuneralOrganManage extends StatefulDatabean {
   //ORGAN_CODE
   	@Rule(value="require")
	@Column(name = "ORGAN_CODE")
   private String organCode;
   //PARENT_ORGAN_CODE
   	@Rule(value="require")
	@Column(name = "PARENT_ORGAN_CODE")
   private String parentOrganCode;
   //PARENT_ORGAN_NAME
   	@Rule(value="require")
	@Column(name = "PARENT_ORGAN_NAME")
   private String parentOrganName;
   //AREA_CODE
   	@Rule(value="require")
	@Column(name = "AREA_CODE")
   private String areaCode;
   //AREA_NAME
   	@Rule(value="require")
	@Column(name = "AREA_NAME")
   private String areaName;
   //UNIT_ID
   	@Rule(value="require")
	@Column(name = "UNIT_ID")
   private String unitId;
   //UNIT_NAME
   	@Rule(value="require")
	@Column(name = "UNIT_NAME")
   private String unitName;
   //PROPERTIES
	@Column(name = "PROPERTIES")
   private String properties;
   //LEGAL_PEOPLE
	@Column(name = "LEGAL_PEOPLE")
   private String legalPeople;
   //NUMBER_OF
   	@Rule(value="number")
	@Column(name = "NUMBER_OF")
   private BigDecimal numberOf;
   //TITLE
	@Column(name = "TITLE")
   private String title;
   //ADDRESS
	@Column(name = "ADDRESS")
   private String address;
   //PORT_CODE
	@Column(name = "PORT_CODE")
   private String portCode;
   //SERVICE_PHONE
	@Column(name = "SERVICE_PHONE")
   private String servicePhone;
   //WEB
	@Column(name = "WEB")
   private String web;
   //EMAIL
	@Column(name = "EMAIL")
   private String email;
   //QQ
	@Column(name = "QQ")
   private String qq;
   //DEMON_UNIT
	@Column(name = "DEMON_UNIT")
   private String demonUnit;
   //GRADE
	@Column(name = "GRADE")
   private String grade;
   //SERVICE_SCOPE
	@Column(name = "SERVICE_SCOPE")
   private String serviceScope;
   //SERVICE_TIME
	@Column(name = "SERVICE_TIME")
   private String serviceTime;
   //FIXED_ASSETS
   	@Rule(value="number")
	@Column(name = "FIXED_ASSETS")
   private BigDecimal fixedAssets;
   //DEPT_CODE
	@Column(name = "DEPT_CODE")
   private String deptCode;
   //CREATE_PEOPLE
	@Column(name = "CREATE_PEOPLE")
   private String createPeople;
   //CREATE_PEOPLE_NAME
	@Column(name = "CREATE_PEOPLE_NAME")
   private String createPeopleName;
   //CREATE_ORGAN
	@Column(name = "CREATE_ORGAN")
   private String createOrgan;
   //CREATE_ORGAN_NAME
	@Column(name = "CREATE_ORGAN_NAME")
   private String createOrganName;
   //CREATE_TIME
	@Column(name = "CREATE_TIME")
   private String createTime;
   //BUILT_AREA
   	@Rule(value="number")
	@Column(name = "BUILT_AREA")
   private BigDecimal builtArea;
   //BUILT_TOTAL_AREA
   	@Rule(value="number")
	@Column(name = "BUILT_TOTAL_AREA")
   private BigDecimal builtTotalArea;
   //GESTION_TIME
	@Column(name = "GESTION_TIME")
   private String gestionTime;
   //HONOURS
	@Column(name = "HONOURS")
   private String honours;
   //NOTE
	@Column(name = "NOTE")
   private String note;
   //NUMBER_REAL
   	@Rule(value="number")
	@Column(name = "NUMBER_REAL")
   private BigDecimal numberReal;
   //UNIT_CODE
	@Column(name = "UNIT_CODE")
   private String unitCode;
	
   //parentStruId
	@Transient
   private String parentStruId;
   public String getParentStruId() {
		return parentStruId;
	}
	public void setParentStruId(String parentStruId) {
		this.parentStruId = parentStruId;
	}
/**
    * getter for ORGAN_CODE
    * @generated
    */
   public String getOrganCode(){
      return this.organCode;
   }
   /**
    * setter for ORGAN_CODE
    * @generated
    */
   public void setOrganCode(String organCode){
      this.organCode = organCode;
   }

   /**
    * getter for PARENT_ORGAN_CODE
    * @generated
    */
   public String getParentOrganCode(){
      return this.parentOrganCode;
   }
   /**
    * setter for PARENT_ORGAN_CODE
    * @generated
    */
   public void setParentOrganCode(String parentOrganCode){
      this.parentOrganCode = parentOrganCode;
   }

   /**
    * getter for PARENT_ORGAN_NAME
    * @generated
    */
   public String getParentOrganName(){
      return this.parentOrganName;
   }
   /**
    * setter for PARENT_ORGAN_NAME
    * @generated
    */
   public void setParentOrganName(String parentOrganName){
      this.parentOrganName = parentOrganName;
   }

   /**
    * getter for AREA_CODE
    * @generated
    */
   public String getAreaCode(){
      return this.areaCode;
   }
   /**
    * setter for AREA_CODE
    * @generated
    */
   public void setAreaCode(String areaCode){
      this.areaCode = areaCode;
   }

   /**
    * getter for AREA_NAME
    * @generated
    */
   public String getAreaName(){
      return this.areaName;
   }
   /**
    * setter for AREA_NAME
    * @generated
    */
   public void setAreaName(String areaName){
      this.areaName = areaName;
   }

   /**
    * getter for UNIT_ID
    * @generated
    */
   public String getUnitId(){
      return this.unitId;
   }
   /**
    * setter for UNIT_ID
    * @generated
    */
   public void setUnitId(String unitId){
      this.unitId = unitId;
   }

   /**
    * getter for UNIT_NAME
    * @generated
    */
   public String getUnitName(){
      return this.unitName;
   }
   /**
    * setter for UNIT_NAME
    * @generated
    */
   public void setUnitName(String unitName){
      this.unitName = unitName;
   }

   /**
    * getter for PROPERTIES
    * @generated
    */
   public String getProperties(){
      return this.properties;
   }
   /**
    * setter for PROPERTIES
    * @generated
    */
   public void setProperties(String properties){
      this.properties = properties;
   }

   /**
    * getter for LEGAL_PEOPLE
    * @generated
    */
   public String getLegalPeople(){
      return this.legalPeople;
   }
   /**
    * setter for LEGAL_PEOPLE
    * @generated
    */
   public void setLegalPeople(String legalPeople){
      this.legalPeople = legalPeople;
   }

   /**
    * getter for NUMBER_OF
    * @generated
    */
   public BigDecimal getNumberOf(){
      return this.numberOf;
   }
   /**
    * setter for NUMBER_OF
    * @generated
    */
   public void setNumberOf(BigDecimal numberOf){
      this.numberOf = numberOf;
   }

   /**
    * getter for TITLE
    * @generated
    */
   public String getTitle(){
      return this.title;
   }
   /**
    * setter for TITLE
    * @generated
    */
   public void setTitle(String title){
      this.title = title;
   }

   /**
    * getter for ADDRESS
    * @generated
    */
   public String getAddress(){
      return this.address;
   }
   /**
    * setter for ADDRESS
    * @generated
    */
   public void setAddress(String address){
      this.address = address;
   }

   /**
    * getter for PORT_CODE
    * @generated
    */
   public String getPortCode(){
      return this.portCode;
   }
   /**
    * setter for PORT_CODE
    * @generated
    */
   public void setPortCode(String portCode){
      this.portCode = portCode;
   }

   /**
    * getter for SERVICE_PHONE
    * @generated
    */
   public String getServicePhone(){
      return this.servicePhone;
   }
   /**
    * setter for SERVICE_PHONE
    * @generated
    */
   public void setServicePhone(String servicePhone){
      this.servicePhone = servicePhone;
   }

   /**
    * getter for WEB
    * @generated
    */
   public String getWeb(){
      return this.web;
   }
   /**
    * setter for WEB
    * @generated
    */
   public void setWeb(String web){
      this.web = web;
   }

   /**
    * getter for EMAIL
    * @generated
    */
   public String getEmail(){
      return this.email;
   }
   /**
    * setter for EMAIL
    * @generated
    */
   public void setEmail(String email){
      this.email = email;
   }

   /**
    * getter for QQ
    * @generated
    */
   public String getQq(){
      return this.qq;
   }
   /**
    * setter for QQ
    * @generated
    */
   public void setQq(String qq){
      this.qq = qq;
   }

   /**
    * getter for DEMON_UNIT
    * @generated
    */
   public String getDemonUnit(){
      return this.demonUnit;
   }
   /**
    * setter for DEMON_UNIT
    * @generated
    */
   public void setDemonUnit(String demonUnit){
      this.demonUnit = demonUnit;
   }

   /**
    * getter for GRADE
    * @generated
    */
   public String getGrade(){
      return this.grade;
   }
   /**
    * setter for GRADE
    * @generated
    */
   public void setGrade(String grade){
      this.grade = grade;
   }

   /**
    * getter for SERVICE_SCOPE
    * @generated
    */
   public String getServiceScope(){
      return this.serviceScope;
   }
   /**
    * setter for SERVICE_SCOPE
    * @generated
    */
   public void setServiceScope(String serviceScope){
      this.serviceScope = serviceScope;
   }

   /**
    * getter for SERVICE_TIME
    * @generated
    */
   public String getServiceTime(){
      return this.serviceTime;
   }
   /**
    * setter for SERVICE_TIME
    * @generated
    */
   public void setServiceTime(String serviceTime){
      this.serviceTime = serviceTime;
   }

   /**
    * getter for FIXED_ASSETS
    * @generated
    */
   public BigDecimal getFixedAssets(){
      return this.fixedAssets;
   }
   /**
    * setter for FIXED_ASSETS
    * @generated
    */
   public void setFixedAssets(BigDecimal fixedAssets){
      this.fixedAssets = fixedAssets;
   }

   /**
    * getter for DEPT_CODE
    * @generated
    */
   public String getDeptCode(){
      return this.deptCode;
   }
   /**
    * setter for DEPT_CODE
    * @generated
    */
   public void setDeptCode(String deptCode){
      this.deptCode = deptCode;
   }

   /**
    * getter for CREATE_PEOPLE
    * @generated
    */
   public String getCreatePeople(){
      return this.createPeople;
   }
   /**
    * setter for CREATE_PEOPLE
    * @generated
    */
   public void setCreatePeople(String createPeople){
      this.createPeople = createPeople;
   }

   /**
    * getter for CREATE_PEOPLE_NAME
    * @generated
    */
   public String getCreatePeopleName(){
      return this.createPeopleName;
   }
   /**
    * setter for CREATE_PEOPLE_NAME
    * @generated
    */
   public void setCreatePeopleName(String createPeopleName){
      this.createPeopleName = createPeopleName;
   }

   /**
    * getter for CREATE_ORGAN
    * @generated
    */
   public String getCreateOrgan(){
      return this.createOrgan;
   }
   /**
    * setter for CREATE_ORGAN
    * @generated
    */
   public void setCreateOrgan(String createOrgan){
      this.createOrgan = createOrgan;
   }

   /**
    * getter for CREATE_ORGAN_NAME
    * @generated
    */
   public String getCreateOrganName(){
      return this.createOrganName;
   }
   /**
    * setter for CREATE_ORGAN_NAME
    * @generated
    */
   public void setCreateOrganName(String createOrganName){
      this.createOrganName = createOrganName;
   }

   /**
    * getter for CREATE_TIME
    * @generated
    */
   public String getCreateTime(){
      return this.createTime;
   }
   /**
    * setter for CREATE_TIME
    * @generated
    */
   public void setCreateTime(String createTime){
      this.createTime = createTime;
   }

   /**
    * getter for BUILT_AREA
    * @generated
    */
   public BigDecimal getBuiltArea(){
      return this.builtArea;
   }
   /**
    * setter for BUILT_AREA
    * @generated
    */
   public void setBuiltArea(BigDecimal builtArea){
      this.builtArea = builtArea;
   }

   /**
    * getter for BUILT_TOTAL_AREA
    * @generated
    */
   public BigDecimal getBuiltTotalArea(){
      return this.builtTotalArea;
   }
   /**
    * setter for BUILT_TOTAL_AREA
    * @generated
    */
   public void setBuiltTotalArea(BigDecimal builtTotalArea){
      this.builtTotalArea = builtTotalArea;
   }

   /**
    * getter for GESTION_TIME
    * @generated
    */
   public String getGestionTime(){
      return this.gestionTime;
   }
   /**
    * setter for GESTION_TIME
    * @generated
    */
   public void setGestionTime(String gestionTime){
      this.gestionTime = gestionTime;
   }

   /**
    * getter for HONOURS
    * @generated
    */
   public String getHonours(){
      return this.honours;
   }
   /**
    * setter for HONOURS
    * @generated
    */
   public void setHonours(String honours){
      this.honours = honours;
   }

   /**
    * getter for NOTE
    * @generated
    */
   public String getNote(){
      return this.note;
   }
   /**
    * setter for NOTE
    * @generated
    */
   public void setNote(String note){
      this.note = note;
   }

   /**
    * getter for NUMBER_REAL
    * @generated
    */
   public BigDecimal getNumberReal(){
      return this.numberReal;
   }
   /**
    * setter for NUMBER_REAL
    * @generated
    */
   public void setNumberReal(BigDecimal numberReal){
      this.numberReal = numberReal;
   }

   /**
    * getter for UNIT_CODE
    * @generated
    */
   public String getUnitCode(){
      return this.unitCode;
   }
   /**
    * setter for UNIT_CODE
    * @generated
    */
   public void setUnitCode(String unitCode){
      this.unitCode = unitCode;
   }

}