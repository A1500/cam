package com.inspur.cams.sorg.online.base.data;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:SomPeopleResumeOnline
 * @description:
 * @author:
 * @since:2012-11-08
 * @version:1.0
*/
 @Table(tableName = "SOM_PEOPLE_RESUME_ONLINE" , keyFields = "id")
public class SomPeopleResumeOnline extends StatefulDatabean {
   //ID
   	
	@Column(name = "ID")
   private String id;
   //PEOPLE_ID
	@Column(name = "PEOPLE_ID")
   private String peopleId;
   //START_DATE
	@Column(name = "START_DATE")
   private String startDate;
   //END_DATE
	@Column(name = "END_DATE")
   private String endDate;
   //WORK_ORGAN
	@Column(name = "WORK_ORGAN")
   private String workOrgan;
   //DUTY
	@Column(name = "DUTY")
   private String duty;
   //TASK_CODE
	@Column(name = "TASK_CODE")
   private String taskCode;
   //DUTY_ID
	@Column(name = "DUTY_ID")
   private String dutyId;
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
    * getter for PEOPLE_ID
    * @generated
    */
   public String getPeopleId(){
      return this.peopleId;
   }
   /**
    * setter for PEOPLE_ID
    * @generated
    */
   public void setPeopleId(String peopleId){
      this.peopleId = peopleId;
   }

   /**
    * getter for START_DATE
    * @generated
    */
   public String getStartDate(){
      return this.startDate;
   }
   /**
    * setter for START_DATE
    * @generated
    */
   public void setStartDate(String startDate){
      this.startDate = startDate;
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
    * getter for WORK_ORGAN
    * @generated
    */
   public String getWorkOrgan(){
      return this.workOrgan;
   }
   /**
    * setter for WORK_ORGAN
    * @generated
    */
   public void setWorkOrgan(String workOrgan){
      this.workOrgan = workOrgan;
   }

   /**
    * getter for DUTY
    * @generated
    */
   public String getDuty(){
      return this.duty;
   }
   /**
    * setter for DUTY
    * @generated
    */
   public void setDuty(String duty){
      this.duty = duty;
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
    * getter for DUTY_ID
    * @generated
    */
   public String getDutyId(){
      return this.dutyId;
   }
   /**
    * setter for DUTY_ID
    * @generated
    */
   public void setDutyId(String dutyId){
      this.dutyId = dutyId;
   }

}