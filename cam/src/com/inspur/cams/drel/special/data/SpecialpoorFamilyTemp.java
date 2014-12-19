package com.inspur.cams.drel.special.data;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * @title:特困临时表
 * @description:
 * @author:
 * @since:2013-08-09
 * @version:1.0
*/
 @Table(tableName = "SPECIALPOOR_FAMILY_TEMP" , keyFields = "address")
public class SpecialpoorFamilyTemp extends StatefulDatabean {
   //DOMICILE_CODE
	@Column(name = "DOMICILE_CODE")
   private String domicileCode;
   //DOMICILE_NAME
	@Column(name = "DOMICILE_NAME")
   private String domicileName;
   //FAMILY_NAME
	@Column(name = "FAMILY_NAME")
   private String familyName;
   //PEOPLE_NUM
	@Column(name = "PEOPLE_NUM")
   private BigDecimal peopleNum;
   //ADDRESS
	@Column(name = "ADDRESS")
   private String address;
   //SPECIALPOOR_CAUSE
	@Column(name = "SPECIALPOOR_CAUSE")
   private String specialpoorCause;
	@Column(name = "SPECIALPOOR_CAUSE_NAME")
	   private String specialpoorCauseName;
   //ASSISTANCE_FLAG
	@Column(name = "ASSISTANCE_FLAG")
   private String assistanceFlag;
	
	@Column(name = "FAMILY_CARD_NO")
	   private String familyCardNo;
		
   public String getFamilyCardNo() {
		return familyCardNo;
	}
	public void setFamilyCardNo(String familyCardNo) {
		this.familyCardNo = familyCardNo;
	}
//PROVINCE
   /**
    * getter for DOMICILE_CODE
    * @generated
    */
   public String getDomicileCode(){
      return this.domicileCode;
   }
   /**
    * setter for DOMICILE_CODE
    * @generated
    */
   public void setDomicileCode(String domicileCode){
      this.domicileCode = domicileCode;
   }

   /**
    * getter for DOMICILE_NAME
    * @generated
    */
   public String getDomicileName(){
      return this.domicileName;
   }
   /**
    * setter for DOMICILE_NAME
    * @generated
    */
   public void setDomicileName(String domicileName){
      this.domicileName = domicileName;
   }

   /**
    * getter for FAMILY_NAME
    * @generated
    */
   public String getFamilyName(){
      return this.familyName;
   }
   /**
    * setter for FAMILY_NAME
    * @generated
    */
   public void setFamilyName(String familyName){
      this.familyName = familyName;
   }

   /**
    * getter for PEOPLE_NUM
    * @generated
    */
   public BigDecimal getPeopleNum(){
      return this.peopleNum;
   }
   /**
    * setter for PEOPLE_NUM
    * @generated
    */
   public void setPeopleNum(BigDecimal peopleNum){
      this.peopleNum = peopleNum;
   }

   /**
    * getter for ADDRESS
    * @generated
    */
   public String getAddress(){
      return this.address;
   }
   /**
    * setter for ADDRESS
    * @generated
    */
   public void setAddress(String address){
      this.address = address;
   }

   /**
    * getter for SPECIALPOOR_CAUSE
    * @generated
    */
   public String getSpecialpoorCause(){
      return this.specialpoorCause;
   }
   /**
    * setter for SPECIALPOOR_CAUSE
    * @generated
    */
   public void setSpecialpoorCause(String specialpoorCause){
      this.specialpoorCause = specialpoorCause;
   }

   /**
    * getter for ASSISTANCE_FLAG
    * @generated
    */
   public String getAssistanceFlag(){
      return this.assistanceFlag;
   }
   /**
    * setter for ASSISTANCE_FLAG
    * @generated
    */
   public void setAssistanceFlag(String assistanceFlag){
      this.assistanceFlag = assistanceFlag;
   }
public String getSpecialpoorCauseName() {
	return specialpoorCauseName;
}
public void setSpecialpoorCauseName(String specialpoorCauseName) {
	this.specialpoorCauseName = specialpoorCauseName;
}
}