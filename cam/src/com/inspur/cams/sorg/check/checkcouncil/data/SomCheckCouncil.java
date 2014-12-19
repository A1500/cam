package com.inspur.cams.sorg.check.checkcouncil.data;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:SomCheckCouncil
 * @description:
 * @author:
 * @since:2011-12-27
 * @version:1.0
*/
 @Table(tableName = "SOM_CHECK_COUNCIL" , keyFields = "id")
public class SomCheckCouncil extends StatefulDatabean {
   //主键
   	
	@Column(name = "ID")
   private String id;
   //业务编号
	@Column(name = "TASK_CODE")
   private String taskCode;
   //理事长姓名
	@Column(name = "CHAIRMAN_NAME")
   private String chairmanName;
   //理事人数
	@Column(name = "COUNCIL_NUM")
   private String councilNum;
   //监事数
	@Column(name = "SUPERVISOR_NUM")
   private String supervisorNum;
   //秘书长以上负责人人数
	@Column(name = "SECRETARYGENERAL_NUM")
   private String secretarygeneralNum;
   //秘书长姓名
	@Column(name = "SECRETARYGENERAL_NAME")
   private String secretarygeneralName;
   //秘书长固定电话
	@Column(name = "SECRETARYGENERAL_PHONE")
   private String secretarygeneralPhone;
   //秘书长移动电话
	@Column(name = "SECRETARYGENERAL_MOBILE")
   private String secretarygeneralMobile;
   //常务理事人数
	@Column(name = "EXECUTIVE_DIRECTOR_NUM")
   private String executiveDirectorNum;
   //秘书长专兼职情况
	@Column(name = "SECRETARYGENERAL_TYPE")
   private String secretarygeneralType;
   //现职公务员兼任负责人省级人数
	@Column(name = "SERVANT_PRO_NUM")
   private String servantProNum;
   //现职公务员兼任负责人地厅级人数
	@Column(name = "SERVANT_CITY_NUM")
   private String servantCityNum;
   //现职公务员兼任负责人县级人数
	@Column(name = "SERVANT_TOWN_NUM")
   private String servantTownNum;
   //离退休人员担任负责人总数
	@Column(name = "RETIRED_SUM_NUM")
   private String retiredSumNum;
   //离退休人员担任负责人地厅及以上人数
	@Column(name = "RETIRED_CITY_NUM")
   private String retiredCityNum;
   //离退休人员担任负责人70岁以上人数
	@Column(name = "RETIRED_OLD_NUM")
   private String retiredOldNum;
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
    * getter for 理事长姓名
    * @generated
    */
   public String getChairmanName(){
      return this.chairmanName;
   }
   /**
    * setter for 理事长姓名
    * @generated
    */
   public void setChairmanName(String chairmanName){
      this.chairmanName = chairmanName;
   }

   /**
    * getter for 理事人数
    * @generated
    */
   public String getCouncilNum(){
      return this.councilNum;
   }
   /**
    * setter for 理事人数
    * @generated
    */
   public void setCouncilNum(String councilNum){
      this.councilNum = councilNum;
   }

   /**
    * getter for 监事数
    * @generated
    */
   public String getSupervisorNum(){
      return this.supervisorNum;
   }
   /**
    * setter for 监事数
    * @generated
    */
   public void setSupervisorNum(String supervisorNum){
      this.supervisorNum = supervisorNum;
   }

   /**
    * getter for 秘书长以上负责人人数
    * @generated
    */
   public String getSecretarygeneralNum(){
      return this.secretarygeneralNum;
   }
   /**
    * setter for 秘书长以上负责人人数
    * @generated
    */
   public void setSecretarygeneralNum(String secretarygeneralNum){
      this.secretarygeneralNum = secretarygeneralNum;
   }

   /**
    * getter for 秘书长姓名
    * @generated
    */
   public String getSecretarygeneralName(){
      return this.secretarygeneralName;
   }
   /**
    * setter for 秘书长姓名
    * @generated
    */
   public void setSecretarygeneralName(String secretarygeneralName){
      this.secretarygeneralName = secretarygeneralName;
   }

   /**
    * getter for 秘书长固定电话
    * @generated
    */
   public String getSecretarygeneralPhone(){
      return this.secretarygeneralPhone;
   }
   /**
    * setter for 秘书长固定电话
    * @generated
    */
   public void setSecretarygeneralPhone(String secretarygeneralPhone){
      this.secretarygeneralPhone = secretarygeneralPhone;
   }

   /**
    * getter for 秘书长移动电话
    * @generated
    */
   public String getSecretarygeneralMobile(){
      return this.secretarygeneralMobile;
   }
   /**
    * setter for 秘书长移动电话
    * @generated
    */
   public void setSecretarygeneralMobile(String secretarygeneralMobile){
      this.secretarygeneralMobile = secretarygeneralMobile;
   }

   /**
    * getter for 常务理事人数
    * @generated
    */
   public String getExecutiveDirectorNum(){
      return this.executiveDirectorNum;
   }
   /**
    * setter for 常务理事人数
    * @generated
    */
   public void setExecutiveDirectorNum(String executiveDirectorNum){
      this.executiveDirectorNum = executiveDirectorNum;
   }

   /**
    * getter for 秘书长专兼职情况
    * @generated
    */
   public String getSecretarygeneralType(){
      return this.secretarygeneralType;
   }
   /**
    * setter for 秘书长专兼职情况
    * @generated
    */
   public void setSecretarygeneralType(String secretarygeneralType){
      this.secretarygeneralType = secretarygeneralType;
   }

   /**
    * getter for 现职公务员兼任负责人省级人数
    * @generated
    */
   public String getServantProNum(){
      return this.servantProNum;
   }
   /**
    * setter for 现职公务员兼任负责人省级人数
    * @generated
    */
   public void setServantProNum(String servantProNum){
      this.servantProNum = servantProNum;
   }

   /**
    * getter for 现职公务员兼任负责人地厅级人数
    * @generated
    */
   public String getServantCityNum(){
      return this.servantCityNum;
   }
   /**
    * setter for 现职公务员兼任负责人地厅级人数
    * @generated
    */
   public void setServantCityNum(String servantCityNum){
      this.servantCityNum = servantCityNum;
   }

   /**
    * getter for 现职公务员兼任负责人县级人数
    * @generated
    */
   public String getServantTownNum(){
      return this.servantTownNum;
   }
   /**
    * setter for 现职公务员兼任负责人县级人数
    * @generated
    */
   public void setServantTownNum(String servantTownNum){
      this.servantTownNum = servantTownNum;
   }

   /**
    * getter for 离退休人员担任负责人总数
    * @generated
    */
   public String getRetiredSumNum(){
      return this.retiredSumNum;
   }
   /**
    * setter for 离退休人员担任负责人总数
    * @generated
    */
   public void setRetiredSumNum(String retiredSumNum){
      this.retiredSumNum = retiredSumNum;
   }

   /**
    * getter for 离退休人员担任负责人地厅及以上人数
    * @generated
    */
   public String getRetiredCityNum(){
      return this.retiredCityNum;
   }
   /**
    * setter for 离退休人员担任负责人地厅及以上人数
    * @generated
    */
   public void setRetiredCityNum(String retiredCityNum){
      this.retiredCityNum = retiredCityNum;
   }

   /**
    * getter for 离退休人员担任负责人70岁以上人数
    * @generated
    */
   public String getRetiredOldNum(){
      return this.retiredOldNum;
   }
   /**
    * setter for 离退休人员担任负责人70岁以上人数
    * @generated
    */
   public void setRetiredOldNum(String retiredOldNum){
      this.retiredOldNum = retiredOldNum;
   }

}