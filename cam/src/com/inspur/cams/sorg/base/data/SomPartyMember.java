package com.inspur.cams.sorg.base.data;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.dao.Transient;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:社会组织党员信息
 * @description:
 * @author:
 * @since:2012-04-08
 * @version:1.0
 */
@Table(tableName = "SOM_PARTY_MEMBER", keyFields = "memberId")
public class SomPartyMember extends StatefulDatabean {
	// 党建党内奖惩
	@Transient
	private List<SomPartyPraise> somPartyPraiseList = new ArrayList<SomPartyPraise>();
	// 党员id
	@Column(name = "MEMBER_ID")
	private String memberId;
	// 社会组织id
	@Column(name = "SORG_ID")
	private String sorgId;
	// 党员类别
	@Column(name = "PEOPLE_TYPE")
	private String peopleType;
	// 姓名
	@Column(name = "NAME")
	private String name;
	// 性别
	@Column(name = "SEX")
	private String sex;
	// 出生日期
	@Column(name = "BIRTHDAY")
	private String birthday;
	// 民族
	@Column(name = "FOLK")
	private String folk;
	// 学历
	@Column(name = "EDUCATION")
	private String education;
	// 学位
	@Column(name = "DEGREE")
	private String degree;
	// 身份证件号码
	@Column(name = "ID_CARD")
	private String idCard;
	// 电话
	@Column(name = "PHONE")
	private String phone;
	// 社会组织职务
	@Column(name = "SORG_DUTIES")
	private String sorgDuties;
	// 社会组织党内职务
	@Column(name = "PARTY_DUTIES")
	private String partyDuties;
	// 主要任职单位
	@Column(name = "WORK_NAME")
	private String workName;
	// 主要任职单位职务
	@Column(name = "WORK_DUTIES")
	private String workDuties;
	// 技术职称
	@Column(name = "PROFESSION")
	private String profession;
	// 是否专（兼）职
	@Column(name = "IF_FULLTIME")
	private String ifFulltime;
	// 是否党建指导员
	@Column(name = "IF_INSTRCTOR")
	private String ifInstrctor;
	// 是否跨支部党员
	@Column(name = "IF_OTHER_BRANCH")
	private String ifOtherBranch;
	//转入转出
	private String inOrOut;
	//转入类型
	private String inType;
	//转入时间
	private String inTime;
	//从何单位转入
	private String inFromOrgan;
	//转出类型
	private String outType;
	//转出时间
	private String outTime;
	//转出到何单位
	private String outToOrgan;
	// 是否困难
	@Column(name = "IF_POOR")
	private String ifPoor;
	// 隶属组织分类
	@Column(name = "BELONG_ORG_TYPE")
	private String belongOrgType;
	// 隶属组织
	@Column(name = "BELONG_ORG")
	private String belongOrg;
	// 组织关系
	@Column(name = "RELATION")
	private String relation;
	// 入党日期
	@Column(name = "JOIN_DATE")
	private String joinDate;
	// 转正日期
	@Column(name = "NORMAL_DATE")
	private String normalDate;
	// 转正情况
	private String normalInfo;
	// 申请入党日期
	@Column(name = "APPLICATION_DATE")
	private String applicationDate;
	// 确定入党积极份子日期
	@Column(name = "ACTIVISTS_DATE")
	private String activistsDate;
	// 确定发展对象日期
	@Column(name = "DEVELOP_DATE")
	private String developDate;
	
	//党员状态
	private String memberStatus;
	
	//党员状态上一次变更时间
	private String statusChangeDate;
	
	//登记管理机关名称
	private String morgName;
	
	//登记管理机关行政区划
	private String morgArea;
	
	//登记人ID
	private String regPeopleOrganId;
	
	//登记人
	private String regPeople;
	
	//登记日期
	private String regDate;
	
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public String getSorgId() {
		return sorgId;
	}
	public void setSorgId(String sorgId) {
		this.sorgId = sorgId;
	}
	public String getPeopleType() {
		return peopleType;
	}
	public void setPeopleType(String peopleType) {
		this.peopleType = peopleType;
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
	public String getBirthday() {
		return birthday;
	}
	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}
	public String getFolk() {
		return folk;
	}
	public void setFolk(String folk) {
		this.folk = folk;
	}
	public String getEducation() {
		return education;
	}
	public void setEducation(String education) {
		this.education = education;
	}
	public String getDegree() {
		return degree;
	}
	public void setDegree(String degree) {
		this.degree = degree;
	}
	public String getIdCard() {
		return idCard;
	}
	public void setIdCard(String idCard) {
		this.idCard = idCard;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getSorgDuties() {
		return sorgDuties;
	}
	public void setSorgDuties(String sorgDuties) {
		this.sorgDuties = sorgDuties;
	}
	public String getPartyDuties() {
		return partyDuties;
	}
	public void setPartyDuties(String partyDuties) {
		this.partyDuties = partyDuties;
	}
	public String getWorkName() {
		return workName;
	}
	public void setWorkName(String workName) {
		this.workName = workName;
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
	public String getIfInstrctor() {
		return ifInstrctor;
	}
	public void setIfInstrctor(String ifInstrctor) {
		this.ifInstrctor = ifInstrctor;
	}
	public String getIfOtherBranch() {
		return ifOtherBranch;
	}
	public void setIfOtherBranch(String ifOtherBranch) {
		this.ifOtherBranch = ifOtherBranch;
	}
	public String getIfPoor() {
		return ifPoor;
	}
	public void setIfPoor(String ifPoor) {
		this.ifPoor = ifPoor;
	}
	public String getBelongOrg() {
		return belongOrg;
	}
	public void setBelongOrg(String belongOrg) {
		this.belongOrg = belongOrg;
	}
	public String getRelation() {
		return relation;
	}
	public void setRelation(String relation) {
		this.relation = relation;
	}
	public String getJoinDate() {
		return joinDate;
	}
	public void setJoinDate(String joinDate) {
		this.joinDate = joinDate;
	}
	public String getNormalDate() {
		return normalDate;
	}
	public void setNormalDate(String normalDate) {
		this.normalDate = normalDate;
	}
	public String getApplicationDate() {
		return applicationDate;
	}
	public void setApplicationDate(String applicationDate) {
		this.applicationDate = applicationDate;
	}
	public String getActivistsDate() {
		return activistsDate;
	}
	public void setActivistsDate(String activistsDate) {
		this.activistsDate = activistsDate;
	}
	public String getDevelopDate() {
		return developDate;
	}
	public void setDevelopDate(String developDate) {
		this.developDate = developDate;
	}
	public String getNormalInfo() {
		return normalInfo;
	}
	public void setNormalInfo(String normalInfo) {
		this.normalInfo = normalInfo;
	}
	public List<SomPartyPraise> getSomPartyPraiseList() {
		return somPartyPraiseList;
	}
	public void setSomPartyPraiseList(List<SomPartyPraise> somPartyPraiseList) {
		this.somPartyPraiseList = somPartyPraiseList;
	}
	public String getInTime() {
		return inTime;
	}
	public void setInTime(String inTime) {
		this.inTime = inTime;
	}
	public String getInOrOut() {
		return inOrOut;
	}
	public void setInOrOut(String inOrOut) {
		this.inOrOut = inOrOut;
	}
	public String getOutTime() {
		return outTime;
	}
	public void setOutTime(String outTime) {
		this.outTime = outTime;
	}
	public String getBelongOrgType() {
		return belongOrgType;
	}
	public void setBelongOrgType(String belongOrgType) {
		this.belongOrgType = belongOrgType;
	}
	public String getInFromOrgan() {
		return inFromOrgan;
	}
	public void setInFromOrgan(String inFromOrgan) {
		this.inFromOrgan = inFromOrgan;
	}
	public String getOutToOrgan() {
		return outToOrgan;
	}
	public void setOutToOrgan(String outToOrgan) {
		this.outToOrgan = outToOrgan;
	}
	public String getInType() {
		return inType;
	}
	public void setInType(String inType) {
		this.inType = inType;
	}
	public String getOutType() {
		return outType;
	}
	public void setOutType(String outType) {
		this.outType = outType;
	}
	public String getMemberStatus() {
		return memberStatus;
	}
	public void setMemberStatus(String memberStatus) {
		this.memberStatus = memberStatus;
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
	public String getRegPeopleOrganId() {
		return regPeopleOrganId;
	}
	public void setRegPeopleOrganId(String regPeopleOrganId) {
		this.regPeopleOrganId = regPeopleOrganId;
	}
	public String getRegPeople() {
		return regPeople;
	}
	public void setRegPeople(String regPeople) {
		this.regPeople = regPeople;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public String getStatusChangeDate() {
		return statusChangeDate;
	}
	public void setStatusChangeDate(String statusChangeDate) {
		this.statusChangeDate = statusChangeDate;
	}
}