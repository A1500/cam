package com.inspur.cams.drel.mbalance.data;

import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * @title:SamMedicalBefore
 * @description:
 * @author:
 * @since:2011-06-25
 * @version:1.0
*/
 @Table(tableName = "sam_medical_before" , keyFields = "id")
public class SamMedicalBefore extends StatefulDatabean {
   //救助ID
	@Column(name = "ID")
   private String id;
   //住院流水ID
	@Column(name = "BALANCE_ID")
   private String balanceId;
   //姓名
	@Column(name = "NAME")
   private String name;
   //家庭ID
	@Column(name = "FAMILY_ID")
   private String familyId;
   //身份证件类型代码
	@Column(name = "ID_CARD_TYPE")
   private String idCardType;
   //身份证件号码
   	@Rule(value="require")
	@Column(name = "ID_CARD")
   private String idCard;
   //人员ID
	@Column(name = "PEOPLE_ID")
   private String peopleId;
   //病种
   	@Rule(value="require")
	@Column(name = "DISEASE")
   private String disease;
   //病情
	@Column(name = "DISEASE_INFO")
   private String diseaseInfo;
   //救助金额
   	@Rule(value="require")
	@Column(name = "ASSITANCE_MON")
   private String assitanceMon;
   //审批日期
   	@Rule(value="require")
	@Column(name = "AUDIT_DATE")
   private String auditDate;
   //使用状态
   	@Rule(value="require")
	@Column(name = "STATUS")
   private String status;
   //救助单位
	@Column(name = "ASSITANCE_ORG")
   private String assitanceOrg;
   //救助单位所属行政区划
   @Column(name="ASSITANCE_ORG_CODE")
   private String assitanceOrgCode;
   //经办人
   	@Rule(value="require")
	@Column(name = "MANAGER")
   private String manager;
   //录入人ID
	@Column(name = "REG_ID")
   private String regId;
   //录入人姓名
	@Column(name = "REG_PEOPLE")
   private String regPeople;
   //录入时间
	@Column(name = "REG_TIME")
   private String regTime;
   //修改人ID
	@Column(name = "MOD_ID")
   private String modId;
   //修改人姓名
	@Column(name = "MOD_PEOPLE")
   private String modPeople;
   //修改时间
	@Column(name = "MOD_TIME")
   private String modTime;
   /**
    * getter for 救助ID
    * @generated
    */
   public String getId(){
      return this.id;
   }
   /**
    * setter for 救助ID
    * @generated
    */
   public void setId(String id){
      this.id = id;
   }

   /**
    * getter for 住院流水ID
    * @generated
    */
   public String getBalanceId(){
      return this.balanceId;
   }
   /**
    * setter for 住院流水ID
    * @generated
    */
   public void setBalanceId(String balanceId){
      this.balanceId = balanceId;
   }

   /**
    * getter for 姓名
    * @generated
    */
   public String getName(){
      return this.name;
   }
   /**
    * setter for 姓名
    * @generated
    */
   public void setName(String name){
      this.name = name;
   }

   /**
    * getter for 家庭ID
    * @generated
    */
   public String getFamilyId(){
      return this.familyId;
   }
   /**
    * setter for 家庭ID
    * @generated
    */
   public void setFamilyId(String familyId){
      this.familyId = familyId;
   }

   /**
    * getter for 身份证件类型代码
    * @generated
    */
   public String getIdCardType(){
      return this.idCardType;
   }
   /**
    * setter for 身份证件类型代码
    * @generated
    */
   public void setIdCardType(String idCardType){
      this.idCardType = idCardType;
   }

   /**
    * getter for 身份证件号码
    * @generated
    */
   public String getIdCard(){
      return this.idCard;
   }
   /**
    * setter for 身份证件号码
    * @generated
    */
   public void setIdCard(String idCard){
      this.idCard = idCard;
   }

   /**
    * getter for 人员ID
    * @generated
    */
   public String getPeopleId(){
      return this.peopleId;
   }
   /**
    * setter for 人员ID
    * @generated
    */
   public void setPeopleId(String peopleId){
      this.peopleId = peopleId;
   }

   /**
    * getter for 病种
    * @generated
    */
   public String getDisease(){
      return this.disease;
   }
   /**
    * setter for 病种
    * @generated
    */
   public void setDisease(String disease){
      this.disease = disease;
   }

   /**
    * getter for 病情
    * @generated
    */
   public String getDiseaseInfo(){
      return this.diseaseInfo;
   }
   /**
    * setter for 病情
    * @generated
    */
   public void setDiseaseInfo(String diseaseInfo){
      this.diseaseInfo = diseaseInfo;
   }

   /**
    * getter for 救助金额
    * @generated
    */
   public String getAssitanceMon(){
      return this.assitanceMon;
   }
   /**
    * setter for 救助金额
    * @generated
    */
   public void setAssitanceMon(String assitanceMon){
      this.assitanceMon = assitanceMon;
   }

   /**
    * getter for 审批日期
    * @generated
    */
   public String getAuditDate(){
      return this.auditDate;
   }
   /**
    * setter for 审批日期
    * @generated
    */
   public void setAuditDate(String auditDate){
      this.auditDate = auditDate;
   }

   /**
    * getter for 使用状态
    * @generated
    */
   public String getStatus(){
      return this.status;
   }
   /**
    * setter for 使用状态
    * @generated
    */
   public void setStatus(String status){
      this.status = status;
   }

   /**
    * getter for 救助单位
    * @generated
    */
   public String getAssitanceOrg(){
      return this.assitanceOrg;
   }
   /**
    * setter for 救助单位
    * @generated
    */
   public void setAssitanceOrg(String assitanceOrg){
      this.assitanceOrg = assitanceOrg;
   }

   /**
    * getter for 经办人
    * @generated
    */
   public String getManager(){
      return this.manager;
   }
   /**
    * setter for 经办人
    * @generated
    */
   public void setManager(String manager){
      this.manager = manager;
   }

   /**
    * getter for 录入人ID
    * @generated
    */
   public String getRegId(){
      return this.regId;
   }
   /**
    * setter for 录入人ID
    * @generated
    */
   public void setRegId(String regId){
      this.regId = regId;
   }

   /**
    * getter for 录入人姓名
    * @generated
    */
   public String getRegPeople(){
      return this.regPeople;
   }
   /**
    * setter for 录入人姓名
    * @generated
    */
   public void setRegPeople(String regPeople){
      this.regPeople = regPeople;
   }

   /**
    * getter for 录入时间
    * @generated
    */
   public String getRegTime(){
      return this.regTime;
   }
   /**
    * setter for 录入时间
    * @generated
    */
   public void setRegTime(String regTime){
      this.regTime = regTime;
   }

   /**
    * getter for 修改人ID
    * @generated
    */
   public String getModId(){
      return this.modId;
   }
   /**
    * setter for 修改人ID
    * @generated
    */
   public void setModId(String modId){
      this.modId = modId;
   }

   /**
    * getter for 修改人姓名
    * @generated
    */
   public String getModPeople(){
      return this.modPeople;
   }
   /**
    * setter for 修改人姓名
    * @generated
    */
   public void setModPeople(String modPeople){
      this.modPeople = modPeople;
   }

   /**
    * getter for 修改时间
    * @generated
    */
   public String getModTime(){
      return this.modTime;
   }
   /**
    * setter for 修改时间
    * @generated
    */
   public void setModTime(String modTime){
      this.modTime = modTime;
   }
public String getAssitanceOrgCode() {
	return assitanceOrgCode;
}
public void setAssitanceOrgCode(String assitanceOrgCode) {
	this.assitanceOrgCode = assitanceOrgCode;
}

}