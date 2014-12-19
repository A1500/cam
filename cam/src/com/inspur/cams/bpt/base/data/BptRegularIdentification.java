package com.inspur.cams.bpt.base.data;

import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * @title:BptRegularIdentification
 * @description:定期认证
 * @author:
 * @since:2011-05-27
 * @version:1.0
*/
 @Table(tableName = "BPT_REGULAR_IDENTIFICATION" , keyFields = "identificationId")
public class BptRegularIdentification extends StatefulDatabean {
   //认证ID
	@Column(name = "IDENTIFICATION_ID")
   private String identificationId;
   //人员ID
	@Column(name = "PEOPLE_ID")
   private String peopleId;
   //姓名
	@Column(name = "NAME")
   private String name;
   //身份证件号码
	@Column(name = "ID_CARD")
   private String idCard;
   //优抚对象类别
	@Column(name = "OBJECT_TYPE")
   private String objectType;
   //认定时间
	@Column(name = "IDENTIFICATION_DATE")
   private String identificationDate;
   //认定结果
	@Column(name = "IDENTIFICATION_RESULT")
   private String identificationResult;
   //备注
	@Column(name = "NOTE")
   private String note;
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
	//认定标志
	@Column(name = "IDENTI_FLAG")
   private String identiFlag;
	
   /**
	 * @return the identiFlag
	 */
	public String getIdentiFlag() {
		return identiFlag;
	}
	/**
	 * @param identiFlag the identiFlag to set
	 */
	public void setIdentiFlag(String identiFlag) {
		this.identiFlag = identiFlag;
	}
/**
    * getter for 认证ID
    * @generated
    */
   public String getIdentificationId(){
      return this.identificationId;
   }
   /**
    * setter for 认证ID
    * @generated
    */
   public void setIdentificationId(String identificationId){
      this.identificationId = identificationId;
   }

   /**
    * getter for 人员ID
    * @generated
    */
   public String getPeopleId(){
      return this.peopleId;
   }
   /**
    * setter for 人员ID
    * @generated
    */
   public void setPeopleId(String peopleId){
      this.peopleId = peopleId;
   }

   /**
    * getter for 姓名
    * @generated
    */
   public String getName(){
      return this.name;
   }
   /**
    * setter for 姓名
    * @generated
    */
   public void setName(String name){
      this.name = name;
   }

   /**
    * getter for 身份证件号码
    * @generated
    */
   public String getIdCard(){
      return this.idCard;
   }
   /**
    * setter for 身份证件号码
    * @generated
    */
   public void setIdCard(String idCard){
      this.idCard = idCard;
   }

   /**
    * getter for 优抚对象类别
    * @generated
    */
   public String getObjectType(){
      return this.objectType;
   }
   /**
    * setter for 优抚对象类别
    * @generated
    */
   public void setObjectType(String objectType){
      this.objectType = objectType;
   }

   /**
    * getter for 认定时间
    * @generated
    */
   public String getIdentificationDate(){
      return this.identificationDate;
   }
   /**
    * setter for 认定时间
    * @generated
    */
   public void setIdentificationDate(String identificationDate){
      this.identificationDate = identificationDate;
   }

   /**
    * getter for 认定结果
    * @generated
    */
   public String getIdentificationResult(){
      return this.identificationResult;
   }
   /**
    * setter for 认定结果
    * @generated
    */
   public void setIdentificationResult(String identificationResult){
      this.identificationResult = identificationResult;
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
    * getter for 录入人ID
    * @generated
    */
   public String getRegId(){
      return this.regId;
   }
   /**
    * setter for 录入人ID
    * @generated
    */
   public void setRegId(String regId){
      this.regId = regId;
   }

   /**
    * getter for 录入时间
    * @generated
    */
   public String getRegTime(){
      return this.regTime;
   }
   /**
    * setter for 录入时间
    * @generated
    */
   public void setRegTime(String regTime){
      this.regTime = regTime;
   }

   /**
    * getter for 修改人ID
    * @generated
    */
   public String getModId(){
      return this.modId;
   }
   /**
    * setter for 修改人ID
    * @generated
    */
   public void setModId(String modId){
      this.modId = modId;
   }

   /**
    * getter for 修改时间
    * @generated
    */
   public String getModTime(){
      return this.modTime;
   }
   /**
    * setter for 修改时间
    * @generated
    */
   public void setModTime(String modTime){
      this.modTime = modTime;
   }

}