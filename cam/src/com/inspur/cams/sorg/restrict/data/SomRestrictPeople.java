package com.inspur.cams.sorg.restrict.data;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:社会组织受限制人员表
 * @description:
 * @author:
 * @since:2012-03-19
 * @version:1.0
 */
@Table(tableName = "SOM_RESTRICT_PEOPLE", keyFields = "peopleId")
public class SomRestrictPeople extends StatefulDatabean {
	// PEOPLE_ID
	@Rule(value = "require")
	@Column(name = "PEOPLE_ID")
	private String peopleId;
	// NAME
	@Column(name = "NAME")
	private String name;
	// ID_CARD
	@Column(name = "ID_CARD")
	private String idCard;
	// IF_LIMIT
	@Column(name = "IF_LIMIT")
	private String ifLimit;
	// IF_VALID
	@Column(name = "IF_VALID")
	private String ifValid;

	/**
	 * getter for PEOPLE_ID
	 * 
	 * @generated
	 */
	public String getPeopleId() {
		return this.peopleId;
	}

	/**
	 * setter for PEOPLE_ID
	 * 
	 * @generated
	 */
	public void setPeopleId(String peopleId) {
		this.peopleId = peopleId;
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
	 * getter for ID_CARD
	 * 
	 * @generated
	 */
	public String getIdCard() {
		return this.idCard;
	}

	/**
	 * setter for ID_CARD
	 * 
	 * @generated
	 */
	public void setIdCard(String idCard) {
		this.idCard = idCard;
	}

	/**
	 * getter for IF_LIMIT
	 * 
	 * @generated
	 */
	public String getIfLimit() {
		return this.ifLimit;
	}

	/**
	 * setter for IF_LIMIT
	 * 
	 * @generated
	 */
	public void setIfLimit(String ifLimit) {
		this.ifLimit = ifLimit;
	}

	/**
	 * getter for IF_VALID
	 * 
	 * @generated
	 */
	public String getIfValid() {
		return this.ifValid;
	}

	/**
	 * setter for IF_VALID
	 * 
	 * @generated
	 */
	public void setIfValid(String ifValid) {
		this.ifValid = ifValid;
	}

}