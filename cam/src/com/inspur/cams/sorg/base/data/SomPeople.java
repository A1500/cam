package com.inspur.cams.sorg.base.data;

import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * 社会组织人员databean
 * @author Muqi
 * @date 2011年9月20日9:22:15
 */
@Table(tableName = "SOM_PEOPLE", keyFields = "peopleId")
public class SomPeople extends StatefulDatabean {
	
	// 社会组织人员ID
	private String peopleId;
	
	// 姓名
	private String name;
	
	// 曾用名
	private String aliasName;
	
	// 性别
	private String sex;
	
	// 民族
	private String folk;
	
	// 出生日期
	private String birthday;
	
	// 国籍
	private String nation;
	
	// 身份证件种类
	private String cardType;
	
	// 身份证件号码
	private String idCard;
	
	// 政治面貌
	private String politics;
	
	// 学历
	private String education;
	
	// 户口所在地
	private String populace;
	
	// 户籍
	private String birthplace;
	
	// 家庭住址
	private String adds;
	
	// 家庭住址邮编
	private String postCode;
	
	// 电话
	private String phone;
	
	// 人事关系所在单位
	private String personUnit;
	
	// 人事关系所在单位电话
	private String personUnitPhone;
	
	// 是否党政领导
	private String ifPartyLeader;
	
	// 党政职级
	private String partyLeaderLevel;
	
	// 是否离退休
	private String ifRetire;
	
	// 工作单位
	private String workName;
	
	// 工作单位电话
	private String workPhone;
	
	// 工作单位职务
	private String workDuties;
	
	// 技术职称
	private String profession;
	
	// 是否专（兼）职
	private String ifFulltime;
	
	// 党员类别
	private String peoplePartyType;
	
	// 入党日期
	private String joinDate;
	
	// 组织关系
	private String relation;
	
	// 党内职务
	private String partyDuties;
	
	// 是否流动党员
	private String ifMoblie;
	
	// 确定发展对象时间
	private String developDate;
	
	// 确定入党积极份子时间
	private String activistsDate;
	
	// 确定申请入党人时间
	private String applicationDate;
	
	// 个人简历
	private String resume;
	
	// 是否社团法人代表
	@Transient
	private String ifLegal;
	
	// 亲属关系
	private String relative;
	
	// 照片ID
	private String photoId;
	
	// 照片Base64码
	@Transient
	private String photoText;
	
	// 录入人
	private String createPeople;
	
	// 录入时间
	private String createTime;
	
	// 备注
	private String note;
	
	// 是否受限人员
	@Transient
	private String ifLimit;
	
	// 受限人员id
	@Transient
	private String restrictPeopleId;
	
	public String getPeopleId() {
		return peopleId;
	}

	public void setPeopleId(String peopleId) {
		this.peopleId = peopleId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAliasName() {
		return aliasName;
	}

	public void setAliasName(String aliasName) {
		this.aliasName = aliasName;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getFolk() {
		return folk;
	}

	public void setFolk(String folk) {
		this.folk = folk;
	}

	public String getBirthday() {
		return birthday;
	}

	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}

	public String getNation() {
		return nation;
	}

	public void setNation(String nation) {
		this.nation = nation;
	}

	public String getCardType() {
		return cardType;
	}

	public void setCardType(String cardType) {
		this.cardType = cardType;
	}

	public String getIdCard() {
		return idCard;
	}

	public void setIdCard(String idCard) {
		this.idCard = idCard;
	}

	public String getPolitics() {
		return politics;
	}

	public void setPolitics(String politics) {
		this.politics = politics;
	}

	public String getEducation() {
		return education;
	}

	public void setEducation(String education) {
		this.education = education;
	}

	public String getPopulace() {
		return populace;
	}

	public void setPopulace(String populace) {
		this.populace = populace;
	}

	public String getBirthplace() {
		return birthplace;
	}

	public void setBirthplace(String birthplace) {
		this.birthplace = birthplace;
	}

	public String getAdds() {
		return adds;
	}

	public void setAdds(String adds) {
		this.adds = adds;
	}

	public String getPostCode() {
		return postCode;
	}

	public void setPostCode(String postCode) {
		this.postCode = postCode;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getPersonUnit() {
		return personUnit;
	}

	public void setPersonUnit(String personUnit) {
		this.personUnit = personUnit;
	}

	public String getPersonUnitPhone() {
		return personUnitPhone;
	}

	public void setPersonUnitPhone(String personUnitPhone) {
		this.personUnitPhone = personUnitPhone;
	}	

	public String getIfPartyLeader() {
		return ifPartyLeader;
	}

	public void setIfPartyLeader(String ifPartyLeader) {
		this.ifPartyLeader = ifPartyLeader;
	}

	public String getIfRetire() {
		return ifRetire;
	}

	public void setIfRetire(String ifRetire) {
		this.ifRetire = ifRetire;
	}

	public String getWorkName() {
		return workName;
	}

	public void setWorkName(String workName) {
		this.workName = workName;
	}

	public String getWorkPhone() {
		return workPhone;
	}

	public void setWorkPhone(String workPhone) {
		this.workPhone = workPhone;
	}

	public String getWorkDuties() {
		return workDuties;
	}

	public void setWorkDuties(String workDuties) {
		this.workDuties = workDuties;
	}

	public String getProfession() {
		return profession;
	}

	public void setProfession(String profession) {
		this.profession = profession;
	}

	public String getIfFulltime() {
		return ifFulltime;
	}

	public void setIfFulltime(String ifFulltime) {
		this.ifFulltime = ifFulltime;
	}

	public String getPeoplePartyType() {
		return peoplePartyType;
	}

	public void setPeoplePartyType(String peoplePartyType) {
		this.peoplePartyType = peoplePartyType;
	}

	public String getJoinDate() {
		return joinDate;
	}

	public void setJoinDate(String joinDate) {
		this.joinDate = joinDate;
	}

	public String getRelation() {
		return relation;
	}

	public void setRelation(String relation) {
		this.relation = relation;
	}

	public String getPartyDuties() {
		return partyDuties;
	}

	public void setPartyDuties(String partyDuties) {
		this.partyDuties = partyDuties;
	}

	public String getIfMoblie() {
		return ifMoblie;
	}

	public void setIfMoblie(String ifMoblie) {
		this.ifMoblie = ifMoblie;
	}

	public String getDevelopDate() {
		return developDate;
	}

	public void setDevelopDate(String developDate) {
		this.developDate = developDate;
	}

	public String getActivistsDate() {
		return activistsDate;
	}

	public void setActivistsDate(String activistsDate) {
		this.activistsDate = activistsDate;
	}

	public String getApplicationDate() {
		return applicationDate;
	}

	public void setApplicationDate(String applicationDate) {
		this.applicationDate = applicationDate;
	}

	public String getResume() {
		return resume;
	}

	public void setResume(String resume) {
		this.resume = resume;
	}

	public String getIfLegal() {
		return ifLegal;
	}

	public void setIfLegal(String ifLegal) {
		this.ifLegal = ifLegal;
	}

	public String getRelative() {
		return relative;
	}

	public void setRelative(String relative) {
		this.relative = relative;
	}

	public String getPhotoId() {
		return photoId;
	}

	public void setPhotoId(String photoId) {
		this.photoId = photoId;
	}

	public String getCreatePeople() {
		return createPeople;
	}

	public void setCreatePeople(String createPeople) {
		this.createPeople = createPeople;
	}

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public String getPhotoText() {
		return photoText;
	}

	public void setPhotoText(String photoText) {
		this.photoText = photoText;
	}

	public String getIfLimit() {
		return ifLimit;
	}

	public void setIfLimit(String ifLimit) {
		this.ifLimit = ifLimit;
	}

	public String getRestrictPeopleId() {
		return restrictPeopleId;
	}

	public void setRestrictPeopleId(String restrictPeopleId) {
		this.restrictPeopleId = restrictPeopleId;
	}

	public String getPartyLeaderLevel() {
		return partyLeaderLevel;
	}

	public void setPartyLeaderLevel(String partyLeaderLevel) {
		this.partyLeaderLevel = partyLeaderLevel;
	}

}