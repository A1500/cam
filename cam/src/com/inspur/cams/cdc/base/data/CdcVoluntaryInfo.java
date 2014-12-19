package com.inspur.cams.cdc.base.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.dao.Transient;
import org.loushang.next.data.StatefulDatabean;

/**
 * 志愿者信息databean
 * 
 * @author
 * @date 2013-02-26
 */
@Table(tableName = "CDC_VOLUNTARY_INFO", keyFields = "voluntaryId")
public class CdcVoluntaryInfo extends StatefulDatabean {

	// 志愿者编号
	private String voluntaryId;

	// 姓名
	private String name;

	// 身份证号
	private String idCard;

	// 性别
	private String sex;

	// 出生日期
	private String birthday;

	// 教育程度
	private String eduCode;

	// 政治面貌
	private String politicalCode;

	// 工作单位
	private String workUnit;

	// 联系电话
	private String tel;

	// 电子邮箱
	private String email;

	// 家庭住址
	private String address;

	// 邮编
	private String postCode;

	// 特长
	private String forte;
	
	
	// 照片
	private String photoId;

	// 志愿活动累计次数
	private BigDecimal caperNums;

	// 志愿活动累计时间
	private BigDecimal caperTimes;

	// 录入单位行政区划
	private String organCode;

	// 录入单位名称
	private String organName;
	
	// 录入时间
	private String createTime;

	// 开始时间
	@Transient
	private String startTime;

	// 结束时间
	@Transient
	private String endTime;

	// 总时长
	@Transient
	private BigDecimal totalTimes;

	/**
	 * 获取 志愿者编号
	 * 
	 * @return String
	 */
	public String getVoluntaryId() {
		return voluntaryId;
	}

	/**
	 * 设置 志愿者编号
	 */
	public void setVoluntaryId(String voluntaryId) {
		this.voluntaryId = voluntaryId;
	}

	/**
	 * 获取 姓名
	 * 
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
	 * 获取 身份证号
	 * 
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
	 * 获取 性别
	 * 
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
	 * 
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
	 * 获取 教育程度
	 * 
	 * @return String
	 */
	public String getEduCode() {
		return eduCode;
	}

	/**
	 * 设置 教育程度
	 */
	public void setEduCode(String eduCode) {
		this.eduCode = eduCode;
	}

	/**
	 * 获取 政治面貌
	 * 
	 * @return String
	 */
	public String getPoliticalCode() {
		return politicalCode;
	}

	/**
	 * 设置 政治面貌
	 */
	public void setPoliticalCode(String politicalCode) {
		this.politicalCode = politicalCode;
	}

	/**
	 * 获取 工作单位
	 * 
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
	 * 获取 联系电话
	 * 
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
	 * 获取 电子邮箱
	 * 
	 * @return String
	 */
	public String getEmail() {
		return email;
	}

	/**
	 * 设置 电子邮箱
	 */
	public void setEmail(String email) {
		this.email = email;
	}

	/**
	 * 获取 家庭住址
	 * 
	 * @return String
	 */
	public String getAddress() {
		return address;
	}

	/**
	 * 设置 家庭住址
	 */
	public void setAddress(String address) {
		this.address = address;
	}

	/**
	 * 获取 邮编
	 * 
	 * @return String
	 */
	public String getPostCode() {
		return postCode;
	}

	/**
	 * 设置 邮编
	 */
	public void setPostCode(String postCode) {
		this.postCode = postCode;
	}

	/**
	 * 获取 特长
	 * 
	 * @return String
	 */
	public String getForte() {
		return forte;
	}

	/**
	 * 设置 特长
	 */
	public void setForte(String forte) {
		this.forte = forte;
	}

	/**
	 * 获取 照片
	 * 
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
	 * 获取 志愿活动累计时间
	 * 
	 * @return BigDecimal
	 */
	public BigDecimal getCaperTimes() {
		return caperTimes;
	}

	/**
	 * 设置 志愿活动累计时间
	 */
	public void setCaperTimes(BigDecimal caperTimes) {
		this.caperTimes = caperTimes;
	}

	public String getOrganCode() {
		return organCode;
	}

	public void setOrganCode(String organCode) {
		this.organCode = organCode;
	}

	public String getOrganName() {
		return organName;
	}

	public void setOrganName(String organName) {
		this.organName = organName;
	}

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	public BigDecimal getCaperNums() {
		return caperNums;
	}

	public void setCaperNums(BigDecimal caperNums) {
		this.caperNums = caperNums;
	}

	public String getStartTime() {
		return startTime;
	}

	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

	public String getEndTime() {
		return endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	public BigDecimal getTotalTimes() {
		return totalTimes;
	}

	public void setTotalTimes(BigDecimal totalTimes) {
		this.totalTimes = totalTimes;
	}

}