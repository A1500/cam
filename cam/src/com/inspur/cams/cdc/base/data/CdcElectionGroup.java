package com.inspur.cams.cdc.base.data;

import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * @title:CdcElectionGroup
 * @description:
 * @author:
 * @since:2012-02-13
 * @version:1.0
*/
 @Table(tableName = "CDC_ELECTION_GROUP" , keyFields = "groupId")
public class CdcElectionGroup extends StatefulDatabean {
   //选举内码
	@Column(name = "RECORD_ID")
   private String recordId;
   //小组情况内码
	@Column(name = "GROUP_ID")
   private String groupId;
   //村/居民代表人数
   	@Rule(value="number")
	@Column(name = "DELEGATE_NUM")
   private BigDecimal delegateNum;
   //村/居民代表女性人数
   	@Rule(value="number")
	@Column(name = "DELEGATE_FEMALE_NUM")
   private BigDecimal delegateFemaleNum;
   //村/居民代表党员人数
   	@Rule(value="number")
	@Column(name = "DELEGATE_PARTY_NUM")
   private BigDecimal delegatePartyNum;
   //村/居民代表少数民族数
   	@Rule(value="number")
	@Column(name = "DELEGATE_FOLK_NUM")
   private BigDecimal delegateFolkNum;
   //村/居民小组长人数
   	@Rule(value="number")
	@Column(name = "HEADMAN_NUM")
   private BigDecimal headmanNum;
   //村/居民小组长女性人数
   	@Rule(value="number")
	@Column(name = "HEADMAN_FEMALE_NUM")
   private BigDecimal headmanFemaleNum;
   //村/居民小组长党员数
   	@Rule(value="number")
	@Column(name = "HEADMAN_PARTY_NUM")
   private BigDecimal headmanPartyNum;
   //村/居民小组长少数民族人数
   	@Rule(value="number")
	@Column(name = "HEADMAN_FOLK_NUM")
   private BigDecimal headmanFolkNum;
   //填报单位行政区划
   	@Rule(value="require")
	@Column(name = "ORGAN_CODE")
   private String organCode;
   //填报单位名称
   	@Rule(value="require")
	@Column(name = "ORGAN_NAME")
   private String organName;
   //所属上级行政区划
   	@Rule(value="require")
	@Column(name = "PARENT_CODE")
   private String parentCode;
   //填报报表类型
	@Column(name = "REPORT_TYPE")
   private String reportType;
   //填报日期
	@Column(name = "REPORT_DATE")
   private String reportDate;
   //上报状态
	@Column(name = "STATUS")
   private String status;
   //上报日期
	@Column(name = "SUBMIT_DATE")
   private String submitDate;
	//创建时间
	@Column(name = "CREATE_TIME")
	private String createTime;
   public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
/**
    * getter for RECORD_ID
    * @generated
    */
   public String getRecordId(){
      return this.recordId;
   }
   /**
    * setter for RECORD_ID
    * @generated
    */
   public void setRecordId(String recordId){
      this.recordId = recordId;
   }

   /**
    * getter for GROUP_ID
    * @generated
    */
   public String getGroupId(){
      return this.groupId;
   }
   /**
    * setter for GROUP_ID
    * @generated
    */
   public void setGroupId(String groupId){
      this.groupId = groupId;
   }

   /**
    * getter for DELEGATE_NUM
    * @generated
    */
   public BigDecimal getDelegateNum(){
      return this.delegateNum;
   }
   /**
    * setter for DELEGATE_NUM
    * @generated
    */
   public void setDelegateNum(BigDecimal delegateNum){
      this.delegateNum = delegateNum;
   }

   /**
    * getter for DELEGATE_FEMALE_NUM
    * @generated
    */
   public BigDecimal getDelegateFemaleNum(){
      return this.delegateFemaleNum;
   }
   /**
    * setter for DELEGATE_FEMALE_NUM
    * @generated
    */
   public void setDelegateFemaleNum(BigDecimal delegateFemaleNum){
      this.delegateFemaleNum = delegateFemaleNum;
   }

   /**
    * getter for DELEGATE_PARTY_NUM
    * @generated
    */
   public BigDecimal getDelegatePartyNum(){
      return this.delegatePartyNum;
   }
   /**
    * setter for DELEGATE_PARTY_NUM
    * @generated
    */
   public void setDelegatePartyNum(BigDecimal delegatePartyNum){
      this.delegatePartyNum = delegatePartyNum;
   }

   /**
    * getter for DELEGATE_FOLK_NUM
    * @generated
    */
   public BigDecimal getDelegateFolkNum(){
      return this.delegateFolkNum;
   }
   /**
    * setter for DELEGATE_FOLK_NUM
    * @generated
    */
   public void setDelegateFolkNum(BigDecimal delegateFolkNum){
      this.delegateFolkNum = delegateFolkNum;
   }

   /**
    * getter for HEADMAN_NUM
    * @generated
    */
   public BigDecimal getHeadmanNum(){
      return this.headmanNum;
   }
   /**
    * setter for HEADMAN_NUM
    * @generated
    */
   public void setHeadmanNum(BigDecimal headmanNum){
      this.headmanNum = headmanNum;
   }

   /**
    * getter for HEADMAN_FEMALE_NUM
    * @generated
    */
   public BigDecimal getHeadmanFemaleNum(){
      return this.headmanFemaleNum;
   }
   /**
    * setter for HEADMAN_FEMALE_NUM
    * @generated
    */
   public void setHeadmanFemaleNum(BigDecimal headmanFemaleNum){
      this.headmanFemaleNum = headmanFemaleNum;
   }

   /**
    * getter for HEADMAN_PARTY_NUM
    * @generated
    */
   public BigDecimal getHeadmanPartyNum(){
      return this.headmanPartyNum;
   }
   /**
    * setter for HEADMAN_PARTY_NUM
    * @generated
    */
   public void setHeadmanPartyNum(BigDecimal headmanPartyNum){
      this.headmanPartyNum = headmanPartyNum;
   }

   /**
    * getter for HEADMAN_FOLK_NUM
    * @generated
    */
   public BigDecimal getHeadmanFolkNum(){
      return this.headmanFolkNum;
   }
   /**
    * setter for HEADMAN_FOLK_NUM
    * @generated
    */
   public void setHeadmanFolkNum(BigDecimal headmanFolkNum){
      this.headmanFolkNum = headmanFolkNum;
   }

   /**
    * getter for ORGAN_CODE
    * @generated
    */
   public String getOrganCode(){
      return this.organCode;
   }
   /**
    * setter for ORGAN_CODE
    * @generated
    */
   public void setOrganCode(String organCode){
      this.organCode = organCode;
   }

   /**
    * getter for ORGAN_NAME
    * @generated
    */
   public String getOrganName(){
      return this.organName;
   }
   /**
    * setter for ORGAN_NAME
    * @generated
    */
   public void setOrganName(String organName){
      this.organName = organName;
   }

   /**
    * getter for PARENT_CODE
    * @generated
    */
   public String getParentCode(){
      return this.parentCode;
   }
   /**
    * setter for PARENT_CODE
    * @generated
    */
   public void setParentCode(String parentCode){
      this.parentCode = parentCode;
   }

   /**
    * getter for REPORT_TYPE
    * @generated
    */
   public String getReportType(){
      return this.reportType;
   }
   /**
    * setter for REPORT_TYPE
    * @generated
    */
   public void setReportType(String reportType){
      this.reportType = reportType;
   }

   /**
    * getter for REPORT_DATE
    * @generated
    */
   public String getReportDate(){
      return this.reportDate;
   }
   /**
    * setter for REPORT_DATE
    * @generated
    */
   public void setReportDate(String reportDate){
      this.reportDate = reportDate;
   }

   /**
    * getter for STATUS
    * @generated
    */
   public String getStatus(){
      return this.status;
   }
   /**
    * setter for STATUS
    * @generated
    */
   public void setStatus(String status){
      this.status = status;
   }

   /**
    * getter for SUBMIT_DATE
    * @generated
    */
   public String getSubmitDate(){
      return this.submitDate;
   }
   /**
    * setter for SUBMIT_DATE
    * @generated
    */
   public void setSubmitDate(String submitDate){
      this.submitDate = submitDate;
   }

}