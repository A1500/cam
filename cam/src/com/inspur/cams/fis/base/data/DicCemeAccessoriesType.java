package com.inspur.cams.fis.base.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 公墓年检附件类型字典databean
 * @author 
 * @date 2013-08-01
 */
@Table(tableName = "DIC_CEME_ACCESSORIES_TYPE", keyFields = "code")
public class DicCemeAccessoriesType extends StatefulDatabean {

	// CODE
	private String code;

	// NAME
	private String name;

	/**
	 * 获取 CODE
	 * @return String
	 */
	public String getCode() {
		return code;
	}

	/**
	 * 设置 CODE
	 */
	public void setCode(String code) {
		this.code = code;
	}

	/**
	 * 获取 NAME
	 * @return String
	 */
	public String getName() {
		return name;
	}

	/**
	 * 设置 NAME
	 */
	public void setName(String name) {
		this.name = name;
	}

}