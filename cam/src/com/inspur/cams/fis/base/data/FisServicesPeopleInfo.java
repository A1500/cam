package com.inspur.cams.fis.base.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 殡葬服务机构工作人员信息表databean
 * @author 
 * @date Wed May 02 09:01:05 GMT+08:00 2012
 */
@Table(tableName = "FIS_SERVICES_PEOPLE_INFO", keyFields = "peopleId")
public class FisServicesPeopleInfo extends StatefulDatabean {

	// 人员编号
	private String peopleId;

	// 员工编号
	private String peopleCode;

	// 人员类型
	private String peopleType;

	// 姓名
	private String name;

	// 性别
	private String sex;

	// 身份证件号
	private String idCard;

	// 民族
	private String folk;

	// 出生日期
	private String birthday;

	// 政治面貌
	private String political;

	// 文化程度
	private String education;

	// 行政级别
	private String profession;

	// 职务
	private String position;

	// 是否法人代表
	private String ifLegal;

	// 联系电话
	private String phone;

	// 从业日期
	private String workDate;

	// 是否注销
	private String ifCancel;

	// 接受民政部门培训情况
	private String trainCase;

	// 工作单位
	private String workName;

	// 登记单位
	private String createOrgan;

	// 登记单位名称
	private String createOrganName;

	// 登记人
	private String createPeople;

	// 登记人姓名
	private String createPeopleName;

	// 登记时间
	private String createTime;

	/**
	 * 获取 人员编号
	 * @return String
	 */
	public String getPeopleId() {
		return peopleId;
	}

	/**
	 * 设置 人员编号
	 */
	public void setPeopleId(String peopleId) {
		this.peopleId = peopleId;
	}

	/**
	 * 获取 员工编号
	 * @return String
	 */
	public String getPeopleCode() {
		return peopleCode;
	}

	/**
	 * 设置 员工编号
	 */
	public void setPeopleCode(String peopleCode) {
		this.peopleCode = peopleCode;
	}

	/**
	 * 获取 人员类型
	 * @return String
	 */
	public String getPeopleType() {
		return peopleType;
	}

	/**
	 * 设置 人员类型
	 */
	public void setPeopleType(String peopleType) {
		this.peopleType = peopleType;
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
	 * 获取 身份证件号
	 * @return String
	 */
	public String getIdCard() {
		return idCard;
	}

	/**
	 * 设置 身份证件号
	 */
	public void setIdCard(String idCard) {
		this.idCard = idCard;
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
	 * 获取 行政级别
	 * @return String
	 */
	public String getProfession() {
		return profession;
	}

	/**
	 * 设置 行政级别
	 */
	public void setProfession(String profession) {
		this.profession = profession;
	}

	/**
	 * 获取 职务
	 * @return String
	 */
	public String getPosition() {
		return position;
	}

	/**
	 * 设置 职务
	 */
	public void setPosition(String position) {
		this.position = position;
	}

	/**
	 * 获取 是否法人代表
	 * @return String
	 */
	public String getIfLegal() {
		return ifLegal;
	}

	/**
	 * 设置 是否法人代表
	 */
	public void setIfLegal(String ifLegal) {
		this.ifLegal = ifLegal;
	}

	/**
	 * 获取 联系电话
	 * @return String
	 */
	public String getPhone() {
		return phone;
	}

	/**
	 * 设置 联系电话
	 */
	public void setPhone(String phone) {
		this.phone = phone;
	}

	/**
	 * 获取 从业日期
	 * @return String
	 */
	public String getWorkDate() {
		return workDate;
	}

	/**
	 * 设置 从业日期
	 */
	public void setWorkDate(String workDate) {
		this.workDate = workDate;
	}

	/**
	 * 获取 是否注销
	 * @return String
	 */
	public String getIfCancel() {
		return ifCancel;
	}

	/**
	 * 设置 是否注销
	 */
	public void setIfCancel(String ifCancel) {
		this.ifCancel = ifCancel;
	}

	/**
	 * 获取 接受民政部门培训情况
	 * @return String
	 */
	public String getTrainCase() {
		return trainCase;
	}

	/**
	 * 设置 接受民政部门培训情况
	 */
	public void setTrainCase(String trainCase) {
		this.trainCase = trainCase;
	}

	/**
	 * 获取 工作单位
	 * @return String
	 */
	public String getWorkName() {
		return workName;
	}

	/**
	 * 设置 工作单位
	 */
	public void setWorkName(String workName) {
		this.workName = workName;
	}

	/**
	 * 获取 登记单位
	 * @return String
	 */
	public String getCreateOrgan() {
		return createOrgan;
	}

	/**
	 * 设置 登记单位
	 */
	public void setCreateOrgan(String createOrgan) {
		this.createOrgan = createOrgan;
	}

	/**
	 * 获取 登记单位名称
	 * @return String
	 */
	public String getCreateOrganName() {
		return createOrganName;
	}

	/**
	 * 设置 登记单位名称
	 */
	public void setCreateOrganName(String createOrganName) {
		this.createOrganName = createOrganName;
	}

	/**
	 * 获取 登记人
	 * @return String
	 */
	public String getCreatePeople() {
		return createPeople;
	}

	/**
	 * 设置 登记人
	 */
	public void setCreatePeople(String createPeople) {
		this.createPeople = createPeople;
	}

	/**
	 * 获取 登记人姓名
	 * @return String
	 */
	public String getCreatePeopleName() {
		return createPeopleName;
	}

	/**
	 * 设置 登记人姓名
	 */
	public void setCreatePeopleName(String createPeopleName) {
		this.createPeopleName = createPeopleName;
	}

	/**
	 * 获取 登记时间
	 * @return String
	 */
	public String getCreateTime() {
		return createTime;
	}

	/**
	 * 设置 登记时间
	 */
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

}