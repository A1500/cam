package com.inspur.cams.bpt.base.data;

import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * @title:BptApplyAssistiveDevices
 * @description:伤残辅助器械
 * @author:
 * @since:2011-05-31
 * @version:1.0
*/
 @Table(tableName = "BPT_APPLY_ASSISTIVE_DEVICES" , keyFields = "applyId")
public class BptApplyAssistiveDevices extends StatefulDatabean {
   //申请ID
	 private String applyId;
   //人员ID
	@Column(name = "PEOPLE_ID")
   private String peopleId;
   //姓名
	@Column(name = "NAME")
   private String name;
   //身份证件号码
	@Column(name = "ID_CARD")
   private String idCard;
   //性别
	@Column(name = "SEX")
   private String sex;
   //优抚对象类别
	@Column(name = "OBJECT_TYPE")
   private String objectType;
   //伤残等级
	@Column(name = "DISABILITY_LEVEL")
   private String disabilityLevel;
   //伤残属别
	@Column(name = "DISABILITY_GENUS")
   private String disabilityGenus;
   //伤残证书编号
	@Column(name = "DISABILITY_NO")
   private String disabilityNo;
   //伤残情形
   	@Rule(value="require")
	@Column(name = "DISABILITY_CASE")
   private String disabilityCase;
   //住址
   	@Rule(value="require")
	@Column(name = "ADDRESS")
   private String address;
   //电话
	@Column(name = "TEL_MOBILE")
   private String telMobile;
   //申请器械ID
	@Column(name = "APPLY_APPARATUS_ID")
   private String applyApparatusId;
   //器械名称
	@Column(name = "APPARATUS_NAME")
   private String apparatusName;
   //申请事由
	@Column(name = "APPLY_CAUSA")
   private String applyCausa;
   //备注
	@Column(name = "NOTE")
   private String note;
	
	//录入人ID
	@Column(name = "REG_ID")
	private String regId;
	
	//录入时间
	@Column(name = "REG_TIME")
	private String regTime;
	
	//提交标志
	@Column(name = "COMMIT_FLAG")
	private String commitFlag;
	
	
   /**
	 * @return the regId
	 */
	public String getRegId() {
		return regId;
	}
	/**
	 * @param regId the regId to set
	 */
	public void setRegId(String regId) {
		this.regId = regId;
	}
	/**
	 * @return the regTime
	 */
	public String getRegTime() {
		return regTime;
	}
	/**
	 * @param regTime the regTime to set
	 */
	public void setRegTime(String regTime) {
		this.regTime = regTime;
	}
	/**
	 * @return the commitFlag
	 */
	public String getCommitFlag() {
		return commitFlag;
	}
	/**
	 * @param commitFlag the commitFlag to set
	 */
	public void setCommitFlag(String commitFlag) {
		this.commitFlag = commitFlag;
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
    * getter for 性别
    * @generated
    */
   public String getSex(){
      return this.sex;
   }
   /**
    * setter for 性别
    * @generated
    */
   public void setSex(String sex){
      this.sex = sex;
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
    * getter for 伤残等级
    * @generated
    */
   public String getDisabilityLevel(){
      return this.disabilityLevel;
   }
   /**
    * setter for 伤残等级
    * @generated
    */
   public void setDisabilityLevel(String disabilityLevel){
      this.disabilityLevel = disabilityLevel;
   }

   /**
    * getter for 伤残属别
    * @generated
    */
   public String getDisabilityGenus(){
      return this.disabilityGenus;
   }
   /**
    * setter for 伤残属别
    * @generated
    */
   public void setDisabilityGenus(String disabilityGenus){
      this.disabilityGenus = disabilityGenus;
   }

   /**
    * getter for 伤残证书编号
    * @generated
    */
   public String getDisabilityNo(){
      return this.disabilityNo;
   }
   /**
    * setter for 伤残证书编号
    * @generated
    */
   public void setDisabilityNo(String disabilityNo){
      this.disabilityNo = disabilityNo;
   }

   /**
    * getter for 伤残情形
    * @generated
    */
   public String getDisabilityCase(){
      return this.disabilityCase;
   }
   /**
    * setter for 伤残情形
    * @generated
    */
   public void setDisabilityCase(String disabilityCase){
      this.disabilityCase = disabilityCase;
   }

   /**
    * getter for 住址
    * @generated
    */
   public String getAddress(){
      return this.address;
   }
   /**
    * setter for 住址
    * @generated
    */
   public void setAddress(String address){
      this.address = address;
   }

   /**
    * getter for 电话
    * @generated
    */
   public String getTelMobile(){
      return this.telMobile;
   }
   /**
    * setter for 电话
    * @generated
    */
   public void setTelMobile(String telMobile){
      this.telMobile = telMobile;
   }

   /**
    * getter for 申请器械ID
    * @generated
    */
   public String getApplyApparatusId(){
      return this.applyApparatusId;
   }
   /**
    * setter for 申请器械ID
    * @generated
    */
   public void setApplyApparatusId(String applyApparatusId){
      this.applyApparatusId = applyApparatusId;
   }

   /**
    * getter for 器械名称
    * @generated
    */
   public String getApparatusName(){
      return this.apparatusName;
   }
   /**
    * setter for 器械名称
    * @generated
    */
   public void setApparatusName(String apparatusName){
      this.apparatusName = apparatusName;
   }

   /**
    * getter for 申请事由
    * @generated
    */
   public String getApplyCausa(){
      return this.applyCausa;
   }
   /**
    * setter for 申请事由
    * @generated
    */
   public void setApplyCausa(String applyCausa){
      this.applyCausa = applyCausa;
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
 * @return the applyId
 */
public String getApplyId() {
	return applyId;
}
/**
 * @param applyId the applyId to set
 */
public void setApplyId(String applyId) {
	this.applyId = applyId;
}

}