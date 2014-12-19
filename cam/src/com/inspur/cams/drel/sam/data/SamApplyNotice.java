package com.inspur.cams.drel.sam.data;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * @title:公示结果
 * @description:
 * @author:yanliangliang
 * @since:2012-05-03
 * @version:1.0
*/
 @Table(tableName = "SAM_APPLY_NOTICE" , keyFields = "noticeId")
public class SamApplyNotice extends StatefulDatabean {
   //NOTICE_ID
	@Column(name = "NOTICE_ID")
   private String noticeId;
   //APPLY_ID
	@Column(name = "APPLY_ID")
   private String applyId;
   //ACTIVITY_ID
	@Column(name = "ACTIVITY_ID")
   private String activityId;
   //BEGIN_DATE
	@Column(name = "BEGIN_DATE")
   private String beginDate;
   //END_DATE
	@Column(name = "END_DATE")
   private String endDate;
   //NOTICE_RESULT
	@Column(name = "NOTICE_RESULT")
   private String noticeResult;
   //REMARKS
	@Column(name = "REMARKS")
   private String remarks;
	 private String principal;
 
public String getPrincipal() {
		return principal;
	}
	public void setPrincipal(String principal) {
		this.principal = principal;
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
    * getter for APPLY_ID
    * @generated
    */
   public String getApplyId(){
      return this.applyId;
   }
   /**
    * setter for APPLY_ID
    * @generated
    */
   public void setApplyId(String applyId){
      this.applyId = applyId;
   }

   /**
    * getter for ACTIVITY_ID
    * @generated
    */
   public String getActivityId(){
      return this.activityId;
   }
   /**
    * setter for ACTIVITY_ID
    * @generated
    */
   public void setActivityId(String activityId){
      this.activityId = activityId;
   }

   /**
    * getter for BEGIN_DATE
    * @generated
    */
   public String getBeginDate(){
      return this.beginDate;
   }
   /**
    * setter for BEGIN_DATE
    * @generated
    */
   public void setBeginDate(String beginDate){
      this.beginDate = beginDate;
   }

   /**
    * getter for END_DATE
    * @generated
    */
   public String getEndDate(){
      return this.endDate;
   }
   /**
    * setter for END_DATE
    * @generated
    */
   public void setEndDate(String endDate){
      this.endDate = endDate;
   }

   /**
    * getter for NOTICE_RESULT
    * @generated
    */
   public String getNoticeResult(){
      return this.noticeResult;
   }
   /**
    * setter for NOTICE_RESULT
    * @generated
    */
   public void setNoticeResult(String noticeResult){
      this.noticeResult = noticeResult;
   }

   /**
    * getter for REMARKS
    * @generated
    */
   public String getRemarks(){
      return this.remarks;
   }
   /**
    * setter for REMARKS
    * @generated
    */
   public void setRemarks(String remarks){
      this.remarks = remarks;
   }

}