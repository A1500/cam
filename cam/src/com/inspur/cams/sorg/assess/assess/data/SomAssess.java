package com.inspur.cams.sorg.assess.assess.data;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:SomAssess
 * @description:
 * @author:
 * @since:2011-12-06
 * @version:1.0
*/
 @Table(tableName = "SOM_ASSESS" , keyFields = "taskCode")
public class SomAssess extends StatefulDatabean {
   //业务编号
	@Column(name = "TASK_CODE")
   private String taskCode;
   //任务编号
	@Column(name = "TASK_ID")
   private String taskId;
   //评估类型
	@Column(name = "ASSESS_TYPE")
   private String assessType;
   //评估社会组织类型
	@Column(name = "SORG_TYPE")
   private String sorgType;
   //评估社会组织登记证号
	@Column(name = "SORG_CODE")
   private String sorgCode;
   //社会组织名称
	@Column(name = "SORG_NAME")
   private String sorgName;
   //总分数
	@Column(name = "SCORE")
   private String score;
   //评估人姓名
	@Column(name = "ASSESS_PERSON_NAME")
   private String assessPersonName;
   //登陆人姓名
	@Column(name = "LOGIN_NAME")
   private String loginName;
   //登陆人组织机构代码
	@Column(name = "LOGIN_ORGAN_ID")
   private String loginOrganId;
   //登陆人所在行政区划
	@Column(name = "AREA_CODE")
   private String areaCode;
   //评估时间
	@Column(name = "ASSESS_DATE")
   private String assessDate;
   //备注
	@Column(name = "NOTE")
   private String note;
   /**
    * getter for 业务编号
    * @generated
    */
   public String getTaskCode(){
      return this.taskCode;
   }
   /**
    * setter for 业务编号
    * @generated
    */
   public void setTaskCode(String taskCode){
      this.taskCode = taskCode;
   }

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
    * getter for 评估类型
    * @generated
    */
   public String getAssessType(){
      return this.assessType;
   }
   /**
    * setter for 评估类型
    * @generated
    */
   public void setAssessType(String assessType){
      this.assessType = assessType;
   }

   /**
    * getter for 评估社会组织类型
    * @generated
    */
   public String getSorgType(){
      return this.sorgType;
   }
   /**
    * setter for 评估社会组织类型
    * @generated
    */
   public void setSorgType(String sorgType){
      this.sorgType = sorgType;
   }

   /**
    * getter for 评估社会组织登记证号
    * @generated
    */
   public String getSorgCode(){
      return this.sorgCode;
   }
   /**
    * setter for 评估社会组织登记证号
    * @generated
    */
   public void setSorgCode(String sorgCode){
      this.sorgCode = sorgCode;
   }

   /**
    * getter for 社会组织名称
    * @generated
    */
   public String getSorgName(){
      return this.sorgName;
   }
   /**
    * setter for 社会组织名称
    * @generated
    */
   public void setSorgName(String sorgName){
      this.sorgName = sorgName;
   }

   /**
    * getter for 总分数
    * @generated
    */
   public String getScore(){
      return this.score;
   }
   /**
    * setter for 总分数
    * @generated
    */
   public void setScore(String score){
      this.score = score;
   }

   /**
    * getter for 评估人姓名
    * @generated
    */
   public String getAssessPersonName(){
      return this.assessPersonName;
   }
   /**
    * setter for 评估人姓名
    * @generated
    */
   public void setAssessPersonName(String assessPersonName){
      this.assessPersonName = assessPersonName;
   }

   /**
    * getter for 登陆人姓名
    * @generated
    */
   public String getLoginName(){
      return this.loginName;
   }
   /**
    * setter for 登陆人姓名
    * @generated
    */
   public void setLoginName(String loginName){
      this.loginName = loginName;
   }

   /**
    * getter for 登陆人组织机构代码
    * @generated
    */
   public String getLoginOrganId(){
      return this.loginOrganId;
   }
   /**
    * setter for 登陆人组织机构代码
    * @generated
    */
   public void setLoginOrganId(String loginOrganId){
      this.loginOrganId = loginOrganId;
   }

   /**
    * getter for 登陆人所在行政区划
    * @generated
    */
   public String getAreaCode(){
      return this.areaCode;
   }
   /**
    * setter for 登陆人所在行政区划
    * @generated
    */
   public void setAreaCode(String areaCode){
      this.areaCode = areaCode;
   }

   /**
    * getter for 评估时间
    * @generated
    */
   public String getAssessDate(){
      return this.assessDate;
   }
   /**
    * setter for 评估时间
    * @generated
    */
   public void setAssessDate(String assessDate){
      this.assessDate = assessDate;
   }

   /**
    * getter for 备注
    * @generated
    */
   public String getNote(){
      return this.note;
   }
   /**
    * setter for 备注
    * @generated
    */
   public void setNote(String note){
      this.note = note;
   }

}