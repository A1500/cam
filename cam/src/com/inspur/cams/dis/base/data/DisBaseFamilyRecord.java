package com.inspur.cams.dis.base.data;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:DisBaseFamilyRecord
 * @description:
 * @author:
 * @since:2012-11-01
 * @version:1.0
*/
 @Table(tableName = "DIS_BASE_FAMILY_RECORD" , keyFields = "recordId")
public class DisBaseFamilyRecord extends StatefulDatabean {
   //档案编号
	@Column(name = "RECORD_ID")
   private String recordId;
   //填报单位代码
	@Column(name = "ORGAN_CODE")
   private String organCode;
   //填报单位名称
	@Column(name = "ORGAN_NAME")
   private String organName;
   //乡镇（街道）区划
	@Column(name = "TOWN_CODE")
   private String townCode;
   //行政村区划
	@Column(name = "VILLIAGE_CODE")
   private String villiageCode;
   //户主姓名
	@Column(name = "NAME")
   private String name;
   //身份证号码
	@Column(name = "ID_CARD")
   private String idCard;
   //家庭人口（人）
	@Column(name = "FAMILY_NUM")
   private String familyNum;
   //家庭类型
	@Column(name = "FAMILY_TYPE")
   private String familyType;
   //户口所在地
	@Column(name = "FAMILY_REGISTER")
   private String familyRegister;
   //房屋间数（间）
	@Column(name = "HOUSE_COUNT")
   private String houseCount;
   //房屋结构
	@Column(name = "HOUSE_STRUCTURE")
   private String houseStructure;
   /**
    * getter for 档案编号
    * @generated
    */
   public String getRecordId(){
      return this.recordId;
   }
   /**
    * setter for 档案编号
    * @generated
    */
   public void setRecordId(String recordId){
      this.recordId = recordId;
   }

   /**
    * getter for 填报单位代码
    * @generated
    */
   public String getOrganCode(){
      return this.organCode;
   }
   /**
    * setter for 填报单位代码
    * @generated
    */
   public void setOrganCode(String organCode){
      this.organCode = organCode;
   }

   /**
    * getter for 填报单位名称
    * @generated
    */
   public String getOrganName(){
      return this.organName;
   }
   /**
    * setter for 填报单位名称
    * @generated
    */
   public void setOrganName(String organName){
      this.organName = organName;
   }

   /**
    * getter for 乡镇（街道）区划
    * @generated
    */
   public String getTownCode(){
      return this.townCode;
   }
   /**
    * setter for 乡镇（街道）区划
    * @generated
    */
   public void setTownCode(String townCode){
      this.townCode = townCode;
   }

   /**
    * getter for 行政村区划
    * @generated
    */
   public String getVilliageCode(){
      return this.villiageCode;
   }
   /**
    * setter for 行政村区划
    * @generated
    */
   public void setVilliageCode(String villiageCode){
      this.villiageCode = villiageCode;
   }

   /**
    * getter for 户主姓名
    * @generated
    */
   public String getName(){
      return this.name;
   }
   /**
    * setter for 户主姓名
    * @generated
    */
   public void setName(String name){
      this.name = name;
   }

   /**
    * getter for 身份证号码
    * @generated
    */
   public String getIdCard(){
      return this.idCard;
   }
   /**
    * setter for 身份证号码
    * @generated
    */
   public void setIdCard(String idCard){
      this.idCard = idCard;
   }

   /**
    * getter for 家庭人口（人）
    * @generated
    */
   public String getFamilyNum(){
      return this.familyNum;
   }
   /**
    * setter for 家庭人口（人）
    * @generated
    */
   public void setFamilyNum(String familyNum){
      this.familyNum = familyNum;
   }

   /**
    * getter for 家庭类型
    * @generated
    */
   public String getFamilyType(){
      return this.familyType;
   }
   /**
    * setter for 家庭类型
    * @generated
    */
   public void setFamilyType(String familyType){
      this.familyType = familyType;
   }

   /**
    * getter for 户口所在地
    * @generated
    */
   public String getFamilyRegister(){
      return this.familyRegister;
   }
   /**
    * setter for 户口所在地
    * @generated
    */
   public void setFamilyRegister(String familyRegister){
      this.familyRegister = familyRegister;
   }

   /**
    * getter for 房屋间数（间）
    * @generated
    */
   public String getHouseCount(){
      return this.houseCount;
   }
   /**
    * setter for 房屋间数（间）
    * @generated
    */
   public void setHouseCount(String houseCount){
      this.houseCount = houseCount;
   }

   /**
    * getter for 房屋结构
    * @generated
    */
   public String getHouseStructure(){
      return this.houseStructure;
   }
   /**
    * setter for 房屋结构
    * @generated
    */
   public void setHouseStructure(String houseStructure){
      this.houseStructure = houseStructure;
   }

}