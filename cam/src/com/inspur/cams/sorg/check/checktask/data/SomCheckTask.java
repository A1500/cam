package com.inspur.cams.sorg.check.checktask.data;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:SomCheckTask
 * @description:
 * @author:
 * @since:2011-12-28
 * @version:1.0
*/
 @Table(tableName = "SOM_CHECK_TASK" , keyFields = "taskId")
public class SomCheckTask extends StatefulDatabean {
   //任务编号
	@Column(name = "TASK_ID")
   private String taskId;
   //任务名称
	@Column(name = "TASK_NAME")
   private String taskName;
	//社会组织类型
	@Column(name = "SORG_TYPE")
   private String sorgType;
   //批次
	@Column(name = "BATCH")
   private String batch;
   //批次年份
	@Column(name = "BATCH_YEAR")
   private String batchYear;
   //有效期至
	@Column(name = "VALID_DATE")
   private String validDate;
   //是否有效
	@Column(name = "IF_VALID")
   private String ifValid;
   //添加日期
	@Column(name = "ADD_DATE")
   private String addDate;
   //添加人名称
	@Column(name = "ADD_PERSONN")
   private String addPersonn;
   //添加人id
	@Column(name = "ADD_PERSONN_ID")
   private String addPersonnId;
   //添加单位名称
	@Column(name = "ADD_ORGAN")
   private String addOrgan;
   //添加单位id
	@Column(name = "ADD_ORGAN_ID")
   private String addOrganId;
	//行政区划
	@Column(name = "AREA_CODE")
   private String areaCode;
   /**
    * getter for 任务编号
    * @generated
    */
   public String getTaskId(){
      return this.taskId;
   }
   /**
    * setter for 任务编号
    * @generated
    */
   public void setTaskId(String taskId){
      this.taskId = taskId;
   }

   /**
    * getter for 任务名称
    * @generated
    */
   public String getTaskName(){
      return this.taskName;
   }
   /**
    * setter for 任务名称
    * @generated
    */
   public void setTaskName(String taskName){
      this.taskName = taskName;
   }

   /**
    * getter for 批次
    * @generated
    */
   public String getBatch(){
      return this.batch;
   }
   /**
    * setter for 批次
    * @generated
    */
   public void setBatch(String batch){
      this.batch = batch;
   }

   /**
    * getter for 批次年份
    * @generated
    */
   public String getBatchYear(){
      return this.batchYear;
   }
   /**
    * setter for 批次年份
    * @generated
    */
   public void setBatchYear(String batchYear){
      this.batchYear = batchYear;
   }

   /**
    * getter for 有效期至
    * @generated
    */
   public String getValidDate(){
      return this.validDate;
   }
   /**
    * setter for 有效期至
    * @generated
    */
   public void setValidDate(String validDate){
      this.validDate = validDate;
   }

   /**
    * getter for 是否有效
    * @generated
    */
   public String getIfValid(){
      return this.ifValid;
   }
   /**
    * setter for 是否有效
    * @generated
    */
   public void setIfValid(String ifValid){
      this.ifValid = ifValid;
   }

   /**
    * getter for 添加日期
    * @generated
    */
   public String getAddDate(){
      return this.addDate;
   }
   /**
    * setter for 添加日期
    * @generated
    */
   public void setAddDate(String addDate){
      this.addDate = addDate;
   }

   /**
    * getter for 添加人名称
    * @generated
    */
   public String getAddPersonn(){
      return this.addPersonn;
   }
   /**
    * setter for 添加人名称
    * @generated
    */
   public void setAddPersonn(String addPersonn){
      this.addPersonn = addPersonn;
   }

   /**
    * getter for 添加人id
    * @generated
    */
   public String getAddPersonnId(){
      return this.addPersonnId;
   }
   /**
    * setter for 添加人id
    * @generated
    */
   public void setAddPersonnId(String addPersonnId){
      this.addPersonnId = addPersonnId;
   }

   /**
    * getter for 添加单位名称
    * @generated
    */
   public String getAddOrgan(){
      return this.addOrgan;
   }
   /**
    * setter for 添加单位名称
    * @generated
    */
   public void setAddOrgan(String addOrgan){
      this.addOrgan = addOrgan;
   }

   /**
    * getter for 添加单位id
    * @generated
    */
   public String getAddOrganId(){
      return this.addOrganId;
   }
   /**
    * setter for 添加单位id
    * @generated
    */
   public void setAddOrganId(String addOrganId){
      this.addOrganId = addOrganId;
   }
public String getSorgType() {
	return sorgType;
}
public void setSorgType(String sorgType) {
	this.sorgType = sorgType;
}
public String getAreaCode() {
	return areaCode;
}
public void setAreaCode(String areaCode) {
	this.areaCode = areaCode;
}

}