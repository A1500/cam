package com.inspur.cams.bpt.base.data;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:BptApplyHistory
 * @description:审批记录历史
 * @author zhanghui
 * 
 */
@Table(tableName = "BPT_COMFORT_NO", keyFields = "domicileCode")
public class BptComfortNo extends StatefulDatabean {

	// 区划代码
	@Rule(value = "require")
	@Column(name = "DOMICILE_CODE")
	private String domicileCode;

	// 参战证号
	@Column(name = "WAR_NO")
	private String warNo;

	// 参试证号
	@Column(name = "TEST_NO")
	private String testNo;

	// 烈属证号
	@Column(name = "REVOLUTION_NO")
	private String revolutionNo;

	// 带病回乡证号
	@Column(name = "DEMOBILIZED_ILLNESS_NO")
	private String demobilizedIllnessNo;

	// 因公遗属证号
	@Column(name = "DUTY_NO")
	private String dutyNo;

	// 病故遗属证号
	@Column(name = "DECEASE_NO")
	private String deceaseNo;
	
	// 在乡证号
	@Column(name = "DEMOBILIZED_NO")
	private String demobilizedNo;

	public String getDomicileCode() {
		return domicileCode;
	}

	public void setDomicileCode(String domicileCode) {
		this.domicileCode = domicileCode;
	}

	public String getWarNo() {
		return warNo;
	}

	public void setWarNo(String warNo) {
		this.warNo = warNo;
	}

	public String getTestNo() {
		return testNo;
	}

	public void setTestNo(String testNo) {
		this.testNo = testNo;
	}

	public String getRevolutionNo() {
		return revolutionNo;
	}

	public void setRevolutionNo(String revolutionNo) {
		this.revolutionNo = revolutionNo;
	}

	public String getDemobilizedIllnessNo() {
		return demobilizedIllnessNo;
	}

	public void setDemobilizedIllnessNo(String demobilizedIllnessNo) {
		this.demobilizedIllnessNo = demobilizedIllnessNo;
	}

	public String getDutyNo() {
		return dutyNo;
	}

	public void setDutyNo(String dutyNo) {
		this.dutyNo = dutyNo;
	}

	public String getDeceaseNo() {
		return deceaseNo;
	}

	public void setDeceaseNo(String deceaseNo) {
		this.deceaseNo = deceaseNo;
	}

	public String getDemobilizedNo() {
		return demobilizedNo;
	}

	public void setDemobilizedNo(String demobilizedNo) {
		this.demobilizedNo = demobilizedNo;
	}

}