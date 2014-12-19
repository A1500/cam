package com.inspur.cams.cdc.base.data;

import java.math.*;
import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * @title:CdcPeopleReport
 * @description:
 * @author:
 * @since:2012-02-13
 * @version:1.0
 */
@Table(tableName = "CDC_PEOPLE_REPORT", keyFields = "recordId")
public class CdcPeopleReport extends StatefulDatabean {
	
	@Transient
	private List<CdcPeopleInfo> cdcPeopleInfoList = new ArrayList<CdcPeopleInfo>();
	
	// 统计内码
	private String recordId;
	
	// 社区数量
	private BigDecimal communityNum;
	
	// 成员总人数
	private BigDecimal mbPeopleNum;
	
	// 成员女性人数
	private BigDecimal mbFemaleNum;
	
	// 成员30岁以下人数
	private BigDecimal mbThirtyNum;
	
	// 成员40岁以下人数
	private BigDecimal mbFourtyNum;
	
	// 成员50岁以下人数
	private BigDecimal mbFiftyNum;
	
	// 成员50岁以上人数
	private BigDecimal mbSixtyNum;
	
	// 成员少数民族人数
	private BigDecimal mbFolkNum;
	
	// 成员交叉任职人数
	private BigDecimal mbCrossNum;
	
	// 成员党员人数
	private BigDecimal mbPartyNum;
	
	// 成员共青团员人数
	private BigDecimal mbLeagueNum;
	
	// 成员政治面貌其他人数
	private BigDecimal mbOtherNum;
	
	// 成员初中及以下人数
	private BigDecimal mbJuniorNum;
	
	// 成员高中及中专人数
	private BigDecimal mbSeniorNum;
	
	// 成员大学专科人数
	private BigDecimal mbSpecialtyNum;
	
	// 成员大学本科人数
	private BigDecimal mbCollegeNum;
	
	// 成员研究生及以上人数
	private BigDecimal mbGraduateNum;
	
	// 成员参加养老保险人数
	private BigDecimal mbAgedInNum;
	
	// 成员参加医疗保险人数
	private BigDecimal mbMedicalInNum;

	// 成员参加失业保险人数
	private BigDecimal mbUnemployInNum;
	
	// 成员参加工伤保险人数
	private BigDecimal mbInjuryInNum;
	
	// 成员参加生育保险人数
	private BigDecimal mbBirthInNum;

	// 成员参加住房公积金人数
	private BigDecimal mbHousingReNum;
	
	// 成员大学生村官人数
	private BigDecimal mbOfficalNum;
	
	// 成员社工师人数
	private BigDecimal mbWorkerNum;
	
	// 成员人均约补贴收入
	private BigDecimal mbSubsidyAvgMon;
	
	// 工作者总人数
	private BigDecimal wkPeopleNum;
	
	// 工作者女性人数
	private BigDecimal wkFemaleNum;
	
	// 工作者30岁以下人数
	private BigDecimal wkThirtyNum;
	
	// 工作者40岁以下人数
	private BigDecimal wkFourtyNum;
	
	// 工作者50岁以下人数
	private BigDecimal wkFiftyNum;
	
	// 工作者50岁以上人数
	private BigDecimal wkSixtyNum;
	
	// 工作者少数民族人数
	private BigDecimal wkFolkNum;
	
	// 工作者党员人数
	private BigDecimal wkPartyNum;
	
	// 工作者共青团员人数
	private BigDecimal wkLeagueNum;
	
	// 工作者政治面貌其他人数
	private BigDecimal wkOtherNum;
	
	// 工作者初中及以下人数
	private BigDecimal wkJuniorNum;
	
	// 工作者高中及中专人数
	private BigDecimal wkSeniorNum;
	
	// 工作者大学专科人数
	private BigDecimal wkSpecialtyNum;
	
	// 工作者大学本科人数
	private BigDecimal wkCollegeNum;
	
	// 工作者研究生及以上人数
	private BigDecimal wkGraduateNum;
	
	// 工作者公务员人数
	private BigDecimal wkOfficialNum;
	
	// 工作者事业编人数
	private BigDecimal wkEnterpriseNum;
	
	// 工作者招聘人员数
	private BigDecimal wkRequiredNum;
	
	// 工作者企业职工人数
	private BigDecimal wkCorporationNum;
	
	// 工作者社区居民人数
	private BigDecimal wkResideNum;
	
	// 工作者身份其他人数
	private BigDecimal wkProOtherNum;
	
	// 工作者参加养老保险人数
	private BigDecimal wkAgedInNum;
	
	// 工作者参加医疗保险人数
	private BigDecimal wkMedicalInNum;
	
	// 工作者参加工伤保险人数
	private BigDecimal wkInjuryInNum;

	// 工作者参加失业保险人数
	private BigDecimal wkUnemployInNum;
	
	// 工作者参加生育保险人数
	private BigDecimal wkBirthInNum;

	// 工作者参加住房公积金人数
	private BigDecimal wkHousingReNum;
	
	// 工作者社工师人数
	private BigDecimal wkWorkerNum;
	
	// 工作者人均约补贴收入
	private BigDecimal wkSubsidyAvgMon;
	
	// 填报单位行政区划
	private String organCode;
	
	// 填报单位名称
	private String organName;
	
	// 所属上级行政区划
	private String parentCode;
	
	// 填报报表类型
	private String reportType;
	
	// 填报日期
	private String reportDate;
	
	// 上报状态
	private String status;
	
	// 上报日期
	private String submitDate;

	// 创建日期
	private String createTime;
	

	/**
	 * 获取 创建日期
	 * 
	 * @return String
	 */
	public String getCreateTime() {
		return createTime;
	}

	/**
	 * 设置 创建日期
	 */
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	/**
	 * getter for 统计内码
	 * 
	 * @generated
	 */
	public String getRecordId() {
		return this.recordId;
	}

	/**
	 * setter for 统计内码
	 * 
	 * @generated
	 */
	public void setRecordId(String recordId) {
		this.recordId = recordId;
	}

	/**
	 * getter for 社区数量
	 * 
	 * @generated
	 */
	public BigDecimal getCommunityNum() {
		return this.communityNum;
	}

	/**
	 * setter for 社区数量
	 * 
	 * @generated
	 */
	public void setCommunityNum(BigDecimal communityNum) {
		this.communityNum = communityNum;
	}

	/**
	 * getter for 成员总人数
	 * 
	 * @generated
	 */
	public BigDecimal getMbPeopleNum() {
		return this.mbPeopleNum;
	}

	/**
	 * setter for 成员总人数
	 * 
	 * @generated
	 */
	public void setMbPeopleNum(BigDecimal mbPeopleNum) {
		this.mbPeopleNum = mbPeopleNum;
	}

	/**
	 * getter for 成员女性人数
	 * 
	 * @generated
	 */
	public BigDecimal getMbFemaleNum() {
		return this.mbFemaleNum;
	}

	/**
	 * setter for 成员女性人数
	 * 
	 * @generated
	 */
	public void setMbFemaleNum(BigDecimal mbFemaleNum) {
		this.mbFemaleNum = mbFemaleNum;
	}

	/**
	 * getter for 成员30岁以下人数
	 * 
	 * @generated
	 */
	public BigDecimal getMbThirtyNum() {
		return this.mbThirtyNum;
	}

	/**
	 * setter for 成员30岁以下人数
	 * 
	 * @generated
	 */
	public void setMbThirtyNum(BigDecimal mbThirtyNum) {
		this.mbThirtyNum = mbThirtyNum;
	}

	/**
	 * getter for 成员40岁以下人数
	 * 
	 * @generated
	 */
	public BigDecimal getMbFourtyNum() {
		return this.mbFourtyNum;
	}

	/**
	 * setter for 成员40岁以下人数
	 * 
	 * @generated
	 */
	public void setMbFourtyNum(BigDecimal mbFourtyNum) {
		this.mbFourtyNum = mbFourtyNum;
	}

	/**
	 * getter for 成员50岁以下人数
	 * 
	 * @generated
	 */
	public BigDecimal getMbFiftyNum() {
		return this.mbFiftyNum;
	}

	/**
	 * setter for 成员50岁以下人数
	 * 
	 * @generated
	 */
	public void setMbFiftyNum(BigDecimal mbFiftyNum) {
		this.mbFiftyNum = mbFiftyNum;
	}

	/**
	 * getter for 成员50岁以上人数
	 * 
	 * @generated
	 */
	public BigDecimal getMbSixtyNum() {
		return this.mbSixtyNum;
	}

	/**
	 * setter for 成员50岁以上人数
	 * 
	 * @generated
	 */
	public void setMbSixtyNum(BigDecimal mbSixtyNum) {
		this.mbSixtyNum = mbSixtyNum;
	}

	/**
	 * getter for 成员少数民族人数
	 * 
	 * @generated
	 */
	public BigDecimal getMbFolkNum() {
		return this.mbFolkNum;
	}

	/**
	 * setter for 成员少数民族人数
	 * 
	 * @generated
	 */
	public void setMbFolkNum(BigDecimal mbFolkNum) {
		this.mbFolkNum = mbFolkNum;
	}

	/**
	 * getter for 成员交叉任职人数
	 * 
	 * @generated
	 */
	public BigDecimal getMbCrossNum() {
		return this.mbCrossNum;
	}

	/**
	 * setter for 成员交叉任职人数
	 * 
	 * @generated
	 */
	public void setMbCrossNum(BigDecimal mbCrossNum) {
		this.mbCrossNum = mbCrossNum;
	}

	/**
	 * getter for 成员党员人数
	 * 
	 * @generated
	 */
	public BigDecimal getMbPartyNum() {
		return this.mbPartyNum;
	}

	/**
	 * setter for 成员党员人数
	 * 
	 * @generated
	 */
	public void setMbPartyNum(BigDecimal mbPartyNum) {
		this.mbPartyNum = mbPartyNum;
	}

	/**
	 * getter for 成员共青团员人数
	 * 
	 * @generated
	 */
	public BigDecimal getMbLeagueNum() {
		return this.mbLeagueNum;
	}

	/**
	 * setter for 成员共青团员人数
	 * 
	 * @generated
	 */
	public void setMbLeagueNum(BigDecimal mbLeagueNum) {
		this.mbLeagueNum = mbLeagueNum;
	}

	/**
	 * getter for 成员政治面貌其他人数
	 * 
	 * @generated
	 */
	public BigDecimal getMbOtherNum() {
		return this.mbOtherNum;
	}

	/**
	 * setter for 成员政治面貌其他人数
	 * 
	 * @generated
	 */
	public void setMbOtherNum(BigDecimal mbOtherNum) {
		this.mbOtherNum = mbOtherNum;
	}

	/**
	 * getter for 成员初中及以下人数
	 * 
	 * @generated
	 */
	public BigDecimal getMbJuniorNum() {
		return this.mbJuniorNum;
	}

	/**
	 * setter for 成员初中及以下人数
	 * 
	 * @generated
	 */
	public void setMbJuniorNum(BigDecimal mbJuniorNum) {
		this.mbJuniorNum = mbJuniorNum;
	}

	/**
	 * getter for 成员高中及中专人数
	 * 
	 * @generated
	 */
	public BigDecimal getMbSeniorNum() {
		return this.mbSeniorNum;
	}

	/**
	 * setter for 成员高中及中专人数
	 * 
	 * @generated
	 */
	public void setMbSeniorNum(BigDecimal mbSeniorNum) {
		this.mbSeniorNum = mbSeniorNum;
	}

	/**
	 * getter for 成员大学专科人数
	 * 
	 * @generated
	 */
	public BigDecimal getMbSpecialtyNum() {
		return this.mbSpecialtyNum;
	}

	/**
	 * setter for 成员大学专科人数
	 * 
	 * @generated
	 */
	public void setMbSpecialtyNum(BigDecimal mbSpecialtyNum) {
		this.mbSpecialtyNum = mbSpecialtyNum;
	}

	/**
	 * getter for 成员大学本科人数
	 * 
	 * @generated
	 */
	public BigDecimal getMbCollegeNum() {
		return this.mbCollegeNum;
	}

	/**
	 * setter for 成员大学本科人数
	 * 
	 * @generated
	 */
	public void setMbCollegeNum(BigDecimal mbCollegeNum) {
		this.mbCollegeNum = mbCollegeNum;
	}

	/**
	 * getter for 成员研究生及以上人数
	 * 
	 * @generated
	 */
	public BigDecimal getMbGraduateNum() {
		return this.mbGraduateNum;
	}

	/**
	 * setter for 成员研究生及以上人数
	 * 
	 * @generated
	 */
	public void setMbGraduateNum(BigDecimal mbGraduateNum) {
		this.mbGraduateNum = mbGraduateNum;
	}

	/**
	 * getter for 成员参加养老保险人数
	 * 
	 * @generated
	 */
	public BigDecimal getMbAgedInNum() {
		return this.mbAgedInNum;
	}

	/**
	 * setter for 成员参加养老保险人数
	 * 
	 * @generated
	 */
	public void setMbAgedInNum(BigDecimal mbAgedInNum) {
		this.mbAgedInNum = mbAgedInNum;
	}

	/**
	 * getter for 成员参加医疗保险人数
	 * 
	 * @generated
	 */
	public BigDecimal getMbMedicalInNum() {
		return this.mbMedicalInNum;
	}

	/**
	 * setter for 成员参加医疗保险人数
	 * 
	 * @generated
	 */
	public void setMbMedicalInNum(BigDecimal mbMedicalInNum) {
		this.mbMedicalInNum = mbMedicalInNum;
	}

	/**
	 * getter for 成员大学生村官人数
	 * 
	 * @generated
	 */
	public BigDecimal getMbOfficalNum() {
		return this.mbOfficalNum;
	}

	/**
	 * setter for 成员大学生村官人数
	 * 
	 * @generated
	 */
	public void setMbOfficalNum(BigDecimal mbOfficalNum) {
		this.mbOfficalNum = mbOfficalNum;
	}

	/**
	 * getter for 成员社工师人数
	 * 
	 * @generated
	 */
	public BigDecimal getMbWorkerNum() {
		return this.mbWorkerNum;
	}

	/**
	 * setter for 成员社工师人数
	 * 
	 * @generated
	 */
	public void setMbWorkerNum(BigDecimal mbWorkerNum) {
		this.mbWorkerNum = mbWorkerNum;
	}

	/**
	 * getter for 成员人均约补贴收入
	 * 
	 * @generated
	 */
	public BigDecimal getMbSubsidyAvgMon() {
		return this.mbSubsidyAvgMon;
	}

	/**
	 * setter for 成员人均约补贴收入
	 * 
	 * @generated
	 */
	public void setMbSubsidyAvgMon(BigDecimal mbSubsidyAvgMon) {
		this.mbSubsidyAvgMon = mbSubsidyAvgMon;
	}

	/**
	 * getter for 工作者总人数
	 * 
	 * @generated
	 */
	public BigDecimal getWkPeopleNum() {
		return this.wkPeopleNum;
	}

	/**
	 * setter for 工作者总人数
	 * 
	 * @generated
	 */
	public void setWkPeopleNum(BigDecimal wkPeopleNum) {
		this.wkPeopleNum = wkPeopleNum;
	}

	/**
	 * getter for 工作者女性人数
	 * 
	 * @generated
	 */
	public BigDecimal getWkFemaleNum() {
		return this.wkFemaleNum;
	}

	/**
	 * setter for 工作者女性人数
	 * 
	 * @generated
	 */
	public void setWkFemaleNum(BigDecimal wkFemaleNum) {
		this.wkFemaleNum = wkFemaleNum;
	}

	/**
	 * getter for 工作者30岁以下人数
	 * 
	 * @generated
	 */
	public BigDecimal getWkThirtyNum() {
		return this.wkThirtyNum;
	}

	/**
	 * setter for 工作者30岁以下人数
	 * 
	 * @generated
	 */
	public void setWkThirtyNum(BigDecimal wkThirtyNum) {
		this.wkThirtyNum = wkThirtyNum;
	}

	/**
	 * getter for 工作者40岁以下人数
	 * 
	 * @generated
	 */
	public BigDecimal getWkFourtyNum() {
		return this.wkFourtyNum;
	}

	/**
	 * setter for 工作者40岁以下人数
	 * 
	 * @generated
	 */
	public void setWkFourtyNum(BigDecimal wkFourtyNum) {
		this.wkFourtyNum = wkFourtyNum;
	}

	/**
	 * getter for 工作者50岁以下人数
	 * 
	 * @generated
	 */
	public BigDecimal getWkFiftyNum() {
		return this.wkFiftyNum;
	}

	/**
	 * setter for 工作者50岁以下人数
	 * 
	 * @generated
	 */
	public void setWkFiftyNum(BigDecimal wkFiftyNum) {
		this.wkFiftyNum = wkFiftyNum;
	}

	/**
	 * getter for 工作者50岁以上人数
	 * 
	 * @generated
	 */
	public BigDecimal getWkSixtyNum() {
		return this.wkSixtyNum;
	}

	/**
	 * setter for 工作者50岁以上人数
	 * 
	 * @generated
	 */
	public void setWkSixtyNum(BigDecimal wkSixtyNum) {
		this.wkSixtyNum = wkSixtyNum;
	}

	/**
	 * getter for 工作者少数民族人数
	 * 
	 * @generated
	 */
	public BigDecimal getWkFolkNum() {
		return this.wkFolkNum;
	}

	/**
	 * setter for 工作者少数民族人数
	 * 
	 * @generated
	 */
	public void setWkFolkNum(BigDecimal wkFolkNum) {
		this.wkFolkNum = wkFolkNum;
	}

	/**
	 * getter for 工作者党员人数
	 * 
	 * @generated
	 */
	public BigDecimal getWkPartyNum() {
		return this.wkPartyNum;
	}

	/**
	 * setter for 工作者党员人数
	 * 
	 * @generated
	 */
	public void setWkPartyNum(BigDecimal wkPartyNum) {
		this.wkPartyNum = wkPartyNum;
	}

	/**
	 * getter for 工作者共青团员人数
	 * 
	 * @generated
	 */
	public BigDecimal getWkLeagueNum() {
		return this.wkLeagueNum;
	}

	/**
	 * setter for 工作者共青团员人数
	 * 
	 * @generated
	 */
	public void setWkLeagueNum(BigDecimal wkLeagueNum) {
		this.wkLeagueNum = wkLeagueNum;
	}

	/**
	 * getter for 工作者政治面貌其他人数
	 * 
	 * @generated
	 */
	public BigDecimal getWkOtherNum() {
		return this.wkOtherNum;
	}

	/**
	 * setter for 工作者政治面貌其他人数
	 * 
	 * @generated
	 */
	public void setWkOtherNum(BigDecimal wkOtherNum) {
		this.wkOtherNum = wkOtherNum;
	}

	/**
	 * getter for 工作者初中及以下人数
	 * 
	 * @generated
	 */
	public BigDecimal getWkJuniorNum() {
		return this.wkJuniorNum;
	}

	/**
	 * setter for 工作者初中及以下人数
	 * 
	 * @generated
	 */
	public void setWkJuniorNum(BigDecimal wkJuniorNum) {
		this.wkJuniorNum = wkJuniorNum;
	}

	/**
	 * getter for 工作者高中及中专人数
	 * 
	 * @generated
	 */
	public BigDecimal getWkSeniorNum() {
		return this.wkSeniorNum;
	}

	/**
	 * setter for 工作者高中及中专人数
	 * 
	 * @generated
	 */
	public void setWkSeniorNum(BigDecimal wkSeniorNum) {
		this.wkSeniorNum = wkSeniorNum;
	}

	/**
	 * getter for 工作者大学专科人数
	 * 
	 * @generated
	 */
	public BigDecimal getWkSpecialtyNum() {
		return this.wkSpecialtyNum;
	}

	/**
	 * setter for 工作者大学专科人数
	 * 
	 * @generated
	 */
	public void setWkSpecialtyNum(BigDecimal wkSpecialtyNum) {
		this.wkSpecialtyNum = wkSpecialtyNum;
	}

	/**
	 * getter for 工作者大学本科人数
	 * 
	 * @generated
	 */
	public BigDecimal getWkCollegeNum() {
		return this.wkCollegeNum;
	}

	/**
	 * setter for 工作者大学本科人数
	 * 
	 * @generated
	 */
	public void setWkCollegeNum(BigDecimal wkCollegeNum) {
		this.wkCollegeNum = wkCollegeNum;
	}

	/**
	 * getter for 工作者研究生及以上人数
	 * 
	 * @generated
	 */
	public BigDecimal getWkGraduateNum() {
		return this.wkGraduateNum;
	}

	/**
	 * setter for 工作者研究生及以上人数
	 * 
	 * @generated
	 */
	public void setWkGraduateNum(BigDecimal wkGraduateNum) {
		this.wkGraduateNum = wkGraduateNum;
	}

	/**
	 * getter for 工作者公务员人数
	 * 
	 * @generated
	 */
	public BigDecimal getWkOfficialNum() {
		return this.wkOfficialNum;
	}

	/**
	 * setter for 工作者公务员人数
	 * 
	 * @generated
	 */
	public void setWkOfficialNum(BigDecimal wkOfficialNum) {
		this.wkOfficialNum = wkOfficialNum;
	}

	/**
	 * getter for 工作者事业编人数
	 * 
	 * @generated
	 */
	public BigDecimal getWkEnterpriseNum() {
		return this.wkEnterpriseNum;
	}

	/**
	 * setter for 工作者事业编人数
	 * 
	 * @generated
	 */
	public void setWkEnterpriseNum(BigDecimal wkEnterpriseNum) {
		this.wkEnterpriseNum = wkEnterpriseNum;
	}

	/**
	 * getter for 工作者招聘人员数
	 * 
	 * @generated
	 */
	public BigDecimal getWkRequiredNum() {
		return this.wkRequiredNum;
	}

	/**
	 * setter for 工作者招聘人员数
	 * 
	 * @generated
	 */
	public void setWkRequiredNum(BigDecimal wkRequiredNum) {
		this.wkRequiredNum = wkRequiredNum;
	}

	/**
	 * getter for 工作者企业职工人数
	 * 
	 * @generated
	 */
	public BigDecimal getWkCorporationNum() {
		return this.wkCorporationNum;
	}

	/**
	 * setter for 工作者企业职工人数
	 * 
	 * @generated
	 */
	public void setWkCorporationNum(BigDecimal wkCorporationNum) {
		this.wkCorporationNum = wkCorporationNum;
	}

	/**
	 * getter for 工作者社区居民人数
	 * 
	 * @generated
	 */
	public BigDecimal getWkResideNum() {
		return this.wkResideNum;
	}

	/**
	 * setter for 工作者社区居民人数
	 * 
	 * @generated
	 */
	public void setWkResideNum(BigDecimal wkResideNum) {
		this.wkResideNum = wkResideNum;
	}

	/**
	 * getter for 工作者身份其他人数
	 * 
	 * @generated
	 */
	public BigDecimal getWkProOtherNum() {
		return this.wkProOtherNum;
	}

	/**
	 * setter for 工作者身份其他人数
	 * 
	 * @generated
	 */
	public void setWkProOtherNum(BigDecimal wkProOtherNum) {
		this.wkProOtherNum = wkProOtherNum;
	}

	/**
	 * getter for 工作者参加养老保险人数
	 * 
	 * @generated
	 */
	public BigDecimal getWkAgedInNum() {
		return this.wkAgedInNum;
	}

	/**
	 * setter for 工作者参加养老保险人数
	 * 
	 * @generated
	 */
	public void setWkAgedInNum(BigDecimal wkAgedInNum) {
		this.wkAgedInNum = wkAgedInNum;
	}

	/**
	 * getter for 工作者参加医疗保险人数
	 * 
	 * @generated
	 */
	public BigDecimal getWkMedicalInNum() {
		return this.wkMedicalInNum;
	}

	/**
	 * setter for 工作者参加医疗保险人数
	 * 
	 * @generated
	 */
	public void setWkMedicalInNum(BigDecimal wkMedicalInNum) {
		this.wkMedicalInNum = wkMedicalInNum;
	}

	/**
	 * getter for 工作者参加工伤保险人数
	 * 
	 * @generated
	 */
	public BigDecimal getWkInjuryInNum() {
		return this.wkInjuryInNum;
	}

	/**
	 * setter for 工作者参加工伤保险人数
	 * 
	 * @generated
	 */
	public void setWkInjuryInNum(BigDecimal wkInjuryInNum) {
		this.wkInjuryInNum = wkInjuryInNum;
	}

	/**
	 * getter for 工作者社工师人数
	 * 
	 * @generated
	 */
	public BigDecimal getWkWorkerNum() {
		return this.wkWorkerNum;
	}

	/**
	 * setter for 工作者社工师人数
	 * 
	 * @generated
	 */
	public void setWkWorkerNum(BigDecimal wkWorkerNum) {
		this.wkWorkerNum = wkWorkerNum;
	}

	/**
	 * getter for 工作者人均约补贴收入
	 * 
	 * @generated
	 */
	public BigDecimal getWkSubsidyAvgMon() {
		return this.wkSubsidyAvgMon;
	}

	/**
	 * setter for 工作者人均约补贴收入
	 * 
	 * @generated
	 */
	public void setWkSubsidyAvgMon(BigDecimal wkSubsidyAvgMon) {
		this.wkSubsidyAvgMon = wkSubsidyAvgMon;
	}

	/**
	 * getter for 填报单位行政区划
	 * 
	 * @generated
	 */
	public String getOrganCode() {
		return this.organCode;
	}

	/**
	 * setter for 填报单位行政区划
	 * 
	 * @generated
	 */
	public void setOrganCode(String organCode) {
		this.organCode = organCode;
	}

	/**
	 * getter for 填报单位名称
	 * 
	 * @generated
	 */
	public String getOrganName() {
		return this.organName;
	}

	/**
	 * setter for 填报单位名称
	 * 
	 * @generated
	 */
	public void setOrganName(String organName) {
		this.organName = organName;
	}

	/**
	 * getter for 所属上级行政区划
	 * 
	 * @generated
	 */
	public String getParentCode() {
		return this.parentCode;
	}

	/**
	 * setter for 所属上级行政区划
	 * 
	 * @generated
	 */
	public void setParentCode(String parentCode) {
		this.parentCode = parentCode;
	}

	/**
	 * getter for 填报报表类型
	 * 
	 * @generated
	 */
	public String getReportType() {
		return this.reportType;
	}

	/**
	 * setter for 填报报表类型
	 * 
	 * @generated
	 */
	public void setReportType(String reportType) {
		this.reportType = reportType;
	}

	/**
	 * getter for 填报日期
	 * 
	 * @generated
	 */
	public String getReportDate() {
		return this.reportDate;
	}

	/**
	 * setter for 填报日期
	 * 
	 * @generated
	 */
	public void setReportDate(String reportDate) {
		this.reportDate = reportDate;
	}

	/**
	 * getter for 上报状态
	 * 
	 * @generated
	 */
	public String getStatus() {
		return this.status;
	}

	/**
	 * setter for 上报状态
	 * 
	 * @generated
	 */
	public void setStatus(String status) {
		this.status = status;
	}

	/**
	 * getter for 上报日期
	 * 
	 * @generated
	 */
	public String getSubmitDate() {
		return this.submitDate;
	}

	/**
	 * setter for 上报日期
	 * 
	 * @generated
	 */
	public void setSubmitDate(String submitDate) {
		this.submitDate = submitDate;
	}

	/**
	 * getter for 基础信息两委成员与工作者信息
	 * 
	 * @return
	 */
	public List<CdcPeopleInfo> getCdcPeopleInfoList() {
		return cdcPeopleInfoList;
	}

	/**
	 * setter for 基础信息两委成员与工作者信息
	 * 
	 * @param cdcPeopleInfoList
	 */
	public void setCdcPeopleInfoList(List<CdcPeopleInfo> cdcPeopleInfoList) {
		this.cdcPeopleInfoList = cdcPeopleInfoList;
	}

	public BigDecimal getMbUnemployInNum() {
		return mbUnemployInNum;
	}

	public void setMbUnemployInNum(BigDecimal mbUnemployInNum) {
		this.mbUnemployInNum = mbUnemployInNum;
	}

	public BigDecimal getMbBirthInNum() {
		return mbBirthInNum;
	}

	public void setMbBirthInNum(BigDecimal mbBirthInNum) {
		this.mbBirthInNum = mbBirthInNum;
	}

	public BigDecimal getMbHousingReNum() {
		return mbHousingReNum;
	}

	public void setMbHousingReNum(BigDecimal mbHousingReNum) {
		this.mbHousingReNum = mbHousingReNum;
	}

	public BigDecimal getWkUnemployInNum() {
		return wkUnemployInNum;
	}

	public void setWkUnemployInNum(BigDecimal wkUnemployInNum) {
		this.wkUnemployInNum = wkUnemployInNum;
	}

	public BigDecimal getWkBirthInNum() {
		return wkBirthInNum;
	}

	public void setWkBirthInNum(BigDecimal wkBirthInNum) {
		this.wkBirthInNum = wkBirthInNum;
	}

	public BigDecimal getWkHousingReNum() {
		return wkHousingReNum;
	}

	public void setWkHousingReNum(BigDecimal wkHousingReNum) {
		this.wkHousingReNum = wkHousingReNum;
	}

	public BigDecimal getMbInjuryInNum() {
		return mbInjuryInNum;
	}

	public void setMbInjuryInNum(BigDecimal mbInjuryInNum) {
		this.mbInjuryInNum = mbInjuryInNum;
	}

}