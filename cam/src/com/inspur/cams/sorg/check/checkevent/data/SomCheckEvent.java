package com.inspur.cams.sorg.check.checkevent.data;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * @title:SomCheckEvent
 * @description:
 * @author:
 * @since:2012-01-07
 * @version:1.0
*/
 @Table(tableName = "SOM_CHECK_EVENT" , keyFields = "id")
public class SomCheckEvent extends StatefulDatabean {
   //ID
   	
	@Column(name = "ID")
   private String id;
   //TASK_CODE
	@Column(name = "TASK_CODE")
   private String taskCode;
   //SEQUENCE
	@Column(name = "SEQUENCE")
   private String sequence;
   //EVENT_NAME
	@Column(name = "EVENT_NAME")
   private String eventName;
   //EVENT_TYPE
	@Column(name = "EVENT_TYPE")
   private String eventType;
   //EVENT_DATE
	@Column(name = "EVENT_DATE")
   private String eventDate;
   //EVENT_PLACE
	@Column(name = "EVENT_PLACE")
   private String eventPlace;
   //APPROVE_ORGAN
	@Column(name = "APPROVE_ORGAN")
   private String approveOrgan;
   //CHARGE_STATUS
	@Column(name = "CHARGE_STATUS")
   private String chargeStatus;
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
    * getter for SEQUENCE
    * @generated
    */
   public String getSequence(){
      return this.sequence;
   }
   /**
    * setter for SEQUENCE
    * @generated
    */
   public void setSequence(String sequence){
      this.sequence = sequence;
   }

   /**
    * getter for EVENT_NAME
    * @generated
    */
   public String getEventName(){
      return this.eventName;
   }
   /**
    * setter for EVENT_NAME
    * @generated
    */
   public void setEventName(String eventName){
      this.eventName = eventName;
   }

   /**
    * getter for EVENT_TYPE
    * @generated
    */
   public String getEventType(){
      return this.eventType;
   }
   /**
    * setter for EVENT_TYPE
    * @generated
    */
   public void setEventType(String eventType){
      this.eventType = eventType;
   }

   /**
    * getter for EVENT_DATE
    * @generated
    */
   public String getEventDate(){
      return this.eventDate;
   }
   /**
    * setter for EVENT_DATE
    * @generated
    */
   public void setEventDate(String eventDate){
      this.eventDate = eventDate;
   }

   /**
    * getter for EVENT_PLACE
    * @generated
    */
   public String getEventPlace(){
      return this.eventPlace;
   }
   /**
    * setter for EVENT_PLACE
    * @generated
    */
   public void setEventPlace(String eventPlace){
      this.eventPlace = eventPlace;
   }

   /**
    * getter for APPROVE_ORGAN
    * @generated
    */
   public String getApproveOrgan(){
      return this.approveOrgan;
   }
   /**
    * setter for APPROVE_ORGAN
    * @generated
    */
   public void setApproveOrgan(String approveOrgan){
      this.approveOrgan = approveOrgan;
   }

   /**
    * getter for CHARGE_STATUS
    * @generated
    */
   public String getChargeStatus(){
      return this.chargeStatus;
   }
   /**
    * setter for CHARGE_STATUS
    * @generated
    */
   public void setChargeStatus(String chargeStatus){
      this.chargeStatus = chargeStatus;
   }

}