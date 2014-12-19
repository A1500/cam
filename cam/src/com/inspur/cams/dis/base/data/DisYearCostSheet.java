package com.inspur.cams.dis.base.data;

import java.math.BigDecimal;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:DisYearCostSheet
 * @description:
 * @author:
 * @since:2012-10-09
 * @version:1.0
*/
 @Table(tableName = "DIS_YEAR_COST_SHEET" , keyFields = "id")
 
public class DisYearCostSheet extends StatefulDatabean {
	 
   //ID
   	@Rule(value="require")
	@Column(name = "ID")
   private String id;
   //DIS_YEAR
	@Column(name = "DIS_YEAR")
   private String disYear;
   //YEAR_COST_SHEET
   	@Rule(value="number")
	@Column(name = "YEAR_COST_SHEET")
   private BigDecimal yearCostSheet;
   //ASSISTANCE_FOR_SELF
   	@Rule(value="number")
	@Column(name = "ASSISTANCE_FOR_SELF")
   private BigDecimal assistanceForSelf;
   //DONATION_FOR_SELF
   	@Rule(value="number")
	@Column(name = "DONATION_FOR_SELF")
   private BigDecimal donationForSelf;
   //ORGAN_CODE
	@Column(name = "ORGAN_CODE")
   private String organCode;
   //ORGAN_NAME
	@Column(name = "ORGAN_NAME")
   private String organName;
   //FILL_PEOPLE_NAME
	@Column(name = "FILL_PEOPLE_NAME")
   private String fillPeopleName;
   //FILL_TIME
	@Column(name = "FILL_TIME")
   private String fillTime;
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
    * getter for DIS_YEAR
    * @generated
    */
   public String getDisYear(){
      return this.disYear;
   }
   /**
    * setter for DIS_YEAR
    * @generated
    */
   public void setDisYear(String disYear){
      this.disYear = disYear;
   }

   /**
    * getter for YEAR_COST_SHEET
    * @generated
    */
   public BigDecimal getYearCostSheet(){
      return this.yearCostSheet;
   }
   /**
    * setter for YEAR_COST_SHEET
    * @generated
    */
   public void setYearCostSheet(BigDecimal yearCostSheet){
      this.yearCostSheet = yearCostSheet;
   }

   /**
    * getter for ASSISTANCE_FOR_SELF
    * @generated
    */
   public BigDecimal getAssistanceForSelf(){
      return this.assistanceForSelf;
   }
   /**
    * setter for ASSISTANCE_FOR_SELF
    * @generated
    */
   public void setAssistanceForSelf(BigDecimal assistanceForSelf){
      this.assistanceForSelf = assistanceForSelf;
   }

   /**
    * getter for DONATION_FOR_SELF
    * @generated
    */
   public BigDecimal getDonationForSelf(){
      return this.donationForSelf;
   }
   /**
    * setter for DONATION_FOR_SELF
    * @generated
    */
   public void setDonationForSelf(BigDecimal donationForSelf){
      this.donationForSelf = donationForSelf;
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
    * getter for FILL_PEOPLE_NAME
    * @generated
    */
   public String getFillPeopleName(){
      return this.fillPeopleName;
   }
   /**
    * setter for FILL_PEOPLE_NAME
    * @generated
    */
   public void setFillPeopleName(String fillPeopleName){
      this.fillPeopleName = fillPeopleName;
   }

   /**
    * getter for FILL_TIME
    * @generated
    */
   public String getFillTime(){
      return this.fillTime;
   }
   /**
    * setter for FILL_TIME
    * @generated
    */
   public void setFillTime(String fillTime){
      this.fillTime = fillTime;
   }

}