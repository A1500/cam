package com.inspur.cams.cdc.base.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 民主选举人员信息databean
 * @author 
 * @date 2012-12-14
 */
@Table(tableName = "CDC_ELECTION_MEMBER", keyFields = "memberId")
public class CdcElectionMember extends StatefulDatabean {

	// 成员组成内码
	private String memberId;

	// 选举内码
	private String recordId;

	// 人员类型
	private String type;

	// 姓名
	private String name;

	// 性别
	private String sex;

	// 年龄
	private String age;

	// 民族
	private String folk;

	// 政治面貌
	private String political;

	// 文化程度
	private String education;

	// 提名形式
	private String nomManner;

	// 提名人数
	private BigDecimal nomNum;

	// 来源
	private String peopleSource;

	// 是否初次当选
	private String ifFirst;
	
	// 是否连选连任
	private String ifReduty;

	// 当选职务
	private String duty;

	// 当选职务票数
	private BigDecimal dutyVoteNum;

	// 得票数
	private BigDecimal voteNum;

	// 是否有从业资格证书
	private String ifCert;

	// 兼任村委会职务
	private String ifPart;

	/**
	 * 获取 成员组成内码
	 * @return String
	 */
	public String getMemberId() {
		return memberId;
	}

	/**
	 * 设置 成员组成内码
	 */
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	/**
	 * 获取 选举内码
	 * @return String
	 */
	public String getRecordId() {
		return recordId;
	}

	/**
	 * 设置 选举内码
	 */
	public void setRecordId(String recordId) {
		this.recordId = recordId;
	}

	/**
	 * 获取 人员类型
	 * @return String
	 */
	public String getType() {
		return type;
	}

	/**
	 * 设置 人员类型
	 */
	public void setType(String type) {
		this.type = type;
	}

	/**
	 * 获取 姓名
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
	 * 获取 年龄
	 * @return String
	 */
	public String getAge() {
		return age;
	}

	/**
	 * 设置 年龄
	 */
	public void setAge(String age) {
		this.age = age;
	}

	/**
	 * 获取 民族
	 * @return String
	 */
	public String getFolk() {
		return folk;
	}

	/**
	 * 设置 民族
	 */
	public void setFolk(String folk) {
		this.folk = folk;
	}

	/**
	 * 获取 政治面貌
	 * @return String
	 */
	public String getPolitical() {
		return political;
	}

	/**
	 * 设置 政治面貌
	 */
	public void setPolitical(String political) {
		this.political = political;
	}

	/**
	 * 获取 文化程度
	 * @return String
	 */
	public String getEducation() {
		return education;
	}

	/**
	 * 设置 文化程度
	 */
	public void setEducation(String education) {
		this.education = education;
	}

	/**
	 * 获取 提名形式
	 * @return String
	 */
	public String getNomManner() {
		return nomManner;
	}

	/**
	 * 设置 提名形式
	 */
	public void setNomManner(String nomManner) {
		this.nomManner = nomManner;
	}

	/**
	 * 获取 提名人数
	 * @return BigDecimal
	 */
	public BigDecimal getNomNum() {
		return nomNum;
	}

	/**
	 * 设置 提名人数
	 */
	public void setNomNum(BigDecimal nomNum) {
		this.nomNum = nomNum;
	}

	/**
	 * 获取 来源
	 * @return String
	 */
	public String getPeopleSource() {
		return peopleSource;
	}

	/**
	 * 设置 来源
	 */
	public void setPeopleSource(String peopleSource) {
		this.peopleSource = peopleSource;
	}

	/**
	 * 获取 是否连选连任
	 * @return String
	 */
	public String getIfReduty() {
		return ifReduty;
	}

	/**
	 * 设置 是否连选连任
	 */
	public void setIfReduty(String ifReduty) {
		this.ifReduty = ifReduty;
	}

	/**
	 * 获取 当选职务
	 * @return String
	 */
	public String getDuty() {
		return duty;
	}

	/**
	 * 设置 当选职务
	 */
	public void setDuty(String duty) {
		this.duty = duty;
	}

	/**
	 * 获取 当选职务票数
	 * @return BigDecimal
	 */
	public BigDecimal getDutyVoteNum() {
		return dutyVoteNum;
	}

	/**
	 * 设置 当选职务票数
	 */
	public void setDutyVoteNum(BigDecimal dutyVoteNum) {
		this.dutyVoteNum = dutyVoteNum;
	}

	/**
	 * 获取 得票数
	 * @return BigDecimal
	 */
	public BigDecimal getVoteNum() {
		return voteNum;
	}

	/**
	 * 设置 得票数
	 */
	public void setVoteNum(BigDecimal voteNum) {
		this.voteNum = voteNum;
	}

	/**
	 * 获取 是否有从业资格证书
	 * @return String
	 */
	public String getIfCert() {
		return ifCert;
	}

	/**
	 * 设置 是否有从业资格证书
	 */
	public void setIfCert(String ifCert) {
		this.ifCert = ifCert;
	}

	/**
	 * 获取 兼任村委会职务
	 * @return String
	 */
	public String getIfPart() {
		return ifPart;
	}

	/**
	 * 设置 兼任村委会职务
	 */
	public void setIfPart(String ifPart) {
		this.ifPart = ifPart;
	}

	public String getIfFirst() {
		return ifFirst;
	}

	public void setIfFirst(String ifFirst) {
		this.ifFirst = ifFirst;
	}

}