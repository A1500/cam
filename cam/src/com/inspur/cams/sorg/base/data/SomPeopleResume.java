package com.inspur.cams.sorg.base.data;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:SomPeopleResume
 * @description:
 * @author:
 * @since:2011-10-31
 * @version:1.0
*/
 @Table(tableName = "SOM_PEOPLE_RESUME" , keyFields = "id")
public class SomPeopleResume extends StatefulDatabean {
   //主键
	@Column(name = "ID")
   private String id;
  //TASK_CODE
	@Column(name = "TASK_CODE")
   private String taskCode;
	//PEOPLE_ID
	@Column(name = "DUTY_ID")
   private String dutyId;
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
   /**
    * getter for 主键
    * @generated
    */
   public String getId(){
      return this.id;
   }
   /**
    * setter for 主键
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
public String getTaskCode() {
	return taskCode;
}
public void setTaskCode(String taskCode) {
	this.taskCode = taskCode;
}
public String getDutyId() {
	return dutyId;
}
public void setDutyId(String dutyId) {
	this.dutyId = dutyId;
}

}