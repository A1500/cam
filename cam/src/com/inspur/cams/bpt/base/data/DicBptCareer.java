package com.inspur.cams.bpt.base.data;

import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * 职称databean
 * @author xuliandong
 * @date 
 */
@Table(tableName = "DIC_BPT_CAREER", keyFields = "id")
public class DicBptCareer extends StatefulDatabean {
	
	// 代码
	@Rule(value = "require")
	private String id;
	
	//代码
	private String code;
	
	// 名称
	private String name;
	
	
	// 上级代码
	private String ups;
	
	// 层级
	private String leve;

	public String getLeve() {
		return leve;
	}

	public void setLeve(String leve) {
		this.leve = leve;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

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



	

}