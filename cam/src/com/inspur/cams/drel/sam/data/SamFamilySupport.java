package com.inspur.cams.drel.sam.data;

import java.math.BigDecimal;

import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 赡扶抚养人
 * @author yanliangliang
 *2012年5月2日9:38:52
 */
@Table(tableName = "SAM_FAMILY_SUPPORT" , keyFields = "supportId")
public class SamFamilySupport extends StatefulDatabean  {
	//赡扶抚养ID
	private String supportId;
	//家庭ID
	private String familyId;
	//姓名
	private String name;
	//性别
	private String sex;
	//身份号码
	private String idCard;
	//职务
	private String position;
	//工作单位
	private String unitName;
	//家庭人口
	private BigDecimal peopleNum;
	//家庭月人均收入
	private BigDecimal monthIncome;
	//赡抚养费用
	private BigDecimal supportedPay;
	//被赡抚养人
	private String supportedPeople;
	//赡抚养关系
	private String relation;
	//赡抚养人数
	private BigDecimal supportedNum;
	//无法赡抚养原因
	private String noSupportReason;
	//备注
	private String remarks;
	public String getSupportId() {
		return supportId;
	}
	public void setSupportId(String supportId) {
		this.supportId = supportId;
	}
	public String getFamilyId() {
		return familyId;
	}
	public void setFamilyId(String familyId) {
		this.familyId = familyId;
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
	public String getIdCard() {
		return idCard;
	}
	public void setIdCard(String idCard) {
		this.idCard = idCard;
	}
	public BigDecimal getPeopleNum() {
		return peopleNum;
	}
	public void setPeopleNum(BigDecimal peopleNum) {
		this.peopleNum = peopleNum;
	}
	public BigDecimal getMonthIncome() {
		return monthIncome;
	}
	public void setMonthIncome(BigDecimal monthIncome) {
		this.monthIncome = monthIncome;
	}
	public BigDecimal getSupportedPay() {
		return supportedPay;
	}
	public void setSupportedPay(BigDecimal supportedPay) {
		this.supportedPay = supportedPay;
	}
	public String getSupportedPeople() {
		return supportedPeople;
	}
	public void setSupportedPeople(String supportedPeople) {
		this.supportedPeople = supportedPeople;
	}
	public String getRelation() {
		return relation;
	}
	public void setRelation(String relation) {
		this.relation = relation;
	}
	public BigDecimal getSupportedNum() {
		return supportedNum;
	}
	public void setSupportedNum(BigDecimal supportedNum) {
		this.supportedNum = supportedNum;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	public String getPosition() {
		return position;
	}
	public void setPosition(String position) {
		this.position = position;
	}
	public String getUnitName() {
		return unitName;
	}
	public void setUnitName(String unitName) {
		this.unitName = unitName;
	}
	public String getNoSupportReason() {
		return noSupportReason;
	}
	public void setNoSupportReason(String noSupportReason) {
		this.noSupportReason = noSupportReason;
	}
	
	
	
	
	
}
