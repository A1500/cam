package com.inspur.cams.bpt.base.data;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:BptPhysicalExamination
 * @description:
 * @author:
 * @since:2011-12-27
 * @version:1.0
*/
 @Table(tableName = "BPT_DEMOBILIZEDILLNESS_CHECK" , keyFields = "applyId")
public class BptDemobilizedillnessCheck extends StatefulDatabean {
	private String applyId; 
   //人员ID
	@Column(name = "PEOPLE_ID")
   private String peopleId;
   //送检医院
	@Column(name = "HOSPITAL")
   private String hospital;
   //送检时间
	@Column(name = "TO_CHECK_DATE")
   private String toCheckDate;
   //送检疾病
	@Column(name = "TO_CHECK_ILLNESS")
   private String toCheckIllness;
   //检查结果
	@Column(name = "CHECK_RESULT")
   private String checkResult;
   //意见
	@Column(name = "ADVICE")
   private String advice;
   //系统
	@Column(name = "SYSTEM")
   private String system;
   //疾病
	@Column(name = "IllNESS")
   private String illness;
   //专家签字
	@Column(name = "SIGN")
   private String sign;
   //签字时间
	@Column(name = "SIGN_DATE")
   private String signDate;
   //送检单位
	@Column(name = "TO_ORGAN_ID")
   private String toOrganId;
   //送检到单位时间
	@Column(name = "TO_ORGAN_DATE")
   private String toOrganDate;
	// 录入人ID
	@Column(name = "REG_ID")
	@Rule(value = "length{32}")
	private String regId;
	// 录入时间
	@Column(name = "REG_TIME")
	@Rule(value = "length{19}")
	private String regTime;
	// 修改人ID
	@Column(name = "MOD_ID")
	@Rule(value = "length{32}")
	private String modId;
	// 修改时间
	@Column(name = "MOD_TIME")
	@Rule(value = "length{19}")
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
	public String getHospital() {
		return hospital;
	}
	public void setHospital(String hospital) {
		this.hospital = hospital;
	}
	public String getToCheckDate() {
		return toCheckDate;
	}
	public void setToCheckDate(String toCheckDate) {
		this.toCheckDate = toCheckDate;
	}
	public String getToCheckIllness() {
		return toCheckIllness;
	}
	public void setToCheckIllness(String toCheckIllness) {
		this.toCheckIllness = toCheckIllness;
	}
	public String getCheckResult() {
		return checkResult;
	}
	public void setCheckResult(String checkResult) {
		this.checkResult = checkResult;
	}
	public String getAdvice() {
		return advice;
	}
	public void setAdvice(String advice) {
		this.advice = advice;
	}
	public String getSystem() {
		return system;
	}
	public void setSystem(String system) {
		this.system = system;
	}
	public String getIllness() {
		return illness;
	}
	public void setIllness(String illness) {
		this.illness = illness;
	}
	public String getSign() {
		return sign;
	}
	public void setSign(String sign) {
		this.sign = sign;
	}
	public String getSignDate() {
		return signDate;
	}
	public void setSignDate(String signDate) {
		this.signDate = signDate;
	}
	public String getToOrganId() {
		return toOrganId;
	}
	public void setToOrganId(String toOrganId) {
		this.toOrganId = toOrganId;
	}
	public String getToOrganDate() {
		return toOrganDate;
	}
	public void setToOrganDate(String toOrganDate) {
		this.toOrganDate = toOrganDate;
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