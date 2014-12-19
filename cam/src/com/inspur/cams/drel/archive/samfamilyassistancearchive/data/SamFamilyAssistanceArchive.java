package com.inspur.cams.drel.archive.samfamilyassistancearchive.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 社会救助_救助基本信息databean
 * @author 
 * @date 2012-06-28
 */
@Table(tableName = "SAM_FAMILY_ASSISTANCE_ARCHIVE", keyFields = "familyArchiveId, familyId, assistanceType")
public class SamFamilyAssistanceArchive extends StatefulDatabean {

	// 归档ID
	private String familyArchiveId;

	// 家庭ID
	private String familyId;

	// 救助类型
	private String assistanceType;

	// 证件号码
	private String cardNo;

	// 供养方式代码（五保）
	private String supportWay;

	// 户月低保救助金额
	private BigDecimal assistanceMon;

	// 其中分类施保金额
	private BigDecimal assistanceClassMon;

	// 保障起始年月
	private String assistanceBegin;

	// 保障停止年月2
	private String assistanceEnd;

	// 开户银行
	private String bank;

	// 开户名称
	private String accountName;

	// 银行账号
	private String accountCode;

	// 发证机关ID
	private String signOrg;

	// 发证机关名称
	private String signOrgName;

	// 发证日期
	private String signDate;

	// 有效日期起
	private String cardValidateBegin;

	// 有效日期止
	private String cardValidateEnd;

	// 状态标志
	private String cardStatus;

	// 录入人ID
	private String reId;

	// 录入单位Id
	private String regOrg;

	// 录入时间
	private String regTime;

	// 修改人ID
	private String modId;

	// 修改单位ID
	private String modOrg;

	// 修改时间
	private String modTime;

	// 申请ID
	private String applyId;

	public String getFamilyArchiveId() {
		return familyArchiveId;
	}

	public void setFamilyArchiveId(String familyArchiveId) {
		this.familyArchiveId = familyArchiveId;
	}

	public String getFamilyId() {
		return familyId;
	}

	public void setFamilyId(String familyId) {
		this.familyId = familyId;
	}

	public String getAssistanceType() {
		return assistanceType;
	}

	public void setAssistanceType(String assistanceType) {
		this.assistanceType = assistanceType;
	}

	public String getCardNo() {
		return cardNo;
	}

	public void setCardNo(String cardNo) {
		this.cardNo = cardNo;
	}

	public String getSupportWay() {
		return supportWay;
	}

	public void setSupportWay(String supportWay) {
		this.supportWay = supportWay;
	}

	public BigDecimal getAssistanceMon() {
		return assistanceMon;
	}

	public void setAssistanceMon(BigDecimal assistanceMon) {
		this.assistanceMon = assistanceMon;
	}

	public BigDecimal getAssistanceClassMon() {
		return assistanceClassMon;
	}

	public void setAssistanceClassMon(BigDecimal assistanceClassMon) {
		this.assistanceClassMon = assistanceClassMon;
	}

	public String getAssistanceBegin() {
		return assistanceBegin;
	}

	public void setAssistanceBegin(String assistanceBegin) {
		this.assistanceBegin = assistanceBegin;
	}

	public String getAssistanceEnd() {
		return assistanceEnd;
	}

	public void setAssistanceEnd(String assistanceEnd) {
		this.assistanceEnd = assistanceEnd;
	}

	public String getBank() {
		return bank;
	}

	public void setBank(String bank) {
		this.bank = bank;
	}

	public String getAccountName() {
		return accountName;
	}

	public void setAccountName(String accountName) {
		this.accountName = accountName;
	}

	public String getAccountCode() {
		return accountCode;
	}

	public void setAccountCode(String accountCode) {
		this.accountCode = accountCode;
	}

	public String getSignOrg() {
		return signOrg;
	}

	public void setSignOrg(String signOrg) {
		this.signOrg = signOrg;
	}

	public String getSignOrgName() {
		return signOrgName;
	}

	public void setSignOrgName(String signOrgName) {
		this.signOrgName = signOrgName;
	}

	public String getSignDate() {
		return signDate;
	}

	public void setSignDate(String signDate) {
		this.signDate = signDate;
	}

	public String getCardValidateBegin() {
		return cardValidateBegin;
	}

	public void setCardValidateBegin(String cardValidateBegin) {
		this.cardValidateBegin = cardValidateBegin;
	}

	public String getCardValidateEnd() {
		return cardValidateEnd;
	}

	public void setCardValidateEnd(String cardValidateEnd) {
		this.cardValidateEnd = cardValidateEnd;
	}

	public String getCardStatus() {
		return cardStatus;
	}

	public void setCardStatus(String cardStatus) {
		this.cardStatus = cardStatus;
	}

	public String getReId() {
		return reId;
	}

	public void setReId(String reId) {
		this.reId = reId;
	}

	public String getRegOrg() {
		return regOrg;
	}

	public void setRegOrg(String regOrg) {
		this.regOrg = regOrg;
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

	public String getModOrg() {
		return modOrg;
	}

	public void setModOrg(String modOrg) {
		this.modOrg = modOrg;
	}

	public String getModTime() {
		return modTime;
	}

	public void setModTime(String modTime) {
		this.modTime = modTime;
	}

	public String getApplyId() {
		return applyId;
	}

	public void setApplyId(String applyId) {
		this.applyId = applyId;
	}

}