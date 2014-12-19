package com.inspur.cams.cdc.base.data;

import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 人员基础信息databean
 * @author 
 * @date 2012-05-25
 */
@Table(tableName = "CDC_BASEINFO_PEOPLE", keyFields = "peopleId")
public class CdcBaseinfoPeople extends StatefulDatabean {

	// 人员ID
	private String peopleId;

	// 家庭ID
	private String familyId;

	// 户主关系代码
	private String relationshipType;

	// 所属区、街道
	private String domicileCode;

	// 居住社区
	private String domicileName;

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

	// 住址
	private String address;

	// 邮政编码
	private String postCode;

	// 工作单位
	private String workUnit;

	// 优抚对象类型
	private String bptType;

	// 伤残类型
	private String disabilityFlag;

	// 失业标志
	private String unemployedFlag;

	// 贫困人员
	private String povertyType;

	// 孤儿标识
	private String orphanFlag;

	// 妇女标识
	private String womanFlag;

	// 农民工标志
	private String peasantFlag;

	// 子女上学问题
	private String childrenEducation;

	// 照片ID
	private String photoId;

	// 备注
	private String note;

	/**
	 * 获取 人员ID
	 * @return String
	 */
	public String getPeopleId() {
		return peopleId;
	}

	/**
	 * 设置 人员ID
	 */
	public void setPeopleId(String peopleId) {
		this.peopleId = peopleId;
	}

	/**
	 * 获取 家庭ID
	 * @return String
	 */
	public String getFamilyId() {
		return familyId;
	}

	/**
	 * 设置 家庭ID
	 */
	public void setFamilyId(String familyId) {
		this.familyId = familyId;
	}

	/**
	 * 获取 户主关系代码
	 * @return String
	 */
	public String getRelationshipType() {
		return relationshipType;
	}

	/**
	 * 设置 户主关系代码
	 */
	public void setRelationshipType(String relationshipType) {
		this.relationshipType = relationshipType;
	}

	/**
	 * 获取 所属区、街道
	 * @return String
	 */
	public String getDomicileCode() {
		return domicileCode;
	}

	/**
	 * 设置 所属区、街道
	 */
	public void setDomicileCode(String domicileCode) {
		this.domicileCode = domicileCode;
	}

	/**
	 * 获取 居住社区
	 * @return String
	 */
	public String getDomicileName() {
		return domicileName;
	}

	/**
	 * 设置 居住社区
	 */
	public void setDomicileName(String domicileName) {
		this.domicileName = domicileName;
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
	 * 获取 工作单位
	 * @return String
	 */
	public String getWorkUnit() {
		return workUnit;
	}

	/**
	 * 设置 工作单位
	 */
	public void setWorkUnit(String workUnit) {
		this.workUnit = workUnit;
	}

	/**
	 * 获取 优抚对象类型
	 * @return String
	 */
	public String getBptType() {
		return bptType;
	}

	/**
	 * 设置 优抚对象类型
	 */
	public void setBptType(String bptType) {
		this.bptType = bptType;
	}

	/**
	 * 获取 伤残类型
	 * @return String
	 */
	public String getDisabilityFlag() {
		return disabilityFlag;
	}

	/**
	 * 设置 伤残类型
	 */
	public void setDisabilityFlag(String disabilityFlag) {
		this.disabilityFlag = disabilityFlag;
	}

	/**
	 * 获取 失业标志
	 * @return String
	 */
	public String getUnemployedFlag() {
		return unemployedFlag;
	}

	/**
	 * 设置 失业标志
	 */
	public void setUnemployedFlag(String unemployedFlag) {
		this.unemployedFlag = unemployedFlag;
	}

	/**
	 * 获取 贫困人员
	 * @return String
	 */
	public String getPovertyType() {
		return povertyType;
	}

	/**
	 * 设置 贫困人员
	 */
	public void setPovertyType(String povertyType) {
		this.povertyType = povertyType;
	}

	/**
	 * 获取 孤儿标识
	 * @return String
	 */
	public String getOrphanFlag() {
		return orphanFlag;
	}

	/**
	 * 设置 孤儿标识
	 */
	public void setOrphanFlag(String orphanFlag) {
		this.orphanFlag = orphanFlag;
	}

	/**
	 * 获取 妇女标识
	 * @return String
	 */
	public String getWomanFlag() {
		return womanFlag;
	}

	/**
	 * 设置 妇女标识
	 */
	public void setWomanFlag(String womanFlag) {
		this.womanFlag = womanFlag;
	}

	/**
	 * 获取 农民工标志
	 * @return String
	 */
	public String getPeasantFlag() {
		return peasantFlag;
	}

	/**
	 * 设置 农民工标志
	 */
	public void setPeasantFlag(String peasantFlag) {
		this.peasantFlag = peasantFlag;
	}

	/**
	 * 获取 子女上学问题
	 * @return String
	 */
	public String getChildrenEducation() {
		return childrenEducation;
	}

	/**
	 * 设置 子女上学问题
	 */
	public void setChildrenEducation(String childrenEducation) {
		this.childrenEducation = childrenEducation;
	}

	/**
	 * 获取 照片ID
	 * @return String
	 */
	public String getPhotoId() {
		return photoId;
	}

	/**
	 * 设置 照片ID
	 */
	public void setPhotoId(String photoId) {
		this.photoId = photoId;
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

}