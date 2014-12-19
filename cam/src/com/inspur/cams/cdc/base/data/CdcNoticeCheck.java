package com.inspur.cams.cdc.base.data;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:CdcNoticeCheck
 * @description:
 * @author:
 * @since:2012-03-29
 * @version:1.0
*/
 @Table(tableName = "CDC_NOTICE_CHECK" , keyFields = "checkId")
public class CdcNoticeCheck extends StatefulDatabean {
   //CHECK_ID
	@Column(name = "CHECK_ID")
   private String checkId;
   //NOTICE_ID
	@Column(name = "NOTICE_ID")
   private String noticeId;
   //ORGAN_CODE
	@Column(name = "ORGAN_CODE")
   private String organCode;
   //ORGAN_NAME
	@Column(name = "ORGAN_NAME")
   private String organName;
   //CREATE_TIME
	@Column(name = "CREATE_TIME")
   private String createTime;
   /**
    * getter for CHECK_ID
    * @generated
    */
   public String getCheckId(){
      return this.checkId;
   }
   /**
    * setter for CHECK_ID
    * @generated
    */
   public void setCheckId(String checkId){
      this.checkId = checkId;
   }

   /**
    * getter for NOTICE_ID
    * @generated
    */
   public String getNoticeId(){
      return this.noticeId;
   }
   /**
    * setter for NOTICE_ID
    * @generated
    */
   public void setNoticeId(String noticeId){
      this.noticeId = noticeId;
   }

   /**
    * getter for ORGAN_CODE
    * @generated
    */
   public String getOrganCode(){
      return this.organCode;
   }
   /**
    * setter for ORGAN_CODE
    * @generated
    */
   public void setOrganCode(String organCode){
      this.organCode = organCode;
   }

   /**
    * getter for ORGAN_NAME
    * @generated
    */
   public String getOrganName(){
      return this.organName;
   }
   /**
    * setter for ORGAN_NAME
    * @generated
    */
   public void setOrganName(String organName){
      this.organName = organName;
   }

   /**
    * getter for CREATE_TIME
    * @generated
    */
   public String getCreateTime(){
      return this.createTime;
   }
   /**
    * setter for CREATE_TIME
    * @generated
    */
   public void setCreateTime(String createTime){
      this.createTime = createTime;
   }

}