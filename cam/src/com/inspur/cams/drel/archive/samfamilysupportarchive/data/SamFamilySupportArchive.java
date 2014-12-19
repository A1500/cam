package com.inspur.cams.drel.archive.samfamilysupportarchive.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 赡扶抚养人databean
 * 
 * @author
 * @date 2012-06-28
 */
@Table(tableName = "SAM_FAMILY_SUPPORT_ARCHIVE", keyFields = "supportArchiveId")
public class SamFamilySupportArchive extends StatefulDatabean {
	// 赡扶抚养归档ID
	private String supportArchiveId;
	// 赡扶抚养ID
	private String supportId;
	// 家庭归档id
	private String familyArchiveId;
	// 家庭ID
	private String familyId;
	// 姓名
	private String name;
	// 性别
	private String sex;
	// 身份号码
	private String idCard;
	// 家庭人口
	private BigDecimal peopleNum;
	// 家庭月人均收入
	private BigDecimal monthIncome;
	// 被赡抚养人
	private String supportedPeople;
	// 赡抚养关系
	private String relation;
	// 赡抚养费用
	private BigDecimal supportedPay;
	// 赡抚养人数
	private BigDecimal supportedNum;
	// 备注
	private String remarks;
	// 申请id
	private String applyId;
	// 职务
	private String position;
	// 工作单位
	private String unitName;
	// 无法赡抚养原因
	private String noSupportReason;

	/**
	 * 获取 赡扶抚养归档ID
	 * 
	 * @return String
	 */
	public String getSupportArchiveId() {
		return supportArchiveId;
	}

	/**
	 * 设置 赡扶抚养归档ID
	 */
	public void setSupportArchiveId(String supportArchiveId) {
		this.supportArchiveId = supportArchiveId;
	}

	/**
	 * 获取 赡扶抚养ID
	 * 
	 * @return String
	 */
	public String getSupportId() {
		return supportId;
	}

	/**
	 * 设置 赡扶抚养ID
	 */
	public void setSupportId(String supportId) {
		this.supportId = supportId;
	}

	/**
	 * 获取 姓名
	 * 
	 * @return String
	 */
	public String getName() {
		return name;
	}

	/**
	 * 设置 姓名
	 */
	public void setName(String name) {
		this.name = name;
	}

	/**
	 * 获取 性别
	 * 
	 * @return String
	 */
	public String getSex() {
		return sex;
	}

	/**
	 * 设置 性别
	 */
	public void setSex(String sex) {
		this.sex = sex;
	}

	/**
	 * 获取 身份号码
	 * 
	 * @return String
	 */
	public String getIdCard() {
		return idCard;
	}

	/**
	 * 设置 身份号码
	 */
	public void setIdCard(String idCard) {
		this.idCard = idCard;
	}

	/**
	 * 获取 家庭人口
	 * 
	 * @return BigDecimal
	 */
	public BigDecimal getPeopleNum() {
		return peopleNum;
	}

	/**
	 * 设置 家庭人口
	 */
	public void setPeopleNum(BigDecimal peopleNum) {
		this.peopleNum = peopleNum;
	}

	/**
	 * 获取 家庭月人均收入
	 * 
	 * @return BigDecimal
	 */
	public BigDecimal getMonthIncome() {
		return monthIncome;
	}

	/**
	 * 设置 家庭月人均收入
	 */
	public void setMonthIncome(BigDecimal monthIncome) {
		this.monthIncome = monthIncome;
	}

	/**
	 * 获取 被赡抚养人
	 * 
	 * @return String
	 */
	public String getSupportedPeople() {
		return supportedPeople;
	}

	/**
	 * 设置 被赡抚养人
	 */
	public void setSupportedPeople(String supportedPeople) {
		this.supportedPeople = supportedPeople;
	}

	/**
	 * 获取 赡抚养关系
	 * 
	 * @return String
	 */
	public String getRelation() {
		return relation;
	}

	/**
	 * 设置 赡抚养关系
	 */
	public void setRelation(String relation) {
		this.relation = relation;
	}

	/**
	 * 获取 赡抚养费用
	 * 
	 * @return BigDecimal
	 */
	public BigDecimal getSupportedPay() {
		return supportedPay;
	}

	/**
	 * 设置 赡抚养费用
	 */
	public void setSupportedPay(BigDecimal supportedPay) {
		this.supportedPay = supportedPay;
	}

	/**
	 * 获取 赡抚养人数
	 * 
	 * @return BigDecimal
	 */
	public BigDecimal getSupportedNum() {
		return supportedNum;
	}

	/**
	 * 设置 赡抚养人数
	 */
	public void setSupportedNum(BigDecimal supportedNum) {
		this.supportedNum = supportedNum;
	}

	/**
	 * 获取 备注
	 * 
	 * @return String
	 */
	public String getRemarks() {
		return remarks;
	}

	/**
	 * 设置 备注
	 */
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public String getFamilyArchiveId() {
		return familyArchiveId;
	}

	public void setFamilyArchiveId(String familyArchiveId) {
		this.familyArchiveId = familyArchiveId;
	}

	public String getFamilyId() {
		return familyId;
	}

	public void setFamilyId(String familyId) {
		this.familyId = familyId;
	}

	public String getApplyId() {
		return applyId;
	}

	public void setApplyId(String applyId) {
		this.applyId = applyId;
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