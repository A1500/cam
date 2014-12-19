package com.inspur.cams.sorg.jxcheck.somjxcouncilmeeting.dao;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:SomJxCouncilMeeting
 * @description:
 * @author:
 * @since:2012-02-07
 * @version:1.0
*/
 @Table(tableName = "SOM_JX_COUNCIL_MEETING" , keyFields = "id")
public class SomJxCouncilMeeting extends StatefulDatabean {
   //ID
	@Column(name = "ID")
   private String id;
   //TASK_CODE
	@Column(name = "TASK_CODE")
   private String taskCode;
   //MEETING_YEAR
	@Column(name = "MEETING_YEAR")
   private String meetingYear;
   //MEETING_MONTH
	@Column(name = "MEETING_MONTH")
   private String meetingMonth;
   //MEETING_DAY
	@Column(name = "MEETING_DAY")
   private String meetingDay;
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
	
	private String noPeopleList;
	private String superList;
	private String noSuperList;
	private String seq;
	
   public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
public String getNoPeopleList() {
		return noPeopleList;
	}
	public void setNoPeopleList(String noPeopleList) {
		this.noPeopleList = noPeopleList;
	}
	public String getSuperList() {
		return superList;
	}
	public void setSuperList(String superList) {
		this.superList = superList;
	}
	public String getNoSuperList() {
		return noSuperList;
	}
	public void setNoSuperList(String noSuperList) {
		this.noSuperList = noSuperList;
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

}