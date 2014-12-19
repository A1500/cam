package com.inspur.cams.cdc.base.data;

import java.math.BigDecimal;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:CdcFinanceInfo
 * @description:
 * @author:
 * @since:2012-02-29
 * @version:1.0
*/
 @Table(tableName = "CDC_FINANCE_INFO" , keyFields = "financeid")
public class CdcFinanceInfo extends StatefulDatabean {
   //FINANCEID
	@Column(name = "FINANCEID")
   private String financeid;
   //YEARLY
	@Column(name = "YEARLY")
   private String yearly;
   //GDP_MON
   	@Rule(value="number")
	@Column(name = "GDP_MON")
   private BigDecimal gdpMon;
   //AGRICULTURE_MON
   	@Rule(value="number")
	@Column(name = "AGRICULTURE_MON")
   private BigDecimal agricultureMon;
   //PERSON_MON
   	@Rule(value="number")
	@Column(name = "PERSON_MON")
   private BigDecimal personMon;
   //FINANCE_MON
   	@Rule(value="number")
	@Column(name = "FINANCE_MON")
   private BigDecimal financeMon;
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
	//
	@Column(name = "CREATE_TIME")
   private String createTime;
   /**
    * getter for FINANCEID
    * @generated
    */
   public String getFinanceid(){
      return this.financeid;
   }
   /**
    * setter for FINANCEID
    * @generated
    */
   public void setFinanceid(String financeid){
      this.financeid = financeid;
   }

   /**
    * getter for YEARLY
    * @generated
    */
   public String getYearly(){
      return this.yearly;
   }
   /**
    * setter for YEARLY
    * @generated
    */
   public void setYearly(String yearly){
      this.yearly = yearly;
   }

   /**
    * getter for GDP_MON
    * @generated
    */
   public BigDecimal getGdpMon(){
      return this.gdpMon;
   }
   /**
    * setter for GDP_MON
    * @generated
    */
   public void setGdpMon(BigDecimal gdpMon){
      this.gdpMon = gdpMon;
   }

   /**
    * getter for AGRICULTURE_MON
    * @generated
    */
   public BigDecimal getAgricultureMon(){
      return this.agricultureMon;
   }
   /**
    * setter for AGRICULTURE_MON
    * @generated
    */
   public void setAgricultureMon(BigDecimal agricultureMon){
      this.agricultureMon = agricultureMon;
   }

   /**
    * getter for PERSON_MON
    * @generated
    */
   public BigDecimal getPersonMon(){
      return this.personMon;
   }
   /**
    * setter for PERSON_MON
    * @generated
    */
   public void setPersonMon(BigDecimal personMon){
      this.personMon = personMon;
   }

   /**
    * getter for FINANCE_MON
    * @generated
    */
   public BigDecimal getFinanceMon(){
      return this.financeMon;
   }
   /**
    * setter for FINANCE_MON
    * @generated
    */
   public void setFinanceMon(BigDecimal financeMon){
      this.financeMon = financeMon;
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
public String getCreateTime() {
	return createTime;
}
public void setCreateTime(String createTime) {
	this.createTime = createTime;
}

}