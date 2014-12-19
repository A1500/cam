package com.inspur.cams.cdc.base.data;

import java.math.BigDecimal;

import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:城市社区物业信息填报
 * @description:
 * @author:
 * @since:2013-03-15
 * @version:1.0
*/
 @Table(tableName = "CDC_TENEMENT_INFO" , keyFields = "recordId")
public class CdcTenementInfo extends StatefulDatabean {
   //RECORD_ID
   	@Rule(value="require")
   private String recordId;
   //TENEMENT_NUM
   	@Rule(value="number")
   private BigDecimal tenementNum;
   //PROPRIETOR_COMMITTEE_NUM
   	@Rule(value="number")
   private BigDecimal proprietorCommitteeNum;
   //ORGAN_CODE
   private String organCode;
   //ORGAN_NAME
   private String organName;
   //PARENT_CODE
   private String parentCode;
   //REPORT_DATE
   private String reportDate;
   //STATUS
   private String status;
   //SUBMIT_DATE
   private String submitDate;
   //REPORT_TYPE
   private String reportType;
   //CREATE_TIME
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
    * getter for TENEMENT_NUM
    * @generated
    */
   public BigDecimal getTenementNum(){
      return this.tenementNum;
   }
   /**
    * setter for TENEMENT_NUM
    * @generated
    */
   public void setTenementNum(BigDecimal tenementNum){
      this.tenementNum = tenementNum;
   }

   /**
    * getter for PROPRIETOR_COMMITTEE_NUM
    * @generated
    */
   public BigDecimal getProprietorCommitteeNum(){
      return this.proprietorCommitteeNum;
   }
   /**
    * setter for PROPRIETOR_COMMITTEE_NUM
    * @generated
    */
   public void setProprietorCommitteeNum(BigDecimal proprietorCommitteeNum){
      this.proprietorCommitteeNum = proprietorCommitteeNum;
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