package com.inspur.cams.drel.application.cityLow.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * 低收入家庭赡养、扶养、义务人情况databean
 * @author 
 * @date 2014-03-11
 */
@Table(tableName = "SAM_LOW_SUPPORT_PEOPLE", keyFields = "supportId")
public class SamLowSupportPeople extends StatefulDatabean {

	// 赡扶义务人内码
	private String supportId;

	// 家庭编号
	private String familyId;

	// 姓名
 	@Rule(value="require")
	private String supportName;

	// 身份证件类型
 	@Rule(value="require")
	private String supportCardType;

	// 身份证号
 	@Rule(value="require")
	private String supportCardNo;

	// 人员类型
 	
	private String supportType;

	// 与户主关系
 	@Rule(value="require")
	private String releationType;

	// 家庭人口数
 	@Rule(value="require")
	private String supportFamilyNum;

	// 职业状况
 	@Rule(value="require")
	private String occupationCondition;

	// 月总收入
 	@Rule(value="require")
	private BigDecimal monthIncome;

	// 月人均收入
 	@Rule(value="number")
	private BigDecimal monthAveIncome;

	/**
	 * 获取 赡扶义务人内码
	 * @return String
	 */
	public String getSupportId() {
		return supportId;
	}

	/**
	 * 设置 赡扶义务人内码
	 */
	public void setSupportId(String supportId) {
		this.supportId = supportId;
	}

	/**
	 * 获取 家庭编号
	 * @return String
	 */
	public String getFamilyId() {
		return familyId;
	}

	/**
	 * 设置 家庭编号
	 */
	public void setFamilyId(String familyId) {
		this.familyId = familyId;
	}

	/**
	 * 获取 姓名
	 * @return String
	 */
	public String getSupportName() {
		return supportName;
	}

	/**
	 * 设置 姓名
	 */
	public void setSupportName(String supportName) {
		this.supportName = supportName;
	}

	/**
	 * 获取 身份证件类型
	 * @return String
	 */
	public String getSupportCardType() {
		return supportCardType;
	}

	/**
	 * 设置 身份证件类型
	 */
	public void setSupportCardType(String supportCardType) {
		this.supportCardType = supportCardType;
	}

	/**
	 * 获取 身份证号
	 * @return String
	 */
	public String getSupportCardNo() {
		return supportCardNo;
	}

	/**
	 * 设置 身份证号
	 */
	public void setSupportCardNo(String supportCardNo) {
		this.supportCardNo = supportCardNo;
	}

	/**
	 * 获取 人员类型
	 * @return String
	 */
	public String getSupportType() {
		return supportType;
	}

	/**
	 * 设置 人员类型
	 */
	public void setSupportType(String supportType) {
		this.supportType = supportType;
	}

	/**
	 * 获取 与户主关系
	 * @return String
	 */
	public String getReleationType() {
		return releationType;
	}

	/**
	 * 设置 与户主关系
	 */
	public void setReleationType(String releationType) {
		this.releationType = releationType;
	}

	/**
	 * 获取 家庭人口数
	 * @return String
	 */
	public String getSupportFamilyNum() {
		return supportFamilyNum;
	}

	/**
	 * 设置 家庭人口数
	 */
	public void setSupportFamilyNum(String supportFamilyNum) {
		this.supportFamilyNum = supportFamilyNum;
	}

	/**
	 * 获取 职业状况
	 * @return String
	 */
	public String getOccupationCondition() {
		return occupationCondition;
	}

	/**
	 * 设置 职业状况
	 */
	public void setOccupationCondition(String occupationCondition) {
		this.occupationCondition = occupationCondition;
	}

	/**
	 * 获取 月总收入
	 * @return BigDecimal
	 */
	public BigDecimal getMonthIncome() {
		return monthIncome;
	}

	/**
	 * 设置 月总收入
	 */
	public void setMonthIncome(BigDecimal monthIncome) {
		this.monthIncome = monthIncome;
	}

	/**
	 * 获取 月人均收入
	 * @return BigDecimal
	 */
	public BigDecimal getMonthAveIncome() {
		return monthAveIncome;
	}

	/**
	 * 设置 月人均收入
	 */
	public void setMonthAveIncome(BigDecimal monthAveIncome) {
		this.monthAveIncome = monthAveIncome;
	}

}