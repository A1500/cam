package com.inspur.cams.drel.archive.sampeopleextendarchive.data;

import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * @title:SamPeopleExtendArchive
 * @description:
 * @author:
 * @since:2012-06-04
 * @version:1.0
*/
 @Table(tableName = "SAM_PEOPLE_EXTEND_ARCHIVE" , keyFields = "extnedArchiveId")
public class SamPeopleExtendArchive extends StatefulDatabean {
   //EXTNED_ARCHIVE_ID
   //@Rule(value="require")
	@Column(name = "EXTNED_ARCHIVE_ID")
   private String extnedArchiveId;
   //EXTNED_ID
	@Column(name = "EXTNED_ID")
   private String extnedId;
   //PEOPLE_ID
	@Column(name = "PEOPLE_ID")
   private String peopleId;
   //BELONGING
	@Column(name = "BELONGING")
   private String belonging;
   //IS_ASSISTANCE
	@Column(name = "IS_ASSISTANCE")
   private String isAssistance;
   //SPICAL_TYPE
	@Column(name = "SPICAL_TYPE")
   private String spicalType;
   //TRADITON_TYPE
	@Column(name = "TRADITON_TYPE")
   private String traditonType;
   //SUPPORT_WAY
	@Column(name = "SUPPORT_WAY")
   private String supportWay;
   //DOMICILE_ADDRESS
	@Column(name = "DOMICILE_ADDRESS")
   private String domicileAddress;
   //DOMICILE_POST_CODE
	@Column(name = "DOMICILE_POST_CODE")
   private String domicilePostCode;
   //SELF_CARE_ABILITY
	@Column(name = "SELF_CARE_ABILITY")
   private String selfCareAbility;
   //SUPPORT_ORG_ID
	@Column(name = "SUPPORT_ORG_ID")
   private String supportOrgId;
   //LABOR_CAPACITY
	@Column(name = "LABOR_CAPACITY")
   private String laborCapacity;
   //IS_THREE_NO
	@Column(name = "IS_THREE_NO")
   private String isThreeNo;
   //DEL_REASON
	@Column(name = "DEL_REASON")
   private String delReason;
   //ASSISTANCE_CLASS
	@Column(name = "ASSISTANCE_CLASS")
   private String assistanceClass;
	private String peopleType;
	private String peopleTypeName;
   //REMARKS
	@Column(name = "REMARKS")
   private String remarks;
   //APPLY_ID
	@Column(name = "APPLY_ID")
   private String applyId;
   //PEOPLE_ARCHIVE_ID
   	@Rule(value="require")
	@Column(name = "PEOPLE_ARCHIVE_ID")
   private String peopleArchiveId;
   /**
    * getter for EXTNED_ARCHIVE_ID
    * @generated
    */
   public String getExtnedArchiveId(){
      return this.extnedArchiveId;
   }
   /**
    * setter for EXTNED_ARCHIVE_ID
    * @generated
    */
   public void setExtnedArchiveId(String extnedArchiveId){
      this.extnedArchiveId = extnedArchiveId;
   }

   /**
    * getter for EXTNED_ID
    * @generated
    */
   public String getExtnedId(){
      return this.extnedId;
   }
   /**
    * setter for EXTNED_ID
    * @generated
    */
   public void setExtnedId(String extnedId){
      this.extnedId = extnedId;
   }

   /**
    * getter for PEOPLE_ID
    * @generated
    */
   public String getPeopleId(){
      return this.peopleId;
   }
   /**
    * setter for PEOPLE_ID
    * @generated
    */
   public void setPeopleId(String peopleId){
      this.peopleId = peopleId;
   }

   /**
    * getter for BELONGING
    * @generated
    */
   public String getBelonging(){
      return this.belonging;
   }
   /**
    * setter for BELONGING
    * @generated
    */
   public void setBelonging(String belonging){
      this.belonging = belonging;
   }

   /**
    * getter for IS_ASSISTANCE
    * @generated
    */
   public String getIsAssistance(){
      return this.isAssistance;
   }
   /**
    * setter for IS_ASSISTANCE
    * @generated
    */
   public void setIsAssistance(String isAssistance){
      this.isAssistance = isAssistance;
   }

   /**
    * getter for SPICAL_TYPE
    * @generated
    */
   public String getSpicalType(){
      return this.spicalType;
   }
   /**
    * setter for SPICAL_TYPE
    * @generated
    */
   public void setSpicalType(String spicalType){
      this.spicalType = spicalType;
   }

   /**
    * getter for TRADITON_TYPE
    * @generated
    */
   public String getTraditonType(){
      return this.traditonType;
   }
   /**
    * setter for TRADITON_TYPE
    * @generated
    */
   public void setTraditonType(String traditonType){
      this.traditonType = traditonType;
   }

   /**
    * getter for SUPPORT_WAY
    * @generated
    */
   public String getSupportWay(){
      return this.supportWay;
   }
   /**
    * setter for SUPPORT_WAY
    * @generated
    */
   public void setSupportWay(String supportWay){
      this.supportWay = supportWay;
   }

   /**
    * getter for DOMICILE_ADDRESS
    * @generated
    */
   public String getDomicileAddress(){
      return this.domicileAddress;
   }
   /**
    * setter for DOMICILE_ADDRESS
    * @generated
    */
   public void setDomicileAddress(String domicileAddress){
      this.domicileAddress = domicileAddress;
   }

   /**
    * getter for DOMICILE_POST_CODE
    * @generated
    */
   public String getDomicilePostCode(){
      return this.domicilePostCode;
   }
   /**
    * setter for DOMICILE_POST_CODE
    * @generated
    */
   public void setDomicilePostCode(String domicilePostCode){
      this.domicilePostCode = domicilePostCode;
   }

   /**
    * getter for SELF_CARE_ABILITY
    * @generated
    */
   public String getSelfCareAbility(){
      return this.selfCareAbility;
   }
   /**
    * setter for SELF_CARE_ABILITY
    * @generated
    */
   public void setSelfCareAbility(String selfCareAbility){
      this.selfCareAbility = selfCareAbility;
   }

   /**
    * getter for SUPPORT_ORG_ID
    * @generated
    */
   public String getSupportOrgId(){
      return this.supportOrgId;
   }
   /**
    * setter for SUPPORT_ORG_ID
    * @generated
    */
   public void setSupportOrgId(String supportOrgId){
      this.supportOrgId = supportOrgId;
   }

   /**
    * getter for LABOR_CAPACITY
    * @generated
    */
   public String getLaborCapacity(){
      return this.laborCapacity;
   }
   /**
    * setter for LABOR_CAPACITY
    * @generated
    */
   public void setLaborCapacity(String laborCapacity){
      this.laborCapacity = laborCapacity;
   }

   /**
    * getter for IS_THREE_NO
    * @generated
    */
   public String getIsThreeNo(){
      return this.isThreeNo;
   }
   /**
    * setter for IS_THREE_NO
    * @generated
    */
   public void setIsThreeNo(String isThreeNo){
      this.isThreeNo = isThreeNo;
   }

   /**
    * getter for DEL_REASON
    * @generated
    */
   public String getDelReason(){
      return this.delReason;
   }
   /**
    * setter for DEL_REASON
    * @generated
    */
   public void setDelReason(String delReason){
      this.delReason = delReason;
   }

   /**
    * getter for ASSISTANCE_CLASS
    * @generated
    */
   public String getAssistanceClass(){
      return this.assistanceClass;
   }
   /**
    * setter for ASSISTANCE_CLASS
    * @generated
    */
   public void setAssistanceClass(String assistanceClass){
      this.assistanceClass = assistanceClass;
   }

   /**
    * getter for REMARKS
    * @generated
    */
   public String getRemarks(){
      return this.remarks;
   }
   /**
    * setter for REMARKS
    * @generated
    */
   public void setRemarks(String remarks){
      this.remarks = remarks;
   }

   /**
    * getter for APPLY_ID
    * @generated
    */
   public String getApplyId(){
      return this.applyId;
   }
   /**
    * setter for APPLY_ID
    * @generated
    */
   public void setApplyId(String applyId){
      this.applyId = applyId;
   }

   /**
    * getter for PEOPLE_ARCHIVE_ID
    * @generated
    */
   public String getPeopleArchiveId(){
      return this.peopleArchiveId;
   }
   /**
    * setter for PEOPLE_ARCHIVE_ID
    * @generated
    */
   public void setPeopleArchiveId(String peopleArchiveId){
      this.peopleArchiveId = peopleArchiveId;
   }
public String getPeopleType() {
	return peopleType;
}
public void setPeopleType(String peopleType) {
	this.peopleType = peopleType;
}
public String getPeopleTypeName() {
	return peopleTypeName;
}
public void setPeopleTypeName(String peopleTypeName) {
	this.peopleTypeName = peopleTypeName;
}

}