package com.inspur.cams.bpt.base.data;

import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * @title:BptTemporaryHelp
 * @description:
 * @author:
 * @since:2011-06-09
 * @version:1.0
 */
@Table(tableName = "BPT_TEMPORARY_HELP", keyFields = "applyId")
public class BptTemporaryHelp extends StatefulDatabean {
	//申请ID
	private String applyId;
	//人员ID
	private String peopleId;
	//行政区划代码
	private String domicileCode;
	// 姓名
	private String name;
	// 性别
	private String sex;
	// 身份证号
	private String idCord;
	// 年龄
	private String age;
	// 民族
	private String nation;
	// 优抚对象类别
	private String objectType;
	// 帮助类别
	private String helpType;
	// 家庭住址
	private String address;
	// 家庭人口
	private BigDecimal familyNum;
	// 申请金额
	private BigDecimal applyMon;
	// 申请人事由
	private String applySubject;
	// 是否同意提交
	private String submitFlag;
	// 村(居)负责人
	private String checkIncharge;
	// 村(居)审核时间
	private String checkDate;
	// 村(居)审核意见
	private String checkAdvice;
	// 乡镇（街道）负责人
	private String auditIncharge;
	// 乡镇（街道）审核时间
	private String auditDate;
	// 乡镇（街道）审核意见
	private String auditAdvice;
	// 县民政部门负责人
	private String verifyIncharge;
	// 县民政部门审核时间
	private String verifyDate;
	// 县民政部门审核意见
	private String verifyAdvice;
	// 备注
	private String note;
	// 录入人
	private String regId;
	// 录入时间
	private String regTime;
	// 修改人
	private String modId;
	// 修改时间
	private String modTime;
	public String getApplyId() {
		return applyId;
	}
	public void setApplyId(String applyId) {
		this.applyId = applyId;
	}
	public String getPeopleId() {
		return peopleId;
	}
	public void setPeopleId(String peopleId) {
		this.peopleId = peopleId;
	}
	public String getDomicileCode() {
		return domicileCode;
	}
	public void setDomicileCode(String domicileCode) {
		this.domicileCode = domicileCode;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public String getIdCord() {
		return idCord;
	}
	public void setIdCord(String idCord) {
		this.idCord = idCord;
	}
	public String getAge() {
		return age;
	}
	public void setAge(String age) {
		this.age = age;
	}
	public String getNation() {
		return nation;
	}
	public void setNation(String nation) {
		this.nation = nation;
	}
	public String getObjectType() {
		return objectType;
	}
	public void setObjectType(String objectType) {
		this.objectType = objectType;
	}
	public String getHelpType() {
		return helpType;
	}
	public void setHelpType(String helpType) {
		this.helpType = helpType;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public BigDecimal getFamilyNum() {
		return familyNum;
	}
	public void setFamilyNum(BigDecimal familyNum) {
		this.familyNum = familyNum;
	}
	public BigDecimal getApplyMon() {
		return applyMon;
	}
	public void setApplyMon(BigDecimal applyMon) {
		this.applyMon = applyMon;
	}
	public String getApplySubject() {
		return applySubject;
	}
	public void setApplySubject(String applySubject) {
		this.applySubject = applySubject;
	}
	public String getSubmitFlag() {
		return submitFlag;
	}
	public void setSubmitFlag(String submitFlag) {
		this.submitFlag = submitFlag;
	}
	public String getCheckIncharge() {
		return checkIncharge;
	}
	public void setCheckIncharge(String checkIncharge) {
		this.checkIncharge = checkIncharge;
	}
	public String getCheckDate() {
		return checkDate;
	}
	public void setCheckDate(String checkDate) {
		this.checkDate = checkDate;
	}
	public String getCheckAdvice() {
		return checkAdvice;
	}
	public void setCheckAdvice(String checkAdvice) {
		this.checkAdvice = checkAdvice;
	}
	public String getAuditIncharge() {
		return auditIncharge;
	}
	public void setAuditIncharge(String auditIncharge) {
		this.auditIncharge = auditIncharge;
	}
	public String getAuditDate() {
		return auditDate;
	}
	public void setAuditDate(String auditDate) {
		this.auditDate = auditDate;
	}
	public String getAuditAdvice() {
		return auditAdvice;
	}
	public void setAuditAdvice(String auditAdvice) {
		this.auditAdvice = auditAdvice;
	}
	public String getVerifyIncharge() {
		return verifyIncharge;
	}
	public void setVerifyIncharge(String verifyIncharge) {
		this.verifyIncharge = verifyIncharge;
	}
	public String getVerifyDate() {
		return verifyDate;
	}
	public void setVerifyDate(String verifyDate) {
		this.verifyDate = verifyDate;
	}
	public String getVerifyAdvice() {
		return verifyAdvice;
	}
	public void setVerifyAdvice(String verifyAdvice) {
		this.verifyAdvice = verifyAdvice;
	}
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
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
}