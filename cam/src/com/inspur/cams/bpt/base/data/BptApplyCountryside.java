package com.inspur.cams.bpt.base.data;

import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * @title:BptApplyCountryside
 * @description:
 * @author:
 * @since:2011-06-16
 * @version:1.0
*/
 @Table(tableName = "BPT_APPLY_COUNTRYSIDE" , keyFields = "applyId")
public class BptApplyCountryside extends StatefulDatabean {
   //申请ID
   	@Rule(value="require")
	@Column(name = "APPLY_ID")
   private String applyId;
   //人员ID
   	@Rule(value="require")
	@Column(name = "PEOPLE_ID")
   private String peopleId;
   //业务类型
   	@Rule(value="require")
	@Column(name = "SERVICE_TYPE")
   private String serviceType;
   //优抚对象类别
   	@Rule(value="require")
	@Column(name = "OBJECT_TYPE")
   private String objectType;
   //乡镇负责人
	@Column(name = "VICUS_CHECK_INCHARGE")
   private String vicusCheckIncharge;
   //乡镇审查时间
	@Column(name = "VICUS_CHECK_APPROVE_DATE")
   private String vicusCheckApproveDate;
   //乡镇审查意见
	@Column(name = "VICUS_CHECK_ADVICE")
   private String vicusCheckAdvice;
   //县级受理人员
	@Column(name = "COUNTY_CHECK_INCHARGE")
   private String countyCheckIncharge;
   //县级受理时间
	@Column(name = "COUNTY_CHECK_APPROVE_DATE")
   private String countyCheckApproveDate;
   //县级受理意见
	@Column(name = "COUNTY_CHECK_ADVICE")
   private String countyCheckAdvice;
   //县级负责人
	@Column(name = "COUNTY_ADUIT_INCHARGE")
   private String countyAduitIncharge;
   //县级审查时间
	@Column(name = "COUNTY_ADUIT__APPROVE_DATE")
   private String countyAduitApproveDate;
   //县级审核意见
	@Column(name = "COUNTY_ADUIT_ADVICE")
   private String countyAduitAdvice;
   //市级受理人员
	@Column(name = "CITY_CHECK_INCHARGE")
   private String cityCheckIncharge;
   //市级受理时间
	@Column(name = "CITY_CHECK_APPROVE_DATE")
   private String cityCheckApproveDate;
   //市级受理意见
	@Column(name = "CITY_CHECK_ADVICE")
   private String cityCheckAdvice;
   //市级负责人
	@Column(name = "CITY_ADUIT_INCHARGE")
   private String cityAduitIncharge;
   //市级审批时间
	@Column(name = "CITY_ADUIT__APPROVE_DATE")
   private String cityAduitApproveDate;
   //市级审批意见
	@Column(name = "CITY_ADUIT_ADVICE")
   private String cityAduitAdvice;
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
    * getter for 优抚对象类别
    * @generated
    */
   public String getObjectType(){
      return this.objectType;
   }
   /**
    * setter for 优抚对象类别
    * @generated
    */
   public void setObjectType(String objectType){
      this.objectType = objectType;
   }

   /**
    * getter for 乡镇负责人
    * @generated
    */
   public String getVicusCheckIncharge(){
      return this.vicusCheckIncharge;
   }
   /**
    * setter for 乡镇负责人
    * @generated
    */
   public void setVicusCheckIncharge(String vicusCheckIncharge){
      this.vicusCheckIncharge = vicusCheckIncharge;
   }

   /**
    * getter for 乡镇审查时间
    * @generated
    */
   public String getVicusCheckApproveDate(){
      return this.vicusCheckApproveDate;
   }
   /**
    * setter for 乡镇审查时间
    * @generated
    */
   public void setVicusCheckApproveDate(String vicusCheckApproveDate){
      this.vicusCheckApproveDate = vicusCheckApproveDate;
   }

   /**
    * getter for 乡镇审查意见
    * @generated
    */
   public String getVicusCheckAdvice(){
      return this.vicusCheckAdvice;
   }
   /**
    * setter for 乡镇审查意见
    * @generated
    */
   public void setVicusCheckAdvice(String vicusCheckAdvice){
      this.vicusCheckAdvice = vicusCheckAdvice;
   }

   /**
    * getter for 县级受理人员
    * @generated
    */
   public String getCountyCheckIncharge(){
      return this.countyCheckIncharge;
   }
   /**
    * setter for 县级受理人员
    * @generated
    */
   public void setCountyCheckIncharge(String countyCheckIncharge){
      this.countyCheckIncharge = countyCheckIncharge;
   }

   /**
    * getter for 县级受理时间
    * @generated
    */
   public String getCountyCheckApproveDate(){
      return this.countyCheckApproveDate;
   }
   /**
    * setter for 县级受理时间
    * @generated
    */
   public void setCountyCheckApproveDate(String countyCheckApproveDate){
      this.countyCheckApproveDate = countyCheckApproveDate;
   }

   /**
    * getter for 县级受理意见
    * @generated
    */
   public String getCountyCheckAdvice(){
      return this.countyCheckAdvice;
   }
   /**
    * setter for 县级受理意见
    * @generated
    */
   public void setCountyCheckAdvice(String countyCheckAdvice){
      this.countyCheckAdvice = countyCheckAdvice;
   }

   /**
    * getter for 县级负责人
    * @generated
    */
   public String getCountyAduitIncharge(){
      return this.countyAduitIncharge;
   }
   /**
    * setter for 县级负责人
    * @generated
    */
   public void setCountyAduitIncharge(String countyAduitIncharge){
      this.countyAduitIncharge = countyAduitIncharge;
   }

   /**
    * getter for 县级审查时间
    * @generated
    */
   public String getCountyAduitApproveDate(){
      return this.countyAduitApproveDate;
   }
   /**
    * setter for 县级审查时间
    * @generated
    */
   public void setCountyAduitApproveDate(String countyAduitApproveDate){
      this.countyAduitApproveDate = countyAduitApproveDate;
   }

   /**
    * getter for 县级审核意见
    * @generated
    */
   public String getCountyAduitAdvice(){
      return this.countyAduitAdvice;
   }
   /**
    * setter for 县级审核意见
    * @generated
    */
   public void setCountyAduitAdvice(String countyAduitAdvice){
      this.countyAduitAdvice = countyAduitAdvice;
   }

   /**
    * getter for 市级受理人员
    * @generated
    */
   public String getCityCheckIncharge(){
      return this.cityCheckIncharge;
   }
   /**
    * setter for 市级受理人员
    * @generated
    */
   public void setCityCheckIncharge(String cityCheckIncharge){
      this.cityCheckIncharge = cityCheckIncharge;
   }

   /**
    * getter for 市级受理时间
    * @generated
    */
   public String getCityCheckApproveDate(){
      return this.cityCheckApproveDate;
   }
   /**
    * setter for 市级受理时间
    * @generated
    */
   public void setCityCheckApproveDate(String cityCheckApproveDate){
      this.cityCheckApproveDate = cityCheckApproveDate;
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
    * getter for 市级负责人
    * @generated
    */
   public String getCityAduitIncharge(){
      return this.cityAduitIncharge;
   }
   /**
    * setter for 市级负责人
    * @generated
    */
   public void setCityAduitIncharge(String cityAduitIncharge){
      this.cityAduitIncharge = cityAduitIncharge;
   }

   /**
    * getter for 市级审批时间
    * @generated
    */
   public String getCityAduitApproveDate(){
      return this.cityAduitApproveDate;
   }
   /**
    * setter for 市级审批时间
    * @generated
    */
   public void setCityAduitApproveDate(String cityAduitApproveDate){
      this.cityAduitApproveDate = cityAduitApproveDate;
   }

   /**
    * getter for 市级审批意见
    * @generated
    */
   public String getCityAduitAdvice(){
      return this.cityAduitAdvice;
   }
   /**
    * setter for 市级审批意见
    * @generated
    */
   public void setCityAduitAdvice(String cityAduitAdvice){
      this.cityAduitAdvice = cityAduitAdvice;
   }

}