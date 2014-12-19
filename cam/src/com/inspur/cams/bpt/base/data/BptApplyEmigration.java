package com.inspur.cams.bpt.base.data;

import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * @description:优抚_抚恤关系跨省迁出
 * @since:2011-07-29
 * @version:1.0
*/
 @Table(tableName = "BPT_APPLY_EMIGRATION" , keyFields = "applyId")
public class BptApplyEmigration extends StatefulDatabean {
   //申请ID
   	@Rule(value="require")
	@Column(name = "APPLY_ID")
   private String applyId;
   //人员ID
   	@Rule(value="require")
	@Column(name = "PEOPLE_ID")
   private String peopleId;
   //业务类型
	@Column(name = "SERVICE_TYPE")
   private String serviceType;
   //抚恤金已发至月份
	@Column(name = "ALLOWANCE_MONTH")
   private String allowanceMonth;
   //申请时间
	@Column(name = "APPLY_DATE")
   private String applyDate;
   //申请机构
	@Column(name = "APPLY_ORGANIZATION")
   private String applyOrganization;
   //迁入地
	@Column(name = "INGOING_ADDRESS")
   private String ingoingAddress;
   //县级受理人员
	@Column(name = "TOWN_CHECK_PEOPLE")
   private String townCheckPeople;
   //县级受理时间
	@Column(name = "TOWN_CHECK_DATE")
   private String townCheckDate;
   //县级受理联系电话
	@Column(name = "TOWN_CHECK_PHONE")
   private String townCheckPhone;
   //县级审核负责人
	@Column(name = "TOWN_ADUIT_INCHARGE")
   private String townAduitIncharge;
   //县级审核时间
	@Column(name = "TOWN_ADUIT_APPROVE_DATE")
   private String townAduitApproveDate;
   //县级审核意见
	@Column(name = "TOWN_ADUIT_ADVICE")
   private String townAduitAdvice;
   //市级受理人员
	@Column(name = "CITY_CHECK_PEOPLE")
   private String cityCheckPeople;
   //市级受理时间
	@Column(name = "CITY_CHECK_DATE")
   private String cityCheckDate;
   //市级受理意见
	@Column(name = "CITY_CHECK_ADVICE")
   private String cityCheckAdvice;
   //市级受理联系电话
	@Column(name = "CITY_CHECK_PHONE")
   private String cityCheckPhone;
   //市级审核负责人
	@Column(name = "CITY_ADUIT_INCHARGE")
   private String cityAduitIncharge;
   //市级审核时间
	@Column(name = "CITY_ADUIT_APPROVE_DATE")
   private String cityAduitApproveDate;
   //市级审核意见
	@Column(name = "CITY_ADUIT_ADVICE")
   private String cityAduitAdvice;
   //省厅受理时间
	@Column(name = "PROVINCE_CHECK_DATE")
   private String provinceCheckDate;
   //省厅受理人员
	@Column(name = "PROVINCE_CHECK_PEOPLE")
   private String provinceCheckPeople;
   //省厅受理意见
	@Column(name = "PROVINCE_CHECK_ADVICE")
   private String provinceCheckAdvice;
   //省厅受理联系电话
	@Column(name = "PROVINCE_CHECK_PHONE")
   private String provinceCheckPhone;
   //省厅审核负责人
	@Column(name = "PROVINCE_ADUIT_INCHARGE")
   private String provinceAduitIncharge;
   //省厅审核时间
	@Column(name = "PROVINCE_ADUIT_APPROVE_DATE")
   private String provinceAduitApproveDate;
   //省厅审核意见
	@Column(name = "PROVINCE_ADUIT_ADVICE")
   private String provinceAduitAdvice;
   //省厅审批负责人
	@Column(name = "PROVINCE_INCHARGE")
   private String provinceIncharge;
   //省厅审批时间
	@Column(name = "PROVINCE_APPROVE_DATE")
   private String provinceApproveDate;
   //省厅审批意见
	@Column(name = "PROVINCE_ADVICE")
   private String provinceAdvice;
   //备注
	@Column(name = "NOTE")
   private String note;
   //发起标志
	@Column(name = "COMMIT_FLAG")
   private String commitFlag;
	   //迁入地
	@Column(name = "INGOING_CODE")
   private String ingoingCode;
   /**
    * getter for 申请ID
    * @generated
    */
   public String getApplyId(){
      return this.applyId;
   }
   /**
    * setter for 申请ID
    * @generated
    */
   public void setApplyId(String applyId){
      this.applyId = applyId;
   }

   /**
    * getter for 人员ID
    * @generated
    */
   public String getPeopleId(){
      return this.peopleId;
   }
   /**
    * setter for 人员ID
    * @generated
    */
   public void setPeopleId(String peopleId){
      this.peopleId = peopleId;
   }

   /**
    * getter for 业务类型
    * @generated
    */
   public String getServiceType(){
      return this.serviceType;
   }
   /**
    * setter for 业务类型
    * @generated
    */
   public void setServiceType(String serviceType){
      this.serviceType = serviceType;
   }

   /**
    * getter for 抚恤金已发至月份
    * @generated
    */
   public String getAllowanceMonth(){
      return this.allowanceMonth;
   }
   /**
    * setter for 抚恤金已发至月份
    * @generated
    */
   public void setAllowanceMonth(String allowanceMonth){
      this.allowanceMonth = allowanceMonth;
   }

   /**
    * getter for 申请时间
    * @generated
    */
   public String getApplyDate(){
      return this.applyDate;
   }
   /**
    * setter for 申请时间
    * @generated
    */
   public void setApplyDate(String applyDate){
      this.applyDate = applyDate;
   }

   /**
    * getter for 申请机构
    * @generated
    */
   public String getApplyOrganization(){
      return this.applyOrganization;
   }
   /**
    * setter for 申请机构
    * @generated
    */
   public void setApplyOrganization(String applyOrganization){
      this.applyOrganization = applyOrganization;
   }

   /**
    * getter for 迁入地
    * @generated
    */
   public String getIngoingAddress(){
      return this.ingoingAddress;
   }
   /**
    * setter for 迁入地
    * @generated
    */
   public void setIngoingAddress(String ingoingAddress){
      this.ingoingAddress = ingoingAddress;
   }

   /**
    * getter for 县级受理时间
    * @generated
    */
   public String getTownCheckDate(){
      return this.townCheckDate;
   }
   /**
    * setter for 县级受理时间
    * @generated
    */
   public void setTownCheckDate(String townCheckDate){
      this.townCheckDate = townCheckDate;
   }

   /**
    * getter for 县级受理联系电话
    * @generated
    */
   public String getTownCheckPhone(){
      return this.townCheckPhone;
   }
   /**
    * setter for 县级受理联系电话
    * @generated
    */
   public void setTownCheckPhone(String townCheckPhone){
      this.townCheckPhone = townCheckPhone;
   }

   /**
    * getter for 县级审核负责人
    * @generated
    */
   public String getTownAduitIncharge(){
      return this.townAduitIncharge;
   }
   /**
    * setter for 县级审核负责人
    * @generated
    */
   public void setTownAduitIncharge(String townAduitIncharge){
      this.townAduitIncharge = townAduitIncharge;
   }

   /**
    * getter for 县级审核时间
    * @generated
    */
   public String getTownAduitApproveDate(){
      return this.townAduitApproveDate;
   }
   /**
    * setter for 县级审核时间
    * @generated
    */
   public void setTownAduitApproveDate(String townAduitApproveDate){
      this.townAduitApproveDate = townAduitApproveDate;
   }

   /**
    * getter for 县级审核意见
    * @generated
    */
   public String getTownAduitAdvice(){
      return this.townAduitAdvice;
   }
   /**
    * setter for 县级审核意见
    * @generated
    */
   public void setTownAduitAdvice(String townAduitAdvice){
      this.townAduitAdvice = townAduitAdvice;
   }

   /**
    * getter for 市级受理时间
    * @generated
    */
   public String getCityCheckDate(){
      return this.cityCheckDate;
   }
   /**
    * setter for 市级受理时间
    * @generated
    */
   public void setCityCheckDate(String cityCheckDate){
      this.cityCheckDate = cityCheckDate;
   }

   /**
    * getter for 市级受理意见
    * @generated
    */
   public String getCityCheckAdvice(){
      return this.cityCheckAdvice;
   }
   /**
    * setter for 市级受理意见
    * @generated
    */
   public void setCityCheckAdvice(String cityCheckAdvice){
      this.cityCheckAdvice = cityCheckAdvice;
   }

   /**
    * getter for 市级受理联系电话
    * @generated
    */
   public String getCityCheckPhone(){
      return this.cityCheckPhone;
   }
   /**
    * setter for 市级受理联系电话
    * @generated
    */
   public void setCityCheckPhone(String cityCheckPhone){
      this.cityCheckPhone = cityCheckPhone;
   }

   /**
    * getter for 市级审核负责人
    * @generated
    */
   public String getCityAduitIncharge(){
      return this.cityAduitIncharge;
   }
   /**
    * setter for 市级审核负责人
    * @generated
    */
   public void setCityAduitIncharge(String cityAduitIncharge){
      this.cityAduitIncharge = cityAduitIncharge;
   }

   /**
    * getter for 市级审核时间
    * @generated
    */
   public String getCityAduitApproveDate(){
      return this.cityAduitApproveDate;
   }
   /**
    * setter for 市级审核时间
    * @generated
    */
   public void setCityAduitApproveDate(String cityAduitApproveDate){
      this.cityAduitApproveDate = cityAduitApproveDate;
   }

   /**
    * getter for 市级审核意见
    * @generated
    */
   public String getCityAduitAdvice(){
      return this.cityAduitAdvice;
   }
   /**
    * setter for 市级审核意见
    * @generated
    */
   public void setCityAduitAdvice(String cityAduitAdvice){
      this.cityAduitAdvice = cityAduitAdvice;
   }

   /**
    * getter for 省厅受理时间
    * @generated
    */
   public String getProvinceCheckDate(){
      return this.provinceCheckDate;
   }
   /**
    * setter for 省厅受理时间
    * @generated
    */
   public void setProvinceCheckDate(String provinceCheckDate){
      this.provinceCheckDate = provinceCheckDate;
   }

   /**
    * getter for 省厅受理意见
    * @generated
    */
   public String getProvinceCheckAdvice(){
      return this.provinceCheckAdvice;
   }
   /**
    * setter for 省厅受理意见
    * @generated
    */
   public void setProvinceCheckAdvice(String provinceCheckAdvice){
      this.provinceCheckAdvice = provinceCheckAdvice;
   }

   /**
    * getter for 省厅受理联系电话
    * @generated
    */
   public String getProvinceCheckPhone(){
      return this.provinceCheckPhone;
   }
   /**
    * setter for 省厅受理联系电话
    * @generated
    */
   public void setProvinceCheckPhone(String provinceCheckPhone){
      this.provinceCheckPhone = provinceCheckPhone;
   }

   /**
    * getter for 省厅审核负责人
    * @generated
    */
   public String getProvinceAduitIncharge(){
      return this.provinceAduitIncharge;
   }
   /**
    * setter for 省厅审核负责人
    * @generated
    */
   public void setProvinceAduitIncharge(String provinceAduitIncharge){
      this.provinceAduitIncharge = provinceAduitIncharge;
   }

   /**
    * getter for 省厅审核时间
    * @generated
    */
   public String getProvinceAduitApproveDate(){
      return this.provinceAduitApproveDate;
   }
   /**
    * setter for 省厅审核时间
    * @generated
    */
   public void setProvinceAduitApproveDate(String provinceAduitApproveDate){
      this.provinceAduitApproveDate = provinceAduitApproveDate;
   }

   /**
    * getter for 省厅审核意见
    * @generated
    */
   public String getProvinceAduitAdvice(){
      return this.provinceAduitAdvice;
   }
   /**
    * setter for 省厅审核意见
    * @generated
    */
   public void setProvinceAduitAdvice(String provinceAduitAdvice){
      this.provinceAduitAdvice = provinceAduitAdvice;
   }

   /**
    * getter for 省厅审批负责人
    * @generated
    */
   public String getProvinceIncharge(){
      return this.provinceIncharge;
   }
   /**
    * setter for 省厅审批负责人
    * @generated
    */
   public void setProvinceIncharge(String provinceIncharge){
      this.provinceIncharge = provinceIncharge;
   }

   /**
    * getter for 省厅审批时间
    * @generated
    */
   public String getProvinceApproveDate(){
      return this.provinceApproveDate;
   }
   /**
    * setter for 省厅审批时间
    * @generated
    */
   public void setProvinceApproveDate(String provinceApproveDate){
      this.provinceApproveDate = provinceApproveDate;
   }

   /**
    * getter for 省厅审批意见
    * @generated
    */
   public String getProvinceAdvice(){
      return this.provinceAdvice;
   }
   /**
    * setter for 省厅审批意见
    * @generated
    */
   public void setProvinceAdvice(String provinceAdvice){
      this.provinceAdvice = provinceAdvice;
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

   /**
    * getter for 发起标志
    * @generated
    */
   public String getCommitFlag(){
      return this.commitFlag;
   }
   /**
    * setter for 发起标志
    * @generated
    */
   public void setCommitFlag(String commitFlag){
      this.commitFlag = commitFlag;
   }
/**
 * @return the townCheckPeople
 */
public String getTownCheckPeople() {
	return townCheckPeople;
}
/**
 * @param townCheckPeople the townCheckPeople to set
 */
public void setTownCheckPeople(String townCheckPeople) {
	this.townCheckPeople = townCheckPeople;
}
/**
 * @return the cityCheckPeople
 */
public String getCityCheckPeople() {
	return cityCheckPeople;
}
/**
 * @param cityCheckPeople the cityCheckPeople to set
 */
public void setCityCheckPeople(String cityCheckPeople) {
	this.cityCheckPeople = cityCheckPeople;
}
/**
 * @return the provinceCheckPeople
 */
public String getProvinceCheckPeople() {
	return provinceCheckPeople;
}
/**
 * @param provinceCheckPeople the provinceCheckPeople to set
 */
public void setProvinceCheckPeople(String provinceCheckPeople) {
	this.provinceCheckPeople = provinceCheckPeople;
}
public String getIngoingCode() {
	return ingoingCode;
}
public void setIngoingCode(String ingoingCode) {
	this.ingoingCode = ingoingCode;
}

}