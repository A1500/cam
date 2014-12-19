package com.inspur.cams.drel.samu.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 供养对象信息表databean
 * @author 
 * @date 2012-10-24
 */
@Table(tableName = "SAM_GERO_KEPT_PERSON", keyFields = "personId")
public class SamGeroKeptPerson extends StatefulDatabean {

	// 供养对象ID
	private String personId;

	// 敬老院ID
	private String gerocomiumId;

	// 姓名
	private String personName;

	// 性别
	private String sex;

	// 证件类型
	private String cardType;

	// 身份证号
	private String idCard;

	// 出生日期
	private String birthday;

	// 民族
	private String nation;

	// 政治面貌
	private String politicsStatus;

	// 家庭住址
	private String familyAdd;

	// 照片
	private String photoId;

	// 是否已建健康档案
	private String ifArchive;

	// 所在房间
	private String inRoom;

	// 所用床位
	private String inBed;

	// 在院状态
	private String isStatus;

	// 入/出院时间
	private String inoutDate;

	// 出院原因
	private String reason;

	// 更新人
	private String updatePerson;

	// 更新时间
	private String updateDate;

	/**
	 * 获取 供养对象ID
	 * @return String
	 */
	public String getPersonId() {
		return personId;
	}

	/**
	 * 设置 供养对象ID
	 */
	public void setPersonId(String personId) {
		this.personId = personId;
	}

	/**
	 * 获取 敬老院ID
	 * @return String
	 */
	public String getGerocomiumId() {
		return gerocomiumId;
	}

	/**
	 * 设置 敬老院ID
	 */
	public void setGerocomiumId(String gerocomiumId) {
		this.gerocomiumId = gerocomiumId;
	}

	/**
	 * 获取 姓名
	 * @return String
	 */
	public String getPersonName() {
		return personName;
	}

	/**
	 * 设置 姓名
	 */
	public void setPersonName(String personName) {
		this.personName = personName;
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
	 * 获取 证件类型
	 * @return String
	 */
	public String getCardType() {
		return cardType;
	}

	/**
	 * 设置 证件类型
	 */
	public void setCardType(String cardType) {
		this.cardType = cardType;
	}

	/**
	 * 获取 身份证号
	 * @return String
	 */
	public String getIdCard() {
		return idCard;
	}

	/**
	 * 设置 身份证号
	 */
	public void setIdCard(String idCard) {
		this.idCard = idCard;
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
	 * 获取 政治面貌
	 * @return String
	 */
	public String getPoliticsStatus() {
		return politicsStatus;
	}

	/**
	 * 设置 政治面貌
	 */
	public void setPoliticsStatus(String politicsStatus) {
		this.politicsStatus = politicsStatus;
	}

	/**
	 * 获取 家庭住址
	 * @return String
	 */
	public String getFamilyAdd() {
		return familyAdd;
	}

	/**
	 * 设置 家庭住址
	 */
	public void setFamilyAdd(String familyAdd) {
		this.familyAdd = familyAdd;
	}

	/**
	 * 获取 照片
	 * @return String
	 */
	public String getPhotoId() {
		return photoId;
	}

	/**
	 * 设置 照片
	 */
	public void setPhotoId(String photoId) {
		this.photoId = photoId;
	}

	/**
	 * 获取 是否已建健康档案
	 * @return String
	 */
	public String getIfArchive() {
		return ifArchive;
	}

	/**
	 * 设置 是否已建健康档案
	 */
	public void setIfArchive(String ifArchive) {
		this.ifArchive = ifArchive;
	}

	/**
	 * 获取 所在房间
	 * @return String
	 */
	public String getInRoom() {
		return inRoom;
	}

	/**
	 * 设置 所在房间
	 */
	public void setInRoom(String inRoom) {
		this.inRoom = inRoom;
	}

	/**
	 * 获取 所用床位
	 * @return String
	 */
	public String getInBed() {
		return inBed;
	}

	/**
	 * 设置 所用床位
	 */
	public void setInBed(String inBed) {
		this.inBed = inBed;
	}

	/**
	 * 获取 在院状态
	 * @return String
	 */
	public String getIsStatus() {
		return isStatus;
	}

	/**
	 * 设置 在院状态
	 */
	public void setIsStatus(String isStatus) {
		this.isStatus = isStatus;
	}

	/**
	 * 获取 入/出院时间
	 * @return String
	 */
	public String getInoutDate() {
		return inoutDate;
	}

	/**
	 * 设置 入/出院时间
	 */
	public void setInoutDate(String inoutDate) {
		this.inoutDate = inoutDate;
	}

	/**
	 * 获取 出院原因
	 * @return String
	 */
	public String getReason() {
		return reason;
	}

	/**
	 * 设置 出院原因
	 */
	public void setReason(String reason) {
		this.reason = reason;
	}

	/**
	 * 获取 更新人
	 * @return String
	 */
	public String getUpdatePerson() {
		return updatePerson;
	}

	/**
	 * 设置 更新人
	 */
	public void setUpdatePerson(String updatePerson) {
		this.updatePerson = updatePerson;
	}

	/**
	 * 获取 更新时间
	 * @return String
	 */
	public String getUpdateDate() {
		return updateDate;
	}

	/**
	 * 设置 更新时间
	 */
	public void setUpdateDate(String updateDate) {
		this.updateDate = updateDate;
	}

}