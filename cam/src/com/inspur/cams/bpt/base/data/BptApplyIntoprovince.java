package com.inspur.cams.bpt.base.data;

import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * @title:BptApplyDisabilityIntoprovi
 * @description:优抚人员抚恤关系迁入我省
 * @author:
 * @since:2011-07-14
 * @version:1.0
*/
 @Table(tableName = "BPT_APPLY_INTOPROVINCE" , keyFields = "applyId")
public class BptApplyIntoprovince extends StatefulDatabean {
   //申请ID
	@Column(name = "APPLY_ID")
   private String applyId;
   //人员ID
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
   //由何地迁入
	@Column(name = "INGOING_ADDRESS")
   private String ingoingAddress;
	
	// 由何地迁入代码
	@Column(name = "INGOING_CODE")
	private String ingoingCode;	
	
   //迁入原因
	@Column(name = "INGOING_REASON")
   private String ingoingReason;
   //原证件编号
	@Column(name = "OLD_PAPER_NO")
   private String oldPaperNo;
   //新证件编号
	@Column(name = "NEW_PAPER_NO")
   private String newPaperNo;
   //县级受理人员
	@Column(name = "TOWN_CHECK_PEOPLE_ID")
   private String townCheckPeopleId;
   //县级受理时间
	@Column(name = "TOWN_CHECK_DATE")
   private String townCheckDate;
   //县级审核负责人
	@Column(name = "TOWN_ADUIT_INCHARGE")
   private String townAduitIncharge;
   //县级审核时间
	@Column(name = "TOWN_ADUIT__APPROVE_DATE")
   private String townAduitApproveDate;
   //县级审核意见
	@Column(name = "TOWN_ADUIT_ADVICE")
   private String townAduitAdvice;
   //市级受理人员
	@Column(name = "CITY_CHECK_PEOPLE_ID")
   private String cityCheckPeopleId;
   //市级受理时间
	@Column(name = "CITY_CHECK_DATE")
   private String cityCheckDate;
   //市级受理意见
	@Column(name = "CITY_CHECK_ADVICE")
   private String cityCheckAdvice;
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
	@Column(name = "PROVINCE_CHECK_PEOPLE_ID")
   private String provinceCheckPeopleId;
   //省厅受理意见
	@Column(name = "PROVINCE_CHECK_ADVICE")
   private String provinceCheckAdvice;
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
	//发起标志
	@Column(name = "COMMIT_FLAG")
   private String commitFlag;
   //备注
	@Column(name = "NOTE")
   private String note;
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
 * @return the oldPaperNo
 */
public String getOldPaperNo() {
	return oldPaperNo;
}
/**
 * @param oldPaperNo the oldPaperNo to set
 */
public void setOldPaperNo(String oldPaperNo) {
	this.oldPaperNo = oldPaperNo;
}
/**
 * @return the newPaperNo
 */
public String getNewPaperNo() {
	return newPaperNo;
}
/**
 * @param newPaperNo the newPaperNo to set
 */
public void setNewPaperNo(String newPaperNo) {
	this.newPaperNo = newPaperNo;
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
    * getter for 由何地迁入
    * @generated
    */
   public String getIngoingAddress(){
      return this.ingoingAddress;
   }
   /**
    * setter for 由何地迁入
    * @generated
    */
   public void setIngoingAddress(String ingoingAddress){
      this.ingoingAddress = ingoingAddress;
   }

   /**
    * getter for 迁入原因
    * @generated
    */
   public String getIngoingReason(){
      return this.ingoingReason;
   }
   /**
    * setter for 迁入原因
    * @generated
    */
   public void setIngoingReason(String ingoingReason){
      this.ingoingReason = ingoingReason;
   }

   /**
    * getter for 县级受理人员
    * @generated
    */
   public String getTownCheckPeopleId(){
      return this.townCheckPeopleId;
   }
   /**
    * setter for 县级受理人员
    * @generated
    */
   public void setTownCheckPeopleId(String townCheckPeopleId){
      this.townCheckPeopleId = townCheckPeopleId;
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
    * getter for 市级受理人员
    * @generated
    */
   public String getCityCheckPeopleId(){
      return this.cityCheckPeopleId;
   }
   /**
    * setter for 市级受理人员
    * @generated
    */
   public void setCityCheckPeopleId(String cityCheckPeopleId){
      this.cityCheckPeopleId = cityCheckPeopleId;
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
    * getter for 省厅受理人员
    * @generated
    */
   public String getProvinceCheckPeopleId(){
      return this.provinceCheckPeopleId;
   }
   /**
    * setter for 省厅受理人员
    * @generated
    */
   public void setProvinceCheckPeopleId(String provinceCheckPeopleId){
      this.provinceCheckPeopleId = provinceCheckPeopleId;
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
 * @return the commitFlag
 */
public String getCommitFlag() {
	return commitFlag;
}
/**
 * @param commitFlag the commitFlag to set
 */
public void setCommitFlag(String commitFlag) {
	this.commitFlag = commitFlag;
}
public String getIngoingCode() {
	return ingoingCode;
}
public void setIngoingCode(String ingoingCode) {
	this.ingoingCode = ingoingCode;
}



}