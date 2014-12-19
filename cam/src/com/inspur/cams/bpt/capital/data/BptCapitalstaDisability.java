package com.inspur.cams.bpt.capital.data;


import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * @title:BptCapitalstaDisability
 * @description:
 * @author:
 * @since:2011-05-23
 * @version:1.0
*/
 @Table(tableName = "BPT_CAPITALSTA_DISABILITY" , keyFields = "id")
public class BptCapitalstaDisability extends StatefulDatabean {
   //优抚对象类别
	@Column(name = "OBJECT_TYPE")
   private String objectType;
   //伤残等级
	@Column(name = "DISABILITY_LEVEL_CODE")
   private String disabilityLevelCode;
   //伤残性质
	@Column(name = "DISABILITY_NATURE")
   private String disabilityNature;
   //现月标准
	@Column(name = "SPOT_STANDARDS")
   private String spotStandards;
   //新月标准
	@Column(name = "NEWMOON_STANDARDS")
   private String newmoonStandards;
   //标准所属县区
	@Column(name = "STANDARDS_COUNTIES")
   private String standardsCounties;
   //生效日期起
	@Column(name = "START_DATE")
   private String startDate;
   //生效日期止
	@Column(name = "END_DATE")
   private String endDate;
   //ID
   	//@Rule(value="require")
	@Column(name = "ID")
   private String id;
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
   public String getDisabilityLevelCode(){
      return this.disabilityLevelCode;
   }
   /**
    * setter for 伤残等级
    * @generated
    */
   public void setDisabilityLevelCode(String disabilityLevelCode){
      this.disabilityLevelCode = disabilityLevelCode;
   }

   /**
    * getter for 伤残性质
    * @generated
    */
   public String getDisabilityNature(){
      return this.disabilityNature;
   }
   /**
    * setter for 伤残性质
    * @generated
    */
   public void setDisabilityNature(String disabilityNature){
      this.disabilityNature = disabilityNature;
   }

   /**
    * getter for 现月标准
    * @generated
    */
   public String getSpotStandards(){
      return this.spotStandards;
   }
   /**
    * setter for 现月标准
    * @generated
    */
   public void setSpotStandards(String spotStandards){
      this.spotStandards = spotStandards;
   }

   /**
    * getter for 新月标准
    * @generated
    */
   public String getNewmoonStandards(){
      return this.newmoonStandards;
   }
   /**
    * setter for 新月标准
    * @generated
    */
   public void setNewmoonStandards(String newmoonStandards){
      this.newmoonStandards = newmoonStandards;
   }

   /**
    * getter for 标准所属县区
    * @generated
    */
   public String getStandardsCounties(){
      return this.standardsCounties;
   }
   /**
    * setter for 标准所属县区
    * @generated
    */
   public void setStandardsCounties(String standardsCounties){
      this.standardsCounties = standardsCounties;
   }

   /**
    * getter for 生效日期起
    * @generated
    */
   public String getStartDate(){
      return this.startDate;
   }
   /**
    * setter for 生效日期起
    * @generated
    */
   public void setStartDate(String startDate){
      this.startDate = startDate;
   }

   /**
    * getter for 生效日期止
    * @generated
    */
   public String getEndDate(){
      return this.endDate;
   }
   /**
    * setter for 生效日期止
    * @generated
    */
   public void setEndDate(String endDate){
      this.endDate = endDate;
   }

   /**
    * getter for ID
    * @generated
    */
   public String getId(){
      return this.id;
   }
   /**
    * setter for ID
    * @generated
    */
   public void setId(String id){
      this.id = id;
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