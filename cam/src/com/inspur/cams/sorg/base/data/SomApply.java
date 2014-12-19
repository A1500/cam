package com.inspur.cams.sorg.base.data;

import java.util.Map;

import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * 社会组织业务表
 * @author shgtch
 * @date 2011-8-9
 */
@Table(tableName = "SOM_APPLY", keyFields = "taskCode")
public class SomApply extends StatefulDatabean {
	
	@Transient
	private SomOrgan somOrgan;
	
	@Transient
	private Map<String, String> map;
	
	// 流程实例ID
	private String processId;
	
	// 业务编号
	private String taskCode;
	
	// 社会组织内码
	private String sorgId;
	
	// 业务类型
	private String applyType;
	
	// 社会组织类型
	private String sorgType;
	
	// 社会组织种类
	private String sorgKind;
	
	// 社会组织名称
	private String sorgName;
	
	// 履行内部程序
	private String process;
	
	// 是否完结
	private String ifFinish;
	
	// 申请人
	private String appPeople;
	
	// 申请人电话
	private String appPhone;
	
	// 申请日期
	private String appDate;
	
	// 数据来源
	private String dataSource;
	
	// 业务主管单位
	private String borgName;
	
	// 业务主管单位负责人
	private String borgPeople;
	
	// 业务主管单位意见
	private String borgOpinion;
	
	// 业务主管单位审查日期
	private String borgCheckDate;
	
	// 业务主管单位电话
	private String borgPhone;
	
	// 受理单位行政区划
	private String acceptArea;
	
	// 受理单位内码
	private String acceptOrganId;
	
	// 受理单位名称
	private String acceptOrganName;
	
	// 受理部门内码
	private String acceptDeptId;
	
	// 受理部门名称
	private String acceptDeptName;
	
	// 受理人内码
	private String acceptPeopleId;
	
	// 受理人名称
	private String acceptPeopleName;
	
	// 受理时间
	private String acceptTime;
	
	//承办人意见
	private String acceptOpinionId;
	
	//承办人补充意见
	private String acceptOpinion;
	
	//现场勘查意见
	private String prospectOpinionId;
	
	//现场勘查补充意见
	private String prospectOpinion;
	
	//现场勘查双方参加人员
	private String prospectAttendPeople;
	
	//现场勘查日期
	private String prospectDate;
	
	//现场勘查地点
	private String prospectPlace;
	
	//现场勘查人员内码
	private String prospectPeopleId;
	
	//现场勘查人员名称
	private String prospectPeopleName;
	
	//现场勘查部门内码
	private String prospectDeptId;
	
	//现场勘查部门名称
	private String prospectDeptName;
	
	//现场勘查单位内码
	private String prospectOrganId;
	
	//现场勘查单位名称
	private String prospectOrganName;
	
	// 初审意见
	private String examinOpinionId;
	
	// 初审补充意见
	private String examinOpinion;
	
	// 初审单位内码
	private String examinOrganId;
	
	// 初审单位名称
	private String examinOrganName;
	
	// 初审部门内码
	private String examinDeptId;
	
	// 初审部门名称
	private String examinDeptName;
	
	// 初审人内码
	private String examinPeopleId;
	
	// 初审人名称
	private String examinPeopleName;
	
	// 初审时间
	private String examinTime;

	// 审核意见
	private String checkOpinionId;
	
	// 审核补充意见
	private String checkOpinion;
	
	// 审核单位内码
	private String checkOrganId;
	
	// 审核单位名称
	private String checkOrganName;
	
	// 审核部门内码
	private String checkDeptId;
	
	// 审核部门名称
	private String checkDeptName;
	
	// 审核人内码
	private String checkPeopleId;
	
	// 审核人名称
	private String checkPeopleName;
	
	// 审核时间
	private String checkTime;

	// 审核意见
	private String auditOpinionId;
	
	// 审批补充意见
	private String auditOpinion;
	
	// 审批单位内码
	private String auditOrganId;
	
	// 审批单位名称
	private String auditOrganName;
	
	// 审批部门内码
	private String auditDeptId;
	
	// 审批部门名称
	private String auditDeptName;
	
	// 审批人内码
	private String auditPeopleId;
	
	// 审批人名称
	private String auditPeopleName;
	
	// 审批时间
	private String auditTime;
	
	// 当前环节
	private String curActivity;
	
	// 当前环节意见
	private String curOpinionId;
	
	// 当前环节补充意见
	private String curOpinion;
	
	// 当前处理单位内码
	private String curOrganId;
	
	// 当前处理单位名称
	private String curOrganName;
	
	// 当前处理部门内码
	private String curDeptId;
	
	// 当前处理部门名称
	private String curDeptName;
	
	// 当前处理人内码
	private String curPeopleId;
	
	// 当前处理人名称
	private String curPeopleName;
	
	// 唯一查询号
	private String elmSerialNo;
	
	// 查询密码
	private String elmPassword;
	
	// 创建时间
	private String createTime;
	
	// 创建人
	private String createPerson;
	
	// 创建单位
	private String createOrgan;
	
	// 届次
	private String sessionId;
	
	// 内外网交换状态  
	/**
	 * 0:未提交(外网)
		1:已提交(外网，此时需要从外网交换到内网)
		2:重新修改(内网,此时需要从内网交换到外网)
		3:已受理(内网)
		默认值0
	 */
	private String onlineStatus;

	public SomOrgan getSomOrgan() {
		return somOrgan;
	}

	public void setSomOrgan(SomOrgan somOrgan) {
		this.somOrgan = somOrgan;
	}

	public Map<String, String> getMap() {
		return map;
	}

	public void setMap(Map<String, String> map) {
		this.map = map;
	}

	public String getProcessId() {
		return processId;
	}

	public void setProcessId(String processId) {
		this.processId = processId;
	}

	public String getTaskCode() {
		return taskCode;
	}

	public void setTaskCode(String taskCode) {
		this.taskCode = taskCode;
	}

	public String getSorgId() {
		return sorgId;
	}

	public void setSorgId(String sorgId) {
		this.sorgId = sorgId;
	}

	public String getApplyType() {
		return applyType;
	}

	public void setApplyType(String applyType) {
		this.applyType = applyType;
	}

	public String getSorgType() {
		return sorgType;
	}

	public void setSorgType(String sorgType) {
		this.sorgType = sorgType;
	}

	public String getSorgKind() {
		return sorgKind;
	}

	public void setSorgKind(String sorgKind) {
		this.sorgKind = sorgKind;
	}

	public String getSorgName() {
		return sorgName;
	}

	public void setSorgName(String sorgName) {
		this.sorgName = sorgName;
	}

	public String getProcess() {
		return process;
	}

	public void setProcess(String process) {
		this.process = process;
	}

	public String getIfFinish() {
		return ifFinish;
	}

	public void setIfFinish(String ifFinish) {
		this.ifFinish = ifFinish;
	}

	public String getAppPeople() {
		return appPeople;
	}

	public void setAppPeople(String appPeople) {
		this.appPeople = appPeople;
	}

	public String getAppPhone() {
		return appPhone;
	}

	public void setAppPhone(String appPhone) {
		this.appPhone = appPhone;
	}

	public String getAppDate() {
		return appDate;
	}

	public void setAppDate(String appDate) {
		this.appDate = appDate;
	}

	public String getDataSource() {
		return dataSource;
	}

	public void setDataSource(String dataSource) {
		this.dataSource = dataSource;
	}

	public String getBorgName() {
		return borgName;
	}

	public void setBorgName(String borgName) {
		this.borgName = borgName;
	}

	public String getBorgPeople() {
		return borgPeople;
	}

	public void setBorgPeople(String borgPeople) {
		this.borgPeople = borgPeople;
	}

	public String getBorgOpinion() {
		return borgOpinion;
	}

	public void setBorgOpinion(String borgOpinion) {
		this.borgOpinion = borgOpinion;
	}

	public String getBorgCheckDate() {
		return borgCheckDate;
	}

	public void setBorgCheckDate(String borgCheckDate) {
		this.borgCheckDate = borgCheckDate;
	}

	public String getBorgPhone() {
		return borgPhone;
	}

	public void setBorgPhone(String borgPhone) {
		this.borgPhone = borgPhone;
	}

	public String getAcceptArea() {
		return acceptArea;
	}

	public void setAcceptArea(String acceptArea) {
		this.acceptArea = acceptArea;
	}

	public String getAcceptOrganId() {
		return acceptOrganId;
	}

	public void setAcceptOrganId(String acceptOrganId) {
		this.acceptOrganId = acceptOrganId;
	}

	public String getAcceptOrganName() {
		return acceptOrganName;
	}

	public void setAcceptOrganName(String acceptOrganName) {
		this.acceptOrganName = acceptOrganName;
	}

	public String getAcceptDeptId() {
		return acceptDeptId;
	}

	public void setAcceptDeptId(String acceptDeptId) {
		this.acceptDeptId = acceptDeptId;
	}

	public String getAcceptDeptName() {
		return acceptDeptName;
	}

	public void setAcceptDeptName(String acceptDeptName) {
		this.acceptDeptName = acceptDeptName;
	}

	public String getAcceptPeopleId() {
		return acceptPeopleId;
	}

	public void setAcceptPeopleId(String acceptPeopleId) {
		this.acceptPeopleId = acceptPeopleId;
	}

	public String getAcceptPeopleName() {
		return acceptPeopleName;
	}

	public void setAcceptPeopleName(String acceptPeopleName) {
		this.acceptPeopleName = acceptPeopleName;
	}

	public String getAcceptTime() {
		return acceptTime;
	}

	public void setAcceptTime(String acceptTime) {
		this.acceptTime = acceptTime;
	}

	public String getAcceptOpinionId() {
		return acceptOpinionId;
	}

	public void setAcceptOpinionId(String acceptOpinionId) {
		this.acceptOpinionId = acceptOpinionId;
	}

	public String getAcceptOpinion() {
		return acceptOpinion;
	}

	public void setAcceptOpinion(String acceptOpinion) {
		this.acceptOpinion = acceptOpinion;
	}
	
	public String getExaminOpinionId() {
		return examinOpinionId;
	}

	public void setExaminOpinionId(String examinOpinionId) {
		this.examinOpinionId = examinOpinionId;
	}

	public String getExaminOpinion() {
		return examinOpinion;
	}

	public void setExaminOpinion(String examinOpinion) {
		this.examinOpinion = examinOpinion;
	}

	public String getExaminOrganId() {
		return examinOrganId;
	}

	public void setExaminOrganId(String examinOrganId) {
		this.examinOrganId = examinOrganId;
	}

	public String getExaminOrganName() {
		return examinOrganName;
	}

	public void setExaminOrganName(String examinOrganName) {
		this.examinOrganName = examinOrganName;
	}

	public String getExaminDeptId() {
		return examinDeptId;
	}

	public void setExaminDeptId(String examinDeptId) {
		this.examinDeptId = examinDeptId;
	}

	public String getExaminDeptName() {
		return examinDeptName;
	}

	public void setExaminDeptName(String examinDeptName) {
		this.examinDeptName = examinDeptName;
	}

	public String getExaminPeopleId() {
		return examinPeopleId;
	}

	public void setExaminPeopleId(String examinPeopleId) {
		this.examinPeopleId = examinPeopleId;
	}

	public String getExaminPeopleName() {
		return examinPeopleName;
	}

	public void setExaminPeopleName(String examinPeopleName) {
		this.examinPeopleName = examinPeopleName;
	}

	public String getExaminTime() {
		return examinTime;
	}

	public void setExaminTime(String examinTime) {
		this.examinTime = examinTime;
	}

	public String getCheckOpinionId() {
		return checkOpinionId;
	}

	public void setCheckOpinionId(String checkOpinionId) {
		this.checkOpinionId = checkOpinionId;
	}

	public String getCheckOpinion() {
		return checkOpinion;
	}

	public void setCheckOpinion(String checkOpinion) {
		this.checkOpinion = checkOpinion;
	}

	public String getCheckOrganId() {
		return checkOrganId;
	}

	public void setCheckOrganId(String checkOrganId) {
		this.checkOrganId = checkOrganId;
	}

	public String getCheckOrganName() {
		return checkOrganName;
	}

	public void setCheckOrganName(String checkOrganName) {
		this.checkOrganName = checkOrganName;
	}

	public String getCheckDeptId() {
		return checkDeptId;
	}

	public void setCheckDeptId(String checkDeptId) {
		this.checkDeptId = checkDeptId;
	}

	public String getCheckDeptName() {
		return checkDeptName;
	}

	public void setCheckDeptName(String checkDeptName) {
		this.checkDeptName = checkDeptName;
	}

	public String getCheckPeopleId() {
		return checkPeopleId;
	}

	public void setCheckPeopleId(String checkPeopleId) {
		this.checkPeopleId = checkPeopleId;
	}

	public String getCheckPeopleName() {
		return checkPeopleName;
	}

	public void setCheckPeopleName(String checkPeopleName) {
		this.checkPeopleName = checkPeopleName;
	}

	public String getCheckTime() {
		return checkTime;
	}

	public void setCheckTime(String checkTime) {
		this.checkTime = checkTime;
	}

	public String getAuditOpinionId() {
		return auditOpinionId;
	}

	public void setAuditOpinionId(String auditOpinionId) {
		this.auditOpinionId = auditOpinionId;
	}

	public String getAuditOpinion() {
		return auditOpinion;
	}

	public void setAuditOpinion(String auditOpinion) {
		this.auditOpinion = auditOpinion;
	}

	public String getAuditOrganId() {
		return auditOrganId;
	}

	public void setAuditOrganId(String auditOrganId) {
		this.auditOrganId = auditOrganId;
	}

	public String getAuditOrganName() {
		return auditOrganName;
	}

	public void setAuditOrganName(String auditOrganName) {
		this.auditOrganName = auditOrganName;
	}

	public String getAuditDeptId() {
		return auditDeptId;
	}

	public void setAuditDeptId(String auditDeptId) {
		this.auditDeptId = auditDeptId;
	}

	public String getAuditDeptName() {
		return auditDeptName;
	}

	public void setAuditDeptName(String auditDeptName) {
		this.auditDeptName = auditDeptName;
	}

	public String getAuditPeopleId() {
		return auditPeopleId;
	}

	public void setAuditPeopleId(String auditPeopleId) {
		this.auditPeopleId = auditPeopleId;
	}

	public String getAuditPeopleName() {
		return auditPeopleName;
	}

	public void setAuditPeopleName(String auditPeopleName) {
		this.auditPeopleName = auditPeopleName;
	}

	public String getAuditTime() {
		return auditTime;
	}

	public void setAuditTime(String auditTime) {
		this.auditTime = auditTime;
	}

	public String getCurActivity() {
		return curActivity;
	}

	public void setCurActivity(String curActivity) {
		this.curActivity = curActivity;
	}

	public String getCurOpinionId() {
		return curOpinionId;
	}

	public void setCurOpinionId(String curOpinionId) {
		this.curOpinionId = curOpinionId;
	}

	public String getCurOpinion() {
		return curOpinion;
	}

	public void setCurOpinion(String curOpinion) {
		this.curOpinion = curOpinion;
	}

	public String getCurOrganId() {
		return curOrganId;
	}

	public void setCurOrganId(String curOrganId) {
		this.curOrganId = curOrganId;
	}

	public String getCurOrganName() {
		return curOrganName;
	}

	public void setCurOrganName(String curOrganName) {
		this.curOrganName = curOrganName;
	}

	public String getCurDeptId() {
		return curDeptId;
	}

	public void setCurDeptId(String curDeptId) {
		this.curDeptId = curDeptId;
	}

	public String getCurDeptName() {
		return curDeptName;
	}

	public void setCurDeptName(String curDeptName) {
		this.curDeptName = curDeptName;
	}

	public String getCurPeopleId() {
		return curPeopleId;
	}

	public void setCurPeopleId(String curPeopleId) {
		this.curPeopleId = curPeopleId;
	}

	public String getCurPeopleName() {
		return curPeopleName;
	}

	public void setCurPeopleName(String curPeopleName) {
		this.curPeopleName = curPeopleName;
	}

	public String getProspectOpinionId() {
		return prospectOpinionId;
	}

	public void setProspectOpinionId(String prospectOpinionId) {
		this.prospectOpinionId = prospectOpinionId;
	}

	public String getProspectOpinion() {
		return prospectOpinion;
	}

	public void setProspectOpinion(String prospectOpinion) {
		this.prospectOpinion = prospectOpinion;
	}

	public String getProspectAttendPeople() {
		return prospectAttendPeople;
	}

	public void setProspectAttendPeople(String prospectAttendPeople) {
		this.prospectAttendPeople = prospectAttendPeople;
	}

	public String getProspectDate() {
		return prospectDate;
	}

	public void setProspectDate(String prospectDate) {
		this.prospectDate = prospectDate;
	}

	public String getProspectPlace() {
		return prospectPlace;
	}

	public void setProspectPlace(String prospectPlace) {
		this.prospectPlace = prospectPlace;
	}

	public String getProspectPeopleId() {
		return prospectPeopleId;
	}

	public void setProspectPeopleId(String prospectPeopleId) {
		this.prospectPeopleId = prospectPeopleId;
	}

	public String getProspectPeopleName() {
		return prospectPeopleName;
	}

	public void setProspectPeopleName(String prospectPeopleName) {
		this.prospectPeopleName = prospectPeopleName;
	}

	public String getProspectDeptId() {
		return prospectDeptId;
	}

	public void setProspectDeptId(String prospectDeptId) {
		this.prospectDeptId = prospectDeptId;
	}

	public String getProspectDeptName() {
		return prospectDeptName;
	}

	public void setProspectDeptName(String prospectDeptName) {
		this.prospectDeptName = prospectDeptName;
	}

	public String getProspectOrganId() {
		return prospectOrganId;
	}

	public void setProspectOrganId(String prospectOrganId) {
		this.prospectOrganId = prospectOrganId;
	}

	public String getProspectOrganName() {
		return prospectOrganName;
	}

	public void setProspectOrganName(String prospectOrganName) {
		this.prospectOrganName = prospectOrganName;
	}

	public String getElmSerialNo() {
		return elmSerialNo;
	}

	public void setElmSerialNo(String elmSerialNo) {
		this.elmSerialNo = elmSerialNo;
	}

	public String getElmPassword() {
		return elmPassword;
	}

	public void setElmPassword(String elmPassword) {
		this.elmPassword = elmPassword;
	}

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	public String getCreatePerson() {
		return createPerson;
	}

	public void setCreatePerson(String createPerson) {
		this.createPerson = createPerson;
	}

	public String getCreateOrgan() {
		return createOrgan;
	}

	public void setCreateOrgan(String createOrgan) {
		this.createOrgan = createOrgan;
	}

	public String getOnlineStatus() {
		return onlineStatus;
	}

	public void setOnlineStatus(String onlineStatus) {
		this.onlineStatus = onlineStatus;
	}

	public String getSessionId() {
		return sessionId;
	}

	public void setSessionId(String sessionId) {
		this.sessionId = sessionId;
	}

}