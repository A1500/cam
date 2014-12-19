package com.inspur.cams.drel.application.cityLow.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 低收入家庭认定业务表databean
 * @author 
 * @date 2014-03-11
 */
@Table(tableName = "SAM_LOW_APPLY_INFO", keyFields = "lowApplyId")
public class SamLowApplyInfo extends StatefulDatabean {

	// 业务ID
	private String lowApplyId;

	// 家庭编号
	private String familyId;

	// 户主姓名
	private String familyName;

	// 身份证件类型
	private String familyCardType;

	// 身份证号
	private String familyCardNo;

	// 申请理由
	private String applyNote;
	
	// 申请人姓名
	private String applyName;
	
	// 申请日期
	private String applyDate;

	// 乡镇（街道）政府初审意见
	private String townOpinion;

	// 初审负责人
	private String townPeople;

	// 初审日期
	private String townDate;

	// 县(市)区住房保障部门审核意见
	private String houseCheckOpinion;

	// 住房审核负责人
	private String houseCheckPeople;

	// 住房审核时间
	private String houseCheckDate;

	// 县(市)区民政部门家庭收入核定意见
	private String incomeAppraiseOpinion;

	// 收入核定负责人
	private String incomeAppraisePeople;

	// 县(市)区住房保障部门审批意见
	private String houseApproveOpinion;

	// 收入核定日期
	private String incomeAppraiseDate;

	// 住房审批负责人
	private String houseApprovePeople;

	// 住房审批日期
	private String houseApproveDate;

	/**
	 * 获取 业务ID
	 * @return String
	 */
	public String getLowApplyId() {
		return lowApplyId;
	}

	/**
	 * 设置 业务ID
	 */
	public void setLowApplyId(String lowApplyId) {
		this.lowApplyId = lowApplyId;
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
	 * 获取 户主姓名
	 * @return String
	 */
	public String getFamilyName() {
		return familyName;
	}

	/**
	 * 设置 户主姓名
	 */
	public void setFamilyName(String familyName) {
		this.familyName = familyName;
	}

	/**
	 * 获取 身份证件类型
	 * @return String
	 */
	public String getFamilyCardType() {
		return familyCardType;
	}

	/**
	 * 设置 身份证件类型
	 */
	public void setFamilyCardType(String familyCardType) {
		this.familyCardType = familyCardType;
	}

	/**
	 * 获取 身份证号
	 * @return String
	 */
	public String getFamilyCardNo() {
		return familyCardNo;
	}

	/**
	 * 设置 身份证号
	 */
	public void setFamilyCardNo(String familyCardNo) {
		this.familyCardNo = familyCardNo;
	}

	/**
	 * 获取 申请理由
	 * @return String
	 */
	public String getApplyNote() {
		return applyNote;
	}

	/**
	 * 设置 申请理由
	 */
	public void setApplyNote(String applyNote) {
		this.applyNote = applyNote;
	}

	/**
	 * 获取 申请日期
	 * @return String
	 */
	public String getApplyDate() {
		return applyDate;
	}

	/**
	 * 设置 申请日期
	 */
	public void setApplyDate(String applyDate) {
		this.applyDate = applyDate;
	}

	/**
	 * 获取 乡镇（街道）政府初审意见
	 * @return String
	 */
	public String getTownOpinion() {
		return townOpinion;
	}

	/**
	 * 设置 乡镇（街道）政府初审意见
	 */
	public void setTownOpinion(String townOpinion) {
		this.townOpinion = townOpinion;
	}

	/**
	 * 获取 初审负责人
	 * @return String
	 */
	public String getTownPeople() {
		return townPeople;
	}

	/**
	 * 设置 初审负责人
	 */
	public void setTownPeople(String townPeople) {
		this.townPeople = townPeople;
	}

	/**
	 * 获取 初审日期
	 * @return String
	 */
	public String getTownDate() {
		return townDate;
	}

	/**
	 * 设置 初审日期
	 */
	public void setTownDate(String townDate) {
		this.townDate = townDate;
	}

	/**
	 * 获取 县(市)区住房保障部门审核意见
	 * @return String
	 */
	public String getHouseCheckOpinion() {
		return houseCheckOpinion;
	}

	/**
	 * 设置 县(市)区住房保障部门审核意见
	 */
	public void setHouseCheckOpinion(String houseCheckOpinion) {
		this.houseCheckOpinion = houseCheckOpinion;
	}

	/**
	 * 获取 住房审核负责人
	 * @return String
	 */
	public String getHouseCheckPeople() {
		return houseCheckPeople;
	}

	/**
	 * 设置 住房审核负责人
	 */
	public void setHouseCheckPeople(String houseCheckPeople) {
		this.houseCheckPeople = houseCheckPeople;
	}

	/**
	 * 获取 住房审核时间
	 * @return String
	 */
	public String getHouseCheckDate() {
		return houseCheckDate;
	}

	/**
	 * 设置 住房审核时间
	 */
	public void setHouseCheckDate(String houseCheckDate) {
		this.houseCheckDate = houseCheckDate;
	}

	/**
	 * 获取 县(市)区民政部门家庭收入核定意见
	 * @return String
	 */
	public String getIncomeAppraiseOpinion() {
		return incomeAppraiseOpinion;
	}

	/**
	 * 设置 县(市)区民政部门家庭收入核定意见
	 */
	public void setIncomeAppraiseOpinion(String incomeAppraiseOpinion) {
		this.incomeAppraiseOpinion = incomeAppraiseOpinion;
	}

	/**
	 * 获取 收入核定负责人
	 * @return String
	 */
	public String getIncomeAppraisePeople() {
		return incomeAppraisePeople;
	}

	/**
	 * 设置 收入核定负责人
	 */
	public void setIncomeAppraisePeople(String incomeAppraisePeople) {
		this.incomeAppraisePeople = incomeAppraisePeople;
	}

	/**
	 * 获取 县(市)区住房保障部门审批意见
	 * @return String
	 */
	public String getHouseApproveOpinion() {
		return houseApproveOpinion;
	}

	/**
	 * 设置 县(市)区住房保障部门审批意见
	 */
	public void setHouseApproveOpinion(String houseApproveOpinion) {
		this.houseApproveOpinion = houseApproveOpinion;
	}

	/**
	 * 获取 收入核定日期
	 * @return String
	 */
	public String getIncomeAppraiseDate() {
		return incomeAppraiseDate;
	}

	/**
	 * 设置 收入核定日期
	 */
	public void setIncomeAppraiseDate(String incomeAppraiseDate) {
		this.incomeAppraiseDate = incomeAppraiseDate;
	}

	/**
	 * 获取 住房审批负责人
	 * @return String
	 */
	public String getHouseApprovePeople() {
		return houseApprovePeople;
	}

	/**
	 * 设置 住房审批负责人
	 */
	public void setHouseApprovePeople(String houseApprovePeople) {
		this.houseApprovePeople = houseApprovePeople;
	}

	/**
	 * 获取 住房审批日期
	 * @return String
	 */
	public String getHouseApproveDate() {
		return houseApproveDate;
	}

	/**
	 * 设置 住房审批日期
	 */
	public void setHouseApproveDate(String houseApproveDate) {
		this.houseApproveDate = houseApproveDate;
	}

	public String getApplyName() {
		return applyName;
	}

	public void setApplyName(String applyName) {
		this.applyName = applyName;
	}

}