package com.inspur.cams.sorg.check.checkmeetingelection.data;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * @title:SomCheckMeetingElection
 * @description:
 * @author:
 * @since:2012-01-06
 * @version:1.0
*/
 @Table(tableName = "SOM_CHECK_MEETING_ELECTION" , keyFields = "id")
public class SomCheckMeetingElection extends StatefulDatabean {
   //ID
   	
	@Column(name = "ID")
   private String id;
   //TASK_CODE
	@Column(name = "TASK_CODE")
   private String taskCode;
   //GENERAL_ELECTION_YEARS
	@Column(name = "GENERAL_ELECTION_YEARS")
   private String generalElectionYears;
   //ORDER_COUNCIL_YEARS
	@Column(name = "ORDER_COUNCIL_YEARS")
   private String orderCouncilYears;
   //ORDER_COUNCIL_TIMES
	@Column(name = "ORDER_COUNCIL_TIMES")
   private String orderCouncilTimes;
   //ORDER_GENERALCOUNCIL_YEARS
	@Column(name = "ORDER_GENERALCOUNCIL_YEARS")
   private String orderGeneralcouncilYears;
   //ORDER_GENERALCOUNCIL_TIMES
	@Column(name = "ORDER_GENERALCOUNCIL_TIMES")
   private String orderGeneralcouncilTimes;
   //ELECTION_MEETING_TIME
	@Column(name = "ELECTION_MEETING_TIME")
   private String electionMeetingTime;
   //COUNCIL_TIMES
	@Column(name = "COUNCIL_TIMES")
   private String councilTimes;
   //GENERALCOUNCIL_TIMES
	@Column(name = "GENERALCOUNCIL_TIMES")
   private String generalcouncilTimes;
   //REASON
	@Column(name = "REASON")
   private String reason;
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
    * getter for GENERAL_ELECTION_YEARS
    * @generated
    */
   public String getGeneralElectionYears(){
      return this.generalElectionYears;
   }
   /**
    * setter for GENERAL_ELECTION_YEARS
    * @generated
    */
   public void setGeneralElectionYears(String generalElectionYears){
      this.generalElectionYears = generalElectionYears;
   }

   /**
    * getter for ORDER_COUNCIL_YEARS
    * @generated
    */
   public String getOrderCouncilYears(){
      return this.orderCouncilYears;
   }
   /**
    * setter for ORDER_COUNCIL_YEARS
    * @generated
    */
   public void setOrderCouncilYears(String orderCouncilYears){
      this.orderCouncilYears = orderCouncilYears;
   }

   /**
    * getter for ORDER_COUNCIL_TIMES
    * @generated
    */
   public String getOrderCouncilTimes(){
      return this.orderCouncilTimes;
   }
   /**
    * setter for ORDER_COUNCIL_TIMES
    * @generated
    */
   public void setOrderCouncilTimes(String orderCouncilTimes){
      this.orderCouncilTimes = orderCouncilTimes;
   }

   /**
    * getter for ORDER_GENERALCOUNCIL_YEARS
    * @generated
    */
   public String getOrderGeneralcouncilYears(){
      return this.orderGeneralcouncilYears;
   }
   /**
    * setter for ORDER_GENERALCOUNCIL_YEARS
    * @generated
    */
   public void setOrderGeneralcouncilYears(String orderGeneralcouncilYears){
      this.orderGeneralcouncilYears = orderGeneralcouncilYears;
   }

   /**
    * getter for ORDER_GENERALCOUNCIL_TIMES
    * @generated
    */
   public String getOrderGeneralcouncilTimes(){
      return this.orderGeneralcouncilTimes;
   }
   /**
    * setter for ORDER_GENERALCOUNCIL_TIMES
    * @generated
    */
   public void setOrderGeneralcouncilTimes(String orderGeneralcouncilTimes){
      this.orderGeneralcouncilTimes = orderGeneralcouncilTimes;
   }

   /**
    * getter for ELECTION_MEETING_TIME
    * @generated
    */
   public String getElectionMeetingTime(){
      return this.electionMeetingTime;
   }
   /**
    * setter for ELECTION_MEETING_TIME
    * @generated
    */
   public void setElectionMeetingTime(String electionMeetingTime){
      this.electionMeetingTime = electionMeetingTime;
   }

   /**
    * getter for COUNCIL_TIMES
    * @generated
    */
   public String getCouncilTimes(){
      return this.councilTimes;
   }
   /**
    * setter for COUNCIL_TIMES
    * @generated
    */
   public void setCouncilTimes(String councilTimes){
      this.councilTimes = councilTimes;
   }

   /**
    * getter for GENERALCOUNCIL_TIMES
    * @generated
    */
   public String getGeneralcouncilTimes(){
      return this.generalcouncilTimes;
   }
   /**
    * setter for GENERALCOUNCIL_TIMES
    * @generated
    */
   public void setGeneralcouncilTimes(String generalcouncilTimes){
      this.generalcouncilTimes = generalcouncilTimes;
   }

   /**
    * getter for REASON
    * @generated
    */
   public String getReason(){
      return this.reason;
   }
   /**
    * setter for REASON
    * @generated
    */
   public void setReason(String reason){
      this.reason = reason;
   }

}