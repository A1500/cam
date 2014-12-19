package com.inspur.cams.bpt.capital.data;

import java.math.BigDecimal;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * @title:BptCapitalstaDisability
 * @description:资金发放标准
 */
@Table(tableName = "BPT_CAPITAL_STA", keyFields = "id")
public class BptCapitalsta extends StatefulDatabean {
	//id
	private String id;
	//类型
	private String type;
	//优抚对象类别
	private String objectType;
	//所属县区
	private String standardsCounties;
	//生效日期起
	private String startDate;
	//生效日期止
	private String endDate;
	//伤残等级
	private String disabilityLevelCode;
	//伤残等级(优待金多选)
	private String disabilityLevel;
	//伤残性质
	private String disabilityNature;
	//伤残属别
	private String disabilityGenusCode;
	//户籍类别
	private String domicileType;
	//省标准
	private BigDecimal provinceStandard;
	//护理费
	private BigDecimal nursingCost;
	//自然增长机制
	private BigDecimal increaseMechanism;
	//粮油补贴
	private BigDecimal grainOilMon;
	//煤补补贴
	private BigDecimal coalSubsidyMon;
	//是否孤老
	private String oldLonelyFlag;
	//孤老增发
	private BigDecimal oldLonelyMon;
	//伤残时期
	private String disabilityWarCode;
	//抗日增发
	private BigDecimal antiJapaneseMon;
	//其他补助1
	private BigDecimal otherSubsidyOne;
	//其他补助2
	private BigDecimal otherSubsidyTwo;
	//其他补助3
	private BigDecimal otherSubsidyThree;
	//其他补助4
	private BigDecimal otherSubsidyFour;
	//其他补助5
	private BigDecimal otherSubsidyFive;
	//进藏进疆
	private String inTibet;
	//进藏进疆增发
	private BigDecimal inTibetAdditional;
	//属于时期	
	private String belongDate;
	//是否集中供养
	private String concentratedFlag;
	//录入ID
	private String regId;
	//录入时间
	private String regTime;
	//修改ID
	private String modId;
	//修改时间
	private String modTime;
	// 备注
	private String note;
	
	/**
	 * @return the note
	 */
	public String getNote() {
		return note;
	}
	/**
	 * @param note the note to set
	 */
	public void setNote(String note) {
		this.note = note;
	}
	/**
	 * @return the id
	 */
	public String getId() {
		return id;
	}
	/**
	 * @param id the id to set
	 */
	public void setId(String id) {
		this.id = id;
	}
	/**
	 * @return the type
	 */
	public String getType() {
		return type;
	}
	/**
	 * @param type the type to set
	 */
	public void setType(String type) {
		this.type = type;
	}
	/**
	 * @return the objectType
	 */
	public String getObjectType() {
		return objectType;
	}
	/**
	 * @param objectType the objectType to set
	 */
	public void setObjectType(String objectType) {
		this.objectType = objectType;
	}
	/**
	 * @return the standardsCounties
	 */
	public String getStandardsCounties() {
		return standardsCounties;
	}
	/**
	 * @param standardsCounties the standardsCounties to set
	 */
	public void setStandardsCounties(String standardsCounties) {
		this.standardsCounties = standardsCounties;
	}
	/**
	 * @return the startDate
	 */
	public String getStartDate() {
		return startDate;
	}
	/**
	 * @param startDate the startDate to set
	 */
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	/**
	 * @return the endDate
	 */
	public String getEndDate() {
		return endDate;
	}
	/**
	 * @param endDate the endDate to set
	 */
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	/**
	 * @return the disabilityLevelCode
	 */
	public String getDisabilityLevelCode() {
		return disabilityLevelCode;
	}
	/**
	 * @param disabilityLevelCode the disabilityLevelCode to set
	 */
	public void setDisabilityLevelCode(String disabilityLevelCode) {
		this.disabilityLevelCode = disabilityLevelCode;
	}
	/**
	 * @return the disabilityNature
	 */
	public String getDisabilityNature() {
		return disabilityNature;
	}
	/**
	 * @param disabilityNature the disabilityNature to set
	 */
	public void setDisabilityNature(String disabilityNature) {
		this.disabilityNature = disabilityNature;
	}
	/**
	 * @return the disabilityGenusCode
	 */
	public String getDisabilityGenusCode() {
		return disabilityGenusCode;
	}
	/**
	 * @param disabilityGenusCode the disabilityGenusCode to set
	 */
	public void setDisabilityGenusCode(String disabilityGenusCode) {
		this.disabilityGenusCode = disabilityGenusCode;
	}
	/**
	 * @return the domicileType
	 */
	public String getDomicileType() {
		return domicileType;
	}
	/**
	 * @param domicileType the domicileType to set
	 */
	public void setDomicileType(String domicileType) {
		this.domicileType = domicileType;
	}
	/**
	 * @return the provinceStandard
	 */
	public BigDecimal getProvinceStandard() {
		return provinceStandard;
	}
	/**
	 * @param provinceStandard the provinceStandard to set
	 */
	public void setProvinceStandard(BigDecimal provinceStandard) {
		this.provinceStandard = provinceStandard;
	}
	/**
	 * @return the nursingCost
	 */
	public BigDecimal getNursingCost() {
		return nursingCost;
	}
	/**
	 * @param nursingCost the nursingCost to set
	 */
	public void setNursingCost(BigDecimal nursingCost) {
		this.nursingCost = nursingCost;
	}
	/**
	 * @return the increaseMechanism
	 */
	public BigDecimal getIncreaseMechanism() {
		return increaseMechanism;
	}
	/**
	 * @param increaseMechanism the increaseMechanism to set
	 */
	public void setIncreaseMechanism(BigDecimal increaseMechanism) {
		this.increaseMechanism = increaseMechanism;
	}
	/**
	 * @return the grainOilMon
	 */
	public BigDecimal getGrainOilMon() {
		return grainOilMon;
	}
	/**
	 * @param grainOilMon the grainOilMon to set
	 */
	public void setGrainOilMon(BigDecimal grainOilMon) {
		this.grainOilMon = grainOilMon;
	}
	/**
	 * @return the coalSubsidyMon
	 */
	public BigDecimal getCoalSubsidyMon() {
		return coalSubsidyMon;
	}
	/**
	 * @param coalSubsidyMon the coalSubsidyMon to set
	 */
	public void setCoalSubsidyMon(BigDecimal coalSubsidyMon) {
		this.coalSubsidyMon = coalSubsidyMon;
	}
	/**
	 * @return the oldLonelyFlag
	 */
	public String getOldLonelyFlag() {
		return oldLonelyFlag;
	}
	/**
	 * @param oldLonelyFlag the oldLonelyFlag to set
	 */
	public void setOldLonelyFlag(String oldLonelyFlag) {
		this.oldLonelyFlag = oldLonelyFlag;
	}
	/**
	 * @return the oldLonelyMon
	 */
	public BigDecimal getOldLonelyMon() {
		return oldLonelyMon;
	}
	/**
	 * @param oldLonelyMon the oldLonelyMon to set
	 */
	public void setOldLonelyMon(BigDecimal oldLonelyMon) {
		this.oldLonelyMon = oldLonelyMon;
	}
	/**
	 * @return the disabilityWarCode
	 */
	public String getDisabilityWarCode() {
		return disabilityWarCode;
	}
	/**
	 * @param disabilityWarCode the disabilityWarCode to set
	 */
	public void setDisabilityWarCode(String disabilityWarCode) {
		this.disabilityWarCode = disabilityWarCode;
	}
	/**
	 * @return the antiJapaneseMon
	 */
	public BigDecimal getAntiJapaneseMon() {
		return antiJapaneseMon;
	}
	/**
	 * @param antiJapaneseMon the antiJapaneseMon to set
	 */
	public void setAntiJapaneseMon(BigDecimal antiJapaneseMon) {
		this.antiJapaneseMon = antiJapaneseMon;
	}
	/**
	 * @return the otherSubsidyOne
	 */
	public BigDecimal getOtherSubsidyOne() {
		return otherSubsidyOne;
	}
	/**
	 * @param otherSubsidyOne the otherSubsidyOne to set
	 */
	public void setOtherSubsidyOne(BigDecimal otherSubsidyOne) {
		this.otherSubsidyOne = otherSubsidyOne;
	}
	/**
	 * @return the otherSubsidyTwo
	 */
	public BigDecimal getOtherSubsidyTwo() {
		return otherSubsidyTwo;
	}
	/**
	 * @param otherSubsidyTwo the otherSubsidyTwo to set
	 */
	public void setOtherSubsidyTwo(BigDecimal otherSubsidyTwo) {
		this.otherSubsidyTwo = otherSubsidyTwo;
	}
	/**
	 * @return the otherSubsidyThree
	 */
	public BigDecimal getOtherSubsidyThree() {
		return otherSubsidyThree;
	}
	/**
	 * @param otherSubsidyThree the otherSubsidyThree to set
	 */
	public void setOtherSubsidyThree(BigDecimal otherSubsidyThree) {
		this.otherSubsidyThree = otherSubsidyThree;
	}
	/**
	 * @return the otherSubsidyFour
	 */
	public BigDecimal getOtherSubsidyFour() {
		return otherSubsidyFour;
	}
	/**
	 * @param otherSubsidyFour the otherSubsidyFour to set
	 */
	public void setOtherSubsidyFour(BigDecimal otherSubsidyFour) {
		this.otherSubsidyFour = otherSubsidyFour;
	}
	/**
	 * @return the otherSubsidyFive
	 */
	public BigDecimal getOtherSubsidyFive() {
		return otherSubsidyFive;
	}
	/**
	 * @param otherSubsidyFive the otherSubsidyFive to set
	 */
	public void setOtherSubsidyFive(BigDecimal otherSubsidyFive) {
		this.otherSubsidyFive = otherSubsidyFive;
	}
	/**
	 * @return the inTibet
	 */
	public String getInTibet() {
		return inTibet;
	}
	/**
	 * @param inTibet the inTibet to set
	 */
	public void setInTibet(String inTibet) {
		this.inTibet = inTibet;
	}
	/**
	 * @return the inTibetAdditional
	 */
	public BigDecimal getInTibetAdditional() {
		return inTibetAdditional;
	}
	/**
	 * @param inTibetAdditional the inTibetAdditional to set
	 */
	public void setInTibetAdditional(BigDecimal inTibetAdditional) {
		this.inTibetAdditional = inTibetAdditional;
	}
	/**
	 * @return the belongDate
	 */
	public String getBelongDate() {
		return belongDate;
	}
	/**
	 * @param belongDate the belongDate to set
	 */
	public void setBelongDate(String belongDate) {
		this.belongDate = belongDate;
	}
	/**
	 * @return the regId
	 */
	public String getRegId() {
		return regId;
	}
	/**
	 * @param regId the regId to set
	 */
	public void setRegId(String regId) {
		this.regId = regId;
	}
	/**
	 * @return the regTime
	 */
	public String getRegTime() {
		return regTime;
	}
	/**
	 * @param regTime the regTime to set
	 */
	public void setRegTime(String regTime) {
		this.regTime = regTime;
	}
	/**
	 * @return the modId
	 */
	public String getModId() {
		return modId;
	}
	/**
	 * @param modId the modId to set
	 */
	public void setModId(String modId) {
		this.modId = modId;
	}
	/**
	 * @return the modTime
	 */
	public String getModTime() {
		return modTime;
	}
	/**
	 * @param modTime the modTime to set
	 */
	public void setModTime(String modTime) {
		this.modTime = modTime;
	}
	/**
	 * @return the concentratedFlag
	 */
	public String getConcentratedFlag() {
		return concentratedFlag;
	}
	/**
	 * @param concentratedFlag the concentratedFlag to set
	 */
	public void setConcentratedFlag(String concentratedFlag) {
		this.concentratedFlag = concentratedFlag;
	}
	/**
	 * @return the disabilityLevel
	 */
	public String getDisabilityLevel() {
		return disabilityLevel;
	}
	/**
	 * @param disabilityLevel the disabilityLevel to set
	 */
	public void setDisabilityLevel(String disabilityLevel) {
		this.disabilityLevel = disabilityLevel;
	}

}