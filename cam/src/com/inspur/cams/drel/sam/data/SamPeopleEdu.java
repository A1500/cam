package com.inspur.cams.drel.sam.data;


import java.math.BigDecimal;
import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:SamPeopleEdu教育
 * @description:
 * @author:ZCH
 * @since:2011-04-25
 * @version:1.0
*/
 @Table(tableName = "SAM_PEOPLE_EDU" , keyFields = "peopleId")
public class SamPeopleEdu extends StatefulDatabean {
   //成员ID
	@Column(name = "PEOPLE_ID")
   private String peopleId;
   //登记时间
	@Column(name = "REG_DATE")
   private String regDate;
   //教育状况
	@Column(name = "EDUCATION")
   private String education;
   //教育状况年级
	@Column(name = "GRADE")
   private String grade;
	//学业状况
	private String eduStatus;
	//学校名称
	private String school;
	//学校性质
	private String schoolType;
	//是否择校
	private String isChoose;
	//学习年限
	private String eduYear;
	//入学时间
	private String entranceDate;
	//毕业时间
	private String graduationDate;
	//联系人
	private String conectPeople;
	//联系电话
	private String conectPhone;
	//地址
	private String address;
	//邮编
	private String postCode;
	//备注
	private String remarks;
   /**
    * getter for PEOPLE_ID
    * @generated
    */
	public String getPeopleId() {
		return peopleId;
	}
	/**
    * setter for PEOPLE_ID
    * @generated
    */
	public void setPeopleId(String peopleId) {
		this.peopleId = peopleId;
	}
	/**
    * getter for REG_DATE
    * @generated
    */
	public String getRegDate() {
		return regDate;
	}
	/**
    * setter for REG_DATE
    * @generated
    */
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	/**
    * getter for EDUCATION
    * @generated
    */
	public String getEducation() {
		return education;
	}
	/**
    * setter for EDUCATION
    * @generated
    */
	public void setEducation(String education) {
		this.education = education;
	}
	/**
    * getter for GRADE
    * @generated
    */
	public String getGrade() {
		return grade;
	}
	/**
    * setter for GRADE
    * @generated
    */
	public void setGrade(String grade) {
		this.grade = grade;
	}
	public String getEduStatus() {
		return eduStatus;
	}
	public void setEduStatus(String eduStatus) {
		this.eduStatus = eduStatus;
	}
	public String getSchool() {
		return school;
	}
	public void setSchool(String school) {
		this.school = school;
	}
	public String getSchoolType() {
		return schoolType;
	}
	public void setSchoolType(String schoolType) {
		this.schoolType = schoolType;
	}
	public String getIsChoose() {
		return isChoose;
	}
	public void setIsChoose(String isChoose) {
		this.isChoose = isChoose;
	}
	public String getEduYear() {
		return eduYear;
	}
	public void setEduYear(String eduYear) {
		this.eduYear = eduYear;
	}
	public String getEntranceDate() {
		return entranceDate;
	}
	public void setEntranceDate(String entranceDate) {
		this.entranceDate = entranceDate;
	}
	public String getGraduationDate() {
		return graduationDate;
	}
	public void setGraduationDate(String graduationDate) {
		this.graduationDate = graduationDate;
	}
	public String getConectPeople() {
		return conectPeople;
	}
	public void setConectPeople(String conectPeople) {
		this.conectPeople = conectPeople;
	}
	public String getConectPhone() {
		return conectPhone;
	}
	public void setConectPhone(String conectPhone) {
		this.conectPhone = conectPhone;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getPostCode() {
		return postCode;
	}
	public void setPostCode(String postCode) {
		this.postCode = postCode;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

}