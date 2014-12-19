package com.inspur.cams.sorg.penalty.base.data;

import java.util.List;

import org.loushang.next.dao.Table;
import org.loushang.next.dao.Transient;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

import com.inspur.cams.sorg.restrict.data.SomRestrictPeopleDetail;

/**
 * 行政执法审批databean
 * 
 * @author:zhangjian
 * @date 2011-12-21
 */
@Table(tableName = "SOM_PENALTY_APPLY", keyFields = "id")
public class SomPenaltyApply extends StatefulDatabean {
	@Transient
	//行政处罚基本信息
	private SomPenalty somPenalty;
	@Transient
	//社会组织受限制人员明细表
	private List<SomRestrictPeopleDetail> somRestrictPeopleDetailList;
	// 主键
	@Rule(value = "require")
	private String id;
	// 业务编号
	private String taskCode;
	// 受理单位ID
	private String acceptOrganId;
	// 受理单位名称
	private String acceptOrganName;
	// 受理部门ID
	private String acceptDeptId;
	// 受理部门名称
	private String acceptDeptName;
	// 受理人ID
	private String acceptPeopleId;
	// 受理人名称
	private String acceptPeopleName;
	// 受理时间
	private String acceptTime;
	// 受理意见
	private String acceptOpinionId;
	// 受理补充意见
	private String acceptOpinion;
	// 受理承办人
	private String acceptDealPeople;
	// 立案承办登记人ID
	private String regPeopleId;
	// 立案承办登记人名称
	private String regPeopleName;
	// 立案承办人
	private String regDealPeople;
	// 立案承办基本意见
	private String regOpinionId;
	// 立案承办补充意见
	private String regOpinion;
	// 立案承办单位ID
	private String regOrganId;
	// 立案承办单位名称
	private String regOrganName;
	// 立案承办部门ID
	private String regDeptId;
	// 立案承办部门名称
	private String regDeptName;
	// 立案承办时间
	private String regTime;
	// 立案审核人ID
	private String regCheckPeopleId;
	// 立案审核人名称
	private String regCheckPeopleName;
	// 立案审核基本意见
	private String regCheckOpinionId;
	// 立案审核补充意见
	private String regCheckOpinion;
	// 立案审核单位ID
	private String regCheckOrganId;
	// 立案审核单位名称
	private String regCheckOrganName;
	// 立案审核部门ID
	private String regCheckDeptId;
	// 立案审核部门名称
	private String regCheckDeptName;
	// 立案审核时间
	private String regCheckTime;
	// 立案审批人ID
	private String regAuditPeopleId;
	// 立案审批人名称
	private String regAuditPeopleName;
	// 立案审批基本意见
	private String regAuditOpinionId;
	// 立案审批补充意见
	private String regAuditOpinion;
	// 立案审批单位ID
	private String regAuditOrganId;
	// 立案审批单位名称
	private String regAuditOrganName;
	// 立案审批部门ID
	private String regAuditDeptId;
	// 立案审批部门名称
	private String regAuditDeptName;
	// 立案审批时间
	private String regAuditTime;
	// 调查承办登记人ID
	private String invAcceptPeopleId;
	// 调查承办登记人名称
	private String invAcceptPeopleName;
	// 调查承办人
	private String invAcceptDealPeople;
	// 调查承办人调查结论
	private String invAcceptOpinionId;
	// 调查承办人调查结论补充
	private String invAcceptOpinion;
	// 调查承办单位ID
	private String invAcceptOrganId;
	// 调查承办单位名称
	private String invAcceptOrganName;
	// 调查承办部门ID
	private String invAcceptDeptId;
	// 调查承办部门名称
	private String invAcceptDeptName;
	// 调查承办时间
	private String invAcceptTime;
	// 调查审核人ID
	private String invCheckPeopleId;
	// 调查审核人名称
	private String invCheckPeopleName;
	// 调查审核人调查结论
	private String invCheckOpinionId;
	// 调查审核人调查结论补充
	private String invCheckOpinion;
	// 调查审核单位ID
	private String invCheckOrganId;
	// 调查审核单位名称
	private String invCheckOrganName;
	// 调查审核部门ID
	private String invCheckDeptId;
	// 调查审核部门名称
	private String invCheckDeptName;
	// 调查审核时间
	private String invCheckTime;
	// 调查审批人ID
	private String invAuditPeopleId;
	// 调查审批人名称
	private String invAuditPeopleName;
	// 调查审批人调查结论
	private String invAuditOpinionId;
	// 调查审批人调查结论补充
	private String invAuditOpinion;
	// 调查审批单位ID
	private String invAuditOrganId;
	// 调查审批单位名称
	private String invAuditOrganName;
	// 调查审批部门ID
	private String invAuditDeptId;
	// 调查审批部门名称
	private String invAuditDeptName;
	// 调查审批时间
	private String invAuditTime;
	// 处罚决定作出登记人ID
	private String penaltyPeopleId;
	// 处罚决定作出登记人名称
	private String penaltyPeopleName;
	// 处罚决定作出承办人
	private String penaltyDealPeople;
	// 处罚决定作出人意见
	private String penaltyOpinionId;
	// 处罚决定作出人补充意见
	private String penaltyOpinion;
	// 处罚决定作出单位ID
	private String penaltyOrganId;
	// 处罚决定作出单位名称
	private String penaltyOrganName;
	// 处罚决定作出部门ID
	private String penaltyDeptId;
	// 处罚决定作出部门名称
	private String penaltyDeptName;
	// 处罚决定作出时间
	private String penaltyTime;
	// 处罚决定审核人ID
	private String penaltyCheckPeopleId;
	// 处罚决定审核人名称
	private String penaltyCheckPeopleName;
	// 处罚决定审核人意见
	private String penaltyCheckOpinionId;
	// 处罚决定审核人补充意见
	private String penaltyCheckOpinion;
	// 处罚决定审核单位ID
	private String penaltyCheckOrganId;
	// 处罚决定审核单位名称
	private String penaltyCheckOrganName;
	// 处罚决定审核部门ID
	private String penaltyCheckDeptId;
	// 处罚决定审核部门名称
	private String penaltyCheckDeptName;
	// 处罚决定审核时间
	private String penaltyCheckTime;
	// 处罚决定审批人ID
	private String penaltyAuditPeopleId;
	// 处罚决定审批人名称
	private String penaltyAuditPeopleName;
	// 处罚决定审批人意见
	private String penaltyAuditOpinionId;
	// 处罚决定审批人补充意见
	private String penaltyAuditOpinion;
	// 处罚决定审批单位ID
	private String penaltyAuditOrganId;
	// 处罚决定审批单位名称
	private String penaltyAuditOrganName;
	// 处罚决定审批部门ID
	private String penaltyAuditDeptId;
	// 处罚决定审批部门名称
	private String penaltyAuditDeptName;
	// 处罚决定审批时间
	private String penaltyAuditTime;
	// 结案承办登记人ID
	private String finalPeopleId;
	// 结案承办登记人名称
	private String finalPeopleName;
	// 结案承办人
	private String finalDealPeople;
	// 结案承办人意见
	private String finalOpinionId;
	// 结案承办人补充意见
	private String finalOpinion;
	// 结案承办单位ID
	private String finalOrganId;
	// 结案承办单位名称
	private String finalOrganName;
	// 结案承办部门ID
	private String finalDeptId;
	// 结案承办部门名称
	private String finalDeptName;
	// 结案承办时间
	private String finalTime;
	// 结案审核人ID
	private String finalCheckPeopleId;
	// 结案审核人名称
	private String finalCheckPeopleName;
	// 结案审核人意见
	private String finalCheckOpinionId;
	// 结案审核人补充意见
	private String finalCheckOpinion;
	// 结案审核单位ID
	private String finalCheckOrganId;
	// 结案审核单位名称
	private String finalCheckOrganName;
	// 结案审核部门ID
	private String finalCheckDeptId;
	// 结案审核部门名称
	private String finalCheckDeptName;
	// 结案审核时间
	private String finalCheckTime;
	// 结案审批人ID
	private String finalAuditPeopleId;
	// 结案审批人名称
	private String finalAuditPeopleName;
	// 结案审批人意见
	private String finalAuditOpinionId;
	// 结案审批人补充意见
	private String finalAuditOpinion;
	// 结案审批单位ID
	private String finalAuditOrganId;
	// 结案审批单位名称
	private String finalAuditOrganName;
	// 结案审批部门ID
	private String finalAuditDeptId;
	// 结案审批部门名称
	private String finalAuditDeptName;
	// 结案审批时间
	private String finalAuditTime;
	// 当前环节
	private String curActivity;
	// 当前处理意见
	private String curOpinionId;
	// 当前处理补充意见
	private String curOpinion;
	// 当前处理单位ID
	private String curOrganId;
	// 当前处理单位名称
	private String curOrganName;
	// 当前处理部门ID
	private String curDeptId;
	// 当前处理部门名称
	private String curDeptName;
	// 当前处理人ID
	private String curPeopleId;
	// 当前处理人名称
	private String curPeopleName;
	public SomPenalty getSomPenalty() {
		return somPenalty;
	}
	public void setSomPenalty(SomPenalty somPenalty) {
		this.somPenalty = somPenalty;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getTaskCode() {
		return taskCode;
	}
	public void setTaskCode(String taskCode) {
		this.taskCode = taskCode;
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
	public String getAcceptDealPeople() {
		return acceptDealPeople;
	}
	public void setAcceptDealPeople(String acceptDealPeople) {
		this.acceptDealPeople = acceptDealPeople;
	}
	public String getRegPeopleId() {
		return regPeopleId;
	}
	public void setRegPeopleId(String regPeopleId) {
		this.regPeopleId = regPeopleId;
	}
	public String getRegPeopleName() {
		return regPeopleName;
	}
	public void setRegPeopleName(String regPeopleName) {
		this.regPeopleName = regPeopleName;
	}
	public String getRegDealPeople() {
		return regDealPeople;
	}
	public void setRegDealPeople(String regDealPeople) {
		this.regDealPeople = regDealPeople;
	}
	public String getRegOpinionId() {
		return regOpinionId;
	}
	public void setRegOpinionId(String regOpinionId) {
		this.regOpinionId = regOpinionId;
	}
	public String getRegOpinion() {
		return regOpinion;
	}
	public void setRegOpinion(String regOpinion) {
		this.regOpinion = regOpinion;
	}
	public String getRegOrganId() {
		return regOrganId;
	}
	public void setRegOrganId(String regOrganId) {
		this.regOrganId = regOrganId;
	}
	public String getRegOrganName() {
		return regOrganName;
	}
	public void setRegOrganName(String regOrganName) {
		this.regOrganName = regOrganName;
	}
	public String getRegDeptId() {
		return regDeptId;
	}
	public void setRegDeptId(String regDeptId) {
		this.regDeptId = regDeptId;
	}
	public String getRegDeptName() {
		return regDeptName;
	}
	public void setRegDeptName(String regDeptName) {
		this.regDeptName = regDeptName;
	}
	public String getRegTime() {
		return regTime;
	}
	public void setRegTime(String regTime) {
		this.regTime = regTime;
	}
	public String getRegCheckPeopleId() {
		return regCheckPeopleId;
	}
	public void setRegCheckPeopleId(String regCheckPeopleId) {
		this.regCheckPeopleId = regCheckPeopleId;
	}
	public String getRegCheckPeopleName() {
		return regCheckPeopleName;
	}
	public void setRegCheckPeopleName(String regCheckPeopleName) {
		this.regCheckPeopleName = regCheckPeopleName;
	}
	public String getRegCheckOpinionId() {
		return regCheckOpinionId;
	}
	public void setRegCheckOpinionId(String regCheckOpinionId) {
		this.regCheckOpinionId = regCheckOpinionId;
	}
	public String getRegCheckOpinion() {
		return regCheckOpinion;
	}
	public void setRegCheckOpinion(String regCheckOpinion) {
		this.regCheckOpinion = regCheckOpinion;
	}
	public String getRegCheckOrganId() {
		return regCheckOrganId;
	}
	public void setRegCheckOrganId(String regCheckOrganId) {
		this.regCheckOrganId = regCheckOrganId;
	}
	public String getRegCheckOrganName() {
		return regCheckOrganName;
	}
	public void setRegCheckOrganName(String regCheckOrganName) {
		this.regCheckOrganName = regCheckOrganName;
	}
	public String getRegCheckDeptId() {
		return regCheckDeptId;
	}
	public void setRegCheckDeptId(String regCheckDeptId) {
		this.regCheckDeptId = regCheckDeptId;
	}
	public String getRegCheckDeptName() {
		return regCheckDeptName;
	}
	public void setRegCheckDeptName(String regCheckDeptName) {
		this.regCheckDeptName = regCheckDeptName;
	}
	public String getRegCheckTime() {
		return regCheckTime;
	}
	public void setRegCheckTime(String regCheckTime) {
		this.regCheckTime = regCheckTime;
	}
	public String getRegAuditPeopleId() {
		return regAuditPeopleId;
	}
	public void setRegAuditPeopleId(String regAuditPeopleId) {
		this.regAuditPeopleId = regAuditPeopleId;
	}
	public String getRegAuditPeopleName() {
		return regAuditPeopleName;
	}
	public void setRegAuditPeopleName(String regAuditPeopleName) {
		this.regAuditPeopleName = regAuditPeopleName;
	}
	public String getRegAuditOpinionId() {
		return regAuditOpinionId;
	}
	public void setRegAuditOpinionId(String regAuditOpinionId) {
		this.regAuditOpinionId = regAuditOpinionId;
	}
	public String getRegAuditOpinion() {
		return regAuditOpinion;
	}
	public void setRegAuditOpinion(String regAuditOpinion) {
		this.regAuditOpinion = regAuditOpinion;
	}
	public String getRegAuditOrganId() {
		return regAuditOrganId;
	}
	public void setRegAuditOrganId(String regAuditOrganId) {
		this.regAuditOrganId = regAuditOrganId;
	}
	public String getRegAuditOrganName() {
		return regAuditOrganName;
	}
	public void setRegAuditOrganName(String regAuditOrganName) {
		this.regAuditOrganName = regAuditOrganName;
	}
	public String getRegAuditDeptId() {
		return regAuditDeptId;
	}
	public void setRegAuditDeptId(String regAuditDeptId) {
		this.regAuditDeptId = regAuditDeptId;
	}
	public String getRegAuditDeptName() {
		return regAuditDeptName;
	}
	public void setRegAuditDeptName(String regAuditDeptName) {
		this.regAuditDeptName = regAuditDeptName;
	}
	public String getRegAuditTime() {
		return regAuditTime;
	}
	public void setRegAuditTime(String regAuditTime) {
		this.regAuditTime = regAuditTime;
	}
	public String getInvAcceptPeopleId() {
		return invAcceptPeopleId;
	}
	public void setInvAcceptPeopleId(String invAcceptPeopleId) {
		this.invAcceptPeopleId = invAcceptPeopleId;
	}
	public String getInvAcceptPeopleName() {
		return invAcceptPeopleName;
	}
	public void setInvAcceptPeopleName(String invAcceptPeopleName) {
		this.invAcceptPeopleName = invAcceptPeopleName;
	}
	public String getInvAcceptDealPeople() {
		return invAcceptDealPeople;
	}
	public void setInvAcceptDealPeople(String invAcceptDealPeople) {
		this.invAcceptDealPeople = invAcceptDealPeople;
	}
	public String getInvAcceptOpinionId() {
		return invAcceptOpinionId;
	}
	public void setInvAcceptOpinionId(String invAcceptOpinionId) {
		this.invAcceptOpinionId = invAcceptOpinionId;
	}
	public String getInvAcceptOpinion() {
		return invAcceptOpinion;
	}
	public void setInvAcceptOpinion(String invAcceptOpinion) {
		this.invAcceptOpinion = invAcceptOpinion;
	}
	public String getInvAcceptOrganId() {
		return invAcceptOrganId;
	}
	public void setInvAcceptOrganId(String invAcceptOrganId) {
		this.invAcceptOrganId = invAcceptOrganId;
	}
	public String getInvAcceptOrganName() {
		return invAcceptOrganName;
	}
	public void setInvAcceptOrganName(String invAcceptOrganName) {
		this.invAcceptOrganName = invAcceptOrganName;
	}
	public String getInvAcceptDeptId() {
		return invAcceptDeptId;
	}
	public void setInvAcceptDeptId(String invAcceptDeptId) {
		this.invAcceptDeptId = invAcceptDeptId;
	}
	public String getInvAcceptDeptName() {
		return invAcceptDeptName;
	}
	public void setInvAcceptDeptName(String invAcceptDeptName) {
		this.invAcceptDeptName = invAcceptDeptName;
	}
	public String getInvAcceptTime() {
		return invAcceptTime;
	}
	public void setInvAcceptTime(String invAcceptTime) {
		this.invAcceptTime = invAcceptTime;
	}
	public String getInvCheckPeopleId() {
		return invCheckPeopleId;
	}
	public void setInvCheckPeopleId(String invCheckPeopleId) {
		this.invCheckPeopleId = invCheckPeopleId;
	}
	public String getInvCheckPeopleName() {
		return invCheckPeopleName;
	}
	public void setInvCheckPeopleName(String invCheckPeopleName) {
		this.invCheckPeopleName = invCheckPeopleName;
	}
	public String getInvCheckOpinionId() {
		return invCheckOpinionId;
	}
	public void setInvCheckOpinionId(String invCheckOpinionId) {
		this.invCheckOpinionId = invCheckOpinionId;
	}
	public String getInvCheckOpinion() {
		return invCheckOpinion;
	}
	public void setInvCheckOpinion(String invCheckOpinion) {
		this.invCheckOpinion = invCheckOpinion;
	}
	public String getInvCheckOrganId() {
		return invCheckOrganId;
	}
	public void setInvCheckOrganId(String invCheckOrganId) {
		this.invCheckOrganId = invCheckOrganId;
	}
	public String getInvCheckOrganName() {
		return invCheckOrganName;
	}
	public void setInvCheckOrganName(String invCheckOrganName) {
		this.invCheckOrganName = invCheckOrganName;
	}
	public String getInvCheckDeptId() {
		return invCheckDeptId;
	}
	public void setInvCheckDeptId(String invCheckDeptId) {
		this.invCheckDeptId = invCheckDeptId;
	}
	public String getInvCheckDeptName() {
		return invCheckDeptName;
	}
	public void setInvCheckDeptName(String invCheckDeptName) {
		this.invCheckDeptName = invCheckDeptName;
	}
	public String getInvCheckTime() {
		return invCheckTime;
	}
	public void setInvCheckTime(String invCheckTime) {
		this.invCheckTime = invCheckTime;
	}
	public String getInvAuditPeopleId() {
		return invAuditPeopleId;
	}
	public void setInvAuditPeopleId(String invAuditPeopleId) {
		this.invAuditPeopleId = invAuditPeopleId;
	}
	public String getInvAuditPeopleName() {
		return invAuditPeopleName;
	}
	public void setInvAuditPeopleName(String invAuditPeopleName) {
		this.invAuditPeopleName = invAuditPeopleName;
	}
	public String getInvAuditOpinionId() {
		return invAuditOpinionId;
	}
	public void setInvAuditOpinionId(String invAuditOpinionId) {
		this.invAuditOpinionId = invAuditOpinionId;
	}
	public String getInvAuditOpinion() {
		return invAuditOpinion;
	}
	public void setInvAuditOpinion(String invAuditOpinion) {
		this.invAuditOpinion = invAuditOpinion;
	}
	public String getInvAuditOrganId() {
		return invAuditOrganId;
	}
	public void setInvAuditOrganId(String invAuditOrganId) {
		this.invAuditOrganId = invAuditOrganId;
	}
	public String getInvAuditOrganName() {
		return invAuditOrganName;
	}
	public void setInvAuditOrganName(String invAuditOrganName) {
		this.invAuditOrganName = invAuditOrganName;
	}
	public String getInvAuditDeptId() {
		return invAuditDeptId;
	}
	public void setInvAuditDeptId(String invAuditDeptId) {
		this.invAuditDeptId = invAuditDeptId;
	}
	public String getInvAuditDeptName() {
		return invAuditDeptName;
	}
	public void setInvAuditDeptName(String invAuditDeptName) {
		this.invAuditDeptName = invAuditDeptName;
	}
	public String getInvAuditTime() {
		return invAuditTime;
	}
	public void setInvAuditTime(String invAuditTime) {
		this.invAuditTime = invAuditTime;
	}
	public String getPenaltyPeopleId() {
		return penaltyPeopleId;
	}
	public void setPenaltyPeopleId(String penaltyPeopleId) {
		this.penaltyPeopleId = penaltyPeopleId;
	}
	public String getPenaltyPeopleName() {
		return penaltyPeopleName;
	}
	public void setPenaltyPeopleName(String penaltyPeopleName) {
		this.penaltyPeopleName = penaltyPeopleName;
	}
	public String getPenaltyDealPeople() {
		return penaltyDealPeople;
	}
	public void setPenaltyDealPeople(String penaltyDealPeople) {
		this.penaltyDealPeople = penaltyDealPeople;
	}
	public String getPenaltyOpinionId() {
		return penaltyOpinionId;
	}
	public void setPenaltyOpinionId(String penaltyOpinionId) {
		this.penaltyOpinionId = penaltyOpinionId;
	}
	public String getPenaltyOpinion() {
		return penaltyOpinion;
	}
	public void setPenaltyOpinion(String penaltyOpinion) {
		this.penaltyOpinion = penaltyOpinion;
	}
	public String getPenaltyOrganId() {
		return penaltyOrganId;
	}
	public void setPenaltyOrganId(String penaltyOrganId) {
		this.penaltyOrganId = penaltyOrganId;
	}
	public String getPenaltyOrganName() {
		return penaltyOrganName;
	}
	public void setPenaltyOrganName(String penaltyOrganName) {
		this.penaltyOrganName = penaltyOrganName;
	}
	public String getPenaltyDeptId() {
		return penaltyDeptId;
	}
	public void setPenaltyDeptId(String penaltyDeptId) {
		this.penaltyDeptId = penaltyDeptId;
	}
	public String getPenaltyDeptName() {
		return penaltyDeptName;
	}
	public void setPenaltyDeptName(String penaltyDeptName) {
		this.penaltyDeptName = penaltyDeptName;
	}
	public String getPenaltyTime() {
		return penaltyTime;
	}
	public void setPenaltyTime(String penaltyTime) {
		this.penaltyTime = penaltyTime;
	}
	public String getPenaltyCheckPeopleId() {
		return penaltyCheckPeopleId;
	}
	public void setPenaltyCheckPeopleId(String penaltyCheckPeopleId) {
		this.penaltyCheckPeopleId = penaltyCheckPeopleId;
	}
	public String getPenaltyCheckPeopleName() {
		return penaltyCheckPeopleName;
	}
	public void setPenaltyCheckPeopleName(String penaltyCheckPeopleName) {
		this.penaltyCheckPeopleName = penaltyCheckPeopleName;
	}
	public String getPenaltyCheckOpinionId() {
		return penaltyCheckOpinionId;
	}
	public void setPenaltyCheckOpinionId(String penaltyCheckOpinionId) {
		this.penaltyCheckOpinionId = penaltyCheckOpinionId;
	}
	public String getPenaltyCheckOpinion() {
		return penaltyCheckOpinion;
	}
	public void setPenaltyCheckOpinion(String penaltyCheckOpinion) {
		this.penaltyCheckOpinion = penaltyCheckOpinion;
	}
	public String getPenaltyCheckOrganId() {
		return penaltyCheckOrganId;
	}
	public void setPenaltyCheckOrganId(String penaltyCheckOrganId) {
		this.penaltyCheckOrganId = penaltyCheckOrganId;
	}
	public String getPenaltyCheckOrganName() {
		return penaltyCheckOrganName;
	}
	public void setPenaltyCheckOrganName(String penaltyCheckOrganName) {
		this.penaltyCheckOrganName = penaltyCheckOrganName;
	}
	public String getPenaltyCheckDeptId() {
		return penaltyCheckDeptId;
	}
	public void setPenaltyCheckDeptId(String penaltyCheckDeptId) {
		this.penaltyCheckDeptId = penaltyCheckDeptId;
	}
	public String getPenaltyCheckDeptName() {
		return penaltyCheckDeptName;
	}
	public void setPenaltyCheckDeptName(String penaltyCheckDeptName) {
		this.penaltyCheckDeptName = penaltyCheckDeptName;
	}
	public String getPenaltyCheckTime() {
		return penaltyCheckTime;
	}
	public void setPenaltyCheckTime(String penaltyCheckTime) {
		this.penaltyCheckTime = penaltyCheckTime;
	}
	public String getPenaltyAuditPeopleId() {
		return penaltyAuditPeopleId;
	}
	public void setPenaltyAuditPeopleId(String penaltyAuditPeopleId) {
		this.penaltyAuditPeopleId = penaltyAuditPeopleId;
	}
	public String getPenaltyAuditPeopleName() {
		return penaltyAuditPeopleName;
	}
	public void setPenaltyAuditPeopleName(String penaltyAuditPeopleName) {
		this.penaltyAuditPeopleName = penaltyAuditPeopleName;
	}
	public String getPenaltyAuditOpinionId() {
		return penaltyAuditOpinionId;
	}
	public void setPenaltyAuditOpinionId(String penaltyAuditOpinionId) {
		this.penaltyAuditOpinionId = penaltyAuditOpinionId;
	}
	public String getPenaltyAuditOpinion() {
		return penaltyAuditOpinion;
	}
	public void setPenaltyAuditOpinion(String penaltyAuditOpinion) {
		this.penaltyAuditOpinion = penaltyAuditOpinion;
	}
	public String getPenaltyAuditOrganId() {
		return penaltyAuditOrganId;
	}
	public void setPenaltyAuditOrganId(String penaltyAuditOrganId) {
		this.penaltyAuditOrganId = penaltyAuditOrganId;
	}
	public String getPenaltyAuditOrganName() {
		return penaltyAuditOrganName;
	}
	public void setPenaltyAuditOrganName(String penaltyAuditOrganName) {
		this.penaltyAuditOrganName = penaltyAuditOrganName;
	}
	public String getPenaltyAuditDeptId() {
		return penaltyAuditDeptId;
	}
	public void setPenaltyAuditDeptId(String penaltyAuditDeptId) {
		this.penaltyAuditDeptId = penaltyAuditDeptId;
	}
	public String getPenaltyAuditDeptName() {
		return penaltyAuditDeptName;
	}
	public void setPenaltyAuditDeptName(String penaltyAuditDeptName) {
		this.penaltyAuditDeptName = penaltyAuditDeptName;
	}
	public String getPenaltyAuditTime() {
		return penaltyAuditTime;
	}
	public void setPenaltyAuditTime(String penaltyAuditTime) {
		this.penaltyAuditTime = penaltyAuditTime;
	}
	public String getFinalPeopleId() {
		return finalPeopleId;
	}
	public void setFinalPeopleId(String finalPeopleId) {
		this.finalPeopleId = finalPeopleId;
	}
	public String getFinalPeopleName() {
		return finalPeopleName;
	}
	public void setFinalPeopleName(String finalPeopleName) {
		this.finalPeopleName = finalPeopleName;
	}
	public String getFinalDealPeople() {
		return finalDealPeople;
	}
	public void setFinalDealPeople(String finalDealPeople) {
		this.finalDealPeople = finalDealPeople;
	}
	public String getFinalOpinionId() {
		return finalOpinionId;
	}
	public void setFinalOpinionId(String finalOpinionId) {
		this.finalOpinionId = finalOpinionId;
	}
	public String getFinalOpinion() {
		return finalOpinion;
	}
	public void setFinalOpinion(String finalOpinion) {
		this.finalOpinion = finalOpinion;
	}
	public String getFinalOrganId() {
		return finalOrganId;
	}
	public void setFinalOrganId(String finalOrganId) {
		this.finalOrganId = finalOrganId;
	}
	public String getFinalOrganName() {
		return finalOrganName;
	}
	public void setFinalOrganName(String finalOrganName) {
		this.finalOrganName = finalOrganName;
	}
	public String getFinalDeptId() {
		return finalDeptId;
	}
	public void setFinalDeptId(String finalDeptId) {
		this.finalDeptId = finalDeptId;
	}
	public String getFinalDeptName() {
		return finalDeptName;
	}
	public void setFinalDeptName(String finalDeptName) {
		this.finalDeptName = finalDeptName;
	}
	public String getFinalTime() {
		return finalTime;
	}
	public void setFinalTime(String finalTime) {
		this.finalTime = finalTime;
	}
	public String getFinalCheckPeopleId() {
		return finalCheckPeopleId;
	}
	public void setFinalCheckPeopleId(String finalCheckPeopleId) {
		this.finalCheckPeopleId = finalCheckPeopleId;
	}
	public String getFinalCheckPeopleName() {
		return finalCheckPeopleName;
	}
	public void setFinalCheckPeopleName(String finalCheckPeopleName) {
		this.finalCheckPeopleName = finalCheckPeopleName;
	}
	public String getFinalCheckOpinionId() {
		return finalCheckOpinionId;
	}
	public void setFinalCheckOpinionId(String finalCheckOpinionId) {
		this.finalCheckOpinionId = finalCheckOpinionId;
	}
	public String getFinalCheckOpinion() {
		return finalCheckOpinion;
	}
	public void setFinalCheckOpinion(String finalCheckOpinion) {
		this.finalCheckOpinion = finalCheckOpinion;
	}
	public String getFinalCheckOrganId() {
		return finalCheckOrganId;
	}
	public void setFinalCheckOrganId(String finalCheckOrganId) {
		this.finalCheckOrganId = finalCheckOrganId;
	}
	public String getFinalCheckOrganName() {
		return finalCheckOrganName;
	}
	public void setFinalCheckOrganName(String finalCheckOrganName) {
		this.finalCheckOrganName = finalCheckOrganName;
	}
	public String getFinalCheckDeptId() {
		return finalCheckDeptId;
	}
	public void setFinalCheckDeptId(String finalCheckDeptId) {
		this.finalCheckDeptId = finalCheckDeptId;
	}
	public String getFinalCheckDeptName() {
		return finalCheckDeptName;
	}
	public void setFinalCheckDeptName(String finalCheckDeptName) {
		this.finalCheckDeptName = finalCheckDeptName;
	}
	public String getFinalCheckTime() {
		return finalCheckTime;
	}
	public void setFinalCheckTime(String finalCheckTime) {
		this.finalCheckTime = finalCheckTime;
	}
	public String getFinalAuditPeopleId() {
		return finalAuditPeopleId;
	}
	public void setFinalAuditPeopleId(String finalAuditPeopleId) {
		this.finalAuditPeopleId = finalAuditPeopleId;
	}
	public String getFinalAuditPeopleName() {
		return finalAuditPeopleName;
	}
	public void setFinalAuditPeopleName(String finalAuditPeopleName) {
		this.finalAuditPeopleName = finalAuditPeopleName;
	}
	public String getFinalAuditOpinionId() {
		return finalAuditOpinionId;
	}
	public void setFinalAuditOpinionId(String finalAuditOpinionId) {
		this.finalAuditOpinionId = finalAuditOpinionId;
	}
	public String getFinalAuditOpinion() {
		return finalAuditOpinion;
	}
	public void setFinalAuditOpinion(String finalAuditOpinion) {
		this.finalAuditOpinion = finalAuditOpinion;
	}
	public String getFinalAuditOrganId() {
		return finalAuditOrganId;
	}
	public void setFinalAuditOrganId(String finalAuditOrganId) {
		this.finalAuditOrganId = finalAuditOrganId;
	}
	public String getFinalAuditOrganName() {
		return finalAuditOrganName;
	}
	public void setFinalAuditOrganName(String finalAuditOrganName) {
		this.finalAuditOrganName = finalAuditOrganName;
	}
	public String getFinalAuditDeptId() {
		return finalAuditDeptId;
	}
	public void setFinalAuditDeptId(String finalAuditDeptId) {
		this.finalAuditDeptId = finalAuditDeptId;
	}
	public String getFinalAuditDeptName() {
		return finalAuditDeptName;
	}
	public void setFinalAuditDeptName(String finalAuditDeptName) {
		this.finalAuditDeptName = finalAuditDeptName;
	}
	public String getFinalAuditTime() {
		return finalAuditTime;
	}
	public void setFinalAuditTime(String finalAuditTime) {
		this.finalAuditTime = finalAuditTime;
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
	public List<SomRestrictPeopleDetail> getSomRestrictPeopleDetailList() {
		return somRestrictPeopleDetailList;
	}
	public void setSomRestrictPeopleDetailList(
			List<SomRestrictPeopleDetail> somRestrictPeopleDetailList) {
		this.somRestrictPeopleDetailList = somRestrictPeopleDetailList;
	}
}