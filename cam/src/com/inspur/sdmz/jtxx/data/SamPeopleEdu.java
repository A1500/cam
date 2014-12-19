package com.inspur.sdmz.jtxx.data;


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
   	@Rule(value="require")
	@Column(name = "PEOPLE_ID")
   private String peopleId;
   //登记时间
   	@Rule(value="require")
	@Column(name = "REG_DATE")
   private String regDate;
   //教育状况
	@Column(name = "EDUCATION")
   private String education;
   //教育状况年级
	@Column(name = "GRADE")
   private String grade;
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

}