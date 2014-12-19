package com.inspur.cams.prs.prspoliciesregulations.dao;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:PrsPoliciesRegulations
 * @description:
 * @author:
 * @since:2011-08-26
 * @version:1.0
 */
@Table(tableName = "PRS_POLICIES_REGULATIONS", keyFields = "policiesRegulationsId")
public class PrsPoliciesRegulations extends StatefulDatabean {
	//政策法规ID
	@Rule(value = "require")
	@Column(name = "POLICIES_REGULATIONS_ID")
	private String policiesRegulationsId;
	//法规标题
	@Column(name = "REGULATIONS_TITLE")
	private String regulationsTitle;
	//法规编号
	@Column(name = "REGULATIONS_NUMBERS")
	private String regulationsNumbers;
	//发布日期
	@Column(name = "RELEASE_DATE")
	private String releaseDate;
	//发布单位
	@Column(name = "RELEASE_COMPANY")
	private String releaseCompany;
	//发布单位
	@Column(name = "RELEASE_COMPANY_NAME")
	private String releaseCompanyName;
	//发布人
	@Column(name = "RELEASE_PEOPLE")
	private String releasePeople;
	//接收单位
	@Column(name = "ACCEPTING_COMPANY")
	private String acceptingCompany;
	//接收单位代码
	@Column(name = "ACCEPTING_COMPANY_CODE")
	private String acceptingCompanyCode;
	//实效时间
	@Column(name = "EFFECT_TIME")
	private String effectTime;
	//内容
	@Column(name = "CONTENT")
	private String content;
	//备注
	@Column(name = "REMARKS")
	private String remarks;
	//类别
	@Column(name = "TYPE")
	private String type;
	//是否有效标志
	@Column(name = "EFFECT_FLAG")
	private String effectFlag;
	//年度
	@Column(name = "YEARLY")
	private String yearly;
	//文号
	@Column(name = "FILE_NUM")
	private String fileNum;

	/**
	 * getter for 政策法规ID
	 * @generated
	 */
	public String getPoliciesRegulationsId() {
		return this.policiesRegulationsId;
	}

	/**
	 * setter for 政策法规ID
	 * @generated
	 */
	public void setPoliciesRegulationsId(String policiesRegulationsId) {
		this.policiesRegulationsId = policiesRegulationsId;
	}

	/**
	 * getter for 法规标题
	 * @generated
	 */
	public String getRegulationsTitle() {
		return this.regulationsTitle;
	}

	/**
	 * setter for 法规标题
	 * @generated
	 */
	public void setRegulationsTitle(String regulationsTitle) {
		this.regulationsTitle = regulationsTitle;
	}

	/**
	 * getter for 法规编号
	 * @generated
	 */
	public String getRegulationsNumbers() {
		return this.regulationsNumbers;
	}

	/**
	 * setter for 法规编号
	 * @generated
	 */
	public void setRegulationsNumbers(String regulationsNumbers) {
		this.regulationsNumbers = regulationsNumbers;
	}

	/**
	 * getter for 发布日期
	 * @generated
	 */
	public String getReleaseDate() {
		return this.releaseDate;
	}

	/**
	 * setter for 发布日期
	 * @generated
	 */
	public void setReleaseDate(String releaseDate) {
		this.releaseDate = releaseDate;
	}

	/**
	 * getter for 发布单位
	 * @generated
	 */
	public String getReleaseCompany() {
		return this.releaseCompany;
	}

	/**
	 * setter for 发布单位
	 * @generated
	 */
	public void setReleaseCompany(String releaseCompany) {
		this.releaseCompany = releaseCompany;
	}

	/**
	 * getter for 发布人
	 * @generated
	 */
	public String getReleasePeople() {
		return this.releasePeople;
	}

	/**
	 * setter for 发布人
	 * @generated
	 */
	public void setReleasePeople(String releasePeople) {
		this.releasePeople = releasePeople;
	}

	/**
	 * getter for 接收单位
	 * @generated
	 */
	public String getAcceptingCompany() {
		return this.acceptingCompany;
	}

	/**
	 * setter for 接收单位
	 * @generated
	 */
	public void setAcceptingCompany(String acceptingCompany) {
		this.acceptingCompany = acceptingCompany;
	}

	/**
	 * getter for 发布单位名称
	 * @generated
	 */
	public String getReleaseCompanyName() {
		return this.releaseCompanyName;
	}

	/**
	 * setter for 发布单位名称
	 * @generated
	 */
	public void setReleaseCompanyName(String releaseCompanyName) {
		this.releaseCompanyName = releaseCompanyName;
	}

	/**
	 * getter for 实效时间
	 * @generated
	 */
	public String getEffectTime() {
		return this.effectTime;
	}

	/**
	 * setter for 实效时间
	 * @generated
	 */
	public void setEffectTime(String effectTime) {
		this.effectTime = effectTime;
	}

	/**
	 * getter for 内容
	 * @generated
	 */
	public String getContent() {
		return this.content;
	}

	/**
	 * setter for 内容
	 * @generated
	 */
	public void setContent(String content) {
		this.content = content;
	}

	/**
	 * getter for 备注
	 * @generated
	 */
	public String getRemarks() {
		return this.remarks;
	}

	/**
	 * setter for 备注
	 * @generated
	 */
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	/**
	 * getter for 类别
	 * @generated
	 */
	public String getType() {
		return this.type;
	}

	/**
	 * setter for 类别
	 * @generated
	 */
	public void setType(String type) {
		this.type = type;
	}

	/**
	 * getter for 有效标志
	 * @generated
	 */
	public String getEffectFlag() {
		return this.effectFlag;
	}

	/**
	 * setter for 有效标志
	 * @generated
	 */
	public void setEffectFlag(String effectFlag) {
		this.effectFlag = effectFlag;
	}

	public String getAcceptingCompanyCode() {
		return acceptingCompanyCode;
	}

	public void setAcceptingCompanyCode(String acceptingCompanyCode) {
		this.acceptingCompanyCode = acceptingCompanyCode;
	}

	public String getYearly() {
		return yearly;
	}

	public void setYearly(String yearly) {
		this.yearly = yearly;
	}

	public String getFileNum() {
		return fileNum;
	}

	public void setFileNum(String fileNum) {
		this.fileNum = fileNum;
	}

}