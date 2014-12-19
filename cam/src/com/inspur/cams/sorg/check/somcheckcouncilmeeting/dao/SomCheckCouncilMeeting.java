package com.inspur.cams.sorg.check.somcheckcouncilmeeting.dao;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * @title:SomCheckCouncilMeeting
 * @description:
 * @author:
 * @since:2012-04-23
 * @version:1.0
*/
 @Table(tableName = "SOM_CHECK_COUNCIL_MEETING" , keyFields = "id")
public class SomCheckCouncilMeeting extends StatefulDatabean {
   //ID
	@Column(name = "ID")
   private String id;
   //TASK_CODE
	@Column(name = "TASK_CODE")
   private String taskCode;
   //MEETING_DATE
	@Column(name = "MEETING_DATE")
   private String meetingDate;
   //MEETING_NUMBER
	@Column(name = "MEETING_NUMBER")
   private String meetingNumber;
   //MEETING_TIMES
	@Column(name = "MEETING_TIMES")
   private String meetingTimes;
   //MEETING_PLACE
	@Column(name = "MEETING_PLACE")
   private String meetingPlace;
   //MEETING_THEME
	@Column(name = "MEETING_THEME")
   private String meetingTheme;
   //PEOPLE_LIST
	@Column(name = "PEOPLE_LIST")
   private String peopleList;
   //MEETING_RESULT
	@Column(name = "MEETING_RESULT")
   private String meetingResult;
   //NOTE
	@Column(name = "NOTE")
   private String note;
   //MEETING_YEAR
	@Column(name = "MEETING_YEAR")
   private String meetingYear;
   //MEETING_MONTH
	@Column(name = "MEETING_MONTH")
   private String meetingMonth;
   //MEETING_DAY
	@Column(name = "MEETING_DAY")
   private String meetingDay;
   //NO_PEOPLE_LIST
	@Column(name = "NO_PEOPLE_LIST")
   private String noPeopleList;
   //SUPER_LIST
	@Column(name = "SUPER_LIST")
   private String superList;
   //NO_SUPER_LIST
	@Column(name = "NO_SUPER_LIST")
   private String noSuperList;
   //SEQ
	@Column(name = "SEQ")
   private String seq;
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
    * getter for MEETING_NUMBER
    * @generated
    */
   public String getMeetingNumber(){
      return this.meetingNumber;
   }
   /**
    * setter for MEETING_NUMBER
    * @generated
    */
   public void setMeetingNumber(String meetingNumber){
      this.meetingNumber = meetingNumber;
   }

   /**
    * getter for MEETING_TIMES
    * @generated
    */
   public String getMeetingTimes(){
      return this.meetingTimes;
   }
   /**
    * setter for MEETING_TIMES
    * @generated
    */
   public void setMeetingTimes(String meetingTimes){
      this.meetingTimes = meetingTimes;
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
    * getter for MEETING_THEME
    * @generated
    */
   public String getMeetingTheme(){
      return this.meetingTheme;
   }
   /**
    * setter for MEETING_THEME
    * @generated
    */
   public void setMeetingTheme(String meetingTheme){
      this.meetingTheme = meetingTheme;
   }

   /**
    * getter for PEOPLE_LIST
    * @generated
    */
   public String getPeopleList(){
      return this.peopleList;
   }
   /**
    * setter for PEOPLE_LIST
    * @generated
    */
   public void setPeopleList(String peopleList){
      this.peopleList = peopleList;
   }

   /**
    * getter for MEETING_RESULT
    * @generated
    */
   public String getMeetingResult(){
      return this.meetingResult;
   }
   /**
    * setter for MEETING_RESULT
    * @generated
    */
   public void setMeetingResult(String meetingResult){
      this.meetingResult = meetingResult;
   }

   /**
    * getter for NOTE
    * @generated
    */
   public String getNote(){
      return this.note;
   }
   /**
    * setter for NOTE
    * @generated
    */
   public void setNote(String note){
      this.note = note;
   }

   /**
    * getter for MEETING_YEAR
    * @generated
    */
   public String getMeetingYear(){
      return this.meetingYear;
   }
   /**
    * setter for MEETING_YEAR
    * @generated
    */
   public void setMeetingYear(String meetingYear){
      this.meetingYear = meetingYear;
   }

   /**
    * getter for MEETING_MONTH
    * @generated
    */
   public String getMeetingMonth(){
      return this.meetingMonth;
   }
   /**
    * setter for MEETING_MONTH
    * @generated
    */
   public void setMeetingMonth(String meetingMonth){
      this.meetingMonth = meetingMonth;
   }

   /**
    * getter for MEETING_DAY
    * @generated
    */
   public String getMeetingDay(){
      return this.meetingDay;
   }
   /**
    * setter for MEETING_DAY
    * @generated
    */
   public void setMeetingDay(String meetingDay){
      this.meetingDay = meetingDay;
   }

   /**
    * getter for NO_PEOPLE_LIST
    * @generated
    */
   public String getNoPeopleList(){
      return this.noPeopleList;
   }
   /**
    * setter for NO_PEOPLE_LIST
    * @generated
    */
   public void setNoPeopleList(String noPeopleList){
      this.noPeopleList = noPeopleList;
   }

   /**
    * getter for SUPER_LIST
    * @generated
    */
   public String getSuperList(){
      return this.superList;
   }
   /**
    * setter for SUPER_LIST
    * @generated
    */
   public void setSuperList(String superList){
      this.superList = superList;
   }

   /**
    * getter for NO_SUPER_LIST
    * @generated
    */
   public String getNoSuperList(){
      return this.noSuperList;
   }
   /**
    * setter for NO_SUPER_LIST
    * @generated
    */
   public void setNoSuperList(String noSuperList){
      this.noSuperList = noSuperList;
   }

   /**
    * getter for SEQ
    * @generated
    */
   public String getSeq(){
      return this.seq;
   }
   /**
    * setter for SEQ
    * @generated
    */
   public void setSeq(String seq){
      this.seq = seq;
   }

}