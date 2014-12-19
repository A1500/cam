package com.inspur.cams.drel.esurey.data;

import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * @title:SamEsureyPeople
 * @description:
 * @author:
 * @since:2011-06-29
 * @version:1.0
*/
 @Table(tableName = "SAM_ESUREY_PEOPLE" , keyFields = "peopleId")
public class SamEsureyPeople extends StatefulDatabean {
   //人员ID
	@Column(name = "PEOPLE_ID")
   private String peopleId;
   //家庭ID
	@Column(name = "FAMILY_ID")
   private String familyId;
   //核对流水ID
	@Column(name = "SURVEY_ID")
   private String surveyId;
   //户主关系代码
	@Column(name = "RELATIONSHIP_TYPE")
   private String relationshipType;
   //属地行政区划
	@Column(name = "DOMICILE_CODE")
   private String domicileCode;
   //住址行政区划
	@Column(name = "APANAGE_CODE")
   private String apanageCode;
   //姓名
	@Column(name = "NAME")
   private String name;
   //身份证件类型代码
	@Column(name = "ID_CARD_TYPE")
   private String idCardType;
   //身份证件号码
	@Column(name = "ID_CARD")
   private String idCard;
   //性别
	@Column(name = "SEX")
   private String sex;
   //出生日期
	@Column(name = "BIRTHDAY")
   private String birthday;
   //民族
	@Column(name = "NATION")
   private String nation;
   //文化程度代码
	@Column(name = "EDU_CODE")
   private String eduCode;
   //健康状况代码
	@Column(name = "HEALTH_CODE")
   private String healthCode;
   //婚姻状况代码
	@Column(name = "MARRIAGE_CODE")
   private String marriageCode;
   //职业代码
	@Column(name = "CAREER_CODE")
   private String careerCode;
   //政治面貌代码
	@Column(name = "POLITICAL_CODE")
   private String politicalCode;
   //户籍类别代码
	@Column(name = "DOMICILE_TYPE")
   private String domicileType;
   //联系方式_手机
	@Column(name = "TEL_MOBILE")
   private String telMobile;
   //联系方式_其他
	@Column(name = "TEL_OTHER")
   private String telOther;
   //住址
	@Column(name = "ADDRESS")
   private String address;
   //邮政编码
	@Column(name = "POST_CODE")
   private String postCode;
   //年收入
	@Column(name = "INCOME_YEAR")
   private String incomeYear;
   //月收入
	@Column(name = "INCOME_MONTH")
   private String incomeMonth;
   //就业状况代码
	@Column(name = "EMPLOYMENT_CODE")
   private String employmentCode;
   //工作单位_名称
	@Column(name = "WORK_UNIT_NAME")
   private String workUnitName;
   //工作单位_电话
	@Column(name = "WORK_UNIT_TEL")
   private String workUnitTel;
   //工作单位_地址
	@Column(name = "WORK_UNIT_ADD")
   private String workUnitAdd;
   //个人状态标志
	@Column(name = "PERSONAL_STATS_TAG")
   private String personalStatsTag;
   //录入人ID
	@Column(name = "REG_ID")
   private String regId;
	//录入人名称
	@Column(name = "REG_PEOPLE")
   private String regPeople;
   //录入时间
	@Column(name = "REG_TIME")
   private String regTime;
   //修改人ID
	@Column(name = "MOD_ID")
   private String modId;
	//修改人名称
	@Column(name = "MOD_PEOPLE")
   private String modPeople;
   //修改时间
	@Column(name = "MOD_TIME")
   private String modTime;
	//是否赡养人员
	@Column(name = "IS_SUPPORT")
	private String isSupport;
	//非表列，发起核对时外部单位社保
	@Transient
	   private String externalSocialOrg;
	//非表列，发起核对时外部单位房管
	@Transient
	   private String externalHouseOrg;
	//非表列，发起核对时外部单位工商
	@Transient
	   private String externalBusinessOrg;
	//非表列，发起核对时外部单位车管
	@Transient
	   private String externalCarOrg;
	//非表列，发起核对时外部单位国税
	@Transient
	   private String externalTaxGOrg;
	//非表列，发起核对时外部单位地税
	@Transient
	   private String externalTaxDOrg;
	//非表列，发起核对时外部单位公积金
	@Transient
	   private String externalFundOrg;
	//非表列，发起核对时外部单位银行
	@Transient
	   private String externalBankOrg;
	//非表列，发起核对时外部单位证监
	@Transient
	   private String externalSecuritiesOrg;
	//非表列，发起核对时外部单位保监
	@Transient
	   private String externalInsuranceOrg;
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
    * getter for 户主关系代码
    * @generated
    */
   public String getRelationshipType(){
      return this.relationshipType;
   }
   /**
    * setter for 户主关系代码
    * @generated
    */
   public void setRelationshipType(String relationshipType){
      this.relationshipType = relationshipType;
   }

   /**
    * getter for 属地行政区划
    * @generated
    */
   public String getDomicileCode(){
      return this.domicileCode;
   }
   /**
    * setter for 属地行政区划
    * @generated
    */
   public void setDomicileCode(String domicileCode){
      this.domicileCode = domicileCode;
   }

   /**
    * getter for 住址行政区划
    * @generated
    */
   public String getApanageCode(){
      return this.apanageCode;
   }
   /**
    * setter for 住址行政区划
    * @generated
    */
   public void setApanageCode(String apanageCode){
      this.apanageCode = apanageCode;
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
    * getter for 出生日期
    * @generated
    */
   public String getBirthday(){
      return this.birthday;
   }
   /**
    * setter for 出生日期
    * @generated
    */
   public void setBirthday(String birthday){
      this.birthday = birthday;
   }

   /**
    * getter for 民族
    * @generated
    */
   public String getNation(){
      return this.nation;
   }
   /**
    * setter for 民族
    * @generated
    */
   public void setNation(String nation){
      this.nation = nation;
   }

   /**
    * getter for 文化程度代码
    * @generated
    */
   public String getEduCode(){
      return this.eduCode;
   }
   /**
    * setter for 文化程度代码
    * @generated
    */
   public void setEduCode(String eduCode){
      this.eduCode = eduCode;
   }

   /**
    * getter for 健康状况代码
    * @generated
    */
   public String getHealthCode(){
      return this.healthCode;
   }
   /**
    * setter for 健康状况代码
    * @generated
    */
   public void setHealthCode(String healthCode){
      this.healthCode = healthCode;
   }

   /**
    * getter for 婚姻状况代码
    * @generated
    */
   public String getMarriageCode(){
      return this.marriageCode;
   }
   /**
    * setter for 婚姻状况代码
    * @generated
    */
   public void setMarriageCode(String marriageCode){
      this.marriageCode = marriageCode;
   }

   /**
    * getter for 职业代码
    * @generated
    */
   public String getCareerCode(){
      return this.careerCode;
   }
   /**
    * setter for 职业代码
    * @generated
    */
   public void setCareerCode(String careerCode){
      this.careerCode = careerCode;
   }

   /**
    * getter for 政治面貌代码
    * @generated
    */
   public String getPoliticalCode(){
      return this.politicalCode;
   }
   /**
    * setter for 政治面貌代码
    * @generated
    */
   public void setPoliticalCode(String politicalCode){
      this.politicalCode = politicalCode;
   }

   /**
    * getter for 户籍类别代码
    * @generated
    */
   public String getDomicileType(){
      return this.domicileType;
   }
   /**
    * setter for 户籍类别代码
    * @generated
    */
   public void setDomicileType(String domicileType){
      this.domicileType = domicileType;
   }

   /**
    * getter for 联系方式_手机
    * @generated
    */
   public String getTelMobile(){
      return this.telMobile;
   }
   /**
    * setter for 联系方式_手机
    * @generated
    */
   public void setTelMobile(String telMobile){
      this.telMobile = telMobile;
   }

   /**
    * getter for 联系方式_其他
    * @generated
    */
   public String getTelOther(){
      return this.telOther;
   }
   /**
    * setter for 联系方式_其他
    * @generated
    */
   public void setTelOther(String telOther){
      this.telOther = telOther;
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
    * getter for 邮政编码
    * @generated
    */
   public String getPostCode(){
      return this.postCode;
   }
   /**
    * setter for 邮政编码
    * @generated
    */
   public void setPostCode(String postCode){
      this.postCode = postCode;
   }

   /**
    * getter for 年收入
    * @generated
    */
   public String getIncomeYear(){
      return this.incomeYear;
   }
   /**
    * setter for 年收入
    * @generated
    */
   public void setIncomeYear(String incomeYear){
      this.incomeYear = incomeYear;
   }

   /**
    * getter for 月收入
    * @generated
    */
   public String getIncomeMonth(){
      return this.incomeMonth;
   }
   /**
    * setter for 月收入
    * @generated
    */
   public void setIncomeMonth(String incomeMonth){
      this.incomeMonth = incomeMonth;
   }

   /**
    * getter for 就业状况代码
    * @generated
    */
   public String getEmploymentCode(){
      return this.employmentCode;
   }
   /**
    * setter for 就业状况代码
    * @generated
    */
   public void setEmploymentCode(String employmentCode){
      this.employmentCode = employmentCode;
   }

   /**
    * getter for 工作单位_名称
    * @generated
    */
   public String getWorkUnitName(){
      return this.workUnitName;
   }
   /**
    * setter for 工作单位_名称
    * @generated
    */
   public void setWorkUnitName(String workUnitName){
      this.workUnitName = workUnitName;
   }

   /**
    * getter for 工作单位_电话
    * @generated
    */
   public String getWorkUnitTel(){
      return this.workUnitTel;
   }
   /**
    * setter for 工作单位_电话
    * @generated
    */
   public void setWorkUnitTel(String workUnitTel){
      this.workUnitTel = workUnitTel;
   }

   /**
    * getter for 工作单位_地址
    * @generated
    */
   public String getWorkUnitAdd(){
      return this.workUnitAdd;
   }
   /**
    * setter for 工作单位_地址
    * @generated
    */
   public void setWorkUnitAdd(String workUnitAdd){
      this.workUnitAdd = workUnitAdd;
   }

   /**
    * getter for 个人状态标志
    * @generated
    */
   public String getPersonalStatsTag(){
      return this.personalStatsTag;
   }
   /**
    * setter for 个人状态标志
    * @generated
    */
   public void setPersonalStatsTag(String personalStatsTag){
      this.personalStatsTag = personalStatsTag;
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
	public String getRegPeople() {
		return regPeople;
	}
	public void setRegPeople(String regPeople) {
		this.regPeople = regPeople;
	}
	public String getModPeople() {
		return modPeople;
	}
	public void setModPeople(String modPeople) {
		this.modPeople = modPeople;
	}
	public String getIsSupport() {
		return isSupport;
	}
	public void setIsSupport(String isSupport) {
		this.isSupport = isSupport;
	}
	public String getExternalSocialOrg() {
		return externalSocialOrg;
	}
	public void setExternalSocialOrg(String externalSocialOrg) {
		this.externalSocialOrg = externalSocialOrg;
	}
	public String getExternalHouseOrg() {
		return externalHouseOrg;
	}
	public void setExternalHouseOrg(String externalHouseOrg) {
		this.externalHouseOrg = externalHouseOrg;
	}
	public String getExternalBusinessOrg() {
		return externalBusinessOrg;
	}
	public void setExternalBusinessOrg(String externalBusinessOrg) {
		this.externalBusinessOrg = externalBusinessOrg;
	}
	public String getExternalCarOrg() {
		return externalCarOrg;
	}
	public void setExternalCarOrg(String externalCarOrg) {
		this.externalCarOrg = externalCarOrg;
	}
	public String getExternalTaxGOrg() {
		return externalTaxGOrg;
	}
	public void setExternalTaxGOrg(String externalTaxGOrg) {
		this.externalTaxGOrg = externalTaxGOrg;
	}
	public String getExternalTaxDOrg() {
		return externalTaxDOrg;
	}
	public void setExternalTaxDOrg(String externalTaxDOrg) {
		this.externalTaxDOrg = externalTaxDOrg;
	}
	public String getExternalFundOrg() {
		return externalFundOrg;
	}
	public void setExternalFundOrg(String externalFundOrg) {
		this.externalFundOrg = externalFundOrg;
	}
	public String getExternalBankOrg() {
		return externalBankOrg;
	}
	public void setExternalBankOrg(String externalBankOrg) {
		this.externalBankOrg = externalBankOrg;
	}
	public String getExternalSecuritiesOrg() {
		return externalSecuritiesOrg;
	}
	public void setExternalSecuritiesOrg(String externalSecuritiesOrg) {
		this.externalSecuritiesOrg = externalSecuritiesOrg;
	}
	public String getExternalInsuranceOrg() {
		return externalInsuranceOrg;
	}
	public void setExternalInsuranceOrg(String externalInsuranceOrg) {
		this.externalInsuranceOrg = externalInsuranceOrg;
	}
	public String getSurveyId() {
		return surveyId;
	}
	public void setSurveyId(String surveyId) {
		this.surveyId = surveyId;
	}

}