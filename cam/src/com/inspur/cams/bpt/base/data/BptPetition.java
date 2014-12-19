package com.inspur.cams.bpt.base.data;

import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * @title:BptPetition
 * @description:
 * @author:
 * @since:2011-05-25
 * @version:1.0
*/
 @Table(tableName = "BPT_PETITION" , keyFields = "petitionId")
public class BptPetition extends StatefulDatabean {
   //信访ID
	@Column(name = "PETITION_ID")
   private String petitionId;
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
   //信访时间
   	@Rule(value="require")
	@Column(name = "PETITION_DATE")
   private String petitionDate;
   //信访内容
   	@Rule(value="require")
	@Column(name = "PETITION_CONTENT")
   private String petitionContent;
   //电子文档
	@Column(name = "E_DOCUMENTS")
   private UploadFile edocuments;
	//电子文档
	@Column(name = "E_DOCUMENTS_NAME")
   private String edocumentsName;
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
	
	public String getEdocumentsName() {
		return edocumentsName;
	}
	public void setEdocumentsName(String edocumentsName) {
		this.edocumentsName = edocumentsName;
	}
/**
    * getter for 信访ID
    * @generated
    */
   public String getPetitionId(){
      return this.petitionId;
   }
   /**
    * setter for 信访ID
    * @generated
    */
   public void setPetitionId(String petitionId){
      this.petitionId = petitionId;
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
    * getter for 信访时间
    * @generated
    */
   public String getPetitionDate(){
      return this.petitionDate;
   }
   /**
    * setter for 信访时间
    * @generated
    */
   public void setPetitionDate(String petitionDate){
      this.petitionDate = petitionDate;
   }

   /**
    * getter for 信访内容
    * @generated
    */
   public String getPetitionContent(){
      return this.petitionContent;
   }
   /**
    * setter for 信访内容
    * @generated
    */
   public void setPetitionContent(String petitionContent){
      this.petitionContent = petitionContent;
   }

   /**
    * getter for 电子文档
    * @generated
    */
   public UploadFile getEdocuments(){
      return this.edocuments;
   }
   /**
    * setter for 电子文档
    * @generated
    */
   public void setEdocuments(UploadFile edocuments){
      this.edocuments = edocuments;
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