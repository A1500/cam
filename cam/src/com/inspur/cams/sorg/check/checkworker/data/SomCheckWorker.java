package com.inspur.cams.sorg.check.checkworker.data;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * @title:SomCheckWorker
 * @description:
 * @author:
 * @since:2012-01-06
 * @version:1.0
*/
 @Table(tableName = "SOM_CHECK_WORKER" , keyFields = "id")
public class SomCheckWorker extends StatefulDatabean {
   //ID
   	
	@Column(name = "ID")
   private String id;
   //TASK_CODE
	@Column(name = "TASK_CODE")
   private String taskCode;
   //TOTAL_NUM
	@Column(name = "TOTAL_NUM")
   private String totalNum;
   //PRINCIPLE_NUM
	@Column(name = "PRINCIPLE_NUM")
   private String principleNum;
   //PRINCIPLE_NATION
	@Column(name = "PRINCIPLE_NATION")
   private String principleNation;
   //PRINCIPLE_PROVINCE
	@Column(name = "PRINCIPLE_PROVINCE")
   private String principleProvince;
   //FULL_PEOPLE_NUM
	@Column(name = "FULL_PEOPLE_NUM")
   private String fullPeopleNum;
   //PART_PEOPLE_NUM
	@Column(name = "PART_PEOPLE_NUM")
   private String partPeopleNum;
   //RETURNMENT_NUM
	@Column(name = "RETURNMENT_NUM")
   private String returnmentNum;
   //VOLUNTER_NUM
	@Column(name = "VOLUNTER_NUM")
   private String volunterNum;
   //VOLUNTER_PERIOD
	@Column(name = "VOLUNTER_PERIOD")
   private String volunterPeriod;
   //FULL_PARTY_NUM
	@Column(name = "FULL_PARTY_NUM")
   private String fullPartyNum;
   //IF_BUILD_PARTY
	@Column(name = "IF_BUILD_PARTY")
   private String ifBuildParty;
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
    * getter for TASK_CODE
    * @generated
    */
   public String getTaskCode(){
      return this.taskCode;
   }
   /**
    * setter for TASK_CODE
    * @generated
    */
   public void setTaskCode(String taskCode){
      this.taskCode = taskCode;
   }

   /**
    * getter for TOTAL_NUM
    * @generated
    */
   public String getTotalNum(){
      return this.totalNum;
   }
   /**
    * setter for TOTAL_NUM
    * @generated
    */
   public void setTotalNum(String totalNum){
      this.totalNum = totalNum;
   }

   /**
    * getter for PRINCIPLE_NUM
    * @generated
    */
   public String getPrincipleNum(){
      return this.principleNum;
   }
   /**
    * setter for PRINCIPLE_NUM
    * @generated
    */
   public void setPrincipleNum(String principleNum){
      this.principleNum = principleNum;
   }

   /**
    * getter for PRINCIPLE_NATION
    * @generated
    */
   public String getPrincipleNation(){
      return this.principleNation;
   }
   /**
    * setter for PRINCIPLE_NATION
    * @generated
    */
   public void setPrincipleNation(String principleNation){
      this.principleNation = principleNation;
   }

   /**
    * getter for PRINCIPLE_PROVINCE
    * @generated
    */
   public String getPrincipleProvince(){
      return this.principleProvince;
   }
   /**
    * setter for PRINCIPLE_PROVINCE
    * @generated
    */
   public void setPrincipleProvince(String principleProvince){
      this.principleProvince = principleProvince;
   }

   /**
    * getter for FULL_PEOPLE_NUM
    * @generated
    */
   public String getFullPeopleNum(){
      return this.fullPeopleNum;
   }
   /**
    * setter for FULL_PEOPLE_NUM
    * @generated
    */
   public void setFullPeopleNum(String fullPeopleNum){
      this.fullPeopleNum = fullPeopleNum;
   }

   /**
    * getter for PART_PEOPLE_NUM
    * @generated
    */
   public String getPartPeopleNum(){
      return this.partPeopleNum;
   }
   /**
    * setter for PART_PEOPLE_NUM
    * @generated
    */
   public void setPartPeopleNum(String partPeopleNum){
      this.partPeopleNum = partPeopleNum;
   }

   /**
    * getter for RETURNMENT_NUM
    * @generated
    */
   public String getReturnmentNum(){
      return this.returnmentNum;
   }
   /**
    * setter for RETURNMENT_NUM
    * @generated
    */
   public void setReturnmentNum(String returnmentNum){
      this.returnmentNum = returnmentNum;
   }

   /**
    * getter for VOLUNTER_NUM
    * @generated
    */
   public String getVolunterNum(){
      return this.volunterNum;
   }
   /**
    * setter for VOLUNTER_NUM
    * @generated
    */
   public void setVolunterNum(String volunterNum){
      this.volunterNum = volunterNum;
   }

   /**
    * getter for VOLUNTER_PERIOD
    * @generated
    */
   public String getVolunterPeriod(){
      return this.volunterPeriod;
   }
   /**
    * setter for VOLUNTER_PERIOD
    * @generated
    */
   public void setVolunterPeriod(String volunterPeriod){
      this.volunterPeriod = volunterPeriod;
   }

   /**
    * getter for FULL_PARTY_NUM
    * @generated
    */
   public String getFullPartyNum(){
      return this.fullPartyNum;
   }
   /**
    * setter for FULL_PARTY_NUM
    * @generated
    */
   public void setFullPartyNum(String fullPartyNum){
      this.fullPartyNum = fullPartyNum;
   }

   /**
    * getter for IF_BUILD_PARTY
    * @generated
    */
   public String getIfBuildParty(){
      return this.ifBuildParty;
   }
   /**
    * setter for IF_BUILD_PARTY
    * @generated
    */
   public void setIfBuildParty(String ifBuildParty){
      this.ifBuildParty = ifBuildParty;
   }

}