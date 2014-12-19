package com.inspur.cams.cdc.base.data;

import java.math.BigDecimal;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:CdcServiceMode
 * @description:
 * @author:
 * @since:2012-02-29
 * @version:1.0
*/
 @Table(tableName = "CDC_SERVICE_MODE" , keyFields = "modeId")
public class CdcServiceMode extends StatefulDatabean {
   //MODE_ID
	@Column(name = "MODE_ID")
   private String modeId;
   //PUBLIC_CONTENT
	@Column(name = "PUBLIC_CONTENT")
   private String publicContent;
   //PUBLIC_PEOPLE_NUM
   	@Rule(value="number")
	@Column(name = "PUBLIC_PEOPLE_NUM")
   private BigDecimal publicPeopleNum;
   //VOLUNT_CONTENT
	@Column(name = "VOLUNT_CONTENT")
   private String voluntContent;
   //VOLUNT_PEOPLE_NUM
   	@Rule(value="number")
	@Column(name = "VOLUNT_PEOPLE_NUM")
   private BigDecimal voluntPeopleNum;
   //COMMERCE_NAME
	@Column(name = "COMMERCE_NAME")
   private String commerceName;
   //COMMERCE_CONTENT
	@Column(name = "COMMERCE_CONTENT")
   private String commerceContent;
   //COMMERCE_ADDRESS
	@Column(name = "COMMERCE_ADDRESS")
   private String commerceAddress;
   //IF_SERVICE
	@Column(name = "IF_SERVICE")
   private String ifService;
   //SERVICE_PHONE
	@Column(name = "SERVICE_PHONE")
   private String servicePhone;
   //SERVICE_WEB
	@Column(name = "SERVICE_WEB")
   private String serviceWeb;
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
	//SUBMIT_DATE
	@Column(name = "CREATE_TIME")
   private String createTime;
   /**
    * getter for MODE_ID
    * @generated
    */
   public String getModeId(){
      return this.modeId;
   }
   /**
    * setter for MODE_ID
    * @generated
    */
   public void setModeId(String modeId){
      this.modeId = modeId;
   }

   /**
    * getter for PUBLIC_CONTENT
    * @generated
    */
   public String getPublicContent(){
      return this.publicContent;
   }
   /**
    * setter for PUBLIC_CONTENT
    * @generated
    */
   public void setPublicContent(String publicContent){
      this.publicContent = publicContent;
   }

   /**
    * getter for PUBLIC_PEOPLE_NUM
    * @generated
    */
   public BigDecimal getPublicPeopleNum(){
      return this.publicPeopleNum;
   }
   /**
    * setter for PUBLIC_PEOPLE_NUM
    * @generated
    */
   public void setPublicPeopleNum(BigDecimal publicPeopleNum){
      this.publicPeopleNum = publicPeopleNum;
   }

   /**
    * getter for VOLUNT_CONTENT
    * @generated
    */
   public String getVoluntContent(){
      return this.voluntContent;
   }
   /**
    * setter for VOLUNT_CONTENT
    * @generated
    */
   public void setVoluntContent(String voluntContent){
      this.voluntContent = voluntContent;
   }

   /**
    * getter for VOLUNT_PEOPLE_NUM
    * @generated
    */
   public BigDecimal getVoluntPeopleNum(){
      return this.voluntPeopleNum;
   }
   /**
    * setter for VOLUNT_PEOPLE_NUM
    * @generated
    */
   public void setVoluntPeopleNum(BigDecimal voluntPeopleNum){
      this.voluntPeopleNum = voluntPeopleNum;
   }

   /**
    * getter for COMMERCE_NAME
    * @generated
    */
   public String getCommerceName(){
      return this.commerceName;
   }
   /**
    * setter for COMMERCE_NAME
    * @generated
    */
   public void setCommerceName(String commerceName){
      this.commerceName = commerceName;
   }

   /**
    * getter for COMMERCE_CONTENT
    * @generated
    */
   public String getCommerceContent(){
      return this.commerceContent;
   }
   /**
    * setter for COMMERCE_CONTENT
    * @generated
    */
   public void setCommerceContent(String commerceContent){
      this.commerceContent = commerceContent;
   }

   /**
    * getter for COMMERCE_ADDRESS
    * @generated
    */
   public String getCommerceAddress(){
      return this.commerceAddress;
   }
   /**
    * setter for COMMERCE_ADDRESS
    * @generated
    */
   public void setCommerceAddress(String commerceAddress){
      this.commerceAddress = commerceAddress;
   }

   /**
    * getter for IF_SERVICE
    * @generated
    */
   public String getIfService(){
      return this.ifService;
   }
   /**
    * setter for IF_SERVICE
    * @generated
    */
   public void setIfService(String ifService){
      this.ifService = ifService;
   }

   /**
    * getter for SERVICE_PHONE
    * @generated
    */
   public String getServicePhone(){
      return this.servicePhone;
   }
   /**
    * setter for SERVICE_PHONE
    * @generated
    */
   public void setServicePhone(String servicePhone){
      this.servicePhone = servicePhone;
   }

   /**
    * getter for SERVICE_WEB
    * @generated
    */
   public String getServiceWeb(){
      return this.serviceWeb;
   }
   /**
    * setter for SERVICE_WEB
    * @generated
    */
   public void setServiceWeb(String serviceWeb){
      this.serviceWeb = serviceWeb;
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