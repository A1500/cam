package com.inspur.cams.bpt.base.data;

import org.loushang.next.dao.*;
import org.loushang.next.data.*;
/**
 * @title:DisabilityIdentification
 * @description:
 * @author:王宝才
 * @since:2011-05-18
 * @version:1.0
*/
 @Table(tableName = "BPT_DISABILITY_IDENTI" , keyFields = "applyId")
public class DisabilityIdentification extends StatefulDatabean {
	//APPLYID
   	@Rule(value="require")
	@Column(name = "APPLY_ID")
   private String applyId;
   //人员ID
   	@Rule(value="require")
	@Column(name = "PEOPLE_ID")
   private String peopleId;
   //编号
   	@Rule(value="require")
	@Column(name = "NUMBERING")
   private String numbering;
   //鉴定单位
   	@Rule(value="require")
	@Column(name = "IDENTIFICATION_UNIT")
   private String identificationUnit;
   //介绍单位
   	@Rule(value="require")
	@Column(name = "INTRODUCTION_UNIT")
   private String introductionUnit;
   //介绍时间
   	@Rule(value="require")
	@Column(name = "INTRODUCTION_DATE")
   private String introductionDate;
   //鉴定时间
	@Column(name = "IDENTIFICATION_DATE")
   private String identificationDate;
   //经办人
	@Column(name = "AGENT")
   private String agent;
   //经办人电话
	@Column(name = "AGENT_PHONE")
   private String agentPhone;
   //姓名
	@Column(name = "NAME")
   private String name;
   //性别
	@Column(name = "SEX")
   private String sex;
   //出生年月
	@Column(name = "BIRTHDAY")
   private String birthday;
   //户籍地行政区划
	@Column(name = "DOMICILE_CODE")
   private String domicileCode;
   //身份证号
	@Column(name = "ID_CARD")
   private String idCard;
   //受伤时身份
	@Column(name = "INJURY_STATUS")
   private String injuryStatus;
   //住址
	@Column(name = "ADDRESS")
   private String address;
   //工作单位名称
	@Column(name = "WORK_UNIT_NAME")
   private String workUnitName;
   //负伤时间
	@Column(name = "DISABILITY_DATE")
   private String disabilityDate;
   //致残原因
	@Column(name = "DISABILITY_REASON")
   private String disabilityReason;
   //致残部位
	@Column(name = "DISABILITY_BODY")
   private String disabilityBody;
   //附送材料情况
	@Column(name = "DATA_SITUATION")
   private String dataSituation;
   //备注
	@Column(name = "NOTE")
   private String note;

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
    * getter for 编号
    * @generated
    */
   public String getNumbering(){
      return this.numbering;
   }
   /**
    * setter for 编号
    * @generated
    */
   public void setNumbering(String numbering){
      this.numbering = numbering;
   }

   /**
    * getter for 鉴定单位
    * @generated
    */
   public String getIdentificationUnit(){
      return this.identificationUnit;
   }
   /**
    * setter for 鉴定单位
    * @generated
    */
   public void setIdentificationUnit(String identificationUnit){
      this.identificationUnit = identificationUnit;
   }

   /**
    * getter for 介绍单位
    * @generated
    */
   public String getIntroductionUnit(){
      return this.introductionUnit;
   }
   /**
    * setter for 介绍单位
    * @generated
    */
   public void setIntroductionUnit(String introductionUnit){
      this.introductionUnit = introductionUnit;
   }

   /**
    * getter for 介绍时间
    * @generated
    */
   public String getIntroductionDate(){
      return this.introductionDate;
   }
   /**
    * setter for 介绍时间
    * @generated
    */
   public void setIntroductionDate(String introductionDate){
      this.introductionDate = introductionDate;
   }

   /**
    * getter for 鉴定时间
    * @generated
    */
   public String getIdentificationDate(){
      return this.identificationDate;
   }
   /**
    * setter for 鉴定时间
    * @generated
    */
   public void setIdentificationDate(String identificationDate){
      this.identificationDate = identificationDate;
   }

   /**
    * getter for 经办人
    * @generated
    */
   public String getAgent(){
      return this.agent;
   }
   /**
    * setter for 经办人
    * @generated
    */
   public void setAgent(String agent){
      this.agent = agent;
   }

   /**
    * getter for 经办人电话
    * @generated
    */
   public String getAgentPhone(){
      return this.agentPhone;
   }
   /**
    * setter for 经办人电话
    * @generated
    */
   public void setAgentPhone(String agentPhone){
      this.agentPhone = agentPhone;
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
    * getter for 性别
    * @generated
    */
   public String getSex(){
      return this.sex;
   }
   /**
    * setter for 性别
    * @generated
    */
   public void setSex(String sex){
      this.sex = sex;
   }

   /**
    * getter for 出生年月
    * @generated
    */
   public String getBirthday(){
      return this.birthday;
   }
   /**
    * setter for 出生年月
    * @generated
    */
   public void setBirthday(String birthday){
      this.birthday = birthday;
   }

   /**
    * getter for 户籍地行政区划
    * @generated
    */
   public String getDomicileCode(){
      return this.domicileCode;
   }
   /**
    * setter for 户籍地行政区划
    * @generated
    */
   public void setDomicileCode(String domicileCode){
      this.domicileCode = domicileCode;
   }

   /**
    * getter for 身份证号
    * @generated
    */
   public String getIdCard(){
      return this.idCard;
   }
   /**
    * setter for 身份证号
    * @generated
    */
   public void setIdCard(String idCard){
      this.idCard = idCard;
   }

   /**
    * getter for 受伤时身份
    * @generated
    */
   public String getInjuryStatus(){
      return this.injuryStatus;
   }
   /**
    * setter for 受伤时身份
    * @generated
    */
   public void setInjuryStatus(String injuryStatus){
      this.injuryStatus = injuryStatus;
   }

   /**
    * getter for 住址
    * @generated
    */
   public String getAddress(){
      return this.address;
   }
   /**
    * setter for 住址
    * @generated
    */
   public void setAddress(String address){
      this.address = address;
   }

   /**
    * getter for 工作单位名称
    * @generated
    */
   public String getWorkUnitName(){
      return this.workUnitName;
   }
   /**
    * setter for 工作单位名称
    * @generated
    */
   public void setWorkUnitName(String workUnitName){
      this.workUnitName = workUnitName;
   }

   /**
    * getter for 负伤时间
    * @generated
    */
   public String getDisabilityDate(){
      return this.disabilityDate;
   }
   /**
    * setter for 负伤时间
    * @generated
    */
   public void setDisabilityDate(String disabilityDate){
      this.disabilityDate = disabilityDate;
   }

   /**
    * getter for 致残原因
    * @generated
    */
   public String getDisabilityReason(){
      return this.disabilityReason;
   }
   /**
    * setter for 致残原因
    * @generated
    */
   public void setDisabilityReason(String disabilityReason){
      this.disabilityReason = disabilityReason;
   }

   /**
    * getter for 致残部位
    * @generated
    */
   public String getDisabilityBody(){
      return this.disabilityBody;
   }
   /**
    * setter for 致残部位
    * @generated
    */
   public void setDisabilityBody(String disabilityBody){
      this.disabilityBody = disabilityBody;
   }

   /**
    * getter for 附送材料情况
    * @generated
    */
   public String getDataSituation(){
      return this.dataSituation;
   }
   /**
    * setter for 附送材料情况
    * @generated
    */
   public void setDataSituation(String dataSituation){
      this.dataSituation = dataSituation;
   }

   /**
    * getter for 备注
    * @generated
    */
   public String getNote(){
      return this.note;
   }
   /**
    * setter for 备注
    * @generated
    */
   public void setNote(String note){
      this.note = note;
   }
public String getApplyId() {
	return applyId;
}
public void setApplyId(String applyId) {
	this.applyId = applyId;
}

}