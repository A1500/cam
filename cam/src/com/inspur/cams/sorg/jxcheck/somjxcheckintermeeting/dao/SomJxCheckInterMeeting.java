package com.inspur.cams.sorg.jxcheck.somjxcheckintermeeting.dao;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * 江西参加国际会议
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 @Table(tableName = "SOM_JX_CHECK_INTER_MEETING" , keyFields = "id")
public class SomJxCheckInterMeeting extends StatefulDatabean {
   //ID
   	@Rule(value="require")
	@Column(name = "ID")
   private String id;
   //TASK_CODE
	@Column(name = "TASK_CODE")
   private String taskCode;
   //MEETING_NAME
	@Column(name = "MEETING_NAME")
   private String meetingName;
   //MEETING_DATE
	@Column(name = "MEETING_DATE")
   private String meetingDate;
   //MEETING_PLACE
	@Column(name = "MEETING_PLACE")
   private String meetingPlace;
   //HOST_ORGAN_NAME
	@Column(name = "HOST_ORGAN_NAME")
   private String hostOrganName;
   //FUNDS_SOURCE
	@Column(name = "FUNDS_SOURCE")
   private String fundsSource;
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
    * getter for MEETING_NAME
    * @generated
    */
   public String getMeetingName(){
      return this.meetingName;
   }
   /**
    * setter for MEETING_NAME
    * @generated
    */
   public void setMeetingName(String meetingName){
      this.meetingName = meetingName;
   }

   /**
    * getter for MEETING_DATE
    * @generated
    */
   public String getMeetingDate(){
      return this.meetingDate;
   }
   /**
    * setter for MEETING_DATE
    * @generated
    */
   public void setMeetingDate(String meetingDate){
      this.meetingDate = meetingDate;
   }

   /**
    * getter for MEETING_PLACE
    * @generated
    */
   public String getMeetingPlace(){
      return this.meetingPlace;
   }
   /**
    * setter for MEETING_PLACE
    * @generated
    */
   public void setMeetingPlace(String meetingPlace){
      this.meetingPlace = meetingPlace;
   }

   /**
    * getter for HOST_ORGAN_NAME
    * @generated
    */
   public String getHostOrganName(){
      return this.hostOrganName;
   }
   /**
    * setter for HOST_ORGAN_NAME
    * @generated
    */
   public void setHostOrganName(String hostOrganName){
      this.hostOrganName = hostOrganName;
   }

   /**
    * getter for FUNDS_SOURCE
    * @generated
    */
   public String getFundsSource(){
      return this.fundsSource;
   }
   /**
    * setter for FUNDS_SOURCE
    * @generated
    */
   public void setFundsSource(String fundsSource){
      this.fundsSource = fundsSource;
   }

}