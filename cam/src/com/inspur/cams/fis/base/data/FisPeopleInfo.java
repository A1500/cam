package com.inspur.cams.fis.base.data;

import java.util.ArrayList;
import java.util.List;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * @Path com.inspur.cams.fis.base.data.FisPeopleInfo
 * @Description: TODO 殡葬业务工作人员信息表
 * @author jiangzhaobao
 * @date 2011-11-15
 */
@Table(tableName = "fis_people_info", keyFields = "peopleId")
public class FisPeopleInfo extends StatefulDatabean {
	// 岗位信息
	@Transient
	private List<FisDutyInfo> dutyInfoList = new ArrayList<FisDutyInfo>();
	// 关系内码
	@Transient
	private String relationId;
	// 服务项目内码
	@Transient
	private String serviceId;

	// 人员编号
	@Column(name = "people_Id")
	private String peopleId;
	// 员工编号
	@Column(name = "people_Code")
	private String peopleCode;
	// 人员内码
	@Column(name = "organ_Id")
	private String organId;
	// 人员类型
	@Column(name = "people_Type")
	private String peopleType;
	// 姓名
	@Column(name = "name")
	private String name;
	// 性别
	@Column(name = "sex")
	private String sex;
	// 身份证件号
	@Column(name = "id_Card")
	private String idCard;
	// 政治面貌
	@Column(name = "political")
	private String political;
	// 文化程度
	@Column(name = "education")
	private String education;
	// 出生日期
	@Column(name = "birthday")
	private String birthday;
	// 民族
	@Column(name = "folk")
	private String folk;
	// 行政级别
	@Column(name = "profession")
	private String profession;
	// 职务
	@Column(name = "position")
	private String position;
	// 是否法人代表
	@Column(name = "if_Legal")
	private String ifLegal;
	// 联系电话
	@Column(name = "phone")
	private String phone;
	// 工作单位
	@Column(name = "work_Name")
	private String workName;
	// 从业日期
	@Column(name = "work_Date")
	private String workDate;
	// 是否离岗
	@Column(name = "if_Cancel")
	private String ifCancel;
	// 离岗时间
	@Column(name = "cancel_Time")
	private String cancelTime;
	// 离岗原因
	@Column(name = "cancel_Reason")
	private String cancelReason;
	// 登记单位
	@Column(name = "create_Organ")
	private String createOrgan;
	// 登记单位名称
	@Column(name = "create_Organ_Name")
	private String createOrganName;
	// 登记人
	@Column(name = "create_People")
	private String createPeople;
	// 登记人姓名
	@Column(name = "create_People_Name")
	private String createPeopleName;
	// 登记时间
	@Column(name = "create_Time")
	private String createTime;
	// 是否统计工作量
	@Column(name = "statistics_workload")
	private String statisticsWorkload;
	// 是否可用
	@Column(name = "IN_USE")
	private String inUse;

	// 对应Bsp人力资源表中STRU_ID
	// @Column(name = "BSP_STRU_ID")
	// private String bspStruId;

	/**
	 * getter for 人员编号
	 * 
	 * @generated
	 */
	public String getPeopleId() {
		return this.peopleId;
	}

	/**
	 * setter for 人员编号
	 * 
	 * @generated
	 */
	public void setPeopleId(String peopleId) {
		this.peopleId = peopleId;
	}

	/**
	 * getter for 人员内码
	 * 
	 * @generated
	 */
	public String getOrganId() {
		return this.organId;
	}

	/**
	 * setter for 人员内码
	 * 
	 * @generated
	 */
	public void setOrganId(String organId) {
		this.organId = organId;
	}

	/**
	 * getter for 人员类型
	 * 
	 * @generated
	 */
	public String getPeopleType() {
		return this.peopleType;
	}

	/**
	 * setter for 人员类型
	 * 
	 * @generated
	 */
	public void setPeopleType(String peopleType) {
		this.peopleType = peopleType;
	}

	/**
	 * getter for 姓名
	 * 
	 * @generated
	 */
	public String getName() {
		return this.name;
	}

	/**
	 * setter for 姓名
	 * 
	 * @generated
	 */
	public void setName(String name) {
		this.name = name;
	}

	/**
	 * getter for 性别
	 * 
	 * @generated
	 */
	public String getSex() {
		return this.sex;
	}

	/**
	 * setter for 性别
	 * 
	 * @generated
	 */
	public void setSex(String sex) {
		this.sex = sex;
	}

	/**
	 * getter for 身份证件号
	 * 
	 * @generated
	 */
	public String getIdCard() {
		return this.idCard;
	}

	/**
	 * setter for 身份证件号
	 * 
	 * @generated
	 */
	public void setIdCard(String idCard) {
		this.idCard = idCard;
	}

	/**
	 * getter for 政治面貌
	 * 
	 * @generated
	 */
	public String getPolitical() {
		return this.political;
	}

	/**
	 * setter for 政治面貌
	 * 
	 * @generated
	 */
	public void setPolitical(String political) {
		this.political = political;
	}

	/**
	 * getter for 文化程度
	 * 
	 * @generated
	 */
	public String getEducation() {
		return this.education;
	}

	/**
	 * setter for 文化程度
	 * 
	 * @generated
	 */
	public void setEducation(String education) {
		this.education = education;
	}

	/**
	 * getter for 行政级别
	 * 
	 * @generated
	 */
	public String getProfession() {
		return this.profession;
	}

	/**
	 * setter for 行政级别
	 * 
	 * @generated
	 */
	public void setProfession(String profession) {
		this.profession = profession;
	}

	/**
	 * getter for 职务
	 * 
	 * @generated
	 */
	public String getPosition() {
		return this.position;
	}

	/**
	 * setter for 职务
	 * 
	 * @generated
	 */
	public void setPosition(String position) {
		this.position = position;
	}

	/**
	 * getter for 是否法人代表
	 * 
	 * @generated
	 */
	public String getIfLegal() {
		return this.ifLegal;
	}

	/**
	 * setter for 是否法人代表
	 * 
	 * @generated
	 */
	public void setIfLegal(String ifLegal) {
		this.ifLegal = ifLegal;
	}

	/**
	 * getter for 联系电话
	 * 
	 * @generated
	 */
	public String getPhone() {
		return this.phone;
	}

	/**
	 * setter for 联系电话
	 * 
	 * @generated
	 */
	public void setPhone(String phone) {
		this.phone = phone;
	}

	/**
	 * getter for 工作单位
	 * 
	 * @generated
	 */
	public String getWorkName() {
		return this.workName;
	}

	/**
	 * setter for 工作单位
	 * 
	 * @generated
	 */
	public void setWorkName(String workName) {
		this.workName = workName;
	}

	/**
	 * getter for 从业日期
	 * 
	 * @generated
	 */
	public String getWorkDate() {
		return this.workDate;
	}

	/**
	 * setter for 从业日期
	 * 
	 * @generated
	 */
	public void setWorkDate(String workDate) {
		this.workDate = workDate;
	}

	/**
	 * getter for 是否注销
	 * 
	 * @generated
	 */
	public String getIfCancel() {
		return this.ifCancel;
	}

	/**
	 * setter for 是否注销
	 * 
	 * @generated
	 */
	public void setIfCancel(String ifCancel) {
		this.ifCancel = ifCancel;
	}

	/**
	 * getter for 登记单位
	 * 
	 * @generated
	 */
	public String getCreateOrgan() {
		return this.createOrgan;
	}

	/**
	 * setter for 登记单位
	 * 
	 * @generated
	 */
	public void setCreateOrgan(String createOrgan) {
		this.createOrgan = createOrgan;
	}

	/**
	 * getter for 登记单位名称
	 * 
	 * @generated
	 */
	public String getCreateOrganName() {
		return this.createOrganName;
	}

	/**
	 * setter for 登记单位名称
	 * 
	 * @generated
	 */
	public void setCreateOrganName(String createOrganName) {
		this.createOrganName = createOrganName;
	}

	/**
	 * getter for 登记人
	 * 
	 * @generated
	 */
	public String getCreatePeople() {
		return this.createPeople;
	}

	/**
	 * setter for 登记人
	 * 
	 * @generated
	 */
	public void setCreatePeople(String createPeople) {
		this.createPeople = createPeople;
	}

	/**
	 * getter for 登记人姓名
	 * 
	 * @generated
	 */
	public String getCreatePeopleName() {
		return this.createPeopleName;
	}

	/**
	 * setter for 登记人姓名
	 * 
	 * @generated
	 */
	public void setCreatePeopleName(String createPeopleName) {
		this.createPeopleName = createPeopleName;
	}

	/**
	 * getter for 登记时间
	 * 
	 * @generated
	 */
	public String getCreateTime() {
		return this.createTime;
	}

	/**
	 * setter for 登记时间
	 * 
	 * @generated
	 */
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	/**
	 * getter for 是否统计工作量
	 * 
	 * @generated
	 */
	public String getStatisticsWorkload() {
		return statisticsWorkload;
	}

	/**
	 * setter for 是否统计工作量
	 * 
	 * @generated
	 */
	public void setStatisticsWorkload(String statisticsWorkload) {
		this.statisticsWorkload = statisticsWorkload;
	}

	public String getRelationId() {
		return relationId;
	}

	public void setRelationId(String relationId) {
		this.relationId = relationId;
	}

	public String getServiceId() {
		return serviceId;
	}

	public void setServiceId(String serviceId) {
		this.serviceId = serviceId;
	}

	/**
	 * getter for 岗位信息
	 * 
	 * @generated
	 */
	public List<FisDutyInfo> getDutyInfoList() {
		return dutyInfoList;
	}

	/**
	 * setter for 岗位信息
	 * 
	 * @generated
	 */
	public void setDutyInfoList(List<FisDutyInfo> dutyInfoList) {
		this.dutyInfoList = dutyInfoList;
	}

	public String getCancelTime() {
		return cancelTime;
	}

	public void setCancelTime(String cancelTime) {
		this.cancelTime = cancelTime;
	}

	public String getCancelReason() {
		return cancelReason;
	}

	public void setCancelReason(String cancelReason) {
		this.cancelReason = cancelReason;
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

	public String getPeopleCode() {
		return peopleCode;
	}

	public void setPeopleCode(String peopleCode) {
		this.peopleCode = peopleCode;
	}

	public String getInUse() {
		return inUse;
	}

	public void setInUse(String inUse) {
		this.inUse = inUse;
	}

	// public String getBspStruId() {
	// return bspStruId;
	// }
	//
	// public void setBspStruId(String bspStruId) {
	// this.bspStruId = bspStruId;
	// }

}