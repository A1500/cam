package com.inspur.cams.bpt.base.data;


import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:BptApplyMartyrOffspring
 * @description:部分烈士（错杀被平反人员）子女、60周岁以上农村籍退役士兵_申请
 * @author:
 * @since:
 * @version:
 */
 @Table(tableName = "BPT_APPLY_MARTYR_OFFSPRING" , keyFields = "applyId")
public class BptApplyMartyrOffspring extends StatefulDatabean {
   //申请Id
   private String applyId;
   //人员ID
   private String peopleId;
   //申请时间
   private String applyDate;
   //申请机构
   private String approveOrganId;
   //业务类型
   private String serviceType;
   //村（居）委会负责人
   private String acceptIncharge;
   //村（居）委会受理时间
   private String acceptDate;
   //村（居）委会意见
   private String acceptAdvice;
   //乡（镇、街道）负责人
   private String checkIncharge;
   //乡（镇、街道）审核时间
   private String checkDate;
   //乡（镇、街道）审核意见
   private String checkAdvice;
   //县（市、区）负责人
   private String auditIncharge;
   //县（市、区）审批时间
   private String auditDate;
   //县（市、区）审批意见
   private String auditAdvice;
   //是否同意
   private String agreeFlag;
   //提交标示
   private String commitFlag;
   //录入人ID
   private String regId;
   //录入时间
   private String regTime;
   //修改人ID
   private String modId;
   //修改时间
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
	public String getApplyDate() {
		return applyDate;
	}
	public void setApplyDate(String applyDate) {
		this.applyDate = applyDate;
	}
	public String getApproveOrganId() {
		return approveOrganId;
	}
	public void setApproveOrganId(String approveOrganId) {
		this.approveOrganId = approveOrganId;
	}
	public String getServiceType() {
		return serviceType;
	}
	public void setServiceType(String serviceType) {
		this.serviceType = serviceType;
	}
	public String getAcceptIncharge() {
		return acceptIncharge;
	}
	public void setAcceptIncharge(String acceptIncharge) {
		this.acceptIncharge = acceptIncharge;
	}
	public String getAcceptDate() {
		return acceptDate;
	}
	public void setAcceptDate(String acceptDate) {
		this.acceptDate = acceptDate;
	}
	public String getAcceptAdvice() {
		return acceptAdvice;
	}
	public void setAcceptAdvice(String acceptAdvice) {
		this.acceptAdvice = acceptAdvice;
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
	public String getCommitFlag() {
		return commitFlag;
	}
	public void setCommitFlag(String commitFlag) {
		this.commitFlag = commitFlag;
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
	public String getAgreeFlag() {
		return agreeFlag;
	}
	public void setAgreeFlag(String agreeFlag) {
		this.agreeFlag = agreeFlag;
	}
}