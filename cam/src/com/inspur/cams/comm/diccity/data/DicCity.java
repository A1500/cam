package com.inspur.cams.comm.diccity.data;

import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * 行政区划databean
 * @author wangbaocai
 * @date 2011-6-23
 */
@Table(tableName = "DIC_CITY", keyFields = "id")
public class DicCity extends StatefulDatabean {
	
	// 代码
	@Rule(value = "require")
	private String id;
	
	// 名称
	private String name;
	
	// 层级
	private String leve;
	
	// 上级代码
	private String ups;
	
	// 标识
	private String flag;
	
	// 标识
	private String fullName;
	
	// 是否本级
	private String isSelf;

	/**
	 * getter for 代码
	 * @generated
	 */
	public String getId() {
		return this.id;
	}

	/**
	 * setter for 代码
	 * @generated
	 */
	public void setId(String id) {
		this.id = id;
	}

	/**
	 * getter for 名称
	 * @generated
	 */
	public String getName() {
		return this.name;
	}

	/**
	 * setter for 名称
	 * @generated
	 */
	public void setName(String name) {
		this.name = name;
	}

	/**
	 * getter for 层级
	 * @generated
	 */
	public String getLeve() {
		return this.leve;
	}

	/**
	 * setter for 层级
	 * @generated
	 */
	public void setLeve(String leve) {
		this.leve = leve;
	}

	/**
	 * getter for 上级代码
	 * @generated
	 */
	public String getUps() {
		return this.ups;
	}

	/**
	 * setter for 上级代码
	 * @generated
	 */
	public void setUps(String ups) {
		this.ups = ups;
	}

	/**
	 * getter for 标识
	 * @generated
	 */
	public String getFlag() {
		return this.flag;
	}

	/**
	 * setter for 标识
	 * @generated
	 */
	public void setFlag(String flag) {
		this.flag = flag;
	}

	public String getFullName() {
		return fullName;
	}

	public void setFullName(String fullName) {
		this.fullName = fullName;
	}

	public String getIsSelf() {
		return isSelf;
	}

	public void setIsSelf(String isSelf) {
		this.isSelf = isSelf;
	}

}