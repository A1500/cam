package com.inspur.cams.drel.sam.data;

import java.math.BigDecimal;

import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:待遇调整记录
 * @description:
 * @author:zhangjian
 * @since:2012-06-06
 * @version:1.0
 */
@Table(tableName = "SAM_TREATMENT_ADJUST", keyFields = "treatmentId")
public class SamTreatmentAdjust extends StatefulDatabean {
	// 调整记录ID
	private String adjustId;
	// 家庭救助待遇ID
	private String treatmentId;
	// 调整类型
	private String adjustType;
	// 调整时间
	private String adjustTime;
	// 调整前金额
	private BigDecimal assistanceBeforeMoney;
	// 调整后金额
	private BigDecimal assistanceMoney;
	// 调整对象
	private String adjustTarget;
	// 调整金额
	private BigDecimal adjustMoney;
	// 单位名称
	private String organName;
	// 单位ID
	private String organId;
	// 操作人名称
	private String peopleName;
	// 操作人ID
	private String peopleId;
	
	
	public String getAdjustId() {
		return adjustId;
	}
	public void setAdjustId(String adjustId) {
		this.adjustId = adjustId;
	}
	public String getTreatmentId() {
		return treatmentId;
	}
	public void setTreatmentId(String treatmentId) {
		this.treatmentId = treatmentId;
	}
	public String getAdjustType() {
		return adjustType;
	}
	public void setAdjustType(String adjustType) {
		this.adjustType = adjustType;
	}
	public String getAdjustTime() {
		return adjustTime;
	}
	public void setAdjustTime(String adjustTime) {
		this.adjustTime = adjustTime;
	}
	public BigDecimal getAssistanceBeforeMoney() {
		return assistanceBeforeMoney;
	}
	public void setAssistanceBeforeMoney(BigDecimal assistanceBeforeMoney) {
		this.assistanceBeforeMoney = assistanceBeforeMoney;
	}
	public BigDecimal getAssistanceMoney() {
		return assistanceMoney;
	}
	public void setAssistanceMoney(BigDecimal assistanceMoney) {
		this.assistanceMoney = assistanceMoney;
	}
	public String getAdjustTarget() {
		return adjustTarget;
	}
	public void setAdjustTarget(String adjustTarget) {
		this.adjustTarget = adjustTarget;
	}
	public BigDecimal getAdjustMoney() {
		return adjustMoney;
	}
	public void setAdjustMoney(BigDecimal adjustMoney) {
		this.adjustMoney = adjustMoney;
	}
	public String getOrganName() {
		return organName;
	}
	public void setOrganName(String organName) {
		this.organName = organName;
	}
	public String getOrganId() {
		return organId;
	}
	public void setOrganId(String organId) {
		this.organId = organId;
	}
	public String getPeopleName() {
		return peopleName;
	}
	public void setPeopleName(String peopleName) {
		this.peopleName = peopleName;
	}
	public String getPeopleId() {
		return peopleId;
	}
	public void setPeopleId(String peopleId) {
		this.peopleId = peopleId;
	}
	
	
}