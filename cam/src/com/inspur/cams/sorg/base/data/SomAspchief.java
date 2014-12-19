package com.inspur.cams.sorg.base.data;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * 社会团体拟任负责人
 * @author shgtch
 * @date 2011-8-12
 */
@Table(tableName = "SOM_ASPCHIEF", keyFields = "id")
public class SomAspchief extends StatefulDatabean {
	
	@Transient
	private List<SomPeopleResume> somPeopleResumeList = new ArrayList<SomPeopleResume>();
	
	// 编码
	private String id;
	
	// 社会组织ID
	private String sorgId;
	
	// 业务编号
	private String taskCode;
	
	// 选举决议ID
	private String electionId;
	
	// 名称
	private String name;
	
	// 性别
	private String sex;
	
	// 出生日期
	private String birthday;
	
	// 身份证号码
	private String idCard;
	
	// 政治面貌
	private String politics;
	
	// 工作单位
	private String workName;
	
	// 工作单位职务
	private String workDuties;
	
	// 是否离退休
	private String ifRetire;
	
	// 是否专（兼）职
	private String ifFulltime;
	
	// 亲属关系
	private String relative;
	
	// 户籍
	private String populace;
	
	// 电话
	private String phone;
	
	// 拟任社会组织职务
	private String sorgDuties;
	
	// 组织部批准机关
	private String promiseOrgan;
	
	// 组织部批准文号
	private String promiseCode;
	
	// 组织部批准日期
	private String promiseDate;
	
	// 其他社会组织职务
	private String otherDuties;
	
	// 刑事处罚情况
	private String penal;
	
	// 登记管理机关
	private String morgName;
	
	// 登记管理机关行政区划
	private String morgArea;
	
	// 创建人
	private String createPeople;
	
	// 创建时间
	private String createTime;
	
	//国籍
	private String citizenship;
	
	//证件类型
	private String cardType;
	
	//邮编
	private String postCode;
	
	//民族
	private String folk;
	
	private String age;
	
	//是否是拟任法定代表人
	private String ifLegal;

	public String getAge() {
		return age;
	}

	public void setAge(String age) {
		this.age = age;
	}

	public List<SomPeopleResume> getSomPeopleResumeList() {
		return somPeopleResumeList;
	}

	public void setSomPeopleResumeList(List<SomPeopleResume> somPeopleResumeList) {
		this.somPeopleResumeList = somPeopleResumeList;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getSorgId() {
		return sorgId;
	}

	public void setSorgId(String sorgId) {
		this.sorgId = sorgId;
	}

	public String getTaskCode() {
		return taskCode;
	}

	public void setTaskCode(String taskCode) {
		this.taskCode = taskCode;
	}

	public String getElectionId() {
		return electionId;
	}

	public void setElectionId(String electionId) {
		this.electionId = electionId;
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

	public String getIfRetire() {
		return ifRetire;
	}

	public void setIfRetire(String ifRetire) {
		this.ifRetire = ifRetire;
	}

	public String getIfFulltime() {
		return ifFulltime;
	}

	public void setIfFulltime(String ifFulltime) {
		this.ifFulltime = ifFulltime;
	}

	public String getRelative() {
		return relative;
	}

	public void setRelative(String relative) {
		this.relative = relative;
	}

	public String getPopulace() {
		return populace;
	}

	public void setPopulace(String populace) {
		this.populace = populace;
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

	public String getOtherDuties() {
		return otherDuties;
	}

	public void setOtherDuties(String otherDuties) {
		this.otherDuties = otherDuties;
	}

	public String getPenal() {
		return penal;
	}

	public void setPenal(String penal) {
		this.penal = penal;
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

	public String getCitizenship() {
		return citizenship;
	}

	public void setCitizenship(String citizenship) {
		this.citizenship = citizenship;
	}

	public String getCardType() {
		return cardType;
	}

	public void setCardType(String cardType) {
		this.cardType = cardType;
	}

	public String getPostCode() {
		return postCode;
	}

	public void setPostCode(String postCode) {
		this.postCode = postCode;
	}

	public String getFolk() {
		return folk;
	}

	public void setFolk(String folk) {
		this.folk = folk;
	}

	public String getIfLegal() {
		return ifLegal;
	}

	public void setIfLegal(String ifLegal) {
		this.ifLegal = ifLegal;
	}
	
	
	
}