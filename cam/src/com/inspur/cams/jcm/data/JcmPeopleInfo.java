package com.inspur.cams.jcm.data;

import java.io.Serializable;
import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 人员基本信息databean
 * @author 
 * @date 2014-05-16
 */
@Table(tableName = "JCM_PEOPLE_INFO", keyFields = "peopleId")
public class JcmPeopleInfo extends StatefulDatabean implements Serializable{
	private static final long serialVersionUID = -4506346154655807873L;

	// 主键
	private String peopleId;

	// 单位主键
	private String companyId;

	// 人员照片ＩＤ
	private String photoId;

	// 姓名
	private String peopleName;

	// 性别
	private String peopleSex;

	// 身份证号
	private String peopleCard;

	// 出生年月
	private String peopleBirthday;

	// 政治面貌
	private String peoplePolitics;

	// 民族
	private String peopleNation;

	// 学历
	private String peopleEdu;

	// 毕业院校
	private String peopleSchool;

	// 家庭住址
	private String peopleAdress;

	// 参加工作时间
	private String jobStartTime;
	
	/*部门Id**/
	private String deptId;

	/**
	 * 获取 主键
	 * @return String
	 */
	public String getPeopleId() {
		return peopleId;
	}

	/**
	 * 设置 主键
	 */
	public void setPeopleId(String peopleId) {
		this.peopleId = peopleId;
	}

	/**
	 * 获取 单位主键
	 * @return String
	 */
	public String getCompanyId() {
		return companyId;
	}

	/**
	 * 设置 单位主键
	 */
	public void setCompanyId(String companyId) {
		this.companyId = companyId;
	}

	/**
	 * 获取 人员照片ＩＤ
	 * @return String
	 */
	public String getPhotoId() {
		return photoId;
	}

	/**
	 * 设置 人员照片ＩＤ
	 */
	public void setPhotoId(String photoId) {
		this.photoId = photoId;
	}

	/**
	 * 获取 姓名
	 * @return String
	 */
	public String getPeopleName() {
		return peopleName;
	}

	/**
	 * 设置 姓名
	 */
	public void setPeopleName(String peopleName) {
		this.peopleName = peopleName;
	}

	/**
	 * 获取 性别
	 * @return String
	 */
	public String getPeopleSex() {
		return peopleSex;
	}

	/**
	 * 设置 性别
	 */
	public void setPeopleSex(String peopleSex) {
		this.peopleSex = peopleSex;
	}

	/**
	 * 获取 身份证号
	 * @return String
	 */
	public String getPeopleCard() {
		return peopleCard;
	}

	/**
	 * 设置 身份证号
	 */
	public void setPeopleCard(String peopleCard) {
		this.peopleCard = peopleCard;
	}

	/**
	 * 获取 出生年月
	 * @return String
	 */
	public String getPeopleBirthday() {
		return peopleBirthday;
	}

	/**
	 * 设置 出生年月
	 */
	public void setPeopleBirthday(String peopleBirthday) {
		this.peopleBirthday = peopleBirthday;
	}

	/**
	 * 获取 政治面貌
	 * @return String
	 */
	public String getPeoplePolitics() {
		return peoplePolitics;
	}

	/**
	 * 设置 政治面貌
	 */
	public void setPeoplePolitics(String peoplePolitics) {
		this.peoplePolitics = peoplePolitics;
	}

	/**
	 * 获取 民族
	 * @return String
	 */
	public String getPeopleNation() {
		return peopleNation;
	}

	/**
	 * 设置 民族
	 */
	public void setPeopleNation(String peopleNation) {
		this.peopleNation = peopleNation;
	}

	/**
	 * 获取 学历
	 * @return String
	 */
	public String getPeopleEdu() {
		return peopleEdu;
	}

	/**
	 * 设置 学历
	 */
	public void setPeopleEdu(String peopleEdu) {
		this.peopleEdu = peopleEdu;
	}

	/**
	 * 获取 毕业院校
	 * @return String
	 */
	public String getPeopleSchool() {
		return peopleSchool;
	}

	/**
	 * 设置 毕业院校
	 */
	public void setPeopleSchool(String peopleSchool) {
		this.peopleSchool = peopleSchool;
	}

	/**
	 * 获取 家庭住址
	 * @return String
	 */
	public String getPeopleAdress() {
		return peopleAdress;
	}

	/**
	 * 设置 家庭住址
	 */
	public void setPeopleAdress(String peopleAdress) {
		this.peopleAdress = peopleAdress;
	}

	/**
	 * 获取 参加工作时间
	 * @return String
	 */
	public String getJobStartTime() {
		return jobStartTime;
	}

	/**
	 * 设置 参加工作时间
	 */
	public void setJobStartTime(String jobStartTime) {
		this.jobStartTime = jobStartTime;
	}

	public String getDeptId() {
		return deptId;
	}

	public void setDeptId(String deptId) {
		this.deptId = deptId;
	}

}