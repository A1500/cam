package com.inspur.cams.drel.esurey.data;

import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * @title:SamLowStandards
 * @description:
 * @author:
 * @since:2011-07-06
 * @version:1.0
*/
 @Table(tableName = "SAM_LOW_STANDARDS" , keyFields = "STANDARDS_ID")
public class SamLowStandards extends StatefulDatabean {
	 
	//STANDARDS_ID
    @Column(name = "STANDARDS_ID")
	private String standardsId;
   //APANAGE
	@Column(name = "DOMICILE_CODE")
   private String domicileCode;
  //APANAGE
	@Column(name = "APANAGE_NAME")
   private String apanageName;
   //ASSITANCE_TYPE
	@Column(name = "ASSITANCE_TYPE")
   private String assitanceType;
	private String supportWay;
	@Column(name = "VALID_YEAR")
   private String validYear;
	@Column(name = "VALID_BEGIN_DATE")
   private String validBeginDate;
   //VALID_END
	@Column(name = "VALID_END_DATE")
   private String validEndDate;
	@Column(name = "IN_USE")
	private String inUse;
   //LOW_STANDARDS
	@Column(name = "LOW_STANDARDS")
   private BigDecimal lowStandards;
   //MOD_PEOPLE
	@Column(name = "MOD_PEOPLE")
   private String modPeople;
   //MOD_ORGAN
	@Column(name = "MOD_ORGAN")
   private String modOrgan;
   //MOD_TIME
	@Column(name = "MOD_TIME")
   private String modTime;
   /**
    * getter for ASSITANCE_TYPE
    * @generated
    */
   public String getAssitanceType(){
      return this.assitanceType;
   }
   /**
    * setter for ASSITANCE_TYPE
    * @generated
    */
   public void setAssitanceType(String assitanceType){
      this.assitanceType = assitanceType;
   }

   /**
    * getter for LOW_STANDARDS
    * @generated
    */
   public BigDecimal getLowStandards(){
      return this.lowStandards;
   }
   /**
    * setter for LOW_STANDARDS
    * @generated
    */
   public void setLowStandards(BigDecimal lowStandards){
      this.lowStandards = lowStandards;
   }

   /**
    * getter for MOD_PEOPLE
    * @generated
    */
   public String getModPeople(){
      return this.modPeople;
   }
   /**
    * setter for MOD_PEOPLE
    * @generated
    */
   public void setModPeople(String modPeople){
      this.modPeople = modPeople;
   }

   /**
    * getter for MOD_ORGAN
    * @generated
    */
   public String getModOrgan(){
      return this.modOrgan;
   }
   /**
    * setter for MOD_ORGAN
    * @generated
    */
   public void setModOrgan(String modOrgan){
      this.modOrgan = modOrgan;
   }

   /**
    * getter for MOD_TIME
    * @generated
    */
   public String getModTime(){
      return this.modTime;
   }
   /**
    * setter for MOD_TIME
    * @generated
    */
   public void setModTime(String modTime){
      this.modTime = modTime;
   }
/**
 * @param standardsId the standardsId to set
 */
public void setStandardsId(String standardsId) {
	this.standardsId = standardsId;
}
/**
 * @return the standardsId
 */
public String getStandardsId() {
	return standardsId;
}
/**
 * @param apanageName the apanageName to set
 */
public void setApanageName(String apanageName) {
	this.apanageName = apanageName;
}
/**
 * @return the apanageName
 */
public String getApanageName() {
	return apanageName;
}
/**
 * @return the validYear
 */
public String getValidYear() {
	return validYear;
}
/**
 * @param validYear the validYear to set
 */
public void setValidYear(String validYear) {
	this.validYear = validYear;
}
public String getDomicileCode() {
	return domicileCode;
}
public void setDomicileCode(String domicileCode) {
	this.domicileCode = domicileCode;
}
public String getValidBeginDate() {
	return validBeginDate;
}
public void setValidBeginDate(String validBeginDate) {
	this.validBeginDate = validBeginDate;
}
public String getValidEndDate() {
	return validEndDate;
}
public void setValidEndDate(String validEndDate) {
	this.validEndDate = validEndDate;
}
public String getInUse() {
	return inUse;
}
public void setInUse(String inUse) {
	this.inUse = inUse;
}
public String getSupportWay() {
	return supportWay;
}
public void setSupportWay(String supportWay) {
	this.supportWay = supportWay;
}

}