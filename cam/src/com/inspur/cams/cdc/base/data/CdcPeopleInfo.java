package com.inspur.cams.cdc.base.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 基础信息两委成员与工作者信息表databean
 * @author 
 * @date 2012-05-25
 */
@Table(tableName = "CDC_PEOPLE_INFO", keyFields = "peopleId")
public class CdcPeopleInfo extends StatefulDatabean {

	// 人员内码
	private String peopleId;

	// 界次
	private String season;

	// 姓名
	private String name;

	// 身份证件号码
	private String idCard;

	// 性别
	private String sex;

	// 出生日期
	private String birthday;

	// 民族
	private String nation;

	// 文化程度代码
	private String eduCode;

	// 政治面貌代码
	private String politicalCode;

	// 联系电话
	private String tel;

	// 个人简历
	private String resume;

	// 住址
	private String address;

	// 邮政编码
	private String postCode;

	// 是否委员会成员
	private String ifCommittee;

	// 是否交叉任职
	private String ifCross;

	// 职务
	private String duty;

	// 是否下属委员会成员
	private String ifCommitteeUnderling;

	// 分管工作
	private String jobType;

	// 是否居民小组长、楼长 2013年4月27日 是否党组织成员
	private String ifGroupHeadman;

	// 是否社工组织成员
	private String ifCommunityWorker;

	// 社工组织成员类别
	private String communityWorkerType;

	// 专业技能
	private String specialSkill;

	// 身份
	private String identity;

	// 是否享有养老保险
	private String ifAgedInsurance;

	// 是否享有医疗保险
	private String ifMedicalInsurance;

	// 是否享有工伤保险
	private String ifInjuryInsurance;

	// 是否享失业保险
	private String ifUnemployInsurance;
	
	// 是否享有生育保险
	private String ifBirthInsurance;
	
	// 是否享有住房公积金
	private String ifHousingReserve;

	// 是否社工师
	private String ifWorker;

	// 是否大学生村官
	private String ifOfficial;

	// 月补贴收入
	private BigDecimal subsidyMon;
	
	//是否连选连任
	private String ifReelected;
	
	//是否在物业服务企业兼职
	private String ifPartTime;

	// 所属行政区划
	private String organCode;
	

	// 备注
	private String note;

	/**
	 * 获取 人员内码
	 * @return String
	 */
	public String getPeopleId() {
		return peopleId;
	}

	/**
	 * 设置 人员内码
	 */
	public void setPeopleId(String peopleId) {
		this.peopleId = peopleId;
	}

	/**
	 * 获取 界次
	 * @return String
	 */
	public String getSeason() {
		return season;
	}

	/**
	 * 设置 界次
	 */
	public void setSeason(String season) {
		this.season = season;
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
	 * 获取 身份证件号码
	 * @return String
	 */
	public String getIdCard() {
		return idCard;
	}

	/**
	 * 设置 身份证件号码
	 */
	public void setIdCard(String idCard) {
		this.idCard = idCard;
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
	 * 获取 出生日期
	 * @return String
	 */
	public String getBirthday() {
		return birthday;
	}

	/**
	 * 设置 出生日期
	 */
	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}

	/**
	 * 获取 民族
	 * @return String
	 */
	public String getNation() {
		return nation;
	}

	/**
	 * 设置 民族
	 */
	public void setNation(String nation) {
		this.nation = nation;
	}

	/**
	 * 获取 文化程度代码
	 * @return String
	 */
	public String getEduCode() {
		return eduCode;
	}

	/**
	 * 设置 文化程度代码
	 */
	public void setEduCode(String eduCode) {
		this.eduCode = eduCode;
	}

	/**
	 * 获取 政治面貌代码
	 * @return String
	 */
	public String getPoliticalCode() {
		return politicalCode;
	}

	/**
	 * 设置 政治面貌代码
	 */
	public void setPoliticalCode(String politicalCode) {
		this.politicalCode = politicalCode;
	}

	/**
	 * 获取 联系电话
	 * @return String
	 */
	public String getTel() {
		return tel;
	}

	/**
	 * 设置 联系电话
	 */
	public void setTel(String tel) {
		this.tel = tel;
	}

	/**
	 * 获取 个人简历
	 * @return String
	 */
	public String getResume() {
		return resume;
	}

	/**
	 * 设置 个人简历
	 */
	public void setResume(String resume) {
		this.resume = resume;
	}

	/**
	 * 获取 住址
	 * @return String
	 */
	public String getAddress() {
		return address;
	}

	/**
	 * 设置 住址
	 */
	public void setAddress(String address) {
		this.address = address;
	}

	/**
	 * 获取 邮政编码
	 * @return String
	 */
	public String getPostCode() {
		return postCode;
	}

	/**
	 * 设置 邮政编码
	 */
	public void setPostCode(String postCode) {
		this.postCode = postCode;
	}

	/**
	 * 获取 是否委员会成员
	 * @return String
	 */
	public String getIfCommittee() {
		return ifCommittee;
	}

	/**
	 * 设置 是否委员会成员
	 */
	public void setIfCommittee(String ifCommittee) {
		this.ifCommittee = ifCommittee;
	}

	/**
	 * 获取 是否交叉任职
	 * @return String
	 */
	public String getIfCross() {
		return ifCross;
	}

	/**
	 * 设置 是否交叉任职
	 */
	public void setIfCross(String ifCross) {
		this.ifCross = ifCross;
	}

	/**
	 * 获取 职务
	 * @return String
	 */
	public String getDuty() {
		return duty;
	}

	/**
	 * 设置 职务
	 */
	public void setDuty(String duty) {
		this.duty = duty;
	}

	/**
	 * 获取 是否下属委员会成员
	 * @return String
	 */
	public String getIfCommitteeUnderling() {
		return ifCommitteeUnderling;
	}

	/**
	 * 设置 是否下属委员会成员
	 */
	public void setIfCommitteeUnderling(String ifCommitteeUnderling) {
		this.ifCommitteeUnderling = ifCommitteeUnderling;
	}

	/**
	 * 获取 分管工作
	 * @return String
	 */
	public String getJobType() {
		return jobType;
	}

	/**
	 * 设置 分管工作
	 */
	public void setJobType(String jobType) {
		this.jobType = jobType;
	}

	/**
	 * 获取 是否居民小组长、楼长
	 * @return String
	 */
	public String getIfGroupHeadman() {
		return ifGroupHeadman;
	}

	/**
	 * 设置 是否居民小组长、楼长
	 */
	public void setIfGroupHeadman(String ifGroupHeadman) {
		this.ifGroupHeadman = ifGroupHeadman;
	}

	/**
	 * 获取 是否社工组织成员
	 * @return String
	 */
	public String getIfCommunityWorker() {
		return ifCommunityWorker;
	}

	/**
	 * 设置 是否社工组织成员
	 */
	public void setIfCommunityWorker(String ifCommunityWorker) {
		this.ifCommunityWorker = ifCommunityWorker;
	}

	/**
	 * 获取 社工组织成员类别
	 * @return String
	 */
	public String getCommunityWorkerType() {
		return communityWorkerType;
	}

	/**
	 * 设置 社工组织成员类别
	 */
	public void setCommunityWorkerType(String communityWorkerType) {
		this.communityWorkerType = communityWorkerType;
	}

	/**
	 * 获取 专业技能
	 * @return String
	 */
	public String getSpecialSkill() {
		return specialSkill;
	}

	/**
	 * 设置 专业技能
	 */
	public void setSpecialSkill(String specialSkill) {
		this.specialSkill = specialSkill;
	}

	/**
	 * 获取 身份
	 * @return String
	 */
	public String getIdentity() {
		return identity;
	}

	/**
	 * 设置 身份
	 */
	public void setIdentity(String identity) {
		this.identity = identity;
	}

	/**
	 * 获取 是否享有养老保险
	 * @return String
	 */
	public String getIfAgedInsurance() {
		return ifAgedInsurance;
	}

	/**
	 * 设置 是否享有养老保险
	 */
	public void setIfAgedInsurance(String ifAgedInsurance) {
		this.ifAgedInsurance = ifAgedInsurance;
	}

	/**
	 * 获取 是否享有医疗保险
	 * @return String
	 */
	public String getIfMedicalInsurance() {
		return ifMedicalInsurance;
	}

	/**
	 * 设置 是否享有医疗保险
	 */
	public void setIfMedicalInsurance(String ifMedicalInsurance) {
		this.ifMedicalInsurance = ifMedicalInsurance;
	}

	/**
	 * 获取 是否享有工伤保险
	 * @return String
	 */
	public String getIfInjuryInsurance() {
		return ifInjuryInsurance;
	}

	/**
	 * 设置 是否享有工伤保险
	 */
	public void setIfInjuryInsurance(String ifInjuryInsurance) {
		this.ifInjuryInsurance = ifInjuryInsurance;
	}

	public String getIfUnemployInsurance() {
		return ifUnemployInsurance;
	}

	public void setIfUnemployInsurance(String ifUnemployInsurance) {
		this.ifUnemployInsurance = ifUnemployInsurance;
	}

	public String getIfBirthInsurance() {
		return ifBirthInsurance;
	}

	public void setIfBirthInsurance(String ifBirthInsurance) {
		this.ifBirthInsurance = ifBirthInsurance;
	}

	public String getIfHousingReserve() {
		return ifHousingReserve;
	}

	public void setIfHousingReserve(String ifHousingReserve) {
		this.ifHousingReserve = ifHousingReserve;
	}

	/**
	 * 获取 是否社工师
	 * @return String
	 */
	public String getIfWorker() {
		return ifWorker;
	}

	/**
	 * 设置 是否社工师
	 */
	public void setIfWorker(String ifWorker) {
		this.ifWorker = ifWorker;
	}

	/**
	 * 获取 是否大学生村官
	 * @return String
	 */
	public String getIfOfficial() {
		return ifOfficial;
	}

	/**
	 * 设置 是否大学生村官
	 */
	public void setIfOfficial(String ifOfficial) {
		this.ifOfficial = ifOfficial;
	}

	/**
	 * 获取 月补贴收入
	 * @return BigDecimal
	 */
	public BigDecimal getSubsidyMon() {
		return subsidyMon;
	}

	/**
	 * 设置 月补贴收入
	 */
	public void setSubsidyMon(BigDecimal subsidyMon) {
		this.subsidyMon = subsidyMon;
	}

	/**
	 * 获取 所属行政区划
	 * @return BigDecimal
	 */
	public String getOrganCode() {
		return organCode;
	}

	/**
	 * 设置 所属行政区划
	 */
	public void setOrganCode(String organCode) {
		this.organCode = organCode;
	}

	/**
	 * 获取 备注
	 * @return String
	 */
	public String getNote() {
		return note;
	}

	/**
	 * 设置 备注
	 */
	public void setNote(String note) {
		this.note = note;
	}

	public String getIfPartTime() {
		return ifPartTime;
	}

	public void setIfPartTime(String ifPartTime) {
		this.ifPartTime = ifPartTime;
	}

	public String getIfReelected() {
		return ifReelected;
	}

	public void setIfReelected(String ifReelected) {
		this.ifReelected = ifReelected;
	}


}