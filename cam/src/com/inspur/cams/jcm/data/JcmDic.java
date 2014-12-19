package com.inspur.cams.jcm.data;

import java.io.Serializable;

import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * JCM字典管理
 * @author zhenSenSen
 * @date 2014-12-15
 */
@Table(tableName = "JCM_DIC_PUB", keyFields = "id")
public class JcmDic extends StatefulDatabean implements Serializable{
	
	//主键
	private String id;
	
	//字典类型
	private String dicType;

	//字典英文编码
	private String dicEn;

	//字典中文编码
	private String dicCn;

	//字典说明
	private String dicNote;
	
	//字典状态
	private String dicStatus;
	
	//字典编码
	private String dicCode;

	
	/**
	 * 获取 主键
	 * @return String
	 */
	public String getId() {
		return id;
	}

	/**
	 *设置 主键 
	 */
	public void setId(String id) {
		this.id = id;
	}

	/**
	 * 获取 字典类型
	 * @return String
	 */
	public String getDicType() {
		return dicType;
	}

	/**
	 *设置 字典类型 
	 */
	public void setDicType(String dicType) {
		this.dicType = dicType;
	}

	/**
	 * 获取 字典英文编码
	 * @return String
	 */
	public String getDicEn() {
		return dicEn;
	}

	/**
	 * 设置 字典英文编码
	 */
	public void setDicEn(String dicEn) {
		this.dicEn = dicEn;
	}

	/**
	 * 获取 字典中文编码
	 * @return String
	 */
	public String getDicCn() {
		return dicCn;
	}

	/**
	 * 设置 字典中文编码
	 */
	public void setDicCn(String dicCn) {
		this.dicCn = dicCn;
	}

	/**
	 * 获取 字典说明
	 * @return String
	 */
	public String getDicNote() {
		return dicNote;
	}

	/**
	 * 设置 字典说明
	 */
	public void setDicNote(String dicNote) {
		this.dicNote = dicNote;
	}

	/**
	 * 获取 字典状态
	 * @return String
	 */
	public String getDicStatus() {
		return dicStatus;
	}

	/**
	 * 设置 字典状态
	 */
	public void setDicStatus(String dicStatus) {
		this.dicStatus = dicStatus;
	}

	/**
	 * 获取 字典编码
	 * @return String
	 */
	public String getDicCode() {
		return dicCode;
	}

	/**
	 * 设置 字典编码
	 */
	public void setDicCode(String dicCode) {
		this.dicCode = dicCode;
	}
	
	private static final long serialVersionUID = -6945495907719674743L;

}
