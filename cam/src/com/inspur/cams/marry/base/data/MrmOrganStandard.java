package com.inspur.cams.marry.base.data;

import java.math.BigDecimal;

import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:等级评定标准
 * @description:
 * @author:
 * @since:2012-11-21
 * @version:1.0
 */
@Table(tableName = "MRM_ORGAN_STANDARD", keyFields = "id")
public class MrmOrganStandard extends StatefulDatabean {
	// 内码
	private String id;
	// 类型
	private String type;
	// 评定等级
	private String standardLevel;
	// 内容1
	private String con1;
	// 内容2
	private String con2;
	// 内容3
	private String con3;
	// 公式
	private String famula;
	// 文本
	private String note;
	// 序号
	private BigDecimal seq;

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
	 * getter for TYPE
	 * 
	 * @generated
	 */
	public String getType() {
		return this.type;
	}

	/**
	 * setter for TYPE
	 * 
	 * @generated
	 */
	public void setType(String type) {
		this.type = type;
	}

	/**
	 * getter for STANDARD_LEVEL
	 * 
	 * @generated
	 */
	public String getStandardLevel() {
		return this.standardLevel;
	}

	/**
	 * setter for STANDARD_LEVEL
	 * 
	 * @generated
	 */
	public void setStandardLevel(String standardLevel) {
		this.standardLevel = standardLevel;
	}

	/**
	 * getter for CON1
	 * 
	 * @generated
	 */
	public String getCon1() {
		return this.con1;
	}

	/**
	 * setter for CON1
	 * 
	 * @generated
	 */
	public void setCon1(String con1) {
		this.con1 = con1;
	}

	/**
	 * getter for CON2
	 * 
	 * @generated
	 */
	public String getCon2() {
		return this.con2;
	}

	/**
	 * setter for CON2
	 * 
	 * @generated
	 */
	public void setCon2(String con2) {
		this.con2 = con2;
	}

	/**
	 * getter for CON3
	 * 
	 * @generated
	 */
	public String getCon3() {
		return this.con3;
	}

	/**
	 * setter for CON3
	 * 
	 * @generated
	 */
	public void setCon3(String con3) {
		this.con3 = con3;
	}

	/**
	 * getter for FAMULA
	 * 
	 * @generated
	 */
	public String getFamula() {
		return this.famula;
	}

	/**
	 * setter for FAMULA
	 * 
	 * @generated
	 */
	public void setFamula(String famula) {
		this.famula = famula;
	}

	/**
	 * getter for NOTE
	 * 
	 * @generated
	 */
	public String getNote() {
		return this.note;
	}

	/**
	 * setter for NOTE
	 * 
	 * @generated
	 */
	public void setNote(String note) {
		this.note = note;
	}

	/**
	 * getter for SEQ
	 * 
	 * @generated
	 */
	public BigDecimal getSeq() {
		return this.seq;
	}

	/**
	 * setter for SEQ
	 * 
	 * @generated
	 */
	public void setSeq(BigDecimal seq) {
		this.seq = seq;
	}

}