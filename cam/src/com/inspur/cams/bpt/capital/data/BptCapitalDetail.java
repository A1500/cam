package com.inspur.cams.bpt.capital.data;

import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * @title:BptCapitalDetail
 * @description:优抚_资金发放_明细
 * @author:
 * @since:2011-05-28
 * @version:1.0
 */
@Table(tableName = "BPT_CAPITAL_DETAIL", keyFields = "regDetailId")
public class BptCapitalDetail extends StatefulDatabean {
	// 名册明细ID
	private String regDetailId;
	// 名册ID
	private String registerId;
	// 名册类别
	private String registerType;
	// 行政区划代码
	private String domicileCode;
	// 行政区划名称
	private String domicileName;
	// 所属年月
	private String respectiveYears;
	// 人员ID
	private String peopleId;
	// 姓名
	private String name;
	// 身份证号
	private String idCord;
	// 银行帐号
	private String accountCode;
	// 优抚证件号
	private String credentialsNo;
	// 优抚对象类别
	private String objectType;
	// 优抚对象状态
	private String changeState;
	// 伤残等级代码
	private String disabilityLevelCode;
	// 伤残时期
	private String disabilityWarCode;
	// 属于时期
	private String belongDate;
	// 是否孤老标志
	private String oldLonelyFlag;
	// 伤残性质
	private String disabilityCaseCode;
	// 伤残属别
	private String disabilityGenusCode;
	// 户籍类别
	private String domicileType;
	// 发放资金金额
	private BigDecimal grantMon;
	// 发放标准
	private BigDecimal grantStaMon;
	// 发放月数
	private BigDecimal grantMonths;
	// 护理费
	private BigDecimal nursingMon;
	// 小计金额
	private BigDecimal subTotal;
	// 自然增长机制
	private BigDecimal increaseMechanism;
	// 粮油补贴
	private BigDecimal grainOilMon;
	// 煤补补贴
	private BigDecimal coalSubsidyMon;
	// 抗日增发
	private BigDecimal antiJapaneseMon;
	// 孤老增发
	private BigDecimal oldLonelyMon;
	//补发金额
	private BigDecimal supplyMon;
	// 其他补助1
	private BigDecimal otherSubsidyOne;
	// 其他补助2
	private BigDecimal otherSubsidyTwo;
	// 其他补助3
	private BigDecimal otherSubsidyThree;
	// 其他补助4
	private BigDecimal otherSubsidyFour;
	// 其他补助5
	private BigDecimal otherSubsidyFive;
	// 发放资金总额
	private BigDecimal grantMonSum;
	// 备注
	private String note;

	// 录入人ID
	private String regId;
	// 录入时间
	private String regTime;
	private String modId;
	private String modTime;

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
	 * getter for 名册明细ID
	 * 
	 * @generated
	 */
	public String getRegDetailId() {
		return this.regDetailId;
	}

	/**
	 * setter for 名册明细ID
	 * 
	 * @generated
	 */
	public void setRegDetailId(String regDetailId) {
		this.regDetailId = regDetailId;
	}

	/**
	 * getter for 名册ID
	 * 
	 * @generated
	 */
	public String getRegisterId() {
		return this.registerId;
	}

	/**
	 * setter for 名册ID
	 * 
	 * @generated
	 */
	public void setRegisterId(String registerId) {
		this.registerId = registerId;
	}

	/**
	 * getter for 姓名
	 * 
	 * @generated
	 */
	public String getName() {
		return this.name;
	}

	/**
	 * setter for 姓名
	 * 
	 * @generated
	 */
	public void setName(String name) {
		this.name = name;
	}

	/**
	 * getter for 身份证号
	 * 
	 * @generated
	 */
	public String getIdCord() {
		return this.idCord;
	}

	/**
	 * setter for 身份证号
	 * 
	 * @generated
	 */
	public void setIdCord(String idCord) {
		this.idCord = idCord;
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
	 * getter for 伤残等级代码
	 * 
	 * @generated
	 */
	public String getDisabilityLevelCode() {
		return this.disabilityLevelCode;
	}

	/**
	 * setter for 伤残等级代码
	 * 
	 * @generated
	 */
	public void setDisabilityLevelCode(String disabilityLevelCode) {
		this.disabilityLevelCode = disabilityLevelCode;
	}

	/**
	 * getter for 是否
	 * 
	 * @generated
	 */
	public String getOldLonelyFlag() {
		return this.oldLonelyFlag;
	}

	/**
	 * setter for 是否
	 * 
	 * @generated
	 */
	public void setOldLonelyFlag(String oldLonelyFlag) {
		this.oldLonelyFlag = oldLonelyFlag;
	}

	/**
	 * getter for 发放资金金额
	 * 
	 * @generated
	 */
	public BigDecimal getGrantMon() {
		return this.grantMon;
	}

	/**
	 * setter for 发放资金金额
	 * 
	 * @generated
	 */
	public void setGrantMon(BigDecimal grantMon) {
		this.grantMon = grantMon;
	}

	/**
	 * getter for 备注
	 * 
	 * @generated
	 */
	public String getNote() {
		return this.note;
	}

	/**
	 * setter for 备注
	 * 
	 * @generated
	 */
	public void setNote(String note) {
		this.note = note;
	}

	public String getRespectiveYears() {
		return respectiveYears;
	}

	public void setRespectiveYears(String respectiveYears) {
		this.respectiveYears = respectiveYears;
	}

	public String getRegisterType() {
		return registerType;
	}

	public void setRegisterType(String registerType) {
		this.registerType = registerType;
	}

	/**
	 * @return the accountCode
	 */
	public String getAccountCode() {
		return accountCode;
	}

	/**
	 * @param accountCode
	 *            the accountCode to set
	 */
	public void setAccountCode(String accountCode) {
		this.accountCode = accountCode;
	}

	/**
	 * @return the credentialsNo
	 */
	public String getCredentialsNo() {
		return credentialsNo;
	}

	/**
	 * @param credentialsNo
	 *            the credentialsNo to set
	 */
	public void setCredentialsNo(String credentialsNo) {
		this.credentialsNo = credentialsNo;
	}

	/**
	 * @return the disabilityCaseCode
	 */
	public String getDisabilityCaseCode() {
		return disabilityCaseCode;
	}

	/**
	 * @param disabilityCaseCode
	 *            the disabilityCaseCode to set
	 */
	public void setDisabilityCaseCode(String disabilityCaseCode) {
		this.disabilityCaseCode = disabilityCaseCode;
	}

	/**
	 * @return the disabilityGenusCode
	 */
	public String getDisabilityGenusCode() {
		return disabilityGenusCode;
	}

	/**
	 * @param disabilityGenusCode
	 *            the disabilityGenusCode to set
	 */
	public void setDisabilityGenusCode(String disabilityGenusCode) {
		this.disabilityGenusCode = disabilityGenusCode;
	}

	/**
	 * @return the grantStaMon
	 */
	public BigDecimal getGrantStaMon() {
		return grantStaMon;
	}

	/**
	 * @param grantStaMon
	 *            the grantStaMon to set
	 */
	public void setGrantStaMon(BigDecimal grantStaMon) {
		this.grantStaMon = grantStaMon;
	}

	/**
	 * @return the grantMonths
	 */
	public BigDecimal getGrantMonths() {
		return grantMonths;
	}

	/**
	 * @param grantMonths
	 *            the grantMonths to set
	 */
	public void setGrantMonths(BigDecimal grantMonths) {
		this.grantMonths = grantMonths;
	}

	/**
	 * @return the grantMonSum
	 */
	public BigDecimal getGrantMonSum() {
		return grantMonSum;
	}

	/**
	 * @param grantMonSum
	 *            the grantMonSum to set
	 */
	public void setGrantMonSum(BigDecimal grantMonSum) {
		this.grantMonSum = grantMonSum;
	}

	/**
	 * @return the changeState
	 */
	public String getChangeState() {
		return changeState;
	}

	/**
	 * @param changeState
	 *            the changeState to set
	 */
	public void setChangeState(String changeState) {
		this.changeState = changeState;
	}

	/**
	 * @return the domicileType
	 */
	public String getDomicileType() {
		return domicileType;
	}

	/**
	 * @param domicileType
	 *            the domicileType to set
	 */
	public void setDomicileType(String domicileType) {
		this.domicileType = domicileType;
	}

	/**
	 * @return the domicileCode
	 */
	public String getDomicileCode() {
		return domicileCode;
	}

	/**
	 * @param domicileCode
	 *            the domicileCode to set
	 */
	public void setDomicileCode(String domicileCode) {
		this.domicileCode = domicileCode;
	}

	/**
	 * @return the domicileName
	 */
	public String getDomicileName() {
		return domicileName;
	}

	/**
	 * @param domicileName
	 *            the domicileName to set
	 */
	public void setDomicileName(String domicileName) {
		this.domicileName = domicileName;
	}

	/**
	 * @return the nursingMon
	 */
	public BigDecimal getNursingMon() {
		return nursingMon;
	}

	/**
	 * @param nursingMon
	 *            the nursingMon to set
	 */
	public void setNursingMon(BigDecimal nursingMon) {
		this.nursingMon = nursingMon;
	}

	/**
	 * @return the subTotal
	 */
	public BigDecimal getSubTotal() {
		return subTotal;
	}

	/**
	 * @param subTotal
	 *            the subTotal to set
	 */
	public void setSubTotal(BigDecimal subTotal) {
		this.subTotal = subTotal;
	}

	/**
	 * @return the increaseMechanism
	 */
	public BigDecimal getIncreaseMechanism() {
		return increaseMechanism;
	}

	/**
	 * @param increaseMechanism
	 *            the increaseMechanism to set
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
	 * @param grainOilMon
	 *            the grainOilMon to set
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
	 * @param coalSubsidyMon
	 *            the coalSubsidyMon to set
	 */
	public void setCoalSubsidyMon(BigDecimal coalSubsidyMon) {
		this.coalSubsidyMon = coalSubsidyMon;
	}

	/**
	 * @return the antiJapaneseMon
	 */
	public BigDecimal getAntiJapaneseMon() {
		return antiJapaneseMon;
	}

	/**
	 * @param antiJapaneseMon
	 *            the antiJapaneseMon to set
	 */
	public void setAntiJapaneseMon(BigDecimal antiJapaneseMon) {
		this.antiJapaneseMon = antiJapaneseMon;
	}

	/**
	 * @return the oldLonelyMon
	 */
	public BigDecimal getOldLonelyMon() {
		return oldLonelyMon;
	}

	/**
	 * @param oldLonelyMon
	 *            the oldLonelyMon to set
	 */
	public void setOldLonelyMon(BigDecimal oldLonelyMon) {
		this.oldLonelyMon = oldLonelyMon;
	}

	/**
	 * @return the otherSubsidyOne
	 */
	public BigDecimal getOtherSubsidyOne() {
		return otherSubsidyOne;
	}

	/**
	 * @param otherSubsidyOne
	 *            the otherSubsidyOne to set
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
	 * @param otherSubsidyTwo
	 *            the otherSubsidyTwo to set
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
	 * @param otherSubsidyThree
	 *            the otherSubsidyThree to set
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
	 * @param otherSubsidyFour
	 *            the otherSubsidyFour to set
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
	 * @param otherSubsidyFive
	 *            the otherSubsidyFive to set
	 */
	public void setOtherSubsidyFive(BigDecimal otherSubsidyFive) {
		this.otherSubsidyFive = otherSubsidyFive;
	}

	/**
	 * @return the disabilityWarCode
	 */
	public String getDisabilityWarCode() {
		return disabilityWarCode;
	}

	/**
	 * @param disabilityWarCode
	 *            the disabilityWarCode to set
	 */
	public void setDisabilityWarCode(String disabilityWarCode) {
		this.disabilityWarCode = disabilityWarCode;
	}

	/**
	 * @return the belongDate
	 */
	public String getBelongDate() {
		return belongDate;
	}

	/**
	 * @param belongDate
	 *            the belongDate to set
	 */
	public void setBelongDate(String belongDate) {
		this.belongDate = belongDate;
	}

	public String getRegId() {
		return regId;
	}

	public void setRegId(String regId) {
		this.regId = regId;
	}

	public String getRegTime() {
		return regTime;
	}

	public void setRegTime(String regTime) {
		this.regTime = regTime;
	}

	public String getModId() {
		return modId;
	}

	public void setModId(String modId) {
		this.modId = modId;
	}

	public String getModTime() {
		return modTime;
	}

	public void setModTime(String modTime) {
		this.modTime = modTime;
	}

	public BigDecimal getSupplyMon() {
		return supplyMon;
	}

	public void setSupplyMon(BigDecimal supplyMon) {
		this.supplyMon = supplyMon;
	}

}