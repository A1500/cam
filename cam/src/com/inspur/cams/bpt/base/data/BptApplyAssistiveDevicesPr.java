package com.inspur.cams.bpt.base.data;

import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * @title:BptApplyAssistiveDevicesPr
 * @description:伤残辅助器械审批表
 * @author:
 * @since:2011-06-07
*/
 @Table(tableName = "BPT_APPLY_ASSISTIVE_DEVICES_PR" , keyFields = "applyId")
public class BptApplyAssistiveDevicesPr extends StatefulDatabean {
   //申请ID
   	@Rule(value="require")
	@Column(name = "APPLY_ID")
   private String applyId;
   	
  //人员ID
	@Column(name = "PEOPLE_ID")
   private String peopleId;
	// 申请时间
	@Column(name = "APPROVE_DATE")
	private String approveDate;
	// 申请机构
	@Column(name = "APPROVE_ORGAN_ID")
	private String approveOrganId;
   //县级_负责人
	@Column(name = "CHECK_INCHARGE")
   private String checkIncharge;
   //县级_意见
	@Column(name = "CHECK_ADVICE")
   private String checkAdvice;
   //县级_时间
	@Column(name = "CHECK_APPROVE_DATE")
   private String checkApproveDate;
	//市级_负责人
	@Column(name = "ADUIT_INCHARGE")
   private String aduitIncharge;
   //市级_意见
	@Column(name = "ADUIT_ADVICE")
   private String aduitAdvice;
   //市级_时间
	@Column(name = "ADUIT_APPROVE_DATE")
   private String aduitApproveDate;
	//同意标志
	private String agreeFlag;
	//上报标志
	private String reportFlag;
	
   /**
	 * @return the agreeFlag
	 */
	public String getAgreeFlag() {
		return agreeFlag;
	}
	/**
	 * @param agreeFlag the agreeFlag to set
	 */
	public void setAgreeFlag(String agreeFlag) {
		this.agreeFlag = agreeFlag;
	}
	/**
	 * @return the reportFlag
	 */
	public String getReportFlag() {
		return reportFlag;
	}
	/**
	 * @param reportFlag the reportFlag to set
	 */
	public void setReportFlag(String reportFlag) {
		this.reportFlag = reportFlag;
	}
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
    * getter for 县级_负责人
    * @generated
    */
   public String getCheckIncharge(){
      return this.checkIncharge;
   }
   /**
    * setter for 县级_负责人
    * @generated
    */
   public void setCheckIncharge(String checkIncharge){
      this.checkIncharge = checkIncharge;
   }

   /**
    * getter for 县级_意见
    * @generated
    */
   public String getCheckAdvice(){
      return this.checkAdvice;
   }
   /**
    * setter for 县级_意见
    * @generated
    */
   public void setCheckAdvice(String checkAdvice){
      this.checkAdvice = checkAdvice;
   }

   /**
    * getter for 县级_时间
    * @generated
    */
   public String getCheckApproveDate(){
      return this.checkApproveDate;
   }
   /**
    * setter for 县级_时间
    * @generated
    */
   public void setCheckApproveDate(String checkApproveDate){
      this.checkApproveDate = checkApproveDate;
   }

   /**
    * getter for 市级_负责人
    * @generated
    */
   public String getAduitIncharge(){
      return this.aduitIncharge;
   }
   /**
    * setter for 市级_负责人
    * @generated
    */
   public void setAduitIncharge(String aduitIncharge){
      this.aduitIncharge = aduitIncharge;
   }

   /**
    * getter for 市级_意见
    * @generated
    */
   public String getAduitAdvice(){
      return this.aduitAdvice;
   }
   /**
    * setter for 市级_意见
    * @generated
    */
   public void setAduitAdvice(String aduitAdvice){
      this.aduitAdvice = aduitAdvice;
   }

   /**
    * getter for 市级_时间
    * @generated
    */
   public String getAduitApproveDate(){
      return this.aduitApproveDate;
   }
   /**
    * setter for 市级_时间
    * @generated
    */
   public void setAduitApproveDate(String aduitApproveDate){
      this.aduitApproveDate = aduitApproveDate;
   }

/**
 * getter for 人员ID
 */
public String getPeopleId() {
	return peopleId;
}
/**
 * setter for 人员ID
 */
public void setPeopleId(String peopleId) {
	this.peopleId = peopleId;
}
/**
 * @return the approveDate
 */
public String getApproveDate() {
	return approveDate;
}
/**
 * @param approveDate the approveDate to set
 */
public void setApproveDate(String approveDate) {
	this.approveDate = approveDate;
}
/**
 * @return the approveOrganId
 */
public String getApproveOrganId() {
	return approveOrganId;
}
/**
 * @param approveOrganId the approveOrganId to set
 */
public void setApproveOrganId(String approveOrganId) {
	this.approveOrganId = approveOrganId;
}

}