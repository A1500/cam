package com.inspur.cams.dataexchange.log;
import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.*;

/**
 * @title: 数据交互日志表
 * @description:
 * @author:YLL
 * @since:2013-06-05
 * @version:1.0
*/
 @Table(tableName = "DATA_EX_CHANGE_LOG" , keyFields = "id")
public class DataExChangeLog extends StatefulDatabean {
   //ID
   	@Rule(value="require")
	@Column(name = "ID")
   private String id;
   //UNIT_CODE
   	@Rule(value="require")
	@Column(name = "UNIT_CODE")
   private String unitCode;
   //UNIT_NAME
   	@Rule(value="require")
	@Column(name = "UNIT_NAME")
   private String unitName;
   //UNIT_ACCOUNT
   	@Rule(value="require")
	@Column(name = "UNIT_ACCOUNT")
   private String unitAccount;
   //QUERY_DATE
   	@Rule(value="require")
	@Column(name = "QUERY_DATE")
   private String queryDate;
   //BUSINESS_CATEGORY
   	/**
   	 * 901 婚姻  902 殡葬
   	 */
   	@Rule(value="require")
	@Column(name = "BUSINESS_CATEGORY")
   private String businessCategory;
   //QUERY_MODE
   	@Rule(value="require")
	@Column(name = "QUERY_MODE")
   private String queryMode;
   //QUERY_CONDITION
	@Column(name = "QUERY_CONDITION")
   private String queryCondition;
   //QUERY_CONDITION_SQL
	@Column(name = "QUERY_CONDITION_SQL")
   private String queryConditionSql;
   //QUERY_RESULT_COUNT
	@Column(name = "QUERY_RESULT_COUNT")
   private String queryResultCount;
   //CERT_MAN
	@Column(name = "CERT_MAN")
   private String certMan;
   //CERT_WOMAN
	@Column(name = "CERT_WOMAN")
   private String certWoman;
   //FIS_ID_CARD
	@Column(name = "FIS_ID_CARD")
   private String fisIdCard;
   /**
    * getter for ID
    * @generated
    */
   public String getId(){
      return this.id;
   }
   /**
    * setter for ID
    * @generated
    */
   public void setId(String id){
      this.id = id;
   }

   /**
    * getter for UNIT_CODE
    * @generated
    */
   public String getUnitCode(){
      return this.unitCode;
   }
   /**
    * setter for UNIT_CODE
    * @generated
    */
   public void setUnitCode(String unitCode){
      this.unitCode = unitCode;
   }

   /**
    * getter for UNIT_NAME
    * @generated
    */
   public String getUnitName(){
      return this.unitName;
   }
   /**
    * setter for UNIT_NAME
    * @generated
    */
   public void setUnitName(String unitName){
      this.unitName = unitName;
   }

   /**
    * getter for UNIT_ACCOUNT
    * @generated
    */
   public String getUnitAccount(){
      return this.unitAccount;
   }
   /**
    * setter for UNIT_ACCOUNT
    * @generated
    */
   public void setUnitAccount(String unitAccount){
      this.unitAccount = unitAccount;
   }

   /**
    * getter for QUERY_DATE
    * @generated
    */
   public String getQueryDate(){
      return this.queryDate;
   }
   /**
    * setter for QUERY_DATE
    * @generated
    */
   public void setQueryDate(String queryDate){
      this.queryDate = queryDate;
   }

   /**
    * getter for BUSINESS_CATEGORY
    * @generated
    */
   public String getBusinessCategory(){
      return this.businessCategory;
   }
   /**
    * setter for BUSINESS_CATEGORY
    * @generated
    */
   public void setBusinessCategory(String businessCategory){
      this.businessCategory = businessCategory;
   }

   /**
    * getter for QUERY_MODE
    * @generated
    */
   public String getQueryMode(){
      return this.queryMode;
   }
   /**
    * setter for QUERY_MODE
    * @generated
    */
   public void setQueryMode(String queryMode){
      this.queryMode = queryMode;
   }

   /**
    * getter for QUERY_CONDITION
    * @generated
    */
   public String getQueryCondition(){
      return this.queryCondition;
   }
   /**
    * setter for QUERY_CONDITION
    * @generated
    */
   public void setQueryCondition(String queryCondition){
      this.queryCondition = queryCondition;
   }

   /**
    * getter for QUERY_CONDITION_SQL
    * @generated
    */
   public String getQueryConditionSql(){
      return this.queryConditionSql;
   }
   /**
    * setter for QUERY_CONDITION_SQL
    * @generated
    */
   public void setQueryConditionSql(String queryConditionSql){
      this.queryConditionSql = queryConditionSql;
   }

   /**
    * getter for QUERY_RESULT_COUNT
    * @generated
    */
   public String getQueryResultCount(){
      return this.queryResultCount;
   }
   /**
    * setter for QUERY_RESULT_COUNT
    * @generated
    */
   public void setQueryResultCount(String queryResultCount){
      this.queryResultCount = queryResultCount;
   }

   /**
    * getter for CERT_MAN
    * @generated
    */
   public String getCertMan(){
      return this.certMan;
   }
   /**
    * setter for CERT_MAN
    * @generated
    */
   public void setCertMan(String certMan){
      this.certMan = certMan;
   }

   /**
    * getter for CERT_WOMAN
    * @generated
    */
   public String getCertWoman(){
      return this.certWoman;
   }
   /**
    * setter for CERT_WOMAN
    * @generated
    */
   public void setCertWoman(String certWoman){
      this.certWoman = certWoman;
   }

   /**
    * getter for FIS_ID_CARD
    * @generated
    */
   public String getFisIdCard(){
      return this.fisIdCard;
   }
   /**
    * setter for FIS_ID_CARD
    * @generated
    */
   public void setFisIdCard(String fisIdCard){
      this.fisIdCard = fisIdCard;
   }

}