package com.inspur.cams.drel.sam.data;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:社会保险databean
 * @description:
 * @author:
 * @since:2012-05-03
 * @version:1.0
 */
@Table(tableName = "SAM_PEOPLE_INSURANCE", keyFields = "insuranceId")
public class SamPeopleInsurance extends StatefulDatabean {
	// 社会保险ID
	@Column(name = "INSURANCE_ID")
	private String insuranceId;
	// 人员ID
	@Column(name = "PEOPLE_ID")
	private String peopleId;
	// 社保证号
	@Column(name = "INSURANCE_NUMBER")
	private String insuranceNumber;
	// 险种类型
	@Column(name = "INSURANCE_TYPE")
	private String insuranceType;
	// 缴纳保险费
	@Column(name = "INSURANCE_FEE")
	private String insuranceFee;
	// 缴费周期
	@Column(name = "INSURANCE_CYCLE")
	private String insuranceCycle;
	// 备注
	@Column(name = "REMARKS")
	private String remarks;
	public String getInsuranceId() {
		return insuranceId;
	}
	public void setInsuranceId(String insuranceId) {
		this.insuranceId = insuranceId;
	}
	public String getPeopleId() {
		return peopleId;
	}
	public void setPeopleId(String peopleId) {
		this.peopleId = peopleId;
	}
	public String getInsuranceNumber() {
		return insuranceNumber;
	}
	public void setInsuranceNumber(String insuranceNumber) {
		this.insuranceNumber = insuranceNumber;
	}
	public String getInsuranceType() {
		return insuranceType;
	}
	public void setInsuranceType(String insuranceType) {
		this.insuranceType = insuranceType;
	}
	public String getInsuranceFee() {
		return insuranceFee;
	}
	public void setInsuranceFee(String insuranceFee) {
		this.insuranceFee = insuranceFee;
	}
	public String getInsuranceCycle() {
		return insuranceCycle;
	}
	public void setInsuranceCycle(String insuranceCycle) {
		this.insuranceCycle = insuranceCycle;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
}