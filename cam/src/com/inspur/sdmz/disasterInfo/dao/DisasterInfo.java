package com.inspur.sdmz.disasterInfo.dao;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:DisasterInfo
 * @description:
 * @author:
 * @since:2011-09-13
 * @version:1.0
*/
 @Table(tableName = "DISASTER_INFO" , keyFields = "disasterId")
public class DisasterInfo extends StatefulDatabean {
   //业务编号
	@Column(name = "DISASTER_ID")
   private String disasterId;
   //灾情标题
	@Column(name = "DISASTER_TITLE")
   private String disasterTitle;
   //灾情发生时间
	@Column(name = "DISASTER_TIME")
   private String disasterTime;
   //灾情发生地点
	@Column(name = "DISASTER_ADD")
   private String disasterAdd;
   //灾情情况
	@Column(name = "DISASTER_SITUATION")
   private String disasterSituation;
   //上报人
	@Column(name = "REG_PEOPLE")
   private String regPeople;
   //上报人ID
	@Column(name = "REG_PEOPLE_ID")
   private String regPeopleId;
   //上报单位
	@Column(name = "REG_ORGAN")
   private String regOrgan;
   //上报单位ID
	@Column(name = "REG_ORGAN_ID")
   private String regOrganId;
   //上报单位区划
	@Column(name = "REG_ORGAN_AREA")
   private String regOrganArea;
   //上报时间
	@Column(name = "REG_TIME")
   private String regTime;
   //修改人
	@Column(name = "MOD_PEOPLE")
   private String modPeople;
   //修改人ID
	@Column(name = "MOD_PEOPLE_ID")
   private String modPeopleId;
   //修改单位
	@Column(name = "MOD_ORGAN")
   private String modOrgan;
   //修改单位ID
	@Column(name = "MOD_ORGAN_ID")
   private String modOrganId;
   //修改单位区划
	@Column(name = "MOD_ORGAN_AREA")
   private String modOrganArea;
   //修改时间
	@Column(name = "MOD_TIME")
   private String modTime;
   /**
    * getter for 业务编号
    * @generated
    */
   public String getDisasterId(){
      return this.disasterId;
   }
   /**
    * setter for 业务编号
    * @generated
    */
   public void setDisasterId(String disasterId){
      this.disasterId = disasterId;
   }

   /**
    * getter for 灾情标题
    * @generated
    */
   public String getDisasterTitle(){
      return this.disasterTitle;
   }
   /**
    * setter for 灾情标题
    * @generated
    */
   public void setDisasterTitle(String disasterTitle){
      this.disasterTitle = disasterTitle;
   }

   /**
    * getter for 灾情发生时间
    * @generated
    */
   public String getDisasterTime(){
      return this.disasterTime;
   }
   /**
    * setter for 灾情发生时间
    * @generated
    */
   public void setDisasterTime(String disasterTime){
      this.disasterTime = disasterTime;
   }

   /**
    * getter for 灾情发生地点
    * @generated
    */
   public String getDisasterAdd(){
      return this.disasterAdd;
   }
   /**
    * setter for 灾情发生地点
    * @generated
    */
   public void setDisasterAdd(String disasterAdd){
      this.disasterAdd = disasterAdd;
   }

   /**
    * getter for 灾情情况
    * @generated
    */
   public String getDisasterSituation(){
      return this.disasterSituation;
   }
   /**
    * setter for 灾情情况
    * @generated
    */
   public void setDisasterSituation(String disasterSituation){
      this.disasterSituation = disasterSituation;
   }

   /**
    * getter for 上报人
    * @generated
    */
   public String getRegPeople(){
      return this.regPeople;
   }
   /**
    * setter for 上报人
    * @generated
    */
   public void setRegPeople(String regPeople){
      this.regPeople = regPeople;
   }

   /**
    * getter for 上报人ID
    * @generated
    */
   public String getRegPeopleId(){
      return this.regPeopleId;
   }
   /**
    * setter for 上报人ID
    * @generated
    */
   public void setRegPeopleId(String regPeopleId){
      this.regPeopleId = regPeopleId;
   }

   /**
    * getter for 上报单位
    * @generated
    */
   public String getRegOrgan(){
      return this.regOrgan;
   }
   /**
    * setter for 上报单位
    * @generated
    */
   public void setRegOrgan(String regOrgan){
      this.regOrgan = regOrgan;
   }

   /**
    * getter for 上报单位ID
    * @generated
    */
   public String getRegOrganId(){
      return this.regOrganId;
   }
   /**
    * setter for 上报单位ID
    * @generated
    */
   public void setRegOrganId(String regOrganId){
      this.regOrganId = regOrganId;
   }

   /**
    * getter for 上报单位区划
    * @generated
    */
   public String getRegOrganArea(){
      return this.regOrganArea;
   }
   /**
    * setter for 上报单位区划
    * @generated
    */
   public void setRegOrganArea(String regOrganArea){
      this.regOrganArea = regOrganArea;
   }

   /**
    * getter for 上报时间
    * @generated
    */
   public String getRegTime(){
      return this.regTime;
   }
   /**
    * setter for 上报时间
    * @generated
    */
   public void setRegTime(String regTime){
      this.regTime = regTime;
   }

   /**
    * getter for 修改人
    * @generated
    */
   public String getModPeople(){
      return this.modPeople;
   }
   /**
    * setter for 修改人
    * @generated
    */
   public void setModPeople(String modPeople){
      this.modPeople = modPeople;
   }

   /**
    * getter for 修改人ID
    * @generated
    */
   public String getModPeopleId(){
      return this.modPeopleId;
   }
   /**
    * setter for 修改人ID
    * @generated
    */
   public void setModPeopleId(String modPeopleId){
      this.modPeopleId = modPeopleId;
   }

 
   public String getModOrgan() {
	return modOrgan;
}
public void setModOrgan(String modOrgan) {
	this.modOrgan = modOrgan;
}
/**
    * getter for 修改单位ID
    * @generated
    */
   public String getModOrganId(){
      return this.modOrganId;
   }
   /**
    * setter for 修改单位ID
    * @generated
    */
   public void setModOrganId(String modOrganId){
      this.modOrganId = modOrganId;
   }

   /**
    * getter for 修改单位区划
    * @generated
    */
   public String getModOrganArea(){
      return this.modOrganArea;
   }
   /**
    * setter for 修改单位区划
    * @generated
    */
   public void setModOrganArea(String modOrganArea){
      this.modOrganArea = modOrganArea;
   }

   /**
    * getter for 修改时间
    * @generated
    */
   public String getModTime(){
      return this.modTime;
   }
   /**
    * setter for 修改时间
    * @generated
    */
   public void setModTime(String modTime){
      this.modTime = modTime;
   }

}