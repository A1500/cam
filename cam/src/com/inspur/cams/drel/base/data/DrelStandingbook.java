package com.inspur.cams.drel.base.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 台账表databean
 * @author 
 * @date 2013-09-09
 */
@Table(tableName = "DREL_STANDINGBOOK", keyFields = "satandingId")
public class DrelStandingbook extends StatefulDatabean {
	
	private String satandingId;
	// 地区
	private String domicileCode;

	// 登记时间
	private String beginDate;

	// 证件号码
	private String cardNo;

	// 户主姓名
	private String familyName;

	// 身份证号码
	private String familyCardNo;

	// 性别
	private String sex;

	// 民族
	private String nation;

	// 家庭住址
	private String address;

	// 邮编
	private String familyPostcode;

	// 家庭电话
	private String familyPhone;

	// 享受保障类别
	private String assistanceType;

	// 享受保障人数
	private String assistancePeopleNum;

	// 女性人数
	private String womenNo;

	// 残疾人数
	private String disabilityNo;

	// 三无人员
	private String isthreeno;

	// 老年人
	private String oldNo;

	// 在职人员
	private String incumbencyNo;

	// 灵活就业
	private String flexibleNo;

	// 登记失业
	private String unemployedNo;

	// 未登记失业
	private String notUnemployedNo;

	// 在校生
	private String studentNo;

	// 其他
	private String otherNo;

	// 户月保障金
	private BigDecimal assistanceMoney;

	// 月收入
	private BigDecimal monthIncome;

	// 最低生活标准
	private BigDecimal lowStandards;

	// 金额二
	private BigDecimal othermoney;

	// 金额三
	private BigDecimal assistanceClassMoney;

	// 开户行
	private String bank;

	// 开户行账号
	private String accountNumber;

	// 变动种类
	private String changeType;

	// 变动时间
	private String changeDate;

	// 户主是否享受
	private String isEnjoy;

	// 成员一姓名
	private String p1Name;

	// 成员一身份证号码
	private String p1IdCard;

	// 成员二姓名
	private String p2Name;

	// 成员二身份证号码
	private String p2IdCard;

	// 成员三姓名
	private String p3Name;

	// 成员三身份证号码
	private String p3IdCard;

	// 成员四姓名
	private String p4Name;

	// 成员四身份证号码
	private String p4IdCard;

	// 成员五姓名
	private String p5Name;

	// 成员五身份证号码
	private String p5IdCard;

	// 成员六姓名
	private String p6Name;

	// 成员六身份证号码
	private String p6IdCard;

	// 成员七姓名
	private String p7Name;

	// 成员七身份证号码
	private String p7IdCard;

	// 成员八姓名
	private String p8Name;

	// 成员八身份证号码
	private String p8IdCard;

	// 成员九姓名
	private String p9Name;

	// 成员九身份证号码
	private String p9IdCard;

	/**
	 * 获取 地区
	 * @return String
	 */
	public String getDomicileCode() {
		return domicileCode;
	}

	/**
	 * 设置 地区
	 */
	public void setDomicileCode(String domicileCode) {
		this.domicileCode = domicileCode;
	}

	/**
	 * 获取 登记时间
	 * @return String
	 */
	public String getBeginDate() {
		return beginDate;
	}

	/**
	 * 设置 登记时间
	 */
	public void setBeginDate(String beginDate) {
		this.beginDate = beginDate;
	}

	/**
	 * 获取 证件号码
	 * @return String
	 */
	public String getCardNo() {
		return cardNo;
	}

	/**
	 * 设置 证件号码
	 */
	public void setCardNo(String cardNo) {
		this.cardNo = cardNo;
	}

	/**
	 * 获取 户主姓名
	 * @return String
	 */
	public String getFamilyName() {
		return familyName;
	}

	/**
	 * 设置 户主姓名
	 */
	public void setFamilyName(String familyName) {
		this.familyName = familyName;
	}

	/**
	 * 获取 身份证号码
	 * @return String
	 */
	public String getFamilyCardNo() {
		return familyCardNo;
	}

	/**
	 * 设置 身份证号码
	 */
	public void setFamilyCardNo(String familyCardNo) {
		this.familyCardNo = familyCardNo;
	}

	/**
	 * 获取 性别
	 * @return String
	 */
	public String getSex() {
		return sex;
	}

	/**
	 * 设置 性别
	 */
	public void setSex(String sex) {
		this.sex = sex;
	}

	/**
	 * 获取 民族
	 * @return String
	 */
	public String getNation() {
		return nation;
	}

	/**
	 * 设置 民族
	 */
	public void setNation(String nation) {
		this.nation = nation;
	}

	/**
	 * 获取 家庭住址
	 * @return String
	 */
	public String getAddress() {
		return address;
	}

	/**
	 * 设置 家庭住址
	 */
	public void setAddress(String address) {
		this.address = address;
	}

	/**
	 * 获取 邮编
	 * @return String
	 */
	public String getFamilyPostcode() {
		return familyPostcode;
	}

	/**
	 * 设置 邮编
	 */
	public void setFamilyPostcode(String familyPostcode) {
		this.familyPostcode = familyPostcode;
	}

	/**
	 * 获取 家庭电话
	 * @return String
	 */
	public String getFamilyPhone() {
		return familyPhone;
	}

	/**
	 * 设置 家庭电话
	 */
	public void setFamilyPhone(String familyPhone) {
		this.familyPhone = familyPhone;
	}

	/**
	 * 获取 享受保障类别
	 * @return String
	 */
	public String getAssistanceType() {
		return assistanceType;
	}

	/**
	 * 设置 享受保障类别
	 */
	public void setAssistanceType(String assistanceType) {
		this.assistanceType = assistanceType;
	}

	/**
	 * 获取 享受保障人数
	 * @return String
	 */
	public String getAssistancePeopleNum() {
		return assistancePeopleNum;
	}

	/**
	 * 设置 享受保障人数
	 */
	public void setAssistancePeopleNum(String assistancePeopleNum) {
		this.assistancePeopleNum = assistancePeopleNum;
	}

	/**
	 * 获取 女性人数
	 * @return String
	 */
	public String getWomenNo() {
		return womenNo;
	}

	/**
	 * 设置 女性人数
	 */
	public void setWomenNo(String womenNo) {
		this.womenNo = womenNo;
	}

	/**
	 * 获取 残疾人数
	 * @return String
	 */
	public String getDisabilityNo() {
		return disabilityNo;
	}

	/**
	 * 设置 残疾人数
	 */
	public void setDisabilityNo(String disabilityNo) {
		this.disabilityNo = disabilityNo;
	}

	/**
	 * 获取 三无人员
	 * @return String
	 */
	public String getIsthreeno() {
		return isthreeno;
	}

	/**
	 * 设置 三无人员
	 */
	public void setIsthreeno(String isthreeno) {
		this.isthreeno = isthreeno;
	}

	/**
	 * 获取 老年人
	 * @return String
	 */
	public String getOldNo() {
		return oldNo;
	}

	/**
	 * 设置 老年人
	 */
	public void setOldNo(String oldNo) {
		this.oldNo = oldNo;
	}

	/**
	 * 获取 在职人员
	 * @return String
	 */
	public String getIncumbencyNo() {
		return incumbencyNo;
	}

	/**
	 * 设置 在职人员
	 */
	public void setIncumbencyNo(String incumbencyNo) {
		this.incumbencyNo = incumbencyNo;
	}

	/**
	 * 获取 灵活就业
	 * @return String
	 */
	public String getFlexibleNo() {
		return flexibleNo;
	}

	/**
	 * 设置 灵活就业
	 */
	public void setFlexibleNo(String flexibleNo) {
		this.flexibleNo = flexibleNo;
	}

	/**
	 * 获取 登记失业
	 * @return String
	 */
	public String getUnemployedNo() {
		return unemployedNo;
	}

	/**
	 * 设置 登记失业
	 */
	public void setUnemployedNo(String unemployedNo) {
		this.unemployedNo = unemployedNo;
	}

	/**
	 * 获取 未登记失业
	 * @return String
	 */
	public String getNotUnemployedNo() {
		return notUnemployedNo;
	}

	/**
	 * 设置 未登记失业
	 */
	public void setNotUnemployedNo(String notUnemployedNo) {
		this.notUnemployedNo = notUnemployedNo;
	}

	/**
	 * 获取 在校生
	 * @return String
	 */
	public String getStudentNo() {
		return studentNo;
	}

	/**
	 * 设置 在校生
	 */
	public void setStudentNo(String studentNo) {
		this.studentNo = studentNo;
	}

	/**
	 * 获取 其他
	 * @return String
	 */
	public String getOtherNo() {
		return otherNo;
	}

	/**
	 * 设置 其他
	 */
	public void setOtherNo(String otherNo) {
		this.otherNo = otherNo;
	}

	/**
	 * 获取 户月保障金
	 * @return BigDecimal
	 */
	public BigDecimal getAssistanceMoney() {
		return assistanceMoney;
	}

	/**
	 * 设置 户月保障金
	 */
	public void setAssistanceMoney(BigDecimal assistanceMoney) {
		this.assistanceMoney = assistanceMoney;
	}

	/**
	 * 获取 月收入
	 * @return BigDecimal
	 */
	public BigDecimal getMonthIncome() {
		return monthIncome;
	}

	/**
	 * 设置 月收入
	 */
	public void setMonthIncome(BigDecimal monthIncome) {
		this.monthIncome = monthIncome;
	}

	/**
	 * 获取 最低生活标准
	 * @return BigDecimal
	 */
	public BigDecimal getLowStandards() {
		return lowStandards;
	}

	/**
	 * 设置 最低生活标准
	 */
	public void setLowStandards(BigDecimal lowStandards) {
		this.lowStandards = lowStandards;
	}

	/**
	 * 获取 金额二
	 * @return BigDecimal
	 */
	public BigDecimal getOthermoney() {
		return othermoney;
	}

	/**
	 * 设置 金额二
	 */
	public void setOthermoney(BigDecimal othermoney) {
		this.othermoney = othermoney;
	}

	/**
	 * 获取 金额三
	 * @return BigDecimal
	 */
	public BigDecimal getAssistanceClassMoney() {
		return assistanceClassMoney;
	}

	/**
	 * 设置 金额三
	 */
	public void setAssistanceClassMoney(BigDecimal assistanceClassMoney) {
		this.assistanceClassMoney = assistanceClassMoney;
	}

	/**
	 * 获取 开户行
	 * @return String
	 */
	public String getBank() {
		return bank;
	}

	/**
	 * 设置 开户行
	 */
	public void setBank(String bank) {
		this.bank = bank;
	}

	/**
	 * 获取 开户行账号
	 * @return String
	 */
	public String getAccountNumber() {
		return accountNumber;
	}

	/**
	 * 设置 开户行账号
	 */
	public void setAccountNumber(String accountNumber) {
		this.accountNumber = accountNumber;
	}

	/**
	 * 获取 变动种类
	 * @return String
	 */
	public String getChangeType() {
		return changeType;
	}

	/**
	 * 设置 变动种类
	 */
	public void setChangeType(String changeType) {
		this.changeType = changeType;
	}

	/**
	 * 获取 变动时间
	 * @return String
	 */
	public String getChangeDate() {
		return changeDate;
	}

	/**
	 * 设置 变动时间
	 */
	public void setChangeDate(String changeDate) {
		this.changeDate = changeDate;
	}

	/**
	 * 获取 户主是否享受
	 * @return String
	 */
	public String getIsEnjoy() {
		return isEnjoy;
	}

	/**
	 * 设置 户主是否享受
	 */
	public void setIsEnjoy(String isEnjoy) {
		this.isEnjoy = isEnjoy;
	}

	/**
	 * 获取 成员一姓名
	 * @return String
	 */
	public String getP1Name() {
		return p1Name;
	}

	/**
	 * 设置 成员一姓名
	 */
	public void setP1Name(String p1Name) {
		this.p1Name = p1Name;
	}

	/**
	 * 获取 成员一身份证号码
	 * @return String
	 */
	public String getP1IdCard() {
		return p1IdCard;
	}

	/**
	 * 设置 成员一身份证号码
	 */
	public void setP1IdCard(String p1IdCard) {
		this.p1IdCard = p1IdCard;
	}

	/**
	 * 获取 成员二姓名
	 * @return String
	 */
	public String getP2Name() {
		return p2Name;
	}

	/**
	 * 设置 成员二姓名
	 */
	public void setP2Name(String p2Name) {
		this.p2Name = p2Name;
	}

	/**
	 * 获取 成员二身份证号码
	 * @return String
	 */
	public String getP2IdCard() {
		return p2IdCard;
	}

	/**
	 * 设置 成员二身份证号码
	 */
	public void setP2IdCard(String p2IdCard) {
		this.p2IdCard = p2IdCard;
	}

	/**
	 * 获取 成员三姓名
	 * @return String
	 */
	public String getP3Name() {
		return p3Name;
	}

	/**
	 * 设置 成员三姓名
	 */
	public void setP3Name(String p3Name) {
		this.p3Name = p3Name;
	}

	/**
	 * 获取 成员三身份证号码
	 * @return String
	 */
	public String getP3IdCard() {
		return p3IdCard;
	}

	/**
	 * 设置 成员三身份证号码
	 */
	public void setP3IdCard(String p3IdCard) {
		this.p3IdCard = p3IdCard;
	}

	/**
	 * 获取 成员四姓名
	 * @return String
	 */
	public String getP4Name() {
		return p4Name;
	}

	/**
	 * 设置 成员四姓名
	 */
	public void setP4Name(String p4Name) {
		this.p4Name = p4Name;
	}

	/**
	 * 获取 成员四身份证号码
	 * @return String
	 */
	public String getP4IdCard() {
		return p4IdCard;
	}

	/**
	 * 设置 成员四身份证号码
	 */
	public void setP4IdCard(String p4IdCard) {
		this.p4IdCard = p4IdCard;
	}

	/**
	 * 获取 成员五姓名
	 * @return String
	 */
	public String getP5Name() {
		return p5Name;
	}

	/**
	 * 设置 成员五姓名
	 */
	public void setP5Name(String p5Name) {
		this.p5Name = p5Name;
	}

	/**
	 * 获取 成员五身份证号码
	 * @return String
	 */
	public String getP5IdCard() {
		return p5IdCard;
	}

	/**
	 * 设置 成员五身份证号码
	 */
	public void setP5IdCard(String p5IdCard) {
		this.p5IdCard = p5IdCard;
	}

	/**
	 * 获取 成员六姓名
	 * @return String
	 */
	public String getP6Name() {
		return p6Name;
	}

	/**
	 * 设置 成员六姓名
	 */
	public void setP6Name(String p6Name) {
		this.p6Name = p6Name;
	}

	/**
	 * 获取 成员六身份证号码
	 * @return String
	 */
	public String getP6IdCard() {
		return p6IdCard;
	}

	/**
	 * 设置 成员六身份证号码
	 */
	public void setP6IdCard(String p6IdCard) {
		this.p6IdCard = p6IdCard;
	}

	/**
	 * 获取 成员七姓名
	 * @return String
	 */
	public String getP7Name() {
		return p7Name;
	}

	/**
	 * 设置 成员七姓名
	 */
	public void setP7Name(String p7Name) {
		this.p7Name = p7Name;
	}

	/**
	 * 获取 成员七身份证号码
	 * @return String
	 */
	public String getP7IdCard() {
		return p7IdCard;
	}

	/**
	 * 设置 成员七身份证号码
	 */
	public void setP7IdCard(String p7IdCard) {
		this.p7IdCard = p7IdCard;
	}

	/**
	 * 获取 成员八姓名
	 * @return String
	 */
	public String getP8Name() {
		return p8Name;
	}

	/**
	 * 设置 成员八姓名
	 */
	public void setP8Name(String p8Name) {
		this.p8Name = p8Name;
	}

	/**
	 * 获取 成员八身份证号码
	 * @return String
	 */
	public String getP8IdCard() {
		return p8IdCard;
	}

	/**
	 * 设置 成员八身份证号码
	 */
	public void setP8IdCard(String p8IdCard) {
		this.p8IdCard = p8IdCard;
	}

	/**
	 * 获取 成员九姓名
	 * @return String
	 */
	public String getP9Name() {
		return p9Name;
	}

	/**
	 * 设置 成员九姓名
	 */
	public void setP9Name(String p9Name) {
		this.p9Name = p9Name;
	}

	/**
	 * 获取 成员九身份证号码
	 * @return String
	 */
	public String getP9IdCard() {
		return p9IdCard;
	}

	/**
	 * 设置 成员九身份证号码
	 */
	public void setP9IdCard(String p9IdCard) {
		this.p9IdCard = p9IdCard;
	}

	public String getSatandingId() {
		return satandingId;
	}

	public void setSatandingId(String satandingId) {
		this.satandingId = satandingId;
	}

}