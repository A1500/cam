package com.inspur.cams.drel.sam.data;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:SamPeopleDisability残疾
 * @description:
 * @author:ZCH
 * @since:2011-04-19
 * @version:1.0
*/
 @Table(tableName = "SAM_PEOPLE_DISABILITY" , keyFields = "peopleId")
public class SamPeopleDisability extends StatefulDatabean {
   //成员Id
   	@Rule(value="require")
	@Column(name = "PEOPLE_ID")
   private String peopleId;
   //残疾类型
   	@Rule(value="require")
	@Column(name = "DISABILITY_TYPE")
   private String disabilityType;

   //残疾等级
	@Column(name = "DISABILITY_LEVEL")
   private String disabilityLevel;
   /**
    * getter for PEOPLE_ID
    * @generated
    */
   public String getPeopleId(){
      return this.peopleId;
   }
   /**
    * setter for PEOPLE_ID
    * @generated
    */
   public void setPeopleId(String peopleId){
      this.peopleId = peopleId;
   }

   /**
    * getter for DISABILITY_TYPE
    * @generated
    */
   public String getDisabilityType(){
      return this.disabilityType;
   }
   /**
    * setter for DISABILITY_TYPE
    * @generated
    */
   public void setDisabilityType(String disabilityType){
      this.disabilityType = disabilityType;
   }

   /**
    * getter for DISABILITY_LEVEL
    * @generated
    */
   public String getDisabilityLevel(){
      return this.disabilityLevel;
   }
   /**
    * setter for DISABILITY_LEVEL
    * @generated
    */
   public void setDisabilityLevel(String disabilityLevel){
      this.disabilityLevel = disabilityLevel;
   }

}