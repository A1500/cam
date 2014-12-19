package com.inspur.cams.bpt.base.data;

import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * @title:BptCountRetiredSoldier
 * @description:
 * @author:
 * @since:2011-08-04
 * @version:1.0
 */
@Table(tableName = "BPT_PEOPLE_RETIRED_SOLDIER", keyFields = "peopleId")
public class BptCountRetiredSoldier extends StatefulDatabean {
	// 人员ID
	@Rule(value = "require")
	@Column(name = "PEOPLE_ID")
	private String peopleId;
	// 退役证件号
	@Column(name = "RETIRED_NO")
	private String retiredNo;
	//批准日期
	private String approvalDate;
	// 入伍时间
	@Rule(value = "require")
	@Column(name = "CONSCRIPT_DATE")
	private String conscriptDate;
	// 退役时间
	@Rule(value = "require")
	@Column(name = "DECRUITMENT_DATE")
	private String decruitmentDate;
	// 服义务兵向起止时间
	@Rule(value = "require")
	@Column(name = "SOLDIER_START_DATE")
	private String soldierStartDate;
	// 服义务兵向起止时间
	@Rule(value = "require")
	@Column(name = "SOLDIER_END_DATE")
	private String soldierEndDate;
	// 所服义务兵役折算年限
	@Rule(value = "number")
	@Column(name = "SOLDIER_YEARS")
	private BigDecimal soldierYears;
	// 服役部队名称(番号)
	@Rule(value = "require")
	@Column(name = "FORCES_NAME")
	private String forcesName;
	// 服役部队代号
	@Rule(value = "require")
	@Column(name = "FORCES_NO")
	private String forcesNo;

	// 家庭人口
	@Rule(value = "number")
	@Column(name = "FAMILY_NUM")
	private BigDecimal familyNum;
	// 18岁(含)以下
	@Rule(value = "number")
	@Column(name = "YOUNG_NUM")
	private BigDecimal youngNum;
	// 60岁(含)以上
	@Rule(value = "number")
	@Column(name = "OLD_NUM")
	private BigDecimal oldNum;
	//是否属于其它优抚对象
	@Column(name = "IS_OTHER_BPTOBJECT")
	private String isOtherBptobject;
	// 优抚对象类别
	@Column(name = "OBJECT_TYPE")
	private String objectType;
	// 是否享受低保待遇
	@Column(name = "IS_GUARANT")
	private String isGuarant;
	// 是否享受五保待遇
	@Column(name = "IS_FIVE_GUARANT")
	private String isFiveGuarant;
	// 身份认定依据
	@Column(name = "IDENTITY_BASIS")
	private String identityBasis;
	// 备注
	@Column(name = "NOTE")
	private String note;
	// 录入人
	// @Rule(value="require")
	@Column(name = "REG_ID")
	private String regId;
	// 录入时间
	// @Rule(value="require")
	@Column(name = "REG_TIME")
	private String regTime;
	// 修改人
	// @Rule(value="require")
	@Column(name = "MOD_ID")
	private String modId;
	// 修改时间
	// @Rule(value="require")
	@Column(name = "MOD_TIME")
	private String modTime;
	//生活状况
	@Rule(value="require")
	@Column(name = "LIFE_STATE_CODE")
	private String lifeStateCode;
    
	//残疾军人
	@Column(name = "DISABILITY_SOLDIER")
	private String disabilitySoldier;
	//伤残公务员
	@Column(name = "DISABILITY_CIVIL")
	private String disabilityCivil;
	//伤残人民警察
	@Column(name = "DISABILITY_POLICE")
	private String disabilityPolice;
	//伤残民兵民工
	@Column(name = "DISABILITY_MIGRANT")
	private String disabilityMigrant;
	//烈属
	@Column(name = "DEPEND_MARTYRS")
	private String dependMartyrs;
	//因公牺牲军人遗属
	@Column(name = "DEPEND_PUBLIC")
	private String dependPublic;
	//病故军人遗属
	@Column(name = "DEPEND_DIED")
	private String dependDied;
	//在乡老复员军人
	@Column(name = "DEMOBILIZED_PEOPLE")
	private String demobilizedSoldier;
	//带病回乡退伍军人
	@Column(name = "DEMOBILIZED_ILLNESS_PEOPLE")
	private String demobilizedIllnessPeople;
	//参战退役人员
	@Column(name = "WAR_PEOPLE")
	private String warPeople;
	//参试退役人员
	@Column(name = "TESTED_PEOPLE")
	private String testedPeople;
	
	public String getCancellationDate() {
		return cancellationDate;
	}

	public void setCancellationDate(String cancellationDate) {
		this.cancellationDate = cancellationDate;
	}

	//参试退役人员
	@Column(name = "Cancellation_Date")
	private String cancellationDate;
	/**
	 * getter for 人员ID
	 * 
	 * @generated
	 */
	public String getPeopleId() {
		return this.peopleId;
	}

	/**
	 * setter for 人员ID
	 * 
	 * @generated
	 */
	public void setPeopleId(String peopleId) {
		this.peopleId = peopleId;
	}

	/**
	 * getter for 退役证件号
	 * 
	 * @generated
	 */
	public String getRetiredNo() {
		return this.retiredNo;
	}

	/**
	 * setter for 退役证件号
	 * 
	 * @generated
	 */
	public void setRetiredNo(String retiredNo) {
		this.retiredNo = retiredNo;
	}

	/**
	 * getter for 入伍时间
	 * 
	 * @generated
	 */
	public String getConscriptDate() {
		return this.conscriptDate;
	}

	/**
	 * setter for 入伍时间
	 * 
	 * @generated
	 */
	public void setConscriptDate(String conscriptDate) {
		this.conscriptDate = conscriptDate;
	}

	/**
	 * getter for 退役时间
	 * 
	 * @generated
	 */
	public String getDecruitmentDate() {
		return this.decruitmentDate;
	}

	/**
	 * setter for 退役时间
	 * 
	 * @generated
	 */
	public void setDecruitmentDate(String decruitmentDate) {
		this.decruitmentDate = decruitmentDate;
	}


	/**
	 * getter for 所服义务兵役折算年限
	 * 
	 * @generated
	 */
	public BigDecimal getSoldierYears() {
		return this.soldierYears;
	}

	/**
	 * setter for 所服义务兵役折算年限
	 * 
	 * @generated
	 */
	public void setSoldierYears(BigDecimal soldierYears) {
		this.soldierYears = soldierYears;
	}

	/**
	 * getter for 服役部队名称(番号)
	 * 
	 * @generated
	 */
	public String getForcesName() {
		return this.forcesName;
	}

	/**
	 * setter for 服役部队名称(番号)
	 * 
	 * @generated
	 */
	public void setForcesName(String forcesName) {
		this.forcesName = forcesName;
	}

	/**
	 * getter for 服役部队代号
	 * 
	 * @generated
	 */
	public String getForcesNo() {
		return this.forcesNo;
	}

	/**
	 * setter for 服役部队代号
	 * 
	 * @generated
	 */
	public void setForcesNo(String forcesNo) {
		this.forcesNo = forcesNo;
	}

	/**
	 * getter for 家庭人口
	 * 
	 * @generated
	 */
	public BigDecimal getFamilyNum() {
		return this.familyNum;
	}

	/**
	 * setter for 家庭人口
	 * 
	 * @generated
	 */
	public void setFamilyNum(BigDecimal familyNum) {
		this.familyNum = familyNum;
	}

	/**
	 * getter for 18岁(含)以下
	 * 
	 * @generated
	 */
	public BigDecimal getYoungNum() {
		return this.youngNum;
	}

	/**
	 * setter for 18岁(含)以下
	 * 
	 * @generated
	 */
	public void setYoungNum(BigDecimal youngNum) {
		this.youngNum = youngNum;
	}

	/**
	 * getter for 60岁(含)以上
	 * 
	 * @generated
	 */
	public BigDecimal getOldNum() {
		return this.oldNum;
	}

	/**
	 * setter for 60岁(含)以上
	 * 
	 * @generated
	 */
	public void setOldNum(BigDecimal oldNum) {
		this.oldNum = oldNum;
	}

	/**
	 * getter for 是否具有其他优抚对象身份
	 * 
	 * @generated
	 */
	public String getIsOtherBptobject() {
		return this.isOtherBptobject;
	}

	/**
	 * setter for 是否具有其他优抚对象身份
	 * 
	 * @generated
	 */
	public void setIsOtherBptobject(String isOtherBptobject) {
		this.isOtherBptobject = isOtherBptobject;
	}

	/**
	 * getter for 优抚对象类别
	 * 
	 * @generated
	 */
	public String getObjectType() {
		return this.objectType;
	}

	/**
	 * setter for 优抚对象类别
	 * 
	 * @generated
	 */
	public void setObjectType(String objectType) {
		this.objectType = objectType;
	}

	/**
	 * getter for 是否享受低保待遇
	 * 
	 * @generated
	 */
	public String getIsGuarant() {
		return this.isGuarant;
	}

	/**
	 * setter for 是否享受低保待遇
	 * 
	 * @generated
	 */
	public void setIsGuarant(String isGuarant) {
		this.isGuarant = isGuarant;
	}

	/**
	 * getter for 是否享受五保待遇
	 * 
	 * @generated
	 */
	public String getIsFiveGuarant() {
		return this.isFiveGuarant;
	}

	/**
	 * setter for 是否享受五保待遇
	 * 
	 * @generated
	 */
	public void setIsFiveGuarant(String isFiveGuarant) {
		this.isFiveGuarant = isFiveGuarant;
	}

	/**
	 * getter for 身份认定依据
	 * 
	 * @generated
	 */
	public String getIdentityBasis() {
		return this.identityBasis;
	}

	/**
	 * setter for 身份认定依据
	 * 
	 * @generated
	 */
	public void setIdentityBasis(String identityBasis) {
		this.identityBasis = identityBasis;
	}

	/**
	 * getter for 录入人
	 * 
	 * @generated
	 */
	public String getRegId() {
		return this.regId;
	}

	/**
	 * setter for 录入人
	 * 
	 * @generated
	 */
	public void setRegId(String regId) {
		this.regId = regId;
	}

	/**
	 * getter for 录入时间
	 * 
	 * @generated
	 */
	public String getRegTime() {
		return this.regTime;
	}

	/**
	 * setter for 录入时间
	 * 
	 * @generated
	 */
	public void setRegTime(String regTime) {
		this.regTime = regTime;
	}

	/**
	 * getter for 修改人
	 * 
	 * @generated
	 */
	public String getModId() {
		return this.modId;
	}

	/**
	 * setter for 修改人
	 * 
	 * @generated
	 */
	public void setModId(String modId) {
		this.modId = modId;
	}

	/**
	 * getter for 修改时间
	 * 
	 * @generated
	 */
	public String getModTime() {
		return this.modTime;
	}

	/**
	 * setter for 修改时间
	 * 
	 * @generated
	 */
	public void setModTime(String modTime) {
		this.modTime = modTime;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public String getSoldierEndDate() {
		return soldierEndDate;
	}

	public void setSoldierEndDate(String soldierEndDate) {
		this.soldierEndDate = soldierEndDate;
	}

	public void setSoldierStartDate(String soldierStartDate) {
		this.soldierStartDate = soldierStartDate;
	}

	public String getLifeStateCode() {
		return lifeStateCode;
	}

	public void setLifeStateCode(String lifeStateCode) {
		this.lifeStateCode = lifeStateCode;
	}

	public String getDisabilitySoldier() {
		return disabilitySoldier;
	}

	public void setDisabilitySoldier(String disabilitySoldier) {
		this.disabilitySoldier = disabilitySoldier;
	}

	public String getDisabilityCivil() {
		return disabilityCivil;
	}

	public void setDisabilityCivil(String disabilityCivil) {
		this.disabilityCivil = disabilityCivil;
	}

	public String getDisabilityPolice() {
		return disabilityPolice;
	}

	public void setDisabilityPolice(String disabilityPolice) {
		this.disabilityPolice = disabilityPolice;
	}

	public String getDisabilityMigrant() {
		return disabilityMigrant;
	}

	public void setDisabilityMigrant(String disabilityMigrant) {
		this.disabilityMigrant = disabilityMigrant;
	}

	public String getDependMartyrs() {
		return dependMartyrs;
	}

	public void setDependMartyrs(String dependMartyrs) {
		this.dependMartyrs = dependMartyrs;
	}

	public String getDependPublic() {
		return dependPublic;
	}

	public void setDependPublic(String dependPublic) {
		this.dependPublic = dependPublic;
	}

	public String getDependDied() {
		return dependDied;
	}

	public void setDependDied(String dependDied) {
		this.dependDied = dependDied;
	}

	public String getDemobilizedSoldier() {
		return demobilizedSoldier;
	}

	public void setDemobilizedSoldier(String demobilizedSoldier) {
		this.demobilizedSoldier = demobilizedSoldier;
	}

	public String getDemobilizedIllnessPeople() {
		return demobilizedIllnessPeople;
	}

	public void setDemobilizedIllnessPeople(String demobilizedIllnessPeople) {
		this.demobilizedIllnessPeople = demobilizedIllnessPeople;
	}

	public String getWarPeople() {
		return warPeople;
	}

	public void setWarPeople(String warPeople) {
		this.warPeople = warPeople;
	}

	public String getTestedPeople() {
		return testedPeople;
	}

	public void setTestedPeople(String testedPeople) {
		this.testedPeople = testedPeople;
	}

	public String getApprovalDate() {
		return approvalDate;
	}

	public void setApprovalDate(String approvalDate) {
		this.approvalDate = approvalDate;
	}

	public String getSoldierStartDate() {
		return soldierStartDate;
	}

}