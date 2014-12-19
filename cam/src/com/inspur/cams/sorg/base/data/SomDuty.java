package com.inspur.cams.sorg.base.data;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * 社会组织任职信息表
 * @author yanliangliang
 * @date 2011-9-19
 */
@Table(tableName = "SOM_DUTY", keyFields = "dutyId")
public class SomDuty extends StatefulDatabean {
	@Transient
	private List<SomPeopleResume> somPeopleResumeList = new ArrayList<SomPeopleResume>();
	
	// 编号
	private String dutyId;
	
	//业务编号
	private String taskCode;
	
	// 社会组织ID
	private String sorgId;
	
	// 社会组织人员ID
	private String peopleId;
	
	// 届次
	private String sessionId;
	
	// 担任社会组织职务
	private String sorgDuties;
	
	// 任期开始日期
	private String startDate;
	
	// 任期结束日期
	private String endDate;
	
	// 按照章程产生过程情况
	private String progress;
	
	// 是否连任
	private String ifRenew;
	
	// 连任届数
	private String renewNum;
	
	// 是否在任
	private String ifServe;
	
	// 担任其他社会组织职务
	private String otherDuties;
	
	// 组织部批准机关
	private String promiseOrgan;
	
	// 批准文号
	private String promiseCode;
	
	// 批准日期
	private String promiseDate;
	
	// 业务主管单位
	private String borgName;
	
	// 业务主管单位意见
	private String borgOpinion;
	
	// 业务主管单位审查日期
	private String borgCheckDate;
	
	// 工作单位
	private String workName;
	
	// 工作单位意见
	private String workOpinion;
	
	// 工作单位审查日期
	private String workCheckDate;
	
	// 社会组织意见
	private String sorgOpinion;
	
	// 社会组织通过日期
	private String sorgCheckDate;
	
	// 备案状态
	private String regStatus;
	
	// 登记管理机关名称
	private String morgName;
	
	// 登记管理机关行政区划
	private String morgArea;
	
	// 备注
	private String note;
	
	// 录入人
	private String createPeople;
	
	// 录入时间
	private String createTime;
	
	//社会组织类型
	private String sorgType;
	
	//TODO -------------人员信息----------------
	// 姓名
	@Transient
	private String name;
	
	// 曾用名
	@Transient
	private String aliasName;
	
	// 性别
	@Transient
	private String sex;
	
	// 民族
	@Transient
	private String folk;
	
	// 出生日期
	@Transient
	private String birthday;
	
	// 国籍
	@Transient
	private String nation;
	
	// 身份证件种类
	@Transient
	private String cardType;
	
	// 身份证件号码
	@Transient
	private String idCard;
	
	// 政治面貌
	@Transient
	private String politics;
	
	// 学历
	@Transient
	private String education;
	
	// 户口所在地
	@Transient
	private String populace;
	
	//户籍
	@Transient
	private String birthplace;
	
	// 家庭住址
	@Transient
	private String adds;
	
	// 家庭住址邮编
	@Transient
	private String postCode;
	
	// 电话
	@Transient
	private String phone;
	
	// 人事关系所在单位
	@Transient
	private String personUnit;
	
	// 人事关系所在单位电话
	@Transient
	private String personUnitPhone;
	
	//是否党政领导
	@Transient
	private String ifPartyLeader;
	
	//党政职务
	@Transient
	private String partyLeaderLevel;
	
	// 是否离退休
	@Transient
	private String ifRetire;
	
//	// 工作单位
//	@Transient
//	private String workName;
	
	// 工作单位电话
	@Transient
	private String workPhone;
	
	// 工作单位职务
	@Transient
	private String workDuties;
	
	// 技术职称
	@Transient
	private String profession;
	
	// 是否专（兼）职
	@Transient
	private String ifFulltime;
	
	// 党员类别
	@Transient
	private String peoplePartyType;
	
	// 入党日期
	@Transient
	private String joinDate;
	
	// 组织关系
	@Transient
	private String relation;
	
	// 党内职务
	@Transient
	private String partyDuties;
	
	// 是否流动党员
	@Transient
	private String ifMoblie;
	
	// 确定发展对象时间
	@Transient
	private String developDate;
	
	// 确定入党积极份子时间
	@Transient
	private String activistsDate;
	
	// 确定申请入党人时间
	@Transient
	private String applicationDate;
	
	// 个人简历
	@Transient
	private String resume;
	
	// 是否社团法人代表
	@Transient
	private String ifLegal;
	
	// 亲属关系
	@Transient
	private String relative;
	
	// 照片ID
	@Transient
	private String photoId;
	
	// 照片Base64码
	@Transient
	private String photoText;
	
	// 照片路径
	@Transient
	private String photoPath;
	
	/**
	 * 获取SomPeople信息
	 * @return
	 */
	public SomPeople getSomPeople() {
		SomPeople somPeople = new SomPeople();
		somPeople.setPeopleId(getPeopleId());
		somPeople.setName(getName());
		somPeople.setAliasName(getAliasName());
		somPeople.setSex(getSex());
		somPeople.setFolk(getFolk());
		somPeople.setBirthday(getBirthday());
		somPeople.setNation(getNation());
		somPeople.setCardType(getCardType());
		somPeople.setIdCard(getIdCard());
		somPeople.setPolitics(getPolitics());
		somPeople.setEducation(getEducation());
		somPeople.setPopulace(getPopulace());
		somPeople.setBirthplace(getBirthplace());
		somPeople.setAdds(getAdds());
		somPeople.setPostCode(getPostCode());
		somPeople.setPhone(getPhone());
		somPeople.setIfPartyLeader(getIfPartyLeader());
		somPeople.setPartyLeaderLevel(getPartyLeaderLevel());
		somPeople.setIfRetire(getIfRetire());
		somPeople.setWorkName(getWorkName());
		somPeople.setWorkPhone(getWorkPhone());
		somPeople.setWorkDuties(getWorkDuties());
		somPeople.setProfession(getProfession());
		somPeople.setIfFulltime(getIfFulltime());
		somPeople.setPeoplePartyType(getPeoplePartyType());
		somPeople.setJoinDate(getJoinDate());
		somPeople.setRelation(getRelation());
		somPeople.setPartyDuties(getPartyDuties());
		somPeople.setIfMoblie(getIfMoblie());
		somPeople.setDevelopDate(getDevelopDate());
		somPeople.setActivistsDate(getActivistsDate());
		somPeople.setApplicationDate(getApplicationDate());
		somPeople.setResume(getResume());
		somPeople.setIfLegal(getIfLegal());
		somPeople.setRelative(getRelative());
		somPeople.setPhotoId(getPhotoId());
		somPeople.setPhotoText(getPhotoText());
		somPeople.setCreatePeople(getCreatePeople());
		somPeople.setCreateTime(getCreateTime());
		somPeople.setNote(getNote());
		somPeople.setPersonUnit(getPersonUnit());
		somPeople.setPersonUnitPhone(getPersonUnitPhone());
		return somPeople;
	}

	public String getDutyId() {
		return dutyId;
	}

	public void setDutyId(String dutyId) {
		this.dutyId = dutyId;
	}

	public String getTaskCode() {
		return taskCode;
	}

	public void setTaskCode(String taskCode) {
		this.taskCode = taskCode;
	}

	public String getSorgId() {
		return sorgId;
	}

	public void setSorgId(String sorgId) {
		this.sorgId = sorgId;
	}

	public String getPeopleId() {
		return peopleId;
	}

	public void setPeopleId(String peopleId) {
		this.peopleId = peopleId;
	}

	public String getSessionId() {
		return sessionId;
	}

	public void setSessionId(String sessionId) {
		this.sessionId = sessionId;
	}

	public String getSorgDuties() {
		return sorgDuties;
	}

	public void setSorgDuties(String sorgDuties) {
		this.sorgDuties = sorgDuties;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public String getProgress() {
		return progress;
	}

	public void setProgress(String progress) {
		this.progress = progress;
	}

	public String getIfRenew() {
		return ifRenew;
	}

	public void setIfRenew(String ifRenew) {
		this.ifRenew = ifRenew;
	}

	public String getRenewNum() {
		return renewNum;
	}

	public void setRenewNum(String renewNum) {
		this.renewNum = renewNum;
	}

	public String getIfServe() {
		return ifServe;
	}

	public void setIfServe(String ifServe) {
		this.ifServe = ifServe;
	}

	public String getOtherDuties() {
		return otherDuties;
	}

	public void setOtherDuties(String otherDuties) {
		this.otherDuties = otherDuties;
	}

	public String getPromiseOrgan() {
		return promiseOrgan;
	}

	public void setPromiseOrgan(String promiseOrgan) {
		this.promiseOrgan = promiseOrgan;
	}

	public String getPromiseCode() {
		return promiseCode;
	}

	public void setPromiseCode(String promiseCode) {
		this.promiseCode = promiseCode;
	}

	public String getPromiseDate() {
		return promiseDate;
	}

	public void setPromiseDate(String promiseDate) {
		this.promiseDate = promiseDate;
	}

	public String getBorgName() {
		return borgName;
	}

	public void setBorgName(String borgName) {
		this.borgName = borgName;
	}

	public String getBorgOpinion() {
		return borgOpinion;
	}

	public void setBorgOpinion(String borgOpinion) {
		this.borgOpinion = borgOpinion;
	}

	public String getBorgCheckDate() {
		return borgCheckDate;
	}

	public void setBorgCheckDate(String borgCheckDate) {
		this.borgCheckDate = borgCheckDate;
	}

	public String getWorkName() {
		return workName;
	}

	public void setWorkName(String workName) {
		this.workName = workName;
	}

	public String getWorkOpinion() {
		return workOpinion;
	}

	public void setWorkOpinion(String workOpinion) {
		this.workOpinion = workOpinion;
	}

	public String getWorkCheckDate() {
		return workCheckDate;
	}

	public void setWorkCheckDate(String workCheckDate) {
		this.workCheckDate = workCheckDate;
	}

	public String getSorgOpinion() {
		return sorgOpinion;
	}

	public void setSorgOpinion(String sorgOpinion) {
		this.sorgOpinion = sorgOpinion;
	}

	public String getSorgCheckDate() {
		return sorgCheckDate;
	}

	public void setSorgCheckDate(String sorgCheckDate) {
		this.sorgCheckDate = sorgCheckDate;
	}

	public String getRegStatus() {
		return regStatus;
	}

	public void setRegStatus(String regStatus) {
		this.regStatus = regStatus;
	}

	public String getMorgName() {
		return morgName;
	}

	public void setMorgName(String morgName) {
		this.morgName = morgName;
	}

	public String getMorgArea() {
		return morgArea;
	}

	public void setMorgArea(String morgArea) {
		this.morgArea = morgArea;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}
	
	public String getSorgType() {
		return sorgType;
	}

	public void setSorgType(String sorgType) {
		this.sorgType = sorgType;
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

	public String getPhotoText() {
		return photoText;
	}

	public void setPhotoText(String photoText) {
		this.photoText = photoText;
	}

	public List<SomPeopleResume> getSomPeopleResumeList() {
		return somPeopleResumeList;
	}

	public void setSomPeopleResumeList(List<SomPeopleResume> somPeopleResumeList) {
		this.somPeopleResumeList = somPeopleResumeList;
	}

	public String getPhotoPath() {
		return photoPath;
	}

	public void setPhotoPath(String photoPath) {
		this.photoPath = photoPath;
	}

	public String getPartyLeaderLevel() {
		return partyLeaderLevel;
	}

	public void setPartyLeaderLevel(String partyLeaderLevel) {
		this.partyLeaderLevel = partyLeaderLevel;
	}
	
}