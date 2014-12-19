package com.inspur.cams.sorg.online.base.data;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:SomMeetingOnline
 * @description:
 * @author:
 * @since:2012-11-09
 * @version:1.0
*/
 @Table(tableName = "SOM_MEETING_ONLINE" , keyFields = "meetingId")
public class SomMeetingOnline extends StatefulDatabean {
   //MEETING_ID
   	
	@Column(name = "MEETING_ID")
   private String meetingId;
   //SORG_ID
	@Column(name = "SORG_ID")
   private String sorgId;
   //MEETING_TYPE
	@Column(name = "MEETING_TYPE")
   private String meetingType;
   //MEETING_FORMAT
	@Column(name = "MEETING_FORMAT")
   private String meetingFormat;
   //MEETING_NAME
	@Column(name = "MEETING_NAME")
   private String meetingName;
   //MEETING_PLACE
	@Column(name = "MEETING_PLACE")
   private String meetingPlace;
   //MEETING_DATE
	@Column(name = "MEETING_DATE")
   private String meetingDate;
   //LINK_PEOPLE
	@Column(name = "LINK_PEOPLE")
   private String linkPeople;
   //LINK_PHONE
	@Column(name = "LINK_PHONE")
   private String linkPhone;
   //MAIN_PEOPLE
	@Column(name = "MAIN_PEOPLE")
   private String mainPeople;
   //MORG_NAME
	@Column(name = "MORG_NAME")
   private String morgName;
   //MORG_AREA
	@Column(name = "MORG_AREA")
   private String morgArea;
   //CREATE_PEOPLE
	@Column(name = "CREATE_PEOPLE")
   private String createPeople;
   //CREATE_TIME
	@Column(name = "CREATE_TIME")
   private String createTime;
   /**
    * getter for MEETING_ID
    * @generated
    */
   public String getMeetingId(){
      return this.meetingId;
   }
   /**
    * setter for MEETING_ID
    * @generated
    */
   public void setMeetingId(String meetingId){
      this.meetingId = meetingId;
   }

   /**
    * getter for SORG_ID
    * @generated
    */
   public String getSorgId(){
      return this.sorgId;
   }
   /**
    * setter for SORG_ID
    * @generated
    */
   public void setSorgId(String sorgId){
      this.sorgId = sorgId;
   }

   /**
    * getter for MEETING_TYPE
    * @generated
    */
   public String getMeetingType(){
      return this.meetingType;
   }
   /**
    * setter for MEETING_TYPE
    * @generated
    */
   public void setMeetingType(String meetingType){
      this.meetingType = meetingType;
   }

   /**
    * getter for MEETING_FORMAT
    * @generated
    */
   public String getMeetingFormat(){
      return this.meetingFormat;
   }
   /**
    * setter for MEETING_FORMAT
    * @generated
    */
   public void setMeetingFormat(String meetingFormat){
      this.meetingFormat = meetingFormat;
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
    * getter for LINK_PEOPLE
    * @generated
    */
   public String getLinkPeople(){
      return this.linkPeople;
   }
   /**
    * setter for LINK_PEOPLE
    * @generated
    */
   public void setLinkPeople(String linkPeople){
      this.linkPeople = linkPeople;
   }

   /**
    * getter for LINK_PHONE
    * @generated
    */
   public String getLinkPhone(){
      return this.linkPhone;
   }
   /**
    * setter for LINK_PHONE
    * @generated
    */
   public void setLinkPhone(String linkPhone){
      this.linkPhone = linkPhone;
   }

   /**
    * getter for MAIN_PEOPLE
    * @generated
    */
   public String getMainPeople(){
      return this.mainPeople;
   }
   /**
    * setter for MAIN_PEOPLE
    * @generated
    */
   public void setMainPeople(String mainPeople){
      this.mainPeople = mainPeople;
   }

   /**
    * getter for MORG_NAME
    * @generated
    */
   public String getMorgName(){
      return this.morgName;
   }
   /**
    * setter for MORG_NAME
    * @generated
    */
   public void setMorgName(String morgName){
      this.morgName = morgName;
   }

   /**
    * getter for MORG_AREA
    * @generated
    */
   public String getMorgArea(){
      return this.morgArea;
   }
   /**
    * setter for MORG_AREA
    * @generated
    */
   public void setMorgArea(String morgArea){
      this.morgArea = morgArea;
   }

   /**
    * getter for CREATE_PEOPLE
    * @generated
    */
   public String getCreatePeople(){
      return this.createPeople;
   }
   /**
    * setter for CREATE_PEOPLE
    * @generated
    */
   public void setCreatePeople(String createPeople){
      this.createPeople = createPeople;
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