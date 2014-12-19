package com.inspur.cams.jcm.data;

import org.loushang.next.data.StatefulDatabean;


/**
 * 
 * @author xinming
 * @date 2014-12-15
 */

public class JcmAllPeopleQuery extends StatefulDatabean {

	// 主键
	private String PEOPLE_ID;

	// 单位主键
	private String COMPANY_ID;

	// 人员照片ID
	private String PHOTO_ID;

	// 姓名
	private String PEOPLE_NAME;

	// 性别
	private String PEOPLE_SEX;

	// 身份证号
	private String PEOPLE_CARD;

	// 出生年月
	private String PEOPLE_BIRTHDAY;

	// 政治面貌
	private String PEOPLE_POLITICS;

	// 民族
	private String PEOPLE_NATION;

	// 学历
	private String PEOPLE_EDU;

	// 毕业院校
	private String PEOPLE_SCHOOL;

	// 家庭住址
	private String PEOPLE_ADRESS;

	// 参加工作时间
	private String JOB_START_TIME;

	/**
	 * 获取主键
	 * 
	 * @return the pEOPLE_ID
	 */
	public String getPEOPLE_ID() {
		return PEOPLE_ID;
	}

	/**
	 * 设置主键
	 * 
	 * @param people_id
	 *            the pEOPLE_ID to set
	 */
	public void setPEOPLE_ID(String people_id) {
		PEOPLE_ID = people_id;
	}

	/**
	 * 获取单位主键
	 * 
	 * @return the cOMPANY_ID
	 */
	public String getCOMPANY_ID() {
		return COMPANY_ID;
	}

	/**
	 * 设置单位主键
	 * 
	 * @param company_id
	 *            the cOMPANY_ID to set
	 */
	public void setCOMPANY_ID(String company_id) {
		COMPANY_ID = company_id;
	}

	/**
	 * 获取人员照片ID
	 * 
	 * @return the pHOTO_ID
	 */
	public String getPHOTO_ID() {
		return PHOTO_ID;
	}

	/**
	 * 设置人员照片ID
	 * 
	 * @param photo_id
	 *            the pHOTO_ID to set
	 */
	public void setPHOTO_ID(String photo_id) {
		PHOTO_ID = photo_id;
	}

	/**
	 * 获取姓名
	 * 
	 * @return the pEOPLE_NAME
	 */
	public String getPEOPLE_NAME() {
		return PEOPLE_NAME;
	}

	/**
	 * 设置姓名
	 * 
	 * @param people_name
	 *            the pEOPLE_NAME to set
	 */
	public void setPEOPLE_NAME(String people_name) {
		PEOPLE_NAME = people_name;
	}

	/**
	 * 获取性别
	 * 
	 * @return the pEOPLE_SEX
	 */
	public String getPEOPLE_SEX() {
		return PEOPLE_SEX;
	}

	/**
	 * 设置性别
	 * 
	 * @param people_sex
	 *            the pEOPLE_SEX to set
	 */
	public void setPEOPLE_SEX(String people_sex) {
		PEOPLE_SEX = people_sex;
	}

	/**
	 * 获取身份证号
	 * 
	 * @return the pEOPLE_CARD
	 */
	public String getPEOPLE_CARD() {
		return PEOPLE_CARD;
	}

	/**
	 * 设置身份证号
	 * 
	 * @param people_card
	 *            the pEOPLE_CARD to set
	 */
	public void setPEOPLE_CARD(String people_card) {
		PEOPLE_CARD = people_card;
	}

	/**
	 * 获取出生年月
	 * 
	 * @return the pEOPLE_BIRTHDAY
	 */
	public String getPEOPLE_BIRTHDAY() {
		return PEOPLE_BIRTHDAY;
	}

	/**
	 * 设置出生年月
	 * 
	 * @param people_birthday
	 *            the pEOPLE_BIRTHDAY to set
	 */
	public void setPEOPLE_BIRTHDAY(String people_birthday) {
		PEOPLE_BIRTHDAY = people_birthday;
	}

	/**
	 * 获取政治面貌
	 * 
	 * @return the pEOPLE_POLITICS
	 */
	public String getPEOPLE_POLITICS() {
		return PEOPLE_POLITICS;
	}

	/**
	 * 设置政治面貌
	 * 
	 * @param people_politics
	 *            the pEOPLE_POLITICS to set
	 */
	public void setPEOPLE_POLITICS(String people_politics) {
		PEOPLE_POLITICS = people_politics;
	}

	/**
	 * 获取民族
	 * 
	 * @return the pEOPLE_NATION
	 */
	public String getPEOPLE_NATION() {
		return PEOPLE_NATION;
	}

	/**
	 * 设置民族
	 * 
	 * @param people_nation
	 *            the pEOPLE_NATION to set
	 */
	public void setPEOPLE_NATION(String people_nation) {
		PEOPLE_NATION = people_nation;
	}

	/**
	 * 获取学历
	 * 
	 * @return the pEOPLE_EDU
	 */
	public String getPEOPLE_EDU() {
		return PEOPLE_EDU;
	}

	/**
	 * 设置学历
	 * 
	 * @param people_edu
	 *            the pEOPLE_EDU to set
	 */
	public void setPEOPLE_EDU(String people_edu) {
		PEOPLE_EDU = people_edu;
	}

	/**
	 * 获取毕业院校
	 * 
	 * @return the pEOPLE_SCHOOL
	 */
	public String getPEOPLE_SCHOOL() {
		return PEOPLE_SCHOOL;
	}

	/**
	 * 设置毕业院校
	 * 
	 * @param people_school
	 *            the pEOPLE_SCHOOL to set
	 */
	public void setPEOPLE_SCHOOL(String people_school) {
		PEOPLE_SCHOOL = people_school;
	}

	/**
	 * 获取家庭住址
	 * 
	 * @return the pEOPLE_ADRESS
	 */
	public String getPEOPLE_ADRESS() {
		return PEOPLE_ADRESS;
	}

	/**
	 * 设置家庭住址
	 * 
	 * @param people_adress
	 *            the pEOPLE_ADRESS to set
	 */
	public void setPEOPLE_ADRESS(String people_adress) {
		PEOPLE_ADRESS = people_adress;
	}

	/**
	 * 获取参加工作时间
	 * 
	 * @return the jOB_START_TIME
	 */
	public String getJOB_START_TIME() {
		return JOB_START_TIME;
	}

	/**
	 * 设置参加工作时间
	 * 
	 * @param job_start_time
	 *            the jOB_START_TIME to set
	 */
	public void setJOB_START_TIME(String job_start_time) {
		JOB_START_TIME = job_start_time;
	}

}
