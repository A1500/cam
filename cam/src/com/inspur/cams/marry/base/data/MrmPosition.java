package com.inspur.cams.marry.base.data;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * @title:MrmPosition
 * @description:
 * @author:
 * @since:2011-12-06
 * @version:1.0
*/
 @Table(tableName = "MRM_POSITION" , keyFields = "zwId")
public class MrmPosition extends StatefulDatabean {
   //职务ID
   	@Rule(value="require")
	@Column(name = "ZW_ID")
   private String zwId;
   //人员ID
   	@Rule(value="number")
	@Column(name = "MRM_PERSON_ID")
   private BigDecimal mrmPersonId;
   //人员
	@Column(name = "PERSON_ID")
   private String personId;
   //职务
   	@Rule(value="require")
	@Column(name = "ZW")
   private String zw;
   //从事本职工作时间
   	@Rule(value="require")
	@Column(name = "CSBZGZSJ_TIME")
   private String csbzgzsjTime;
   /**
    * getter for 职务ID
    * @generated
    */
   public String getZwId(){
      return this.zwId;
   }
   /**
    * setter for 职务ID
    * @generated
    */
   public void setZwId(String zwId){
      this.zwId = zwId;
   }

   /**
    * getter for 人员ID
    * @generated
    */
   public BigDecimal getMrmPersonId(){
      return this.mrmPersonId;
   }
   /**
    * setter for 人员ID
    * @generated
    */
   public void setMrmPersonId(BigDecimal mrmPersonId){
      this.mrmPersonId = mrmPersonId;
   }

   /**
    * getter for 人员
    * @generated
    */
   public String getPersonId(){
      return this.personId;
   }
   /**
    * setter for 人员
    * @generated
    */
   public void setPersonId(String personId){
      this.personId = personId;
   }

   /**
    * getter for 职务
    * @generated
    */
   public String getZw(){
      return this.zw;
   }
   /**
    * setter for 职务
    * @generated
    */
   public void setZw(String zw){
      this.zw = zw;
   }

   /**
    * getter for 从事本职工作时间
    * @generated
    */
   public String getCsbzgzsjTime(){
      return this.csbzgzsjTime;
   }
   /**
    * setter for 从事本职工作时间
    * @generated
    */
   public void setCsbzgzsjTime(String csbzgzsjTime){
      this.csbzgzsjTime = csbzgzsjTime;
   }

}