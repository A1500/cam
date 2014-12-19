package com.inspur.cams.marry.base.dao;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * @title:MrmExamApply
 * @description:
 * @author:
 * @since:2011-12-06
 * @version:1.0
*/
 @Table(tableName = "MRM_EXAM_APPLY" , keyFields = "ksbmId")
public class MrmExamApply extends StatefulDatabean {
   //考试报名id
   	@Rule(value="require")
	@Column(name = "KSBM_ID")
   private String ksbmId;
   //考试安排id
	@Column(name = "EXAMPLAN_ID")
   private String examplanId;
   //人员id
   	@Rule(value="number")
	@Column(name = "PERSON_ID")
   private BigDecimal personId;
   /**
    * getter for 考试报名id
    * @generated
    */
   public String getKsbmId(){
      return this.ksbmId;
   }
   /**
    * setter for 考试报名id
    * @generated
    */
   public void setKsbmId(String ksbmId){
      this.ksbmId = ksbmId;
   }

   /**
    * getter for 考试安排id
    * @generated
    */
   public String getExamplanId(){
      return this.examplanId;
   }
   /**
    * setter for 考试安排id
    * @generated
    */
   public void setExamplanId(String examplanId){
      this.examplanId = examplanId;
   }

   /**
    * getter for 人员id
    * @generated
    */
   public BigDecimal getPersonId(){
      return this.personId;
   }
   /**
    * setter for 人员id
    * @generated
    */
   public void setPersonId(BigDecimal personId){
      this.personId = personId;
   }

}