package com.inspur.cams.cdc.base.data;

import java.math.BigDecimal;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:CdcElectionCityMember
 * @description:
 * @author:
 * @since:2013-02-17
 * @version:1.0
*/
 @Table(tableName = "CDC_ELECTION_CITY_MEMBER" , keyFields = "memberId")
public class CdcElectionCityMember extends StatefulDatabean {
   //RECORD_ID
	@Column(name = "RECORD_ID")
   private String recordId;
   //MEMBER_ID
	@Column(name = "MEMBER_ID")
   private String memberId;
   //HEAD_NUM
   	@Rule(value="number")
	@Column(name = "HEAD_NUM")
   private BigDecimal headNum;
   //HEAD_PARTY_NUM
   	@Rule(value="number")
	@Column(name = "HEAD_PARTY_NUM")
   private BigDecimal headPartyNum;
   //SHEAD_NUM
   	@Rule(value="number")
	@Column(name = "SHEAD_NUM")
   private BigDecimal sheadNum;
   //SHEAD_PARTY_NUM
   	@Rule(value="number")
	@Column(name = "SHEAD_PARTY_NUM")
   private BigDecimal sheadPartyNum;
   //MEMBER_NUM
   	@Rule(value="number")
	@Column(name = "MEMBER_NUM")
   private BigDecimal memberNum;
   //MEMBER_PARTY_NUM
   	@Rule(value="number")
	@Column(name = "MEMBER_PARTY_NUM")
   private BigDecimal memberPartyNum;
   //ORGAN_CODE
   	@Rule(value="require")
	@Column(name = "ORGAN_CODE")
   private String organCode;
   //ORGAN_NAME
   	@Rule(value="require")
	@Column(name = "ORGAN_NAME")
   private String organName;
   //PARENT_CODE
   	@Rule(value="require")
	@Column(name = "PARENT_CODE")
   private String parentCode;
   //REPORT_TYPE
	@Column(name = "REPORT_TYPE")
   private String reportType;
   //REPORT_DATE
	@Column(name = "REPORT_DATE")
   private String reportDate;
   //STATUS
	@Column(name = "STATUS")
   private String status;
   //SUBMIT_DATE
	@Column(name = "SUBMIT_DATE")
   private String submitDate;
   //CREATE_TIME
	@Column(name = "CREATE_TIME")
   private String createTime;
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
    * getter for MEMBER_ID
    * @generated
    */
   public String getMemberId(){
      return this.memberId;
   }
   /**
    * setter for MEMBER_ID
    * @generated
    */
   public void setMemberId(String memberId){
      this.memberId = memberId;
   }

   /**
    * getter for HEAD_NUM
    * @generated
    */
   public BigDecimal getHeadNum(){
      return this.headNum;
   }
   /**
    * setter for HEAD_NUM
    * @generated
    */
   public void setHeadNum(BigDecimal headNum){
      this.headNum = headNum;
   }

   /**
    * getter for HEAD_PARTY_NUM
    * @generated
    */
   public BigDecimal getHeadPartyNum(){
      return this.headPartyNum;
   }
   /**
    * setter for HEAD_PARTY_NUM
    * @generated
    */
   public void setHeadPartyNum(BigDecimal headPartyNum){
      this.headPartyNum = headPartyNum;
   }

   /**
    * getter for SHEAD_NUM
    * @generated
    */
   public BigDecimal getSheadNum(){
      return this.sheadNum;
   }
   /**
    * setter for SHEAD_NUM
    * @generated
    */
   public void setSheadNum(BigDecimal sheadNum){
      this.sheadNum = sheadNum;
   }

   /**
    * getter for SHEAD_PARTY_NUM
    * @generated
    */
   public BigDecimal getSheadPartyNum(){
      return this.sheadPartyNum;
   }
   /**
    * setter for SHEAD_PARTY_NUM
    * @generated
    */
   public void setSheadPartyNum(BigDecimal sheadPartyNum){
      this.sheadPartyNum = sheadPartyNum;
   }

   /**
    * getter for MEMBER_NUM
    * @generated
    */
   public BigDecimal getMemberNum(){
      return this.memberNum;
   }
   /**
    * setter for MEMBER_NUM
    * @generated
    */
   public void setMemberNum(BigDecimal memberNum){
      this.memberNum = memberNum;
   }

   /**
    * getter for MEMBER_PARTY_NUM
    * @generated
    */
   public BigDecimal getMemberPartyNum(){
      return this.memberPartyNum;
   }
   /**
    * setter for MEMBER_PARTY_NUM
    * @generated
    */
   public void setMemberPartyNum(BigDecimal memberPartyNum){
      this.memberPartyNum = memberPartyNum;
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

   /**
    * getter for CREATE_TIME
    * @generated
    */
   public String getCreateTime(){
      return this.createTime;
   }
   /**
    * setter for CREATE_TIME
    * @generated
    */
   public void setCreateTime(String createTime){
      this.createTime = createTime;
   }

}