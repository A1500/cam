package com.inspur.cams.bpt.base.data;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

@Table(tableName = "BPT_DECISION_LETTER" , keyFields = "applyId")
public class BptDecisionLetter extends StatefulDatabean {
	
	/**
	 * 申请id
	 */
	@Rule(value="require")
	@Column(name = "APPLY_ID")
	private String applyId;
	
	/**
	 * 人员Id
	 */
	@Rule(value="require")
	@Column(name = "PEOPLE_ID")
	private String peopleId;
	
	/**
	 * 业务类型
	 */
	
	@Column(name = "SERVICE_TYPE")
	private String serviceType;
	
	/**
	 * 不符合情形
	 */
	@Rule(value="require")
	@Column(name = "NO_FIT")
	private String noFit;
	
	/**
	 * 依据
	 */
	@Rule(value="require")
	@Column(name = "FOUNDATION")
	private String foundation;
	
	/**
	 * 条款
	 */
	@Column(name = "CLAUSE")
	private String clause;
	
	/**
	 * 出具部门Id
	 */
	
	@Column(name = "ORGAN_ID")
	private String organId;
	
	/**
	 * 出具日期
	 */
	@Rule(value="require")
	@Column(name = "DECISION_DATE")
	private String decisionDate;

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

	public String getServiceType() {
		return serviceType;
	}

	public void setServiceType(String serviceType) {
		this.serviceType = serviceType;
	}

	public String getNoFit() {
		return noFit;
	}

	public void setNoFit(String noFit) {
		this.noFit = noFit;
	}

	public String getFoundation() {
		return foundation;
	}

	public void setFoundation(String foundation) {
		this.foundation = foundation;
	}

	public String getClause() {
		return clause;
	}

	public void setClause(String clause) {
		this.clause = clause;
	}

	public String getOrganId() {
		return organId;
	}

	public void setOrganId(String organId) {
		this.organId = organId;
	}

	public String getDecisionDate() {
		return decisionDate;
	}

	public void setDecisionDate(String decisionDate) {
		this.decisionDate = decisionDate;
	}
	
	
}
