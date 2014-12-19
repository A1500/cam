package com.inspur.cams.bpt.capital.data;

import java.math.BigDecimal;

import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:优待金明细 DataBean
 * @description:
 */
 @Table(tableName = "BPT_COMPULSORY_DETAILS" , keyFields = "regDetailId")
public class BptCompulsoryDetails extends StatefulDatabean {
	 // 名册名细ID
	 private String regDetailId;
	 // 名册ID
	 private String registerId;
	 // 优待金发放时间
	 private String grantDate;
	 // 发放所属年度
	 private String belongYear;
	 // 人员ID
	 private String peopleId;
	 // 行政区划代码
	 private String domicileCode;
	 // 行政区划名称
	 private String domicileName;
	 // 姓名
	 private String name;
	 // 身份证件号码
	 private String idCard;
	 // 银行账号
	 private String accountCode;
	 // 户籍类别
	 private String domicileType;
	 // 优抚对象类别
	 private String objectTypeCode;
	 // 证书编号
	 private String credentialsNo;
	 // 伤残等级代码
	 private String disabilityLevelCode;
	 // 伤残性质代码
	 private String disabilityCaseCode;
	 // 伤残属别代码
	 private String disabilityGenusCode;
	 // 属于时期
	 private String belongDate;
	 // 孤老标志
	 private String oldLonelyFlag;
	 // 供养方式
	 private String supportPattern;
	 // 标准
	 private BigDecimal grantMonSta;
	 // 发放月数
	 private BigDecimal grantMonths;
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
	 // 孤老增发
	 private BigDecimal oldLonelyMon;
	 // 进藏进疆增发
	 private BigDecimal inTibetAdditional;
	 // 立功增发
	 private BigDecimal meritAdditional;
	 // 其他增发
	 private String otherAdditional;
	 // 资金总额
	 private BigDecimal grantMonSum;
	 // 领取人姓名
	 private String receiveName;
	 // 领取人联系方式
	 private String receiveContact;
	 // 发放次数
	 private String grantNumber;
	 // 备注
	 private String note;
	 // 录入ID
	 private String regId;
	 // 录入时间
	 private String regTime;
	 // 修改ID
	 private String modId;
	 // 修改时间
	 private String modTime;
	/**
	 * @return the regDetailId
	 */
	public String getRegDetailId() {
		return regDetailId;
	}
	/**
	 * @param regDetailId the regDetailId to set
	 */
	public void setRegDetailId(String regDetailId) {
		this.regDetailId = regDetailId;
	}
	/**
	 * @return the registerId
	 */
	public String getRegisterId() {
		return registerId;
	}
	/**
	 * @param registerId the registerId to set
	 */
	public void setRegisterId(String registerId) {
		this.registerId = registerId;
	}
	/**
	 * @return the grantDate
	 */
	public String getGrantDate() {
		return grantDate;
	}
	/**
	 * @param grantDate the grantDate to set
	 */
	public void setGrantDate(String grantDate) {
		this.grantDate = grantDate;
	}
	/**
	 * @return the belongYear
	 */
	public String getBelongYear() {
		return belongYear;
	}
	/**
	 * @param belongYear the belongYear to set
	 */
	public void setBelongYear(String belongYear) {
		this.belongYear = belongYear;
	}
	/**
	 * @return the peopleId
	 */
	public String getPeopleId() {
		return peopleId;
	}
	/**
	 * @param peopleId the peopleId to set
	 */
	public void setPeopleId(String peopleId) {
		this.peopleId = peopleId;
	}
	/**
	 * @return the domicileCode
	 */
	public String getDomicileCode() {
		return domicileCode;
	}
	/**
	 * @param domicileCode the domicileCode to set
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
	 * @param domicileName the domicileName to set
	 */
	public void setDomicileName(String domicileName) {
		this.domicileName = domicileName;
	}
	/**
	 * @return the name
	 */
	public String getName() {
		return name;
	}
	/**
	 * @param name the name to set
	 */
	public void setName(String name) {
		this.name = name;
	}
	/**
	 * @return the idCard
	 */
	public String getIdCard() {
		return idCard;
	}
	/**
	 * @param idCard the idCard to set
	 */
	public void setIdCard(String idCard) {
		this.idCard = idCard;
	}
	/**
	 * @return the accountCode
	 */
	public String getAccountCode() {
		return accountCode;
	}
	/**
	 * @param accountCode the accountCode to set
	 */
	public void setAccountCode(String accountCode) {
		this.accountCode = accountCode;
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
	 * @return the objectTypeCode
	 */
	public String getObjectTypeCode() {
		return objectTypeCode;
	}
	/**
	 * @param objectTypeCode the objectTypeCode to set
	 */
	public void setObjectTypeCode(String objectTypeCode) {
		this.objectTypeCode = objectTypeCode;
	}
	/**
	 * @return the credentialsNo
	 */
	public String getCredentialsNo() {
		return credentialsNo;
	}
	/**
	 * @param credentialsNo the credentialsNo to set
	 */
	public void setCredentialsNo(String credentialsNo) {
		this.credentialsNo = credentialsNo;
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
	 * @return the disabilityCaseCode
	 */
	public String getDisabilityCaseCode() {
		return disabilityCaseCode;
	}
	/**
	 * @param disabilityCaseCode the disabilityCaseCode to set
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
	 * @param disabilityGenusCode the disabilityGenusCode to set
	 */
	public void setDisabilityGenusCode(String disabilityGenusCode) {
		this.disabilityGenusCode = disabilityGenusCode;
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
	 * @return the supportPatternb
	 */
	public String getSupportPattern() {
		return supportPattern;
	}
	/**
	 * @param supportPatternb the supportPatternb to set
	 */
	public void setSupportPattern(String supportPattern) {
		this.supportPattern = supportPattern;
	}
	/**
	 * @return the grantMonSta
	 */
	/**
	 * @return the receiveName
	 */
	public String getReceiveName() {
		return receiveName;
	}
	/**
	 * @param receiveName the receiveName to set
	 */
	public void setReceiveName(String receiveName) {
		this.receiveName = receiveName;
	}
	/**
	 * @return the receiveContact
	 */
	public String getReceiveContact() {
		return receiveContact;
	}
	/**
	 * @param receiveContact the receiveContact to set
	 */
	public void setReceiveContact(String receiveContact) {
		this.receiveContact = receiveContact;
	}
	/**
	 * @return the grantNumber
	 */
	public String getGrantNumber() {
		return grantNumber;
	}
	/**
	 * @param grantNumber the grantNumber to set
	 */
	public void setGrantNumber(String grantNumber) {
		this.grantNumber = grantNumber;
	}
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
	 * @return the grantMonSta
	 */
	public BigDecimal getGrantMonSta() {
		return grantMonSta;
	}
	/**
	 * @param grantMonSta the grantMonSta to set
	 */
	public void setGrantMonSta(BigDecimal grantMonSta) {
		this.grantMonSta = grantMonSta;
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
	 * @return the meritAdditional
	 */
	public BigDecimal getMeritAdditional() {
		return meritAdditional;
	}
	/**
	 * @param meritAdditional the meritAdditional to set
	 */
	public void setMeritAdditional(BigDecimal meritAdditional) {
		this.meritAdditional = meritAdditional;
	}
	/**
	 * @return the otherAdditional
	 */
	public String getOtherAdditional() {
		return otherAdditional;
	}
	/**
	 * @param otherAdditional the otherAdditional to set
	 */
	public void setOtherAdditional(String otherAdditional) {
		this.otherAdditional = otherAdditional;
	}
	/**
	 * @return the grantMonSum
	 */
	public BigDecimal getGrantMonSum() {
		return grantMonSum;
	}
	/**
	 * @param grantMonSum the grantMonSum to set
	 */
	public void setGrantMonSum(BigDecimal grantMonSum) {
		this.grantMonSum = grantMonSum;
	}
	/**
	 * @return the grantMonths
	 */
	public BigDecimal getGrantMonths() {
		return grantMonths;
	}
	/**
	 * @param grantMonths the grantMonths to set
	 */
	public void setGrantMonths(BigDecimal grantMonths) {
		this.grantMonths = grantMonths;
	}
	 
	 
	 
	 

}