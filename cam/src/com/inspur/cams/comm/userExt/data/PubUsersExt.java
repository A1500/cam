package com.inspur.cams.comm.userExt.data;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * @author licb
 * @date:2011-10-27 上午08:11:03
 * @version : PubUsersExt.java
 */
@Table(tableName = "PUB_USERS_EXT", keyFields = "userId")
public class PubUsersExt extends StatefulDatabean {
	// 人员ID
	@Rule(value = "require")
	@Column(name = "USER_ID")
	private String userId;
	// 姓名
	@Column(name = "NAME")
	private String name;
	// 身份证件类型代码
	@Column(name = "ID_CARD_TYPE")
	private String idCardType;
	// 身份证件号码
	@Column(name = "ID_CARD")
	private String idCard;
	// 出生日期
	@Column(name = "BIRTHDAY")
	private String birthday;
	// 性别
	@Column(name = "SEX")
	private String sex;
	// 政治面貌
	@Column(name = "POLITICS")
	private String politics;
	// 婚姻状况
	@Column(name = "MARRIAGE_CODE")
	private String marriageCode;
	// 文化程度
	@Column(name = "EDU_CODE")
	private String eduCode;
	// 毕业院校
	@Column(name = "UNIVERSITY")
	private String university;
	// 毕业时间
	@Column(name = "GRADUATION_DATE")
	private String graduationDate;
	// 职务
	@Column(name = "POST")
	private String post;
	// 职称
	@Column(name = "TITLE")
	private String title;
	// 电话
	@Column(name = "TELEPHONE")
	private String telephone;
	// 邮箱
	@Column(name = "EMAIL")
	private String email;
	// 住址
	@Column(name = "ADDS")
	private String adds;
	// 到民政局工作时间
	@Column(name = "WORKING_DATE")
	private String workingDate;
	// 简历
	@Column(name = "RESUME")
	private String resume;
	// 表彰
	@Column(name = "PRAISE")
	private String praise;
	// 惩戒
	@Column(name = "PUNISH")
	private String punish;
	// 备注
	@Column(name = "NOTE")
	private String note;
    //新增字段户籍类型
	@Column(name="DOMICILE_TYPE")
	private String domicileType;
	/**
	 * getter  for 户籍类型
	 * @return
	 */
	public String getDomicileType() {
		return domicileType;
	}
	/**
	 * setter for  户籍类型
	 * @param domicileType
	 */
	public void setDomicileType(String domicileType) {
		this.domicileType = domicileType;
	}

	/**
	 * getter for 人员ID
	 * 
	 * @return
	 */
	public String getUserId() {
		return userId;
	}

	/**
	 * setter for 人员ID
	 * 
	 * @param userId
	 */
	public void setUserId(String userId) {
		this.userId = userId;
	}

	/**
	 * getter for 姓名
	 * 
	 * @return
	 */
	public String getName() {
		return name;
	}

	/**
	 * setter for 姓名
	 * 
	 * @param name
	 */
	public void setName(String name) {
		this.name = name;
	}

	/**
	 * getter for 身份证件类型
	 * 
	 * @return
	 */
	public String getIdCardType() {
		return idCardType;
	}

	/**
	 * setter for 身份证件类型
	 * 
	 * @param idCardType
	 */
	public void setIdCardType(String idCardType) {
		this.idCardType = idCardType;
	}

	/**
	 * getter for 身份证
	 * 
	 * @return
	 */
	public String getIdCard() {
		return idCard;
	}

	/**
	 * setter for 身份证
	 * 
	 * @param idCard
	 */
	public void setIdCard(String idCard) {
		this.idCard = idCard;
	}

	/**
	 * getter for 出生日期
	 * 
	 * @param birthday
	 */
	public String getBirthday() {
		return birthday;
	}

	/**
	 * setter for 出生日期
	 * 
	 * @param userId
	 */
	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}

	/**
	 * getter for 性别
	 * 
	 * @param
	 */
	public String getSex() {
		return sex;
	}

	/**
	 * setter for 性别
	 * 
	 * @param sex
	 */
	public void setSex(String sex) {
		this.sex = sex;
	}

	/**
	 * getter for 政治面貌
	 * 
	 * @param
	 */
	public String getPolitics() {
		return politics;
	}

	/**
	 * setter for 政治面貌
	 * 
	 * @param politics
	 */
	public void setPolitics(String politics) {
		this.politics = politics;
	}

	/**
	 * getter for 婚姻状况
	 * 
	 * @param
	 */
	public String getMarriageCode() {
		return marriageCode;
	}

	/**
	 * setter for 婚姻状况
	 * 
	 * @param marriageCode
	 */
	public void setMarriageCode(String marriageCode) {
		this.marriageCode = marriageCode;
	}

	/**
	 * getter for 文化程度
	 * 
	 * @param
	 */
	public String getEduCode() {
		return eduCode;
	}

	/**
	 * setter for 文化程度
	 * 
	 * @param eduCode
	 */
	public void setEduCode(String eduCode) {
		this.eduCode = eduCode;
	}

	/**
	 * getter for 毕业院校
	 * 
	 * @param
	 */
	public String getUniversity() {
		return university;
	}

	/**
	 * setter for 毕业院校
	 * 
	 * @param university
	 */
	public void setUniversity(String university) {
		this.university = university;
	}

	/**
	 * getter for 毕业时间
	 * 
	 * @param
	 */
	public String getGraduationDate() {
		return graduationDate;
	}

	/**
	 * setter for 毕业时间
	 * 
	 * @param graduationDate
	 */
	public void setGraduationDate(String graduationDate) {
		this.graduationDate = graduationDate;
	}

	/**
	 * getter for 职务
	 * 
	 * @return
	 */
	public String getPost() {
		return post;
	}

	/**
	 * setter for 职务
	 * 
	 * @param post
	 */
	public void setPost(String post) {
		this.post = post;
	}

	/**
	 * getter for 职称
	 * 
	 * @return
	 */
	public String getTitle() {
		return title;
	}

	/**
	 * setter for 职称
	 * 
	 * @param title
	 */
	public void setTitle(String title) {
		this.title = title;
	}

	/**
	 * getter for 电话
	 * 
	 * @return
	 */
	public String getTelephone() {
		return telephone;
	}

	/**
	 * setter for 电话
	 * 
	 * @param telephone
	 */
	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}

	/**
	 * getter for 邮箱
	 * 
	 * @return
	 */
	public String getEmail() {
		return email;
	}

	/**
	 * setter for 邮箱
	 * 
	 * @param email
	 */
	public void setEmail(String email) {
		this.email = email;
	}

	/**
	 * getter for 地址
	 * 
	 * @return
	 */
	public String getAdds() {
		return adds;
	}

	/**
	 * setter for 地址
	 * 
	 * @param adds
	 */
	public void setAdds(String adds) {
		this.adds = adds;
	}

	/**
	 * getter for （到民政局）工作时间
	 * 
	 * @return
	 */
	public String getWorkingDate() {
		return workingDate;
	}

	/**
	 * setter for （到民政局）工作时间
	 * 
	 * @param workingDate
	 */
	public void setWorkingDate(String workingDate) {
		this.workingDate = workingDate;
	}

	/**
	 * getter for 简历
	 * 
	 * @return
	 */
	public String getResume() {
		return resume;
	}

	/**
	 * setter for 简历
	 * 
	 * @param resume
	 */
	public void setResume(String resume) {
		this.resume = resume;
	}

	/**
	 * getter for 表彰
	 * 
	 * @return
	 */
	public String getPraise() {
		return praise;
	}

	/**
	 * setter for 表彰
	 * 
	 * @return praise
	 */
	public void setPraise(String praise) {
		this.praise = praise;
	}

	/**
	 * getter for 惩戒
	 * 
	 * @return
	 */
	public String getPunish() {
		return punish;
	}

	/**
	 * setter for 惩戒
	 * 
	 * @param punish
	 */
	public void setPunish(String punish) {
		this.punish = punish;
	}

	/**
	 * getter for 备注
	 * 
	 * @return
	 */
	public String getNote() {
		return note;
	}

	/**
	 * setter for 备注
	 * 
	 * @param note
	 */
	public void setNote(String note) {
		this.note = note;
	}

}
