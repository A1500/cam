package com.inspur.sdmz.jzfa.data;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * @title:ComPlanOrgan
 * @description:
 * @author:
 * @since:2011-09-17
 * @version:1.0
*/
 @Table(tableName = "COM_PLAN_ORGAN" , keyFields = "planId")
public class ComPlanOrgan extends StatefulDatabean {
   //救助方案
  // 	@Rule(value="require")
	@Column(name = "PLAN_ID")
   private String planId;
   //单位Id
 //  	@Rule(value="require")
	@Column(name = "ORGAN_ID")
   private String organId;
   //单位名称
	@Column(name = "ORGAN_NAME")
   private String organName;
   //单位类型
	@Column(name = "ORGAN_TYPE")
   private String organType;
   /**
    * getter for 救助方案
    * @generated
    */
   public String getPlanId(){
      return this.planId;
   }
   /**
    * setter for 救助方案
    * @generated
    */
   public void setPlanId(String planId){
      this.planId = planId;
   }

   /**
    * getter for 单位Id
    * @generated
    */
   public String getOrganId(){
      return this.organId;
   }
   /**
    * setter for 单位Id
    * @generated
    */
   public void setOrganId(String organId){
      this.organId = organId;
   }

   /**
    * getter for 单位名称
    * @generated
    */
   public String getOrganName(){
      return this.organName;
   }
   /**
    * setter for 单位名称
    * @generated
    */
   public void setOrganName(String organName){
      this.organName = organName;
   }

   /**
    * getter for 单位类型
    * @generated
    */
   public String getOrganType(){
      return this.organType;
   }
   /**
    * setter for 单位类型
    * @generated
    */
   public void setOrganType(String organType){
      this.organType = organType;
   }

}