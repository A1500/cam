package com.inspur.cams.bpt.bptrecuperate.data;

import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:BptRecuperateDetal
 * @description:
 * @author:
 * @since:2011-11-09
 * @version:1.0
 */
@Table(tableName = "BPT_RECUPERATE_DETAL", keyFields = "id")
public class BptRecuperateDetail extends StatefulDatabean {
	private String id;
	// 批次Id
	private String batchId;
	// 人员ID
	private String peopleId;
	// 姓名
	private String name;
	//身份证号
	private String idCard;
	//出生日期
	private String birthday;
	//优抚对象类别
	private String objectType;
	//优抚对象编号
	private String credentialsNo;
	//轮养（休养）地点
	private String place;
	//备注
    private String note;
    //录入人ID
    private String regId;
    //录入时间
    private String regTime;
    //修改人ID
    private String modId;
    //修改时间
    private String modTime;
	
	/**
	 * getter for ID
	 * 
	 * @generated
	 */
	public String getId() {
		return this.id;
	}

	/**
	 * setter for ID
	 * 
	 * @generated
	 */
	public void setId(String id) {
		this.id = id;
	}

	/**
	 * getter for BATCH_ID
	 * 
	 * @generated
	 */
	public String getBatchId() {
		return this.batchId;
	}

	/**
	 * setter for BATCH_ID
	 * 
	 * @generated
	 */
	public void setBatchId(String batchId) {
		this.batchId = batchId;
	}

	/**
	 * getter for NAME
	 * 
	 * @generated
	 */
	public String getName() {
		return this.name;
	}

	/**
	 * setter for NAME
	 * 
	 * @generated
	 */
	public void setName(String name) {
		this.name = name;
	}

	/**
	 * getter for OBJECT_TYPE
	 * 
	 * @generated
	 */
	public String getObjectType() {
		return this.objectType;
	}

	/**
	 * setter for OBJECT_TYPE
	 * 
	 * @generated
	 */
	public void setObjectType(String objectType) {
		this.objectType = objectType;
	}

	/**
	 * getter for CREDENTIALS_NO
	 * 
	 * @generated
	 */
	public String getCredentialsNo() {
		return this.credentialsNo;
	}

	/**
	 * setter for CREDENTIALS_NO
	 * 
	 * @generated
	 */
	public void setCredentialsNo(String credentialsNo) {
		this.credentialsNo = credentialsNo;
	}

	/**
	 * getter for PLACE
	 * 
	 * @generated
	 */
	public String getPlace() {
		return this.place;
	}

	/**
	 * setter for PLACE
	 * 
	 * @generated
	 */
	public void setPlace(String place) {
		this.place = place;
	}

	public String getPeopleId() {
		return peopleId;
	}

	public void setPeopleId(String peopleId) {
		this.peopleId = peopleId;
	}

	/**
	 * @return the idCard
	 */
	public String getIdCard() {
		return idCard;
	}

	/**
	 * @param idCard the idCard to set
	 */
	public void setIdCard(String idCard) {
		this.idCard = idCard;
	}

	/**
	 * @return the note
	 */
	public String getNote() {
		return note;
	}

	/**
	 * @param note the note to set
	 */
	public void setNote(String note) {
		this.note = note;
	}

	/**
	 * @return the regId
	 */
	public String getRegId() {
		return regId;
	}

	/**
	 * @param regId the regId to set
	 */
	public void setRegId(String regId) {
		this.regId = regId;
	}

	/**
	 * @return the regTime
	 */
	public String getRegTime() {
		return regTime;
	}

	/**
	 * @param regTime the regTime to set
	 */
	public void setRegTime(String regTime) {
		this.regTime = regTime;
	}

	/**
	 * @return the modId
	 */
	public String getModId() {
		return modId;
	}

	/**
	 * @param modId the modId to set
	 */
	public void setModId(String modId) {
		this.modId = modId;
	}

	/**
	 * @return the modTime
	 */
	public String getModTime() {
		return modTime;
	}

	/**
	 * @param modTime the modTime to set
	 */
	public void setModTime(String modTime) {
		this.modTime = modTime;
	}

	/**
	 * @return the birthday
	 */
	public String getBirthday() {
		return birthday;
	}

	/**
	 * @param birthday the birthday to set
	 */
	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}

}